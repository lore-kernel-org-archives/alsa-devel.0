From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] alsa-info.sh: add dmesg info on ALSA/HDA
Date: Thu, 16 Jul 2009 19:24:06 +0800
Message-ID: <20090716112406.GA5431@localhost>
References: <20090708130722.723912338@intel.com> <s5hskgxnevi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F58510381C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 13:24:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskgxnevi.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 05:42:09PM +0800, Takashi Iwai wrote:
> At Wed, 08 Jul 2009 21:07:22 +0800,
> Wu Fengguang wrote:
> > 
> > Hi Takashi,
> > 
> > This patchset mainly disables the auto-upload of alsa info by default.
> 
> I pushed the patches now.  Thanks!

Thank you!

btw, I find it often necessary to query user for the dmesg info.
How about adding dmesg to alsa-info?

Thanks,
Fengguang
---
alsa-info.sh: add dmesg info on ALSA/HDA

Add outputs:
		dmesg | grep -E 'ALSA|HDA|HDMI|sound|hda.codec|hda.intel'
which should cover most ALSA HDA kernel messages.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 utils/alsa-info.sh |   44 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

--- alsa-driver.orig/utils/alsa-info.sh
+++ alsa-driver/utils/alsa-info.sh
@@ -243,6 +243,15 @@ withsysfs() {
     fi
 }
 
+withdmesg() {
+	echo "!!ALSA/HDA dmesg" >> $FILE
+	echo "!!------------------" >> $FILE
+	echo "" >> $FILE
+	dmesg | grep -E 'ALSA|HDA|HDMI|sound|hda.codec|hda.intel' >> $FILE
+	echo "" >> $FILE
+	echo "" >> $FILE
+}
+
 withall() {
 	withdevices
 	withconfigs
@@ -251,6 +260,7 @@ withall() {
 	withalsactl
 	withlsmod
 	withsysfs
+	withdmesg
 }
 
 get_alsa_library_version() {
@@ -341,15 +351,31 @@ done
 
 #Script header output.
 if [ "$WELCOME" = "yes" ]; then
+greeting_message="\
+
+This script visits the following commands/files to collect diagnostic
+information about your ALSA installation and sound related hardware.
+
+  dmesg
+  lspci
+  lsmod
+  aplay
+  amixer
+  alsactl
+  /proc/asound/
+  /sys/class/sound/
+  ~/.asoundrc (etc.)
+
+See '$0 --help' for command line options.
+"
 if [[ -n "$DIALOG" ]]; then
-	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v $SCRIPT_VERSION" --msgbox "\nThis script visits the following commands/files to collect diagnostic information about your ALSA installation and sound related hardware.\n\n  lspci\n  lsmod\n  aplay\n  amixer\n  alsactl\n  /proc/asound/\n  /sys/class/sound/\n  ~/.asoundrc (etc.)\n\nSee '$0 --help' for command line options.\n" 20 80
+	dialog  --backtitle "$BGTITLE" \
+		--title "ALSA-Info script v $SCRIPT_VERSION" \
+		--msgbox "$greeting_message" 20 80
 else
-
-echo "ALSA Information Script v $SCRIPT_VERSION"
-echo "--------------------------------"
-echo ""
-echo "This script will collect information about your ALSA installation and sound related hardware, to help diagnose your problem."
-echo ""
+	echo "ALSA Information Script v $SCRIPT_VERSION"
+	echo "--------------------------------"
+	echo "$greeting_message"
 fi # dialog
 fi # WELCOME
 
@@ -619,6 +645,9 @@ then
 		--with-devices)
 			withdevices
 			;;
+		--with-dmesg)
+			withdmesg
+			;;
 		--with-configs)
 			if [[ -e $HOME/.asoundrc ]] || [[ -e /etc/asound.conf ]]
 			then
@@ -674,6 +703,7 @@ then
 			echo "	--with-configs (includes the output of ~/.asoundrc and"
 			echo "	    /etc/asound.conf if they exist)" 
 			echo "	--with-devices (shows the device nodes in /dev/snd/)"
+			echo "	--with-dmesg (shows the ALSA/HDA kernel messages)"
 			echo ""
 			echo "	--update (check server for script updates)"
 			echo "	--upload (upload contents to remote server)"
