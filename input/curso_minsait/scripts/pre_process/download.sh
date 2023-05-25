#!/bin/bash

dataResource="https://github.com/caiuafranca/dados_curso/blob/main/"
dataExtension=".csv"
cleanData=true
rawData=("alunos" "categoria" "cidade" "cliente" "estado" "filial" "item_pedido" "parceiro" "produto" "subcategoria")

cd /workspace/curso_minsait_DE/input/curso_minsait/raw

for data in ${rawData[@]}; do
  
  # Verifica se existe diretório   
  if [ ! -d "$data" ]; then
    echo "Diretório $data não foi criado! Criando diretório..."
    mkdir $data
  fi

  cd $data

  # Verifica se arquivo já foi baixado e se é necessário remover   
  if [ -f "$data$dataExtension" ] && [ $cleanData == true ]; then
    echo "Arquivo $data$dataExtension já foi criado! Limpando arquivo..."  
    rm $data$dataExtension
  elif [ -f "$data$dataExtension" ] && [ $cleanData == false ]; then
    echo "Arquivo $data$dataExtension já foi criado! Baixando o próximo arquivo..."
    cd ..
    continue
  fi

  echo "$dataResource$data$dataExtension"
  curl -O $dataResource$data$dataExtension

  cd ..
done

echo "Todos os arquivos foram ingeridos."

# cd ../../raw
# mkdir categoria
# cd categoria
# curl -O https://github.com/caiuafranca/dados_curso/blob/main/categoria.csv