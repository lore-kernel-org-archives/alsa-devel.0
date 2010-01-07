From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 2/2] ALSA: hda - support OLPC XO-1.5 DC input
Date: Thu,  7 Jan 2010 12:47:04 +0000 (GMT)
Message-ID: <20100107124705.118969D400D@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com
	[81.103.221.49]) by alsa0.perex.cz (Postfix) with ESMTP id ECD4D24505
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 13:47:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, devel@lists.laptop.org
List-Id: alsa-devel@alsa-project.org

The XO's audio hardware is wired up to allow DC sensors (e.g. light
sensors, thermistors, etc) to be plugged in through the microphone jack.

Add sound mixer controls to allow this mode to be enabled and tweaked.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 sound/pci/hda/patch_conexant.c |  213 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 190 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 9ad1219..ffc609e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -117,6 +117,16 @@ struct conexant_spec {
 	unsigned int recording;
 	void (*capture_prepare)(struct hda_codec *codec);
 	void (*capture_cleanup)(struct hda_codec *codec);
+
+	/* OLPC XO-1.5 supports DC input mode (e.g. for use with analog sensors)
+	 * through the microphone jack.
+	 * When the user enables this through a mixer switch, both internal and
+	 * external microphones are disabled. Gain is fixed at 0dB. In this mode,
+	 * we also allow the bias to be configured through a separate mixer
+	 * control. */
+	unsigned int dc_enable;
+	unsigned int dc_input_bias; /* offset into cxt5066_olpc_dc_bias */
+	unsigned int mic_boost; /* offset into cxt5066_analog_mic_boost */
 };
 
 static int conexant_playback_pcm_open(struct hda_pcm_stream *hinfo,
@@ -1974,6 +1984,26 @@ static int cxt5066_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static const struct hda_input_mux cxt5066_olpc_dc_bias = {
+	.num_items = 3,
+	.items = {
+		{ "Off", PIN_IN },
+		{ "50%", PIN_VREF50 },
+		{ "80%", PIN_VREF80 },
+	},
+};
+
+static int cxt5066_set_olpc_dc_bias(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	/* Even though port F is the DC input, the bias is controlled on port B.
+	 * we also leave that port as an active input (but unselected) in DC mode
+	 * just in case that is necessary to make the bias setting take effect. */
+	return snd_hda_codec_write_cache(codec, 0x1a, 0,
+		AC_VERB_SET_PIN_WIDGET_CONTROL,
+		cxt5066_olpc_dc_bias.items[spec->dc_input_bias].index);
+}
+
 /* OLPC defers mic widget control until when capture is started because the
  * microphone LED comes on as soon as these settings are put in place. if we
  * did this before recording, it would give the false indication that recording
@@ -1984,6 +2014,27 @@ static void cxt5066_olpc_select_mic(struct hda_codec *codec)
 	if (!spec->recording)
 		return;
 
+	if (spec->dc_enable) {
+		/* in DC mode we ignore presence detection and just use the jack
+		 * through our special DC port */
+		const struct hda_verb enable_dc_mode[] = {
+			/* disble internal mic, port C */
+			{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+
+			/* enable DC capture, port F */
+			{0x1e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+			{},
+		};
+
+		snd_hda_sequence_write(codec, enable_dc_mode);
+		/* port B input disabled (and bias set) through the following call */
+		cxt5066_set_olpc_dc_bias(codec);
+		return;
+	}
+
+	/* disable DC (port F) */
+	snd_hda_codec_write(codec, 0x1e, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
+
 	/* external mic, port B */
 	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
 		spec->ext_mic_present ? CXT5066_OLPC_EXT_MIC_BIAS : 0);
@@ -1999,6 +2050,9 @@ static void cxt5066_olpc_automic(struct hda_codec *codec)
 	struct conexant_spec *spec = codec->spec;
 	unsigned int present;
 
+	if (spec->dc_enable) /* don't do presence detection in DC mode */
+		return;
+
 	present = snd_hda_codec_read(codec, 0x1a, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	if (present)
@@ -2073,13 +2127,16 @@ static void cxt5066_hp_automute(struct hda_codec *codec)
 /* unsolicited event for jack sensing */
 static void cxt5066_olpc_unsol_event(struct hda_codec *codec, unsigned int res)
 {
+	struct conexant_spec *spec = codec->spec;
 	snd_printdd("CXT5066: unsol event %x (%x)\n", res, res >> 26);
 	switch (res >> 26) {
 	case CONEXANT_HP_EVENT:
 		cxt5066_hp_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
-		cxt5066_olpc_automic(codec);
+		/* ignore mic events in DC mode; we're always using the jack */
+		if (!spec->dc_enable)
+			cxt5066_olpc_automic(codec);
 		break;
 	}
 }
@@ -2109,6 +2166,15 @@ static const struct hda_input_mux cxt5066_analog_mic_boost = {
 	},
 };
 
+static int cxt5066_set_mic_boost(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	return snd_hda_codec_write_cache(codec, 0x17, 0,
+		AC_VERB_SET_AMP_GAIN_MUTE,
+		AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT |
+			cxt5066_analog_mic_boost.items[spec->mic_boost].index);
+}
+
 static int cxt5066_mic_boost_mux_enum_info(struct snd_kcontrol *kcontrol,
 					   struct snd_ctl_elem_info *uinfo)
 {
@@ -2119,15 +2185,8 @@ static int cxt5066_mic_boost_mux_enum_get(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	int val;
-	hda_nid_t nid = kcontrol->private_value & 0xff;
-	int inout = (kcontrol->private_value & 0x100) ?
-		AC_AMP_GET_INPUT : AC_AMP_GET_OUTPUT;
-
-	val = snd_hda_codec_read(codec, nid, 0,
-		AC_VERB_GET_AMP_GAIN_MUTE, inout);
-
-	ucontrol->value.enumerated.item[0] = val & AC_AMP_GAIN;
+	struct conexant_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = spec->mic_boost;
 	return 0;
 }
 
@@ -2135,23 +2194,101 @@ static int cxt5066_mic_boost_mux_enum_put(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
 	const struct hda_input_mux *imux = &cxt5066_analog_mic_boost;
 	unsigned int idx;
-	hda_nid_t nid = kcontrol->private_value & 0xff;
-	int inout = (kcontrol->private_value & 0x100) ?
-		AC_AMP_SET_INPUT : AC_AMP_SET_OUTPUT;
+	idx = ucontrol->value.enumerated.item[0];
+	if (idx >= imux->num_items)
+		idx = imux->num_items - 1;
+
+	spec->mic_boost = idx;
+	if (!spec->dc_enable)
+		cxt5066_set_mic_boost(codec);
+	return 1;
+}
+
+static void cxt5066_enable_dc(struct hda_codec *codec)
+{
+	const struct hda_verb enable_dc_mode[] = {
+		/* disable gain */
+		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+
+		/* switch to DC input */
+		{0x17, AC_VERB_SET_CONNECT_SEL, 3},
+		{}
+	};
+
+	/* configure as input source */
+	snd_hda_sequence_write(codec, enable_dc_mode);
+	cxt5066_olpc_select_mic(codec); /* also sets configured bias */
+}
+
+static void cxt5066_disable_dc(struct hda_codec *codec)
+{
+	/* reconfigure input source */
+	cxt5066_set_mic_boost(codec);
+	/* automic also selects the right mic if we're recording */
+	cxt5066_olpc_automic(codec);
+}
+
+static int cxt5066_olpc_dc_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	ucontrol->value.integer.value[0] = spec->dc_enable;
+	return 0;
+}
 
-	if (!imux->num_items)
+static int cxt5066_olpc_dc_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	int dc_enable = !!ucontrol->value.integer.value[0];
+
+	if (dc_enable == spec->dc_enable)
 		return 0;
+
+	spec->dc_enable = dc_enable;
+	if (dc_enable)
+		cxt5066_enable_dc(codec);
+	else
+		cxt5066_disable_dc(codec);
+
+	return 1;
+}
+
+static int cxt5066_olpc_dc_bias_enum_info(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_info *uinfo)
+{
+	return snd_hda_input_mux_info(&cxt5066_olpc_dc_bias, uinfo);
+}
+
+static int cxt5066_olpc_dc_bias_enum_get(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = spec->dc_input_bias;
+	return 0;
+}
+
+static int cxt5066_olpc_dc_bias_enum_put(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	const struct hda_input_mux *imux = &cxt5066_analog_mic_boost;
+	unsigned int idx;
+
 	idx = ucontrol->value.enumerated.item[0];
 	if (idx >= imux->num_items)
 		idx = imux->num_items - 1;
 
-	snd_hda_codec_write_cache(codec, nid, 0,
-		AC_VERB_SET_AMP_GAIN_MUTE,
-		AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | inout |
-			imux->items[idx].index);
-
+	spec->dc_input_bias = idx;
+	if (spec->dc_enable)
+		cxt5066_set_olpc_dc_bias(codec);
 	return 1;
 }
 
@@ -2173,6 +2310,9 @@ static void cxt5066_olpc_capture_cleanup(struct hda_codec *codec)
 
 		/* disble internal mic, port C */
 		{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+
+		/* disable DC capture, port F */
+		{0x1e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 		{},
 	};
 
@@ -2231,6 +2371,24 @@ static struct snd_kcontrol_new cxt5066_mixer_master_olpc[] = {
 	{}
 };
 
+static struct snd_kcontrol_new cxt5066_mixer_olpc_dc[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "DC Mode Enable Switch",
+		.info = snd_ctl_boolean_mono_info,
+		.get = cxt5066_olpc_dc_get,
+		.put = cxt5066_olpc_dc_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "DC Input Bias Enum",
+		.info = cxt5066_olpc_dc_bias_enum_info,
+		.get = cxt5066_olpc_dc_bias_enum_get,
+		.put = cxt5066_olpc_dc_bias_enum_put,
+	},
+	{}
+};
+
 static struct snd_kcontrol_new cxt5066_mixers[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -2243,11 +2401,10 @@ static struct snd_kcontrol_new cxt5066_mixers[] = {
 
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Ext Mic Boost Capture Enum",
+		.name = "Analog Mic Boost Capture Enum",
 		.info = cxt5066_mic_boost_mux_enum_info,
 		.get = cxt5066_mic_boost_mux_enum_get,
 		.put = cxt5066_mic_boost_mux_enum_put,
-		.private_value = 0x17,
 	},
 
 	HDA_BIND_VOL("Capture Volume", &cxt5066_bind_capture_vol_others),
@@ -2341,7 +2498,7 @@ static struct hda_verb cxt5066_init_verbs_olpc[] = {
 	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 	{0x1d, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */
 
-	/* Port F: unused */
+	/* Port F: external DC input through microphone port */
 	{0x1e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 
 	/* Port G: internal speakers */
@@ -2462,15 +2619,22 @@ static int cxt5066_init(struct hda_codec *codec)
 		if (spec->dell_vostro)
 			cxt5066_vostro_automic(codec);
 	}
+	cxt5066_set_mic_boost(codec);
 	return 0;
 }
 
 static int cxt5066_olpc_init(struct hda_codec *codec)
 {
+	struct conexant_spec *spec = codec->spec;
 	snd_printdd("CXT5066: init\n");
 	conexant_init(codec);
 	cxt5066_hp_automute(codec);
-	cxt5066_olpc_automic(codec);
+	if (!spec->dc_enable) {
+		cxt5066_set_mic_boost(codec);
+		cxt5066_olpc_automic(codec);
+	} else {
+		cxt5066_enable_dc(codec);
+	}
 	return 0;
 }
 
@@ -2553,8 +2717,10 @@ static int patch_cxt5066(struct hda_codec *codec)
 		codec->patch_ops.unsol_event = cxt5066_olpc_unsol_event;
 		spec->init_verbs[0] = cxt5066_init_verbs_olpc;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master_olpc;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixer_olpc_dc;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
 		spec->port_d_mode = 0;
+		spec->mic_boost = 3; /* default 30dB gain */
 
 		/* no S/PDIF out */
 		spec->multiout.dig_out_nid = 0;
@@ -2576,6 +2742,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->mixers[spec->num_mixers++] = cxt5066_vostro_mixers;
 		spec->port_d_mode = 0;
 		spec->dell_vostro = 1;
+		spec->mic_boost = 3; /* default 30dB gain */
 		snd_hda_attach_beep_device(codec, 0x13);
 
 		/* no S/PDIF out */
-- 
1.6.2.5
