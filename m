From: Jordi Mallach <jordi@debian.org>
Subject: New Debian patches
Date: Mon, 10 Feb 2003 18:59:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030210175931.GB5402@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--wTWi5aaYRw9ix9vO
Content-Type: multipart/mixed; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

We added these patches in the last few weeks.

For the alsaconf patch, it's the changes I made to the script to make it
work on Debian. It still lacks propper unbashization (removing let's,
etc).

More flavours could be added to the distributions detection, and adding
distro-specific stuff to it.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="04_alsaconf_fixes.dpatch"
Content-Transfer-Encoding: quoted-printable

#! /bin/sh -e

# 04_alsaconf_bashisms.dpatch by Jordi Mallach
#
# DP: Use /bin/bash, not /bin/sh so it works with /bin/sh -> dash.
# DP: Fix a bunch of bashisms and gawkisms.
# DP: Adapt alsconf to Debian needs, by calling the correct scripts
# DP: and writing configuration where it belongs.

=2E debian/patches/patch-opts

if [ $# -ne 1 ]; then
    echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
    exit 1
fi
case "$1" in
    -patch) patch $patch_opts < $0;;
    -unpatch) patch $patch_opts -R < $0;;
    *)
        echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
        exit 1;;
esac

exit 0

--- alsa-driver-0.9.0rc6+2.orig/utils/alsaconf	2003-01-31 17:50:27.00000000=
0 +0100
+++ alsa-driver-0.9.0rc6+2/utils/alsaconf	2003-01-31 17:58:21.000000000 +01=
00
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 #  ALSA Configurator
 #
@@ -25,7 +25,14 @@
   exit 1
 fi
=20
-function usage() {
+# Check for GNU/Linux distributions
+if [ -f /etc/debian_version ]; then
+  distribution=3D"debian"
+elif [ -f /etc/redhat-release ]; then
+  distribution=3D"redhat"
+fi
+
+usage() {
     echo "ALSA configurator version $version"
     echo "usage: alsaconf [options]"
     echo "  -l|--legacy    check only legacy non-isapnp cards"
@@ -54,8 +61,8 @@
 alsa_gid=3D0
 alsa_mode=3D0666
 legacy_probe_card=3D""
-LOGFILE=3D/tmp/alsaconf.log
-TESTSOUND=3D/usr/share/sounds/alsa/test.wav
+LOGFILE=3D"/tmp/alsaconf.log"
+TESTSOUND=3D"/usr/share/sounds/alsa/test.wav"
 try_all_combination=3D0
=20
 while true ; do
@@ -96,7 +103,9 @@
     alsa_device_opts=3D"$alsa_device_opts ${mpfx}device_mode=3D$alsa_mode"
 fi
=20
-if [ -e /etc/modules.conf ]; then
+if [ "$distribution" =3D "debian" ]; then
+  cfgfile=3D"/etc/alsa/modutils/0.9"
+elif [ -e /etc/modules.conf ]; then
   cfgfile=3D"/etc/modules.conf"
 elif [ -e /etc/conf.modules ]; then
   cfgfile=3D"/etc/conf.modules"
@@ -120,7 +129,7 @@
   DIALOG=3Ddialog
 else
   if which whiptail > /dev/null; then
-    function whiptail_wrapper() {
+    whiptail_wrapper() {
       X1=3D"$1"
       X2=3D"$2"
       if [ $1 =3D --yesno ]; then
@@ -146,7 +155,7 @@
 #
 # remove entries by yast2 sound configurator
 #
-function remove_y2_block() {
+remove_y2_block() {
     awk '
     /^alias sound-slot-[0-9]/ { next }
     /^alias char-major-116 / { next }
@@ -166,7 +175,7 @@
 # found strings to search for in WriteConfModules,=20
 # from sndconfig 0.68-4 (rawhide version)
=20
-function remove_sndconfig_block() {
+remove_sndconfig_block() {
     awk '
     /^alias sound-slot-0/ { modulename =3D $3 ; next }
     /^alias sound-slot-[0-9]/ { next }
@@ -192,18 +201,18 @@
 #
 # remove the previous configuration by alsaconf
 #
-function remove_ac_block() {
+remove_ac_block() {
     awk '/^'"$ACB"'$/,/^'"$ACE"'$/ { next } { print }'
 }
=20
 #
 # set default mixer volumes
 #
-function mixer() {
+mixer() {
   amixer set "$1" "$2" unmute >/dev/null 2>&1
 }
=20
-function set_mixers() {
+set_mixers() {
     mixer Master 75%
     mixer PCM 90%
     mixer Synth 90%
@@ -224,7 +233,7 @@
=20
=20
 # INTRO
-function intro() {
+intro() {
 $DIALOG --msgbox "
                    ALSA  CONFIGURATOR
                           v$version
@@ -240,7 +249,7 @@
 }
=20
 # FAREWELL
-function farewell() {
+farewell() {
 $DIALOG --msgbox "
=20
      $*
@@ -249,7 +258,7 @@
=20
           will prepare the card for playing now.
=20
-     Now I'll run 'alsasound start', then I'll use
+     Now I'll run '`basename $rcalsasound` start', then I'll use
      amixer to raise the default volumes.
      You can change the volume later via a mixer
      program such as alsamixer or gamix.
@@ -258,7 +267,7 @@
 }
=20
 # Exit function
-function acex() {
+acex() {
   cleanup
   clear
   exit $1
@@ -267,7 +276,10 @@
 #
 # search for alsasound init script
 #
-if [ -x /etc/init.d/alsasound ]; then
+
+if [ "$distribution" =3D "debian" ]; then
+    rcalsasound=3D/etc/init.d/alsa
+elif [ -x /etc/init.d/alsasound ]; then
     rcalsasound=3D/etc/init.d/alsasound
 elif [ -x /usr/sbin/rcalsasound ]; then
     rcalsasound=3D/usr/sbin/rcalsasound
@@ -310,7 +322,7 @@
 trap cleanup 0=20
=20
 # convert ISA PnP id number to string 'ABC'
-function convert_isapnp_id () {
+convert_isapnp_id () {
     let a=3D'('$1'>>2) & 0x3f'
     let b=3D'(('$1' & 0x03) << 3) | (('$1' >> 13) & 0x07)'
     let c=3D'('$1'>> 8) & 0x1f'
@@ -319,14 +331,14 @@
 }
=20
 # swap high & low bytes
-function swap_number () {
+swap_number () {
     let v=3D'(('$1'>>8)&0xff)|(('$1'&0xff)<<8)'
     printf "%04x" $v
 }
=20
 # build card database
 # build_card_db filename
-function build_card_db () {
+build_card_db () {
     MODDIR=3D/lib/modules/`uname -r`
     last_driver=3D""
     echo -n > $1
@@ -363,7 +375,7 @@
 #
 # probe cards
 #
-function probe_cards () {
+probe_cards () {
     test -r /proc/isapnp || /sbin/modprobe isapnp >/dev/null 2>&1
     test -r /proc/isapnp || /sbin/modprobe isa-pnp >/dev/null 2>&1
     if [ -r /proc/isapnp ]; then
@@ -403,14 +415,14 @@
 	print perc;
 	idx++;
 }
-/^[[:space:]]*PCI: /{
+/^[<literal space><literal tab>]*PCI: /{
 	gsub(/0x/, "");
 	gsub(/=3D/, ":");
 	x =3D sprintf ("/sbin/lspci -n | grep '"'Class 0401'"' | grep %s", $2);
 	if (system (x) =3D=3D 0)
 		printf "%s %s\n", $2, driver >>"'"$FOUND"'"
 }
-/^[[:space:]]*ISAPNP: /{
+/^[<literal space><literal tab>]*ISAPNP: /{
 	gsub(/=3D.*/, "");
 	x =3D sprintf ("grep '\''^Card [0-9] .%s:'\'' '"$DUMP"'", $2);
 	if (system (x) =3D=3D 0)
@@ -434,7 +446,7 @@
 #
 # look for a descriptive device name from the given device id
 #
-function find_device_name () {
+find_device_name () {
     if expr "$1" : '[0-9a-f][0-9a-f][0-9a-f][0-9a-f]:[0-9a-f][0-9a-f][0-9a=
-f][0-9a-f]' >/dev/null; then
 	/sbin/lspci -d $1 | sed -e 's/^..:..\.. Multimedia audio controller: //g'
 	return
@@ -449,7 +461,7 @@
 #
 # configure and try test sound
 #
-function ac_config_card () {
+ac_config_card () {
=20
     CARD_DRIVER=3Dsnd-$1
     CARD_OPTS=3D"${*:2}"
@@ -526,9 +538,14 @@
     fi
=20
     farewell "OK, driver $CARD_DRIVER is configured."
-    echo Loading driver..
+    clear
+    if [ "$distribution" =3D "debian" ]; then
+      echo Running update-modules...
+      update-modules
+    fi
+    echo Loading driver...
     $rcalsasound start
-    echo Setting default volumes..
+    echo Setting default volumes...
     if [ -x /usr/bin/set_default_volume ]; then
 	/usr/bin/set_default_volume -f
     else
@@ -569,7 +586,7 @@
 # probe legacy ISA cards
 #
=20
-function check_dma_avail () {
+check_dma_avail () {
     if [ -r /proc/dma ]; then
 	list=3D""
 	for dma in $*; do
@@ -579,7 +596,7 @@
     fi
 }
=20
-function check_irq_avail () {
+check_irq_avail () {
     if [ -r /proc/interrupts ]; then
 	list=3D""
 	for irq in $*; do
@@ -591,7 +608,7 @@
=20
 # check playback
 # return 0 - OK, 1 - NG, 2 - not working (irq/dma problem)
-function ac_try_load () {
+ac_try_load () {
     echo "alias char-major-116 snd
 alias snd-card-0 snd-card-$1
 options snd ${mpfx}major=3D116 ${mpfx}cards_limit=3D1
@@ -631,7 +648,7 @@
 # check capture
 # return 0 - OK, 1 - NG, 2 - not working (irq/dma problem)
 # ac_try_capture card duplex opts
-function ac_try_capture () {
+ac_try_capture () {
     echo "alias char-major-116 snd
 alias snd-card-0 snd-$1
 options snd ${mpfx}major=3D116 ${mpfx}cards_limit=3D1
@@ -674,7 +691,7 @@
     fi
 }
=20
-function get_dma_pair () {
+get_dma_pair () {
     case $1 in
     0)
 	echo 1 3 5;;
@@ -693,7 +710,7 @@
 # ac_try_irq card opts irqs...
 # return 0 - OK, 1 - NG, 2 - not working (dma problem?)
 #
-function ac_try_irq () {
+ac_try_irq () {
     card=3D$1
     opts=3D"$2 ${mpfx}irq=3D$3"
     ac_try_load $card $opts >/dev/null 2>&1
@@ -724,7 +741,7 @@
 # ac_try_dmas card opts irqs...
 # return 0 - OK, 1 - NG
 #
-function ac_try_dmas () {
+ac_try_dmas () {
     dma_list=3D`check_dma_avail 1 0 3 5`
     for irq in ${*:3}; do
 	for dma1 in $dma_list; do
@@ -760,13 +777,13 @@
 }
=20
 # check if the option $2 exists in card =A71: set value $3
-function ac_check_option () {
+ac_check_option () {
     if modinfo -p snd-$1 | grep $2 > /dev/null 2>&1 ; then
       echo "$2=3D$3"
     fi
 }
   =20
-function ac_try_card_sb8 () {
+ac_try_card_sb8 () {
     card=3Dsb8
     irq_list=3D`check_irq_avail 5 3 9 10 7`
     for dma8 in `check_dma_avail 1 3`; do
@@ -776,7 +793,7 @@
     return 1
 }
=20
-function ac_try_card_sb16 () {
+ac_try_card_sb16 () {
     card=3Dsb16
     isapnp=3D`ac_check_option $card ${mpfx}isapnp 0`
     opts=3D"$isapnp"
@@ -821,7 +838,7 @@
     return 1
 }
=20
-function ac_try_card_es1688 () {
+ac_try_card_es1688 () {
     card=3Des1688
     opts=3D""
     irq_list=3D`check_irq_avail 5 9 10 7`
@@ -832,14 +849,14 @@
     return 1
 }
=20
-function ac_try_card_es18xx () {
+ac_try_card_es18xx () {
     card=3Des18xx
     opts=3D`ac_check_option $card ${mpfx}isapnp 0`
     ac_try_dmas $card "$opts" `check_irq_avail 5 9 10 7` && return 0
     return 1
 }
=20
-function ac_try_card_cs4236 () {
+ac_try_card_cs4236 () {
     card=3Dcs4236
     irq_list=3D`check_irq_avail 5 7 9 11 12 15`
     isapnp=3D`ac_check_option $card ${mpfx}isapnp 0`
@@ -850,7 +867,7 @@
     return 1
 }
=20
-function ac_try_card_cs4232 () {
+ac_try_card_cs4232 () {
     card=3Dcs4232
     irq_list=3D`check_irq_avail 5 7 9 11 12 15`
     isapnp=3D`ac_check_option $card ${mpfx}isapnp 0`
@@ -861,7 +878,7 @@
     return 1
 }
=20
-function ac_try_card_cs4231 () {
+ac_try_card_cs4231 () {
     card=3Dcs4231
     irq_list=3D`check_irq_avail 5 7 9 11 12 15`
     for port in 0x530 0x534; do
@@ -871,7 +888,7 @@
     return 1
 }
=20
-function ac_try_card_opl3sa2 () {
+ac_try_card_opl3sa2 () {
     card=3Dopl3sa2
     irq_list=3D`check_irq_avail 5 9 3 1 11 12 15 0`
     isapnp=3D`ac_check_option $card ${mpfx}isapnp 0`
@@ -884,7 +901,7 @@
     return 1
 }
=20
-function ac_config_legacy () {
+ac_config_legacy () {
=20
     $DIALOG --title "WARNING" --yesno "
    Probing legacy ISA cards might make

--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="06_isa_build.dpatch"
Content-Transfer-Encoding: quoted-printable

#! /bin/sh -e

# 06_isa_build.dpatch by Steve Kowalik
#
# DP: Don't build ISA sound modules if CONFIG_ISA is n.

=2E debian/patches/patch-opts

if [ $# -ne 1 ]; then
    echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
    exit 1
fi
case "$1" in
    -patch) patch $patch_opts < $0;;
    -unpatch) patch $patch_opts -R < $0;;
    *)
        echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
        exit 1;;
esac

exit 0

--- alsa-driver/Makefile~	2003-02-06 23:00:11.000000000 +1100
+++ alsa-driver/Makefile	2003-02-06 23:00:48.000000000 +1100
@@ -37,7 +37,7 @@
 endif
 endif
=20
-SUBDIRS  +=3D acore i2c drivers isa synth
+SUBDIRS  +=3D acore i2c drivers synth
 ifeq (y,$(CONFIG_PCI))
 SUBDIRS  +=3D pci
 endif
@@ -56,6 +56,9 @@
 ifeq (y,$(CONFIG_PCMCIA))
 SUBDIRS  +=3D pcmcia
 endif
+ifeq (y,$(CONFIG_ISA))
+SUBDIRS  +=3D isa
+endif
 CSUBDIRS +=3D include test utils
=20
 .PHONY: all

--hoZxPH4CaxYzWscb--

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+R+iDJYSUupF6Il4RAhKFAKDuwS0eBjUmGYpDcJzi1yagNcZTgQCfTkAe
PizP4HqeY8UPwJiyT05M+1M=
=k5T4
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
