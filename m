From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] alsa-info: Refactor "withall" logic
Date: Fri, 22 Aug 2014 10:31:41 +0200
Message-ID: <1408696301-5622-2-git-send-email-david.henningsson@canonical.com>
References: <1408696301-5622-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 69039265741
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 10:31:44 +0200 (CEST)
In-Reply-To: <1408696301-5622-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Previously, using --output, --no-upload, --upload and --pastebin
switches implied the withall switch.

A more intuitive logic would be that --with-all is disabled if you
use another --with* switch, such as --withdmesg, and only then.

Also update script version to reflect the behaviour change.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsa-info/alsa-info.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 47157f0..acd8495 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.63
+SCRIPT_VERSION=0.4.64
 CHANGELOG="http://www.alsa-project.org/alsa-info.sh.changelog"
 
 #################################################################################
@@ -260,6 +260,7 @@ withall() {
 	withlsmod
 	withsysfs
 	withdmesg
+	WITHALL="no"
 }
 
 get_alsa_library_version() {
@@ -629,7 +630,6 @@ fi
 #If no command line options are specified, then run as though --with-all was specified
 if [ -z "$1" ]; then
 	update
-	withall
 	pbcheck	
 fi
 
@@ -642,7 +642,6 @@ if [ -n "$1" ]; then
 	case "$1" in
 		--pastebin)
 		        update
-			withall
         		pbcheck
 			;;
 		--update)
@@ -651,43 +650,45 @@ if [ -n "$1" ]; then
 			;;
 		--upload)
 			UPLOAD="yes"
-			withall
 			;;
 		--no-upload)
 			UPLOAD="no"
-			withall
 			;;
 		--output)
 			shift
 			NFILE="$1"
 			KEEP_OUTPUT="yes"
-			withall
 			;;
 		--debug)
 			echo "Debugging enabled. $FILE and $TEMPDIR will not be deleted"
 			KEEP_FILES="yes"
 			echo ""
-			withall
 			;;
 		--with-all)
 			withall
 			;;
 		--with-aplay)
 			withaplay
+			WITHALL="no"
 			;;
 		--with-amixer)
 			withamixer
+			WITHALL="no"
 			;;
 		--with-alsactl)
 			withalsactl
+			WITHALL="no"
 			;;
 		--with-devices)
 			withdevices
+			WITHALL="no"
 			;;
 		--with-dmesg)
 			withdmesg
+			WITHALL="no"
 			;;
 		--with-configs)
+			WITHALL="no"
 			if [[ -e $HOME/.asoundrc ]] || [[ -e /etc/asound.conf ]]
 			then
 				echo "!!ALSA configuration files" >> $FILE
@@ -717,7 +718,9 @@ if [ -n "$1" ]; then
 			;;
 		--stdout)
 			UPLOAD="no"
-			withall
+			if [ -z "$WITHALL" ]; then
+				withall
+			fi
 			cat $FILE
 			rm $FILE
 			;;
@@ -766,6 +769,10 @@ if [ "$PROCEED" = "no" ]; then
 	exit 1
 fi
 
+if [ -z "$WITHALL" ]; then
+	withall
+fi
+
 if [ "$UPLOAD" = "ask" ]; then
 	if [ -n "$DIALOG" ]; then
 		dialog --backtitle "$BGTITLE" --title "Information collected" --yes-label " UPLOAD / SHARE " --no-label " SAVE LOCALLY " --defaultno --yesno "\n\nAutomatically upload ALSA information to $WWWSERVICE?" 10 80
-- 
1.9.1
