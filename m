From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-info: Run without lspci (if there is no
	pci bus)
Date: Fri,  9 Aug 2013 14:47:49 +0200
Message-ID: <1376052469-6022-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D519526577F
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 14:47:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On some embedded ARM hardware, there is no pci bus. In that case,
do not require lspci so we can still get as much info as we can.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsa/utils/alsa-info.sh |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/alsa/utils/alsa-info.sh b/alsa/utils/alsa-info.sh
index 9d996aa..2280af5 100755
--- a/alsa/utils/alsa-info.sh
+++ b/alsa/utils/alsa-info.sh
@@ -393,8 +393,10 @@ trap cleanup 0
 if [ "$PROCEED" = "yes" ]; then
 
 if [ -z "$LSPCI" ]; then
-	echo "This script requires lspci. Please install it, and re-run this script."
-	exit 0
+	if [ -d /sys/bus/pci ]; then
+		echo "This script requires lspci. Please install it, and re-run this script."
+		exit 0
+	fi
 fi
 
 #Fetch the info and store in temp files/variables
@@ -407,8 +409,6 @@ KERNEL_OS=`uname -o`
 ALSA_DRIVER_VERSION=`cat /proc/asound/version |head -n1|awk {'print $7'} |sed 's/\.$//'`
 get_alsa_library_version
 ALSA_UTILS_VERSION=`amixer -v |awk {'print $3'}`
-VENDOR_ID=`lspci -vn | grep 040[1-3] | awk -F':' '{print $3}'| awk {'print substr($0, 2);}' >$TEMPDIR/vendor_id.tmp`
-DEVICE_ID=`lspci -vn | grep 040[1-3] | awk -F':' '{print $4}'| awk {'print $1'} >$TEMPDIR/device_id.tmp`
 LAST_CARD=$((`grep "]: " /proc/asound/cards | wc -l` - 1 ))
 
 ESDINST=$(which esd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
@@ -434,7 +434,9 @@ fi
 
 cat /proc/asound/modules 2>/dev/null|awk {'print $2'}>$TEMPDIR/alsamodules.tmp
 cat /proc/asound/cards >$TEMPDIR/alsacards.tmp
+if [[ ! -z "$LSPCI" ]]; then
 lspci |grep -i "multi\|audio">$TEMPDIR/lspci.tmp
+fi
 
 #Check for HDA-Intel cards codec#*
 cat /proc/asound/card*/codec\#* > $TEMPDIR/alsa-hda-intel.tmp 2> /dev/null
@@ -547,6 +549,8 @@ echo "" >> $FILE
 cat $TEMPDIR/alsacards.tmp >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
+
+if [[ ! -z "$LSPCI" ]]; then
 echo "!!PCI Soundcards installed in the system" >> $FILE
 echo "!!--------------------------------------" >> $FILE
 echo "" >> $FILE
@@ -559,6 +563,7 @@ echo "" >> $FILE
 lspci -vvn |grep -A1 040[1-3] >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
+fi
 
 if [ "$SNDOPTIONS" ]
 then
-- 
1.7.9.5
