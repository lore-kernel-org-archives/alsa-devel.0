From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/ALC260: 5/7 - add "acer" model
Date: Tue, 28 Feb 2006 10:45:54 +1030 (CST)
Message-ID: <200602280015.k1S0FsAF016737@auster.physics.adelaide.edu.au>
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

This patch adds a new "acer" model.  It is based on work by Rimas and many
other dedicated Acer owners over the past few weeks (see bug number 
1618) - kudos to them. This adds support for a variety of Acer laptops,
although we are still in the process of collecting pci/subsystem IDs to add. 
There are still some potentially outstanding issues: there are reports that
the CD control might not yet be functional for example.  However, the time
is probably right to get a "first cut" into the kernel which can be refined
as more test reports come in.

>From the reports by various Acer owners, this code allows them to record
from internal mics and external jacks.  Playback also seems to work to all
external jacks and the internal speaker.  The "beep" control doesn't appear
functional at the moment.

This patch depends on the changes made in patch 3/7.

Regards
  jonathan


--- patch_realtek.c-04-add_test_model_gpio_switches	2006-02-28 00:18:09.000000000 +1030
+++ patch_realtek.c	2006-02-28 00:17:48.000000000 +1030
@@ -64,6 +64,7 @@
 	ALC260_HP,
 	ALC260_HP_3013,
 	ALC260_FUJITSU_S702X,
+	ALC260_ACER,
 #ifdef CONFIG_SND_DEBUG
 	ALC260_TEST,
 #endif
@@ -2504,6 +2505,19 @@
 	},
 };
 
+/* Acer TravelMate(/Extensa/Aspire) notebooks have similar configutation to
+ * the Fujitsu S702x, but jacks are marked differently. We won't allow
+ * retasking the Headphone jack, so it won't be available here.
+ */
+static struct hda_input_mux alc260_acer_capture_source = {
+	.num_items = 3,
+	.items = {
+		{ "Mic", 0x0 },
+		{ "Line", 0x2 },
+		{ "CD", 0x4 },
+	},
+};
+
 /*
  * This is just place-holder, so there's something for alc_build_pcms to look
  * at when it calculates the maximum number of channels. ALC260 has no mixer
@@ -2521,6 +2535,7 @@
  * HP: base_output + input + capture_alt
  * HP_3013: hp_3013 + input + capture
  * fujitsu: fujitsu + capture
+ * acer: acer + capture
  */
 
 static struct snd_kcontrol_new alc260_base_output_mixer[] = {
@@ -2579,6 +2594,22 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc260_acer_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0x08, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Master Playback Switch", 0x08, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x07, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x07, 0x0, HDA_INPUT),
+	ALC_PIN_MODE("Mic Jack Mode", 0x12, ALC_PIN_DIR_IN),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x07, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x07, 0x02, HDA_INPUT),
+	ALC_PIN_MODE("Line Jack Mode", 0x14, ALC_PIN_DIR_INOUT),
+	HDA_CODEC_VOLUME("Beep Playback Volume", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("Beep Playback Switch", 0x07, 0x05, HDA_INPUT),
+	{ } /* end */
+};
+
 /* capture mixer elements */
 static struct snd_kcontrol_new alc260_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x04, 0x0, HDA_INPUT),
@@ -2860,6 +2891,90 @@
 	{ }
 };
 
+/* Initialisation sequence for ALC260 as configured in Acer TravelMate and
+ * similar laptops (adapted from Fujitsu init verbs).
+ */
+static struct hda_verb alc260_acer_init_verbs[] = {
+	/* On TravelMate laptops, GPIO 0 enables the internal speaker and
+	 * the headphone jack.  Turn this on and rely on the standard mute
+	 * methods whenever the user wants to turn these outputs off.
+	 */
+	{0x01, AC_VERB_SET_GPIO_MASK, 0x01},
+	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
+	{0x01, AC_VERB_SET_GPIO_DATA, 0x01},
+	/* Internal speaker/Headphone jack is connected to Line-out pin */
+	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Internal microphone/Mic jack is connected to Mic1 pin */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
+	/* Line In jack is connected to Line1 pin */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	/* Ensure all other unused pins are disabled and muted. */
+	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	/* Disable digital (SPDIF) pins */
+	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
+	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
+
+	/* Ensure Mic1 and Line1 pin widgets take input from the OUT1 sum 
+	 * bus when acting as outputs.
+	 */
+	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x0d, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* Start with output sum widgets muted and their output gains at min */
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+
+	/* Unmute Line-out pin widget amp left and right (no equiv mixer ctrl) */
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Unmute Mic1 and Line1 pin widget input buffers since they start as
+	 * inputs. If the pin mode is changed by the user the pin mode control
+	 * will take care of enabling the pin's input/output buffers as needed.
+	 * Therefore there's no need to enable the input buffer at this
+	 * stage.
+	 */
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+	/* Mute capture amp left and right */
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	/* Set ADC connection select to match default mixer setting - mic
+	 * (on mic1 pin)
+	 */
+	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Do similar with the second ADC: mute capture input amp and
+	 * set ADC connection to line (on line1 pin)
+	 */
+	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x05, AC_VERB_SET_CONNECT_SEL, 0x02},
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
+
+	{ }
+};
+
 /* Test configuration for debugging, modelled after the ALC880 test
  * configuration.
  */
@@ -3296,6 +3411,8 @@
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3016, .config = ALC260_HP },
 	{ .modelname = "fujitsu", .config = ALC260_FUJITSU_S702X },
 	{ .pci_subvendor = 0x10cf, .pci_subdevice = 0x1326, .config = ALC260_FUJITSU_S702X },
+	{ .modelname = "acer", .config = ALC260_ACER },
+	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x008f, .config = ALC260_ACER },
 #ifdef CONFIG_SND_DEBUG
 	{ .modelname = "test", .config = ALC260_TEST },
 #endif
@@ -3356,6 +3473,18 @@
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_fujitsu_capture_source,
 	},
+	[ALC260_ACER] = {
+		.mixers = { alc260_acer_mixer,
+			    alc260_capture_mixer },
+		.init_verbs = { alc260_acer_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc260_dac_nids),
+		.dac_nids = alc260_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc260_dual_adc_nids),
+		.adc_nids = alc260_dual_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc260_modes),
+		.channel_mode = alc260_modes,
+		.input_mux = &alc260_acer_capture_source,
+	},
 #ifdef CONFIG_SND_DEBUG
 	[ALC260_TEST] = {
 		.mixers = { alc260_test_mixer,


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
