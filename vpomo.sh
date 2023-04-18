#!/bin/bash

# Vpomo V1 cli 
# a simple CLI Bash pomodoro timer
# Valentin Coellar S.
# 2023 

# Use chmod +x vpomo.sh to make it executable
# For invocation use in cli terminal: ./vpomo.sh <WorkTime> <BreakTime> 



# Define los colores de la terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# arg1 y arg2 de linea de comandos
work_time=$1
break_time=$2

# Reproducir la alarma 
function play_alarm() {
  for i in {1..3}; do
    printf "\a"
    sleep 1
  done
}

# tiempo restante countdown
function print_time() {
  local min=$1
  local sec=$2
  printf "\r%02d:%02d" $min $sec
}

# duracion del tiempo de trabajo
function work_timer() {
  local duration=$1
  local min=$duration
  local sec=0

  while [ $min -ge 0 ]; do
    while [ $sec -ge 0 ]; do
      print_time $min $sec
      sleep 1
      sec=$((sec-1))
    done
    min=$((min-1))
    sec=59
  done

# Alarma y cambio de color
  printf "${RED}${GREEN}\rTIEMPO DE DESCANSO${RESET}"
  play_alarm

}

# duracion tiempo de descanso
function break_timer() {
  local duration=$1
  local min=$duration
  local sec=0

  while [ $min -ge 0 ]; do
    while [ $sec -ge 0 ]; do
      print_time $min $sec
      sleep 1
      sec=$((sec-1))
    done
    min=$((min-1))
    sec=59
  done
}

# Main rutine Inicio del programa
printf "Inicio de Vpomodo de %d minutos de trabajo y %d minutos de descanso\n" $work_time $break_time
while true; do
  work_timer $work_time
  printf "\nTiempo de descanso de %d minutos\n" $break_time
  break_timer $break_time
  printf "\nContinuar con otro Vpomodo? [s/n]\n"
  read answer
  if [ "$answer" != "s" ]; then
    printf "Vpomodo finalizado\n"
    exit 0
  fi
done


