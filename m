From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] let alsaconf work on all distros
Date: Mon, 08 Sep 2003 16:58:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2vfs3uy2n.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

on mandrake, lspci is in /usr/bin, not /bin.

the following patch make alsaconf search for lspci location and
factorize binary location with lsmod btw:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsaconf.diff

--- ./alsaconf.tv	2003-09-08 16:33:13.000000000 +0200
+++ ./alsaconf	2003-09-08 16:44:03.000000000 +0200
@@ -36,11 +36,12 @@
   distribution="unknown"
 fi
 
-if [ -x /sbin/lsmod ]; then
-  lsmod=/sbin/lsmod
-else
-  lsmod=/bin/lsmod
-fi
+for prog in lspci lsmod; do
+	for path in /sbin /usr/sbin /bin /usr/bin;do
+		[[ -x $path/$prog ]] && eval $prog=$path/$prog
+	done
+done
+unset prog path
 
 usage() {
     echo "ALSA configurator version $version"
@@ -438,7 +439,7 @@
 /^[<literal space><literal tab>]*PCI: /{
 	gsub(/0x/, "");
 	gsub(/=/, ":");
-	x = sprintf ("/sbin/lspci -n | grep '"'Class 0401'"' | grep %s", $2);
+	x = sprintf ("'$lspci' -n | grep '"'Class 0401'"' | grep %s", $2);
 	if (system (x) == 0)
 		printf "%s %s\n", $2, driver >>"'"$FOUND"'"
 }
@@ -468,7 +469,7 @@
 #
 find_device_name () {
     if expr "$1" : '[0-9a-f][0-9a-f][0-9a-f][0-9a-f]:[0-9a-f][0-9a-f][0-9a-f][0-9a-f]' >/dev/null; then
-	/sbin/lspci -d $1 | sed -e 's/^..:..\.. Multimedia audio controller: //g'
+	$lspci -d $1 | sed -e 's/^..:..\.. Multimedia audio controller: //g'
 	return
     elif expr "$1" : '[A-Z@][A-Z@][A-Z@][0-9a-f][0-9a-f][0-9a-f][0-9a-f]' >/dev/null; then
 	cardname=`grep '^Card [0-9]\+ '\'$1':' $DUMP | head -n 1 | sed -e 's/^Card [0-9]\+ '\''.*:\(.*\)'\'' .*$/\1/'`
@@ -1026,7 +1027,7 @@
     # check for TP600E
     #
     if [ ${devs_found[0]} = cs46xx ]; then
-	if /sbin/lspci -nv | grep -q "Subsystem: 1014:1010"; then
+	if $lspci -nv | grep -q "Subsystem: 1014:1010"; then
 	    if $DIALOG --yesno "
  Looks like you having a Thinkpad 600E notebook.
  On this notebook, CS4236 driver should be used

--=-=-=--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
