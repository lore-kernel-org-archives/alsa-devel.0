From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Thu, 15 Sep 2005 09:45:01 +0930 (CST)
Message-ID: <200509150015.j8F0F1ps008191@auster.physics.adelaide.edu.au>
References: <s5h4q8qinxw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.5329.1126743301--%"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q8qinxw.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 12, 2005 12:24:11 PM
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


--%--multipart-mixed-boundary-1.5329.1126743301--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Takashi 

> > Find attached a patch which adds support for the ALC260 as it is connected
> > in a Fujitsu S7020 laptop (and probably the S7021 too).  A new
> > initialisation verb list is defined which sets up the somewhat unexpected
> > use of the ALC260 pins:
> >   Headphone pin -> Internal speaker
> >   mic 1 pin     -> mic/LineIn jack
> >   line 1 pin    -> LineOut jack
> >   CD pin        -> Internal CD drive audio
> 
> Thanks for a patch!
:
> Well, I feel some mixer names are unconventional, namely, "LineOut
> Playback Volume", "Mic/LineIn Playback Volume", "BeepGen Playback
> Volume", "IntSpeaker Playback Volume".  They can't work with OSS
> emulation (unless you adjust manually a proc file) -- although you
> claim that it works.

Find attached a revised patch which addresses this.  I've relented and
renamed "LineOut" to "Headphone" in the interests of conformance.
"Mic/LineIn" I've renamed to "Mic/Line" as you suggested.  If we have to
drop the dual name then I think we should call the input "Line" since that's
really what it is.  "IntSpeaker" and "BeepGen" are now "Internal Speaker"
and "Beep" respectively, as per your suggestions.

Again, the patch is relative to 1.0.10rc1.

> > The new mixer/initialisation is only activated if the subsystem vendor
> > and device IDs match those in the S7020, since there's no guarantee that
> > other Fujitsu models will share this device layout.  I figure things can
> > always be relaxed later if it turns out this applies to other models.
> 
> Let's add a new model string so that people can test this model on
> other devices, too.

Done - it's "fujitsu".

> > The only outstanding mixer-related issue is control of the headphone amp
> > associated with the LineOut jack.  In essence the ALC260 Line 1 pin has a
> > headphone amp which can be enabled to drive headphones harder than can be
> > done without it.  However, the noise level increases if this is done, so if
> > the output is being fed to other equipment it's better to leave the amp off. 
> > It would be nice to be able to turn this amp on and off dynamically but the
> > mixer API doesn't appear to have the ability to do this (although I'm still
> > looking). The alternative is to define a new module option which turns the
> > amp on if the user requests it.  I'm still working on this and will submit a
> > patch addressing this if I can come up with something sensible.
> 
> The mixer API can.  Simply add a control like "Headhpone Amplifer
> Switch", or so.  (I guess you mean to turn on/off HP pin control bit?)

I've now added such a switch (which also required some new get/put functions
to make it happen - I couldn't find any existing functions which drove the
Realtek pin widget controls after basic initialisation).  I called the
control "Headphone Amp Switch" but feel free to expand this to "Headphone
Amplifier Switch" if you think it's better - I'm not fussed.

Regards
  jonathan

--%--multipart-mixed-boundary-1.5329.1126743301--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII C program text
Content-Disposition: attachment; filename="alsa_s7020_patch-v2.diff"

--- patch_realtek.c-orig	2005-08-16 04:31:40.000000000 +0930
+++ patch_realtek.c	2005-09-15 01:04:45.000000000 +0930
@@ -57,6 +57,7 @@
 enum {
 	ALC260_BASIC,
 	ALC260_HP,
+	ALC260_FUJITSU_S702x,
 	ALC260_MODEL_LAST /* last tag */
 };
 
@@ -72,6 +73,7 @@
 #define PIN_VREF50	0x21
 #define PIN_OUT		0x40
 #define PIN_HP		0xc0
+#define PIN_HP_AMP	0x80
 
 struct alc_spec {
 	/* codec parameterization */
@@ -284,6 +286,54 @@
 
 #define ALC_BIND_MUTE(xname,nid,indices,dir) ALC_BIND_MUTE_MONO(xname,nid,3,indices,dir)
 
+/*
+ * Control of pin widget settings via the mixer.  Only boolean settings are
+ * supported, so VrefEn can't be controlled using these functions as they
+ * stand.
+ */
+static int alc_pinctl_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int alc_pinctl_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	long mask = (kcontrol->private_value >> 16) & 0xff;
+	long *valp = ucontrol->value.integer.value;
+
+	*valp = 0;
+	if (snd_hda_codec_read(codec,nid,0,AC_VERB_GET_PIN_WIDGET_CONTROL,0x00) & mask)
+		*valp = 1;
+	return 0;
+}
+
+static int alc_pinctl_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	long mask = (kcontrol->private_value >> 16) & 0xff;
+	long *valp = ucontrol->value.integer.value;
+	unsigned int pinctl = snd_hda_codec_read(codec,nid,0,AC_VERB_GET_PIN_WIDGET_CONTROL,0x00);
+	int change = ((pinctl & mask)!=0) != *valp;
+
+	if (change)
+		snd_hda_codec_write(codec,nid,0,AC_VERB_SET_PIN_WIDGET_CONTROL,
+			*valp?(pinctl|mask):(pinctl&~mask));
+	return change;
+}
+
+#define ALC_PINCTL_SWITCH(xname, nid, mask) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
+	  .info = alc_pinctl_switch_info, \
+	  .get = alc_pinctl_switch_get, \
+	  .put = alc_pinctl_switch_put, \
+	  .private_value = (nid) | (mask<<16) }
 
 /*
  * ALC880 3-stack model
@@ -2209,6 +2259,17 @@
 	},
 };
 
+/* On Fujitsu S702x laptops capture only makes sense from Mic/LineIn jack
+ * and the internal CD lines.
+ */
+static struct hda_input_mux alc260_fujitsu_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "Mic/Line", 0x0 },
+		{ "CD", 0x4 },
+	},
+};
+
 /*
  * This is just place-holder, so there's something for alc_build_pcms to look
  * at when it calculates the maximum number of channels. ALC260 has no mixer
@@ -2275,6 +2336,30 @@
 	{ } /* end */
 };
 
+static snd_kcontrol_new_t alc260_fujitsu_mixer[] = {
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x08, 0x0, HDA_OUTPUT),
+	ALC_BIND_MUTE("Headphone Playback Switch", 0x08, 2, HDA_INPUT),
+	ALC_PINCTL_SWITCH("Headphone Amp Switch", 0x14, PIN_HP_AMP),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic/Line Playback Volume", 0x07, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic/Line Playback Switch", 0x07, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Beep Playback Volume", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("Beep Playback Switch", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Speaker Playback Volume", 0x09, 0x0, HDA_OUTPUT),
+	ALC_BIND_MUTE("Internal Speaker Playback Switch", 0x09, 2, HDA_INPUT),
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
@@ -2336,6 +2421,60 @@
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
+	/* Headphone/Line-out jack connects to Line1 pin; make it an output */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+        /* Mic/Line-in jack is connected to mic1 pin, so make it an input */
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
@@ -2351,6 +2490,8 @@
 static struct hda_board_config alc260_cfg_tbl[] = {
 	{ .modelname = "hp", .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .config = ALC260_HP },
+	{ .modelname = "fujitsu", .config = ALC260_FUJITSU_S702x },
+	{ .pci_subvendor = 0x10cf, .pci_subdevice = 0x1326, .config = ALC260_FUJITSU_S702x },
 	{}
 };
 
@@ -2377,14 +2518,23 @@
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
@@ -2397,7 +2547,11 @@
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

--%--multipart-mixed-boundary-1.5329.1126743301--%--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
