From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] hda: ALC260 test model implementation
Date: Tue, 7 Feb 2006 09:20:00 +1030 (CST)
Message-ID: <200602062250.k16Mo0XK012879@auster.physics.adelaide.edu.au>
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

The following patch adds a "test" ALC260 model specification to the
patch_realtek.c driver if CONFIG_SND_DEBUG is set.  This is similar to the
"test" ALC880 model in that it sets up mixer controls for almost everything
to make it easier for people to test their laptop/soundcard when working out
what pin widgets are connected to which real-world devices.

This patch assumes my previous patch (adding the second PCM to the ALC260)
has previously been applied since it uses infrastructure added by that
patch.

In developing this patch it was found that not all retasking pins accept all
the modes - in particular, some ignore the VREFxx variants.  The pin mode
control has therefore been tweaked to prevent this becoming a problem in
mixer applications.

Regards
  jonathan

--- patch_realtek.c-dualadc+initfix	2006-02-07 09:02:18.000000000 +1030
+++ patch_realtek.c	2006-02-07 09:04:53.000000000 +1030
@@ -6,6 +6,7 @@
  * Copyright (c) 2004 Kailang Yang <kailang@realtek.com.tw>
  *                    PeiSen Hou <pshou@realtek.com.tw>
  *                    Takashi Iwai <tiwai@suse.de>
+ *                    Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
  *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -63,6 +64,9 @@
 	ALC260_HP,
 	ALC260_HP_3013,
 	ALC260_FUJITSU_S702X,
+#ifdef CONFIG_SND_DEBUG
+	ALC260_TEST,
+#endif
 	ALC260_AUTO,
 	ALC260_MODEL_LAST /* last tag */
 };
@@ -223,13 +227,19 @@
  * instead of "%" to avoid consequences of accidently treating the % as 
  * being part of a format specifier.  Maximum allowed length of a value is
  * 63 characters plus NULL terminator.
+ *
+ * Note: some retasking pin complexes seem to ignore requests for input
+ * states other than HiZ (eg: PIN_VREFxx) and revert to HiZ if any of these
+ * are requested.  Therefore order this list so that this behaviour will not
+ * cause problems when mixer clients move through the enum sequentially.
+ * NIDs 0x0f and 0x10 have been observed to have this behaviour.
  */
 static char *alc_pin_mode_names[] = {
-	"Line in", "Mic 80pc bias", "Mic 50pc bias",
-	"Line out", "Headphone out",
+	"Mic 50pc bias", "Mic 80pc bias",
+	"Line in", "Line out", "Headphone out",
 };
 static unsigned char alc_pin_mode_values[] = {
-	PIN_IN, PIN_VREF80, PIN_VREF50, PIN_OUT, PIN_HP,
+	PIN_VREF50, PIN_VREF80, PIN_IN, PIN_OUT, PIN_HP,
 };
 /* The control can present all 5 options, or it can limit the options based
  * in the pin being assumed to be exclusively an input or an output pin.
@@ -259,7 +269,7 @@
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = alc_pin_mode_n_items(dir);
-printk("item_num=%d\n",item_num);
+
 	if (item_num<alc_pin_mode_min(dir) || item_num>alc_pin_mode_max(dir))
 		item_num = alc_pin_mode_min(dir);
 	strcpy(uinfo->value.enumerated.name, alc_pin_mode_names[item_num]);
@@ -2770,6 +2780,146 @@
 	{ }
 };
 
+/* Test configuration for debugging, modelled after the ALC880 test
+ * configuration.
+ */
+#ifdef CONFIG_SND_DEBUG
+static hda_nid_t alc260_test_dac_nids[1] = {
+	0x02,
+};
+static hda_nid_t alc260_test_adc_nids[2] = {
+	0x04, 0x05,
+};
+static struct hda_input_mux alc260_test_capture_source = {
+	.num_items = 7,
+	.items = {
+		{ "MIC1 pin", 0x0 },
+		{ "MIC2 pin", 0x1 },
+		{ "LINE1 pin", 0x2 },
+		{ "LINE2 pin", 0x3 },
+		{ "CD pin", 0x4 },
+		{ "LINE-OUT pin", 0x5 },
+		{ "HP-OUT pin", 0x6 },
+        },
+};
+static struct snd_kcontrol_new alc260_test_mixer[] = {
+	/* Output driver widgets */
+	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("LOUT2 Playback Volume", 0x09, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("LOUT2 Playback Switch", 0x09, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("LOUT1 Playback Volume", 0x08, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("LOUT1 Playback Switch", 0x08, 2, HDA_INPUT),
+
+	/* Modes for retasking pin widgets */
+	ALC_PIN_MODE("HP-OUT pin mode", 0x10, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("LINE-OUT pin mode", 0x0f, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("LINE2 pin mode", 0x15, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("LINE1 pin mode", 0x14, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("MIC2 pin mode", 0x13, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("MIC1 pin mode", 0x12, ALC_PIN_DIR_INOUT),
+
+	/* Loopback mixer controls */
+	HDA_CODEC_VOLUME("MIC1 Playback Volume", 0x07, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("MIC1 Playback Switch", 0x07, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("MIC2 Playback Volume", 0x07, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("MIC2 Playback Switch", 0x07, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE1 Playback Volume", 0x07, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("LINE1 Playback Switch", 0x07, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE2 Playback Volume", 0x07, 0x03, HDA_INPUT),
+	HDA_CODEC_MUTE("LINE2 Playback Switch", 0x07, 0x03, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Beep Playback Volume", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("Beep Playback Switch", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE-OUT loopback Playback Volume", 0x07, 0x06, HDA_INPUT),
+	HDA_CODEC_MUTE("LINE-OUT loopback Playback Switch", 0x07, 0x06, HDA_INPUT),
+	HDA_CODEC_VOLUME("HP-OUT loopback Playback Volume", 0x07, 0x7, HDA_INPUT),
+	HDA_CODEC_MUTE("HP-OUT loopback Playback Switch", 0x07, 0x7, HDA_INPUT),
+	{ } /* end */
+};
+static struct hda_verb alc260_test_init_verbs[] = {
+	/* Disable all GPIOs */
+	{0x01, AC_VERB_SET_GPIO_MASK, 0},
+	/* Enable retasking pins as output, initially without power amp */
+	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+
+	/* Disable digital (SPDIF) pins for now */
+	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
+	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
+
+	/* Ensure mic1, mic2, line1 and line2 pin widget take input from the 
+	 * OUT1 sum bus when acting as an output.
+	 */
+	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x0c, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x0d, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x0e, AC_VERB_SET_CONNECT_SEL, 0},
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
+	/* Unmute retasking pin widget output amp left/right (no mixer ctrl) */
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Also unmute the mono-out pin widget */
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+
+	/* Also unmute the retasking pin input amps.  Having the input and
+	 * output amps unmuted at the same time doesn't appear to cause any
+	 * trouble.
+	 */
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+	/* Mute capture amp left and right */
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	/* Set ADC connection select to match default mixer setting - line 
+	 * in (on mic1 pin)
+	 */
+	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Do the same for the second ADC: mute capture input amp and
+	 * set ADC connection to line in
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
+
+	{ }
+};
+#endif
+
 static struct hda_pcm_stream alc260_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
@@ -3053,6 +3203,9 @@
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3016, .config = ALC260_HP },
 	{ .modelname = "fujitsu", .config = ALC260_FUJITSU_S702X },
 	{ .pci_subvendor = 0x10cf, .pci_subdevice = 0x1326, .config = ALC260_FUJITSU_S702X },
+#ifdef CONFIG_SND_DEBUG
+	{ .modelname = "test", .config = ALC260_TEST },
+#endif
 	{ .modelname = "auto", .config = ALC260_AUTO },
 	{}
 };
@@ -3110,6 +3263,20 @@
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_fujitsu_capture_source,
 	},
+#ifdef CONFIG_SND_DEBUG
+	[ALC260_TEST] = {
+		.mixers = { alc260_test_mixer,
+			    alc260_capture_mixer },
+		.init_verbs = { alc260_test_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc260_test_dac_nids),
+		.dac_nids = alc260_test_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc260_test_adc_nids),
+		.adc_nids = alc260_test_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc260_modes),
+		.channel_mode = alc260_modes,
+		.input_mux = &alc260_test_capture_source,
+	},
+#endif
 };
 
 static int patch_alc260(struct hda_codec *codec)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
