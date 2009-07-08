From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 3/4] alsa-info.sh: let mv fail loudly
Date: Wed, 08 Jul 2009 21:07:25 +0800
Message-ID: <20090708131504.200097234@intel.com>
References: <20090708130722.723912338@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CAFE1038AD
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 15:16:38 +0200 (CEST)
Content-Disposition: inline; filename=alsa-mv-f.patch
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

When mv cannot overwrite target file, it will prompt and return TRUE.
Add the '-f' option so that it returns FALSE when failed.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 utils/alsa-info.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- alsa-driver.orig/utils/alsa-info.sh
+++ alsa-driver/utils/alsa-info.sh
@@ -74,7 +74,7 @@ update() {
 					echo "Please re-run the script"
 					rm $SHFILE 2>/dev/null
 				else
-					mv $SHFILE /tmp/alsa-info.sh || exit 1
+					mv -f $SHFILE /tmp/alsa-info.sh || exit 1
 					echo "ALSA-Info script has been downloaded as /tmp/alsa-info.sh."
 					echo "Please re-run the script from new location."
 				fi
@@ -92,7 +92,7 @@ update() {
 				echo "ALSA-Info script has been updated. Please re-run it."
 				rm $SHFILE 2>/dev/null
 			else
-				mv $SHFILE /tmp/alsa-info.sh || exit 1
+				mv -f $SHFILE /tmp/alsa-info.sh || exit 1
 				echo "ALSA-Info script has been downloaded as /tmp/alsa-info.sh."
 				echo "Please, re-run it from new location."
 			fi
@@ -750,7 +750,7 @@ fi
 if [ "$UPLOAD" = "no" ]; then
 
 	if [ -z "$TOSTDOUT" ]; then
-		mv $FILE $NFILE || exit 1
+		mv -f $FILE $NFILE || exit 1
 	fi
 
 	if [[ -n $DIALOG ]]
@@ -863,7 +863,7 @@ echo ""
 
 #We couldnt find a suitable wget, so tell the user to upload manually.
 else
-	mv $FILE $NFILE || exit 1
+	mv -f $FILE $NFILE || exit 1
 	if [[ -z $DIALOG ]]
 	then
 		if [[ -z $PASTEBIN ]]; then

-- 
