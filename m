From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/ALC260: 2/7 - switch pin buffer enables
Date: Tue, 28 Feb 2006 10:23:35 +1030 (CST)
Message-ID: <200602272353.k1RNrZtN014672@auster.physics.adelaide.edu.au>
References: <s5hlkvxt57f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkvxt57f.wl%tiwai@suse.de> from "Takashi Iwai" at Feb 27, 2006 12:24:20 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi

This patch adds functionality which switches the input/output buffer enables
of retasking pins when the user changes their mode with the mode control.
This probably reduces noise *slightly* for recording compared to the case
where both input and output buffers were enabled simultaneously.

Regards
  jonathan


--- patch_realtek.c-01-input_mux_label	2006-02-27 22:46:52.000000000 +1030
+++ patch_realtek.c	2006-02-27 22:46:24.000000000 +1030
@@ -306,9 +306,32 @@
 		val = alc_pin_mode_min(dir);
 
 	change = pinctl != alc_pin_mode_values[val];
-	if (change)
+	if (change) {
+		/* Set pin mode to that requested */
 		snd_hda_codec_write(codec,nid,0,AC_VERB_SET_PIN_WIDGET_CONTROL,
 			alc_pin_mode_values[val]);
+
+		/* Also enable the retasking pin's input/output as required 
+		 * for the requested pin mode.  Enum values of 2 or less are
+		 * input modes.
+		 *
+		 * Dynamically switching the input/output buffers probably
+		 * reduces noise slightly, particularly on input.  However,
+		 * havingboth input and output buffers enabled
+		 * simultaneously doesn't seem to be problematic.
+		 */
+		if (val <= 2) {
+			snd_hda_codec_write(codec,nid,0,AC_VERB_SET_AMP_GAIN_MUTE,
+				AMP_OUT_MUTE);
+			snd_hda_codec_write(codec,nid,0,AC_VERB_SET_AMP_GAIN_MUTE,
+				AMP_IN_UNMUTE(0));
+		} else {
+			snd_hda_codec_write(codec,nid,0,AC_VERB_SET_AMP_GAIN_MUTE,
+				AMP_IN_MUTE(0));
+			snd_hda_codec_write(codec,nid,0,AC_VERB_SET_AMP_GAIN_MUTE,
+				AMP_OUT_UNMUTE);
+		}
+	}
 	return change;
 }
 
@@ -2744,14 +2767,16 @@
 
         /* Unmute HP pin widget amp left and right (no equiv mixer ctrl) */
         {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-        /* Unmute Line1 pin widget amp left and right (no equiv mixer ctrl) */
+        /* Unmute Line1 pin widget output buffer since it starts as an output.
+         * If the pin mode is changed by the user the pin mode control will
+         * take care of enabling the pin's input/output buffers as needed.
+         * Therefore there's no need to enable the input buffer at this
+         * stage.
+	 */
         {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-        /* Unmute Line1 pin widget input for when this pin is used as input
-         * (no equiv mixer ctrl).  Having input and output unmuted doesn't
-         * seem to cause a problem.
-         */
-        {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	/* Unmute pin widget used for Line-in (no equiv mixer ctrl) */
+	/* Unmute input buffer of pin widget used for Line-in (no equiv 
+	 * mixer ctrl)
+	 */
         {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 
         /* Mute capture amp left and right */
@@ -2882,7 +2907,11 @@
 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 
-	/* Unmute retasking pin widget output amp left/right (no mixer ctrl) */
+	/* Unmute retasking pin widget output buffers since the default
+	 * state appears to be output.  As the pin mode is changed by the
+	 * user the pin mode control will take care of enabling the pin's
+	 * input/output buffers as needed.
+	 */
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
@@ -2892,17 +2921,6 @@
 	/* Also unmute the mono-out pin widget */
 	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 
-	/* Also unmute the retasking pin input amps.  Having the input and
-	 * output amps unmuted at the same time doesn't appear to cause any
-	 * trouble.
-	 */
-	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-
 	/* Mute capture amp left and right */
 	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	/* Set ADC connection select to match default mixer setting - line 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
