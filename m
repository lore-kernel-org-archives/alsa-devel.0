From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] hda: minor correction to fujitsu ALC260 initverbs
Date: Mon, 6 Feb 2006 12:52:15 +1030 (CST)
Message-ID: <200602060222.k162MFsk024873@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi

The following patch changes the initverbs associated with the output sum
widgets 0x08, 0x09 and 0x0a used with the fujitsu model in patch_realtek.c.
It is against alsa 1.0.11rc3.

Currently these widgets have their output muted, but a close reading of the
datasheet suggests that they don't actually have an output mute.  They have
an *input* mute for each of their two inputs and a single output gain. This
patch therefore activates the input mutes and zeros the output gain.  It has
not yet been tested but the above interpretation of the ALC260 datasheet
seems correct.

Regards
  jonathan

--- patch_realtek.c-orig	2006-01-27 22:35:02.000000000 +1030
+++ patch_realtek.c	2006-02-06 12:44:19.000000000 +1030
@@ -2645,10 +2645,16 @@
         {0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
         {0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
 
-        /* Start with mixer outputs muted */
-        {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-        {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-        {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+        /* Start with output sum widgets muted and their output gains at min */
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 
         /* Unmute HP pin widget amp left and right (no equiv mixer ctrl) */
         {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
