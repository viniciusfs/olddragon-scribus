#!/bin/bash

# commands
CP_CMD=$(which cp)
SED_CMD=$(which sed)
ZIP_CMD=$(which zip)


# variables
PACKAGE_NAME="Old_Dragon-Templates-Scribus.zip"
AVENTURA_TEMPLATE="OD_Template-Aventura-Variaveis.sla"
AVENTURA_OUTPUT="OD_Template-Aventura.sla"
SUPLEMENTO_TEMPLATE="OD_Template-Suplemento-Variaveis.sla"
SUPLEMENTO_OUTPUT="OD_Template-Suplemento.sla"
EXTRA_FILES="images/img_capa.jpg images/img_cc-logo.eps images/img_lateral-azul.png images/img_lateral-verde.jpg"


# functions
convert() {
	${CP_CMD} -p ${AVENTURA_TEMPLATE} ${SUPLEMENTO_TEMPLATE}

	${SED_CMD} -i 's/Uma aventura para/Um suplemento para/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/desta Aventura/deste Suplemento/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/AVENTURAS/SUPLEMENTOS/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/%VAR_codigo% - Para %VAR_jogadores% personagens de nível %VAR_nivel%/%VAR_subtitulo%/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/PCOLOR=\"Verde_RedBox\"/PCOLOR=\"Azul_RedBox\"/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/img_lateral_verde_capa/img_lateral_azul_capa/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/img_lateral-verde.jpg/img_lateral-azul.png/g' ${SUPLEMENTO_TEMPLATE}
	${SED_CMD} -i 's/LOCALSCX=\"0.24\" LOCALSCY=\"0.24\"/LOCALSCX=\"1\" LOCALSCY=\"1\"/g' ${SUPLEMENTO_TEMPLATE}
}

replace_data() {
	${CP_CMD} -p ${AVENTURA_TEMPLATE} ${AVENTURA_OUTPUT}

	${SED_CMD} -i 's/%VAR_titulo%/Título da Aventura/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_codigo%/XX#/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_jogadores%/#/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_nivel%/#/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_autor%/Nome do Autor/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_editor%/Nome do Editor/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_revisor%/Nome do Revisor/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_artista%/Nome do Artista/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_mes%/Mês/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_ano%/Ano/g' ${AVENTURA_OUTPUT}
	${SED_CMD} -i 's/%VAR_capa%/img_capa.jpg/g' ${AVENTURA_OUTPUT}

	${CP_CMD} -p ${SUPLEMENTO_TEMPLATE} ${SUPLEMENTO_OUTPUT}

	${SED_CMD} -i 's/%VAR_titulo%/Título do Suplemento/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_subtitulo%/Subtítulo do Suplemento/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_autor%/Nome do Autor/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_editor%/Nome do Editor/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_revisor%/Nome do Revisor/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_artista%/Nome do Artista/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_mes%/Mês/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_ano%/Ano/g' ${SUPLEMENTO_OUTPUT}
	${SED_CMD} -i 's/%VAR_capa%/img_capa.jpg/g' ${SUPLEMENTO_OUTPUT}
}

pack() {
	${ZIP_CMD} ${PACKAGE_NAME} ${AVENTURA_OUTPUT} ${SUPLEMENTO_OUTPUT} ${EXTRA_FILES}
}



# main loop
echo "Convertendo templates de Aventura para Suplemento..."
convert
echo "Substituindo variáveis nos templates..."
replace_data
echo "Criando pacote ${PACKAGE_NAME} ..."
pack
echo "Arquivos criados com sucesso!"

