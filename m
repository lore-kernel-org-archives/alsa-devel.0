From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 4/4] alsa-info.sh: introduce withall()
Date: Wed, 08 Jul 2009 21:07:26 +0800
Message-ID: <20090708131504.317462072@intel.com>
References: <20090708130722.723912338@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2557B1038A4
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 15:16:37 +0200 (CEST)
Content-Disposition: inline; filename=alsa-de-duplicate.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

This merges duplicate code. The only behavior change is, we will now call
withsysfs() when no options are provided. I guess this is desired info.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 utils/alsa-info.sh |   64 +++++++++++--------------------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

--- alsa-driver.orig/utils/alsa-info.sh
+++ alsa-driver/utils/alsa-info.sh
@@ -243,6 +243,16 @@ withsysfs() {
     fi
 }
 
+withall() {
+	withdevices
+	withconfigs
+	withaplay
+	withamixer
+	withalsactl
+	withlsmod
+	withsysfs
+}
+
 get_alsa_library_version() {
 	ALSA_LIB_VERSION=`grep VERSION_STR /usr/include/alsa/version.h 2>/dev/null|awk {'print $3'}|sed 's/"//g'`
 
@@ -559,12 +569,7 @@ fi
 if [[ -z "$1" ]]
 then
 	update
-	withdevices
-	withconfigs
-	withaplay
-	withamixer
-	withalsactl
-	withlsmod
+	withall
 	pbcheck	
 fi
 
@@ -578,13 +583,7 @@ then
 	case "$1" in
 		--pastebin)
 		        update
-        		withdevices
-        		withconfigs
-        		withaplay
-        		withamixer
-        		withalsactl
-        		withlsmod
-			withsysfs
+			withall
         		pbcheck
 			;;
 		--update)
@@ -593,44 +592,20 @@ then
 			;;
 		--upload)
 			UPLOAD="yes"
-			withdevices
-			withconfigs
-			withaplay
-			withamixer
-			withalsactl
-			withlsmod
-			withsysfs
+			withall
 			;;
 		--no-upload)
 			UPLOAD="no"
-			withdevices
-			withconfigs
-			withaplay
-			withamixer
-			withalsactl
-			withlsmod
-			withsysfs
+			withall
 			;;
 		--debug)
 			echo "Debugging enabled. $FILE and $TEMPDIR will not be deleted"
 			KEEP_FILES="yes"
 			echo ""
-			withdevices
-			withconfigs
-			withaplay
-			withamixer
-			withalsactl
-			withlsmod
-			withsysfs
+			withall
 			;;
 		--with-all)
-			withdevices
-			withconfigs
-			withaplay
-			withamixer
-			withalsactl
-			withlsmod
-			withsysfs
+			withall
 			;;
 		--with-aplay)
 			withaplay
@@ -674,12 +649,7 @@ then
 			;;
 		--stdout)
 			UPLOAD="no"
-			withdevices
-			withconfigs
-			withaplay
-			withamixer
-			withalsactl
-			withlsmod
+			withall
 			cat $FILE
 			rm $FILE
 			;;

-- 
