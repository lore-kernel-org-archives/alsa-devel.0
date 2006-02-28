From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/ALC260: 6/7 - Fujitsu/test model tweaks
Date: Tue, 28 Feb 2006 10:50:42 +1030 (CST)
Message-ID: <200602280020.k1S0KgDV017061@auster.physics.adelaide.edu.au>
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

This patch is janitorial - it cleans up a number of cosmetic issues with
the "fujitsu" and "test" models.  Issues addressed:

 * spaces instead of tabs used for some indents,

 * clarified/corrected selected comments.

Unlike a patch from earlier this week, this keeps both ADCs connected to
the mic1 pin widget by default.  I believe this is the better default, since
some laptops don't bring the line1 widget to the outside world.  Most (if
not all) do bring mic1 out though, so it seems to me that this default
should remain in place.

Regards
  jonathan

--- patch_realtek.c-05-add_acer_model	2006-02-28 00:17:48.000000000 +1030
+++ patch_realtek.c	2006-02-28 00:17:29.000000000 +1030
@@ -2819,28 +2819,28 @@
 	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
 	/* Headphone/Line-out jack connects to Line1 pin; make it an output */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-        /* Mic/Line-in jack is connected to mic1 pin, so make it an input */
-        {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
-        /* Ensure all other unused pins are disabled and muted.
-	 * Note: trying to set widget 0x15 to anything blocks all audio
-	 * output for some reason, so just leave that at the default.
-	 */
-        {0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
-        {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	/* Mic/Line-in jack is connected to mic1 pin, so make it an input */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	/* Ensure all other unused pins are disabled and muted. */
+	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
-        {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
-        {0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-        /* Disable digital (SPDIF) pins */
-        {0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
-        {0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
-
-        /* Ensure Line1 pin widget takes its input from the OUT1 sum bus 
-         * when acting as an output.
-         */
-        {0x0d, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+
+	/* Disable digital (SPDIF) pins */
+	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
+	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
 
-        /* Start with output sum widgets muted and their output gains at min */
+	/* Ensure Line1 pin widget takes its input from the OUT1 sum bus 
+	 * when acting as an output.
+	 */
+	{0x0d, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* Start with output sum widgets muted and their output gains at min */
 	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
 	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
@@ -2851,42 +2851,42 @@
 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 
-        /* Unmute HP pin widget amp left and right (no equiv mixer ctrl) */
-        {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-        /* Unmute Line1 pin widget output buffer since it starts as an output.
-         * If the pin mode is changed by the user the pin mode control will
-         * take care of enabling the pin's input/output buffers as needed.
-         * Therefore there's no need to enable the input buffer at this
-         * stage.
+	/* Unmute HP pin widget amp left and right (no equiv mixer ctrl) */
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Unmute Line1 pin widget output buffer since it starts as an output.
+	 * If the pin mode is changed by the user the pin mode control will
+	 * take care of enabling the pin's input/output buffers as needed.
+	 * Therefore there's no need to enable the input buffer at this
+	 * stage.
 	 */
-        {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	/* Unmute input buffer of pin widget used for Line-in (no equiv 
 	 * mixer ctrl)
 	 */
-        {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 
-        /* Mute capture amp left and right */
-        {0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-        /* Set ADC connection select to match default mixer setting - line 
-         * in (on mic1 pin)
-         */
-        {0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
-
-        /* Do the same for the second ADC: mute capture input amp and
-         * set ADC connection to line in
-         */
-        {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-        {0x05, AC_VERB_SET_CONNECT_SEL, 0x00},
-
-        /* Mute all inputs to mixer widget (even unconnected ones) */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}, /* mic2 pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)}, /* line1 pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)}, /* line2 pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)}, /* CD pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)}, /* Beep-gen pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)}, /* Line-out pin */
-        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)}, /* HP-pin pin */
+	/* Mute capture amp left and right */
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	/* Set ADC connection select to match default mixer setting - line 
+	 * in (on mic1 pin)
+	 */
+	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Do the same for the second ADC: mute capture input amp and
+	 * set ADC connection to line in (on mic1 pin)
+	 */
+	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x05, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Mute all inputs to mixer widget (even unconnected ones) */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}, /* mic2 pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)}, /* line1 pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)}, /* line2 pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)}, /* CD pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)}, /* Beep-gen pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)}, /* Line-out pin */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)}, /* HP-pin pin */
 
 	{ }
 };
@@ -3068,7 +3068,7 @@
 	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
 	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
 
-	/* Ensure mic1, mic2, line1 and line2 pin widget take input from the 
+	/* Ensure mic1, mic2, line1 and line2 pin widgets take input from the 
 	 * OUT1 sum bus when acting as an output.
 	 */
 	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
@@ -3103,13 +3103,13 @@
 
 	/* Mute capture amp left and right */
 	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	/* Set ADC connection select to match default mixer setting - line 
-	 * in (on mic1 pin)
+	/* Set ADC connection select to match default mixer setting (mic1
+	 * pin)
 	 */
 	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
 
 	/* Do the same for the second ADC: mute capture input amp and
-	 * set ADC connection to line in
+	 * set ADC connection to mic1 pin
 	 */
 	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x05, AC_VERB_SET_CONNECT_SEL, 0x00},


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
