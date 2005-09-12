From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Mon, 12 Sep 2005 09:40:05 +0930 (CST)
Message-ID: <200509120010.j8C0A6cn001862@auster.physics.adelaide.edu.au>
References: <s5hzmqn6hwd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.523.1126483805--%"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmqn6hwd.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 08, 2005 11:14:10 AM
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


--%--multipart-mixed-boundary-1.523.1126483805--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Takashi 

> > I'll do a patch up along these lines in the next day or so unless you advise
> > that there is a better way.
> Agreed.  You need just to put your ssid there.  Go ahead!

Find attached a patch which adds support for the ALC260 as it is connected
in a Fujitsu S7020 laptop (and probably the S7021 too).  A new
initialisation verb list is defined which sets up the somewhat unexpected
use of the ALC260 pins:
  Headphone pin -> Internal speaker
  mic 1 pin     -> mic/LineIn jack
  line 1 pin    -> LineOut jack
  CD pin        -> Internal CD drive audio

As far as I can tell these are the only pins connected and in use.  Thus
the others are effectively turned off.

The number of mixer controls have been reduced to include only the pins
which actually do something.  The control names reflect the above usage
rather than the ALC260 pins they control.  These control names appear to do
the right thing for the ALSA and OSS apps I've tested (audacity, aplay,
wavplay plus some OSS things I've written).

Capture is enabled for the mic 1 and CD pins.

The patch is against alsa-kernel/pci/hda/patch_realtek.c from 1.0.10rc1 but
I expect it will apply trivially to CVS.  If there's a problem let me know.

The new mixer/initialisation is only activated if the subsystem vendor
and device IDs match those in the S7020, since there's no guarantee that
other Fujitsu models will share this device layout.  I figure things can
always be relaxed later if it turns out this applies to other models.

The only outstanding mixer-related issue is control of the headphone amp
associated with the LineOut jack.  In essence the ALC260 Line 1 pin has a
headphone amp which can be enabled to drive headphones harder than can be
done without it.  However, the noise level increases if this is done, so if
the output is being fed to other equipment it's better to leave the amp off. 
It would be nice to be able to turn this amp on and off dynamically but the
mixer API doesn't appear to have the ability to do this (although I'm still
looking). The alternative is to define a new module option which turns the
amp on if the user requests it.  I'm still working on this and will submit a
patch addressing this if I can come up with something sensible.

Regards
  jonathan

--%--multipart-mixed-boundary-1.523.1126483805--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII C program text
Content-Disposition: attachment; filename="alsa_s7020_patch.diff"

--- patch_realtek.c-orig	2005-08-16 04:31:40.000000000 +0930
+++ patch_realtek.c	2005-09-12 00:27:32.000000000 +0930
@@ -57,6 +57,7 @@
 enum {
 	ALC260_BASIC,
 	ALC260_HP,
+	ALC260_FUJITSU_S702x,
 	ALC260_MODEL_LAST /* last tag */
 };
 
@@ -2209,6 +2210,17 @@
 	},
 };
 
+/* On Fujitsu S702x laptops capture only makes sense from Mic/LineIn jack
+ * and the internal CD lines.
+ */
+static struct hda_input_mux alc260_fujitsu_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "Mic/LineIn", 0x0 },
+		{ "CD", 0x4 },
+	},
+};
+
 /*
  * This is just place-holder, so there's something for alc_build_pcms to look
  * at when it calculates the maximum number of channels. ALC260 has no mixer
@@ -2275,6 +2287,29 @@
 	{ } /* end */
 };
 
+static snd_kcontrol_new_t alc260_fujitsu_mixer[] = {
+	HDA_CODEC_VOLUME("LineOut Playback Volume", 0x08, 0x0, HDA_OUTPUT),
+	ALC_BIND_MUTE("LineOut Playback Switch", 0x08, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic/LineIn Playback Volume", 0x07, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic/LineIn Playback Switch", 0x07, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("BeepGen Playback Volume", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("BeepGen Playback Switch", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_VOLUME("IntSpeaker Playback Volume", 0x09, 0x0, HDA_OUTPUT),
+	ALC_BIND_MUTE("IntSpeaker Playback Switch", 0x09, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x04, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x04, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = alc_mux_enum_info,
+		.get = alc_mux_enum_get,
+		.put = alc_mux_enum_put,
+	},
+	{ } /* end */
+};
+
 static struct hda_verb alc260_init_verbs[] = {
 	/* Line In pin widget for input */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
@@ -2336,6 +2371,60 @@
 	{ }
 };
 
+/* Initialisation sequence for ALC260 as configured in Fujitsu S702x
+ * laptops.
+ */
+static struct hda_verb alc260_fujitsu_init_verbs[] = {
+	/* Disable all GPIOs */
+	{0x01, AC_VERB_SET_GPIO_MASK, 0},
+	/* Internal speaker is connected to headphone pin */
+	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Line-out jack is connected to Line1 pin, so make it an output */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+        /* Line-in jack is connected to mic1 pin, so make it an input */
+        {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+        /* Ensure all other unused pins are disabled and muted.
+	 * Note: trying to set widget 0x15 to anything blocks all audio
+	 * output for some reason, so just leave that at the default.
+	 */
+        {0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+        {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+        {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+        {0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+        /* Disable digital (SPDIF) pins */
+        {0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
+        {0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
+
+        /* Start with mixer outputs muted */
+        {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+        {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+        {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+
+        /* Unmute HP pin widget amp left and right (no equiv mixer ctrl) */
+        {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+        /* Unmute Line1 pin widget amp left and right (no equiv mixer ctrl) */
+        {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Unmute pin widget used for Line-in (no equiv mixer ctrl) */
+        {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+        /* Mute capture amp left and right */
+        {0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+        /* Set ADC connection select to line in (on mic1 pin) */
+        {0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+        /* Mute all inputs to mixer widget (even unconnected ones) */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}, /* mic2 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)}, /* line1 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)}, /* line2 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)}, /* CD pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)}, /* Beep-gen pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)}, /* Line-out pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)}, /* HP-pin pin */
+};
+
 static struct hda_pcm_stream alc260_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
@@ -2351,6 +2440,7 @@
 static struct hda_board_config alc260_cfg_tbl[] = {
 	{ .modelname = "hp", .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .config = ALC260_HP },
+	{ .pci_subvendor = 0x10cf, .pci_subdevice = 0x1326, .config = ALC260_FUJITSU_S702x },
 	{}
 };
 
@@ -2377,14 +2467,23 @@
 		spec->mixers[spec->num_mixers] = alc260_hp_mixer;
 		spec->num_mixers++;
 		break;
+	case ALC260_FUJITSU_S702x:
+		spec->mixers[spec->num_mixers] = alc260_fujitsu_mixer;
+		spec->num_mixers++;
+		break;
 	default:
 		spec->mixers[spec->num_mixers] = alc260_base_mixer;
 		spec->num_mixers++;
 		break;
 	}
 
-	spec->init_verbs[0] = alc260_init_verbs;
-	spec->num_init_verbs = 1;
+	if (board_config != ALC260_FUJITSU_S702x) {
+		spec->init_verbs[0] = alc260_init_verbs;
+		spec->num_init_verbs = 1;
+	} else {
+		spec->init_verbs[0] = alc260_fujitsu_init_verbs;
+		spec->num_init_verbs = 1;
+	}
 
 	spec->channel_mode = alc260_modes;
 	spec->num_channel_mode = ARRAY_SIZE(alc260_modes);
@@ -2397,7 +2496,11 @@
 	spec->multiout.num_dacs = ARRAY_SIZE(alc260_dac_nids);
 	spec->multiout.dac_nids = alc260_dac_nids;
 
-	spec->input_mux = &alc260_capture_source;
+	if (board_config != ALC260_FUJITSU_S702x) {
+		spec->input_mux = &alc260_capture_source;
+	} else {
+		spec->input_mux = &alc260_fujitsu_capture_source;
+	}
 	switch (board_config) {
 	case ALC260_HP:
 		spec->num_adc_nids = ARRAY_SIZE(alc260_hp_adc_nids);

--%--multipart-mixed-boundary-1.523.1126483805--%--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
