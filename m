From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/ALC260: switch pin buffers when pin mode changed
Date: Thu, 23 Feb 2006 11:18:26 +1030 (CST)
Message-ID: <200602230048.k1N0mQkP006542@auster.physics.adelaide.edu.au>
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

The following patch (against CVS from 20060223) makes ALSA switch ALC260 pin
input/output buffers in tandem with pin mode changes.  This means that a
given pin only ever has a single buffer enabled and there's no need to
statically enable both input and output for pins which can be retasked by
the user as inputs and outputs.  Although there is little obvervable benefit
from doing the dynamic switching, it is arguably a neater solution from the
engineering point of view, an will probably also result in a slightly lower
noise floor when recording from such pins.

The initverbs for the test and fujitsu models have been adjusted to take
this new functionality into account.

Regards
  jonathan

--- patch_realtek.c-orig	2006-02-10 10:10:31.000000000 +1030
+++ patch_realtek.c	2006-02-23 11:05:06.000000000 +1030
@@ -306,9 +306,32 @@
 		val = alc_pin_mode_min(dir);
 
 	change = pinctl != alc_pin_mode_values[val];
-	if (change)
+	if (change) {
+		/* Set pin mode as requested */
 		snd_hda_codec_write(codec,nid,0,AC_VERB_SET_PIN_WIDGET_CONTROL,
 			alc_pin_mode_values[val]);
+
+		/* Also enable the retasking pin's input/output as required 
+		 * for the requested pin mode.  Enum values of 2 or less are
+		 * input modes.
+		 *
+		 * Dynamically switching the input/output buffers probably
+		 * reduces noise slightly, particularly on input.  However,
+		 * having both the input and output buffers enabled
+		 * simultaneously doesn't seem to be too problematic.
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
@@ -2872,7 +2897,11 @@
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
@@ -2882,17 +2911,6 @@
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
