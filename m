From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/4] alsa-info: Cosmetic heading fixup
Date: Mon, 11 Jun 2012 10:45:21 +0200
Message-ID: <1339404323-3770-2-git-send-email-david.henningsson@canonical.com>
References: <1339404323-3770-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id AEBEA1041B6
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 10:45:33 +0200 (CEST)
In-Reply-To: <1339404323-3770-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The number of ---- should match the corresponding headers.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 utils/alsa-info.sh |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index 46d2ebb..01429a5 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -111,7 +111,7 @@ cleanup() {
 
 withaplay() {
         echo "!!Aplay/Arecord output" >> $FILE
-        echo "!!------------" >> $FILE
+        echo "!!--------------------" >> $FILE
         echo "" >> $FILE
        	echo "APLAY" >> $FILE
 	echo "" >> $FILE 
@@ -149,7 +149,7 @@ withamixer() {
 
 withalsactl() {
 	echo "!!Alsactl output" >> $FILE
-        echo "!!-------------" >> $FILE
+        echo "!!--------------" >> $FILE
         echo "" >> $FILE
         exe=""
         if [ -x /usr/sbin/alsactl ]; then
@@ -244,7 +244,7 @@ withsysfs() {
 
 withdmesg() {
 	echo "!!ALSA/HDA dmesg" >> $FILE
-	echo "!!------------------" >> $FILE
+	echo "!!--------------" >> $FILE
 	echo "" >> $FILE
 	dmesg | grep -C1 -E 'ALSA|HDA|HDMI|sound|hda.codec|hda.intel' >> $FILE
 	echo "" >> $FILE
@@ -547,7 +547,7 @@ cat $TEMPDIR/lspci.tmp >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
 echo "!!Advanced information - PCI Vendor/Device/Subsystem ID's" >> $FILE
-echo "!!--------------------------------------------------------" >> $FILE
+echo "!!-------------------------------------------------------" >> $FILE
 echo "" >> $FILE
 lspci -vvn |grep -A1 040[1-3] >> $FILE
 echo "" >> $FILE
@@ -566,7 +566,7 @@ fi
 if [ -d "$SYSFS" ]
 then
 echo "!!Loaded sound module options" >> $FILE
-echo "!!--------------------------" >> $FILE
+echo "!!---------------------------" >> $FILE
 echo "" >> $FILE
 for mod in `cat /proc/asound/modules|awk {'print $2'}`;do
 echo "!!Module: $mod" >> $FILE
@@ -594,7 +594,7 @@ fi
 if [ -s "$TEMPDIR/alsa-ac97.tmp" ]
 then
         echo "!!AC97 Codec information" >> $FILE
-        echo "!!---------------------------" >> $FILE
+        echo "!!----------------------" >> $FILE
         echo "--startcollapse--" >> $FILE
         echo "" >> $FILE
         cat $TEMPDIR/alsa-ac97.tmp >> $FILE
@@ -608,7 +608,7 @@ fi
 if [ -s "$TEMPDIR/alsa-usbmixer.tmp" ]
 then
         echo "!!USB Mixer information" >> $FILE
-        echo "!!---------------------------" >> $FILE
+        echo "!!---------------------" >> $FILE
         echo "--startcollapse--" >> $FILE
         echo "" >> $FILE
         cat $TEMPDIR/alsa-usbmixer.tmp >> $FILE
-- 
1.7.9.5
