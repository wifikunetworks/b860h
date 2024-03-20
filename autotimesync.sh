#!/bin/bash

temp_dir="/tmp"
date_file="$temp_dir/date_google"
log_file="$temp_dir/logp"
script_name="$(basename "$0")"

function fetch_date() {
	curl -si "http://google.com" | grep Date > "$date_file"
	echo -e "$script_name: Mengambil waktu dari server Google."
	logger "$script_name: Mengambil waktu dari server Google."
}

function set_system_time() {
    hari=$(cat "$date_file" | cut -b 12-13)
    bulan=$(cat "$date_file" | cut -b 15-17)
    tahun=$(cat "$date_file" | cut -b 19-22)
    jam=$(cat "$date_file" | cut -b 24-25)
    menit=$(cat "$date_file" | cut -b 26-31)

    case $bulan in
        "Jan")
           bulan="01"
            ;;
        "Feb")
            bulan="02"
            ;;
        "Mar")
            bulan="03"
            ;;
        "Apr")
            bulan="04"
            ;;
        "May")
            bulan="05"
            ;;
        "Jun")
            bulan="06"
            ;;
        "Jul")
            bulan="07"
            ;;
        "Aug")
            bulan="08"
            ;;
        "Sep")
            bulan="09"
            ;;
        "Oct")
            bulan="10"
            ;;
        "Nov")
            bulan="11"
            ;;
        "Dec")
            bulan="12"
            ;;
        *)
           return

    esac

	date -u -s "$tahun"."$bulan"."$hari"-"$jam""$menit" > /dev/null 2>&1
	echo -e "$script_name: Menyetel waktu ke [ $(date) ]"
	logger "$script_name: Menyetel waktu ke [ $(date) ]"
}

# Runner
fetch_date
set_system_time

# Cleaning files
[[ -f "$log_file" ]] && rm -f "$log_file" && echo -e "$script_name: logp cleaned up!" && logger "$script_name: logp cleaned up!"
[[ -f "$date_file" ]] && rm -f "$date_file" && echo -e "$script_name: temporary file cleaned up!" && logger "$script_name: temporary file cleaned up!"
