From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: ALSA 1.0.0pre3 release
Date: Thu, 27 Nov 2003 01:46:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC5495B.1030409@undata.org>
References: <s5h7k1oz2v0.wl@alsa2.suse.de>	<3FC4D6EC.5070504@undata.org> <s5h7k1nxdl1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060205010801010304080200"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k1nxdl1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060205010801010304080200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote :

>>Takashi it seems that at least for hdsploader (I didn't check the other 
>>tools) you forgot the trailing / in DATAPATH in Makefile.am, so the 
>>program fails to find the firmware file :
>>Unable to open file 
>>'/usr/local/share/alsa/firmware/hdsploadermultiface_firmware.bin' for 
>>reading
> 
> 
> oh yes, you're right.
> is the attached patch ok?
> i'll check it in.
> 

Good for me, thanks.
Please also apply the attached patch to hdspmixer, it fixes some 
problems with default presets file handling.

Thomas.

--------------060205010801010304080200
Content-Type: text/plain;
 name="hdspmixer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdspmixer.diff"

diff -Naur hdspmixer.orig/src/HDSPMixerWindow.cxx hdspmixer/src/HDSPMixerWindow.cxx
--- hdspmixer.orig/src/HDSPMixerWindow.cxx	2003-11-27 01:36:29.000000000 +0100
+++ hdspmixer/src/HDSPMixerWindow.cxx	2003-11-27 01:35:01.000000000 +0100
@@ -397,7 +397,13 @@
 {
     FILE *file;
     if ((file = fopen(file_name, "r")) == NULL) {
+	int i = 0;
 	fl_alert("Error opening file %s for reading", file_name);
+	while (cards[i] != NULL) {
+	    restoreDefaults(i++);
+	}
+	inputs->buttons->presets->preset_change(1);	
+	return;
     }
     for (int speed = 0; speed < 3; ++speed) {
 	for (int card = 0; card < 3; ++card) {
@@ -533,6 +539,7 @@
 	h9632_an12_submix[2] = 1;
 	num_modes = 3;
 	phones = 0;
+	break;
     default:
 	/* should never happen */
 	return;
@@ -624,8 +631,18 @@
     cards[2] = hdsp_card3;
     current_card = current_preset = 0;
     prefs = new Fl_Preferences(Fl_Preferences::USER, "thomasATundata.org", "HDSPMixer");
-    if (!prefs->get("default_file", file_name_buffer, NULL, FL_PATH_MAX-1)) file_name = NULL;
-    else file_name = file_name_buffer;
+    if (!prefs->get("default_file", file_name_buffer, NULL, FL_PATH_MAX-1)) {
+	file_name = NULL;
+    } else {
+	struct stat buf;
+	if (!stat(file_name_buffer, &buf)) {
+	    file_name = file_name_buffer;
+	} else {
+	    file_name = NULL;
+	    prefs->deleteEntry("default_file");
+	    prefs->flush();
+	}	
+    }
     for (int j = 0; j < 3; ++j) {
 	for (int i = 0; i < 8; ++i) {
 	    data[j][0][i] = new HDSPMixerPresetData();
diff -Naur hdspmixer.orig/src/HDSPMixerWindow.h hdspmixer/src/HDSPMixerWindow.h
--- hdspmixer.orig/src/HDSPMixerWindow.h	2003-11-27 01:36:29.000000000 +0100
+++ hdspmixer/src/HDSPMixerWindow.h	2003-11-27 01:25:03.000000000 +0100
@@ -35,6 +35,9 @@
 #include <stdlib.h>
 #include <math.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
 #include <alsa/asoundlib.h>
 #include <sound/hdsp.h>
 #include "HDSPMixerCard.h"

--------------060205010801010304080200--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
