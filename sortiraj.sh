#!/bin/sh

# Nastavitve map
INBOX="/mnt/media/INBOX"
DOCS="/mnt/media/dokumenti"

echo "Začenjam sortiranje..."
echo "Iz: $INBOX"
echo "V:  $DOCS"

while true; do
    # Če je mapa INBOX prazna, počakaj 3 sekunde in ponovi
    if [ -z "$(ls -A "$INBOX" 2>/dev/null)" ]; then
        sleep 3
        continue
    fi

    # 1. PDF
    mv -n "$INBOX"/*.pdf "$DOCS/PDF/" 2>/dev/null
    mv -n "$INBOX"/*.PDF "$DOCS/PDF/" 2>/dev/null

    # 2. SLIKE
    mv -n "$INBOX"/*.jpg "$DOCS/FOTOGRAFIJE/" 2>/dev/null
    mv -n "$INBOX"/*.png "$DOCS/FOTOGRAFIJE/" 2>/dev/null
    mv -n "$INBOX"/*.webp "$DOCS/FOTOGRAFIJE/" 2>/dev/null

    # 3. DOKUMENTI (Word, Excel, Txt)
    mv -n "$INBOX"/*.doc* "$DOCS/Dokumenti/" 2>/dev/null
    mv -n "$INBOX"/*.xls* "$DOCS/Dokumenti/" 2>/dev/null
    mv -n "$INBOX"/*.txt "$DOCS/Dokumenti/" 2>/dev/null

    # 4. OSTALO (Vse kar je ostalo premakni v OSTALO)
    # Pazi: premakni samo datoteke, ne map
    for f in "$INBOX"/*; do
        if [ -f "$f" ]; then
            mv -n "$f" "$DOCS/OSTALO/" 2>/dev/null
        fi
    done

    sleep 2
done
