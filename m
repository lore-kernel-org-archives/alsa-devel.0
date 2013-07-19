From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/13] ALSA: hda - Remove static quirks for
	AD1981 and AD1983 codecs
Date: Fri, 19 Jul 2013 17:12:15 +0200
Message-ID: <1374246742-14373-7-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A4654265765
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80F35A538A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
In-Reply-To: <1374246742-14373-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

These are relatively easy ones, as we already converted all static
quirks to the generic parser.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 684 +------------------------------------------
 1 file changed, 2 insertions(+), 682 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index bfa8f53..4fedd9d 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1427,161 +1427,6 @@ static int patch_ad1986a(struct hda_codec *codec)
  * AD1983 specific
  */
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-#define AD1983_SPDIF_OUT	0x02
-#define AD1983_DAC		0x03
-#define AD1983_ADC		0x04
-
-static const hda_nid_t ad1983_dac_nids[1] = { AD1983_DAC };
-static const hda_nid_t ad1983_adc_nids[1] = { AD1983_ADC };
-static const hda_nid_t ad1983_capsrc_nids[1] = { 0x15 };
-
-static const struct hda_input_mux ad1983_capture_source = {
-	.num_items = 4,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "Line", 0x1 },
-		{ "Mix", 0x2 },
-		{ "Mix Mono", 0x3 },
-	},
-};
-
-/*
- * SPDIF playback route
- */
-static int ad1983_spdif_route_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	static const char * const texts[] = { "PCM", "ADC" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
-}
-
-static int ad1983_spdif_route_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-
-	ucontrol->value.enumerated.item[0] = spec->spdif_route;
-	return 0;
-}
-
-static int ad1983_spdif_route_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-
-	if (ucontrol->value.enumerated.item[0] > 1)
-		return -EINVAL;
-	if (spec->spdif_route != ucontrol->value.enumerated.item[0]) {
-		spec->spdif_route = ucontrol->value.enumerated.item[0];
-		snd_hda_codec_write_cache(codec, spec->multiout.dig_out_nid, 0,
-					  AC_VERB_SET_CONNECT_SEL,
-					  spec->spdif_route);
-		return 1;
-	}
-	return 0;
-}
-
-static const struct snd_kcontrol_new ad1983_mixers[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Playback Switch", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x06, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x06, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x07, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x07, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-		.info = ad1983_spdif_route_info,
-		.get = ad1983_spdif_route_get,
-		.put = ad1983_spdif_route_put,
-	},
-	{ } /* end */
-};
-
-static const struct hda_verb ad1983_init_verbs[] = {
-	/* Front, HP, Mono; mute as default */
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* Beep, PCM, Mic, Line-In: mute */
-	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* Front, HP selectors; from Mix */
-	{0x05, AC_VERB_SET_CONNECT_SEL, 0x01},
-	{0x06, AC_VERB_SET_CONNECT_SEL, 0x01},
-	/* Mono selector; from Mix */
-	{0x0b, AC_VERB_SET_CONNECT_SEL, 0x03},
-	/* Mic selector; Mic */
-	{0x0c, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Line-in selector: Line-in */
-	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Mic boost: 0dB */
-	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
-	/* Record selector: mic */
-	{0x15, AC_VERB_SET_CONNECT_SEL, 0x0},
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* SPDIF route: PCM */
-	{0x02, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Front Pin */
-	{0x05, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	/* HP Pin */
-	{0x06, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 },
-	/* Mono Pin */
-	{0x07, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	/* Mic Pin */
-	{0x08, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
-	/* Line Pin */
-	{0x09, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	{ } /* end */
-};
-
-#ifdef CONFIG_PM
-static const struct hda_amp_list ad1983_loopbacks[] = {
-	{ 0x12, HDA_OUTPUT, 0 }, /* Mic */
-	{ 0x13, HDA_OUTPUT, 0 }, /* Line */
-	{ } /* end */
-};
-#endif
-
-/* models */
-enum {
-	AD1983_AUTO,
-	AD1983_BASIC,
-	AD1983_MODELS
-};
-
-static const char * const ad1983_models[AD1983_MODELS] = {
-	[AD1983_AUTO]		= "auto",
-	[AD1983_BASIC]		= "basic",
-};
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
-
 /*
  * SPDIF mux control for AD1983 auto-parser
  */
@@ -1656,7 +1501,7 @@ static int ad1983_add_spdif_mux_ctl(struct hda_codec *codec)
 	return 0;
 }
 
-static int ad1983_parse_auto_config(struct hda_codec *codec)
+static int patch_ad1983(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
 	int err;
@@ -1681,432 +1526,11 @@ static int ad1983_parse_auto_config(struct hda_codec *codec)
 	return err;
 }
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static int patch_ad1983(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec;
-	int board_config;
-	int err;
-
-	board_config = snd_hda_check_board_config(codec, AD1983_MODELS,
-						  ad1983_models, NULL);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = AD1983_AUTO;
-	}
-
-	if (board_config == AD1983_AUTO)
-		return ad1983_parse_auto_config(codec);
-
-	err = alloc_ad_spec(codec);
-	if (err < 0)
-		return err;
-	spec = codec->spec;
-
-	err = snd_hda_attach_beep_device(codec, 0x10);
-	if (err < 0) {
-		ad198x_free(codec);
-		return err;
-	}
-	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
-
-	spec->multiout.max_channels = 2;
-	spec->multiout.num_dacs = ARRAY_SIZE(ad1983_dac_nids);
-	spec->multiout.dac_nids = ad1983_dac_nids;
-	spec->multiout.dig_out_nid = AD1983_SPDIF_OUT;
-	spec->num_adc_nids = 1;
-	spec->adc_nids = ad1983_adc_nids;
-	spec->capsrc_nids = ad1983_capsrc_nids;
-	spec->input_mux = &ad1983_capture_source;
-	spec->num_mixers = 1;
-	spec->mixers[0] = ad1983_mixers;
-	spec->num_init_verbs = 1;
-	spec->init_verbs[0] = ad1983_init_verbs;
-	spec->spdif_route = 0;
-#ifdef CONFIG_PM
-	spec->loopback.amplist = ad1983_loopbacks;
-#endif
-	spec->vmaster_nid = 0x05;
-
-	codec->patch_ops = ad198x_patch_ops;
-
-	codec->no_trigger_sense = 1;
-	codec->no_sticky_stream = 1;
-
-	return 0;
-}
-#else /* ENABLE_AD_STATIC_QUIRKS */
-#define patch_ad1983	ad1983_parse_auto_config
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 
 /*
  * AD1981 HD specific
  */
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-#define AD1981_SPDIF_OUT	0x02
-#define AD1981_DAC		0x03
-#define AD1981_ADC		0x04
-
-static const hda_nid_t ad1981_dac_nids[1] = { AD1981_DAC };
-static const hda_nid_t ad1981_adc_nids[1] = { AD1981_ADC };
-static const hda_nid_t ad1981_capsrc_nids[1] = { 0x15 };
-
-/* 0x0c, 0x09, 0x0e, 0x0f, 0x19, 0x05, 0x18, 0x17 */
-static const struct hda_input_mux ad1981_capture_source = {
-	.num_items = 7,
-	.items = {
-		{ "Front Mic", 0x0 },
-		{ "Line", 0x1 },
-		{ "Mix", 0x2 },
-		{ "Mix Mono", 0x3 },
-		{ "CD", 0x4 },
-		{ "Mic", 0x6 },
-		{ "Aux", 0x7 },
-	},
-};
-
-static const struct snd_kcontrol_new ad1981_mixers[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Playback Switch", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x06, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x06, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x07, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x07, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Aux Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Aux Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	/* identical with AD1983 */
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-		.info = ad1983_spdif_route_info,
-		.get = ad1983_spdif_route_get,
-		.put = ad1983_spdif_route_put,
-	},
-	{ } /* end */
-};
-
-static const struct hda_verb ad1981_init_verbs[] = {
-	/* Front, HP, Mono; mute as default */
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* Beep, PCM, Front Mic, Line, Rear Mic, Aux, CD-In: mute */
-	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* Front, HP selectors; from Mix */
-	{0x05, AC_VERB_SET_CONNECT_SEL, 0x01},
-	{0x06, AC_VERB_SET_CONNECT_SEL, 0x01},
-	/* Mono selector; from Mix */
-	{0x0b, AC_VERB_SET_CONNECT_SEL, 0x03},
-	/* Mic Mixer; select Front Mic */
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
-	{0x1f, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* Mic boost: 0dB */
-	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	/* Record selector: Front mic */
-	{0x15, AC_VERB_SET_CONNECT_SEL, 0x0},
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* SPDIF route: PCM */
-	{0x02, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Front Pin */
-	{0x05, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	/* HP Pin */
-	{0x06, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 },
-	/* Mono Pin */
-	{0x07, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	/* Front & Rear Mic Pins */
-	{0x08, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
-	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
-	/* Line Pin */
-	{0x09, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	/* Digital Beep */
-	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
-	/* Line-Out as Input: disabled */
-	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{ } /* end */
-};
-
-#ifdef CONFIG_PM
-static const struct hda_amp_list ad1981_loopbacks[] = {
-	{ 0x12, HDA_OUTPUT, 0 }, /* Front Mic */
-	{ 0x13, HDA_OUTPUT, 0 }, /* Line */
-	{ 0x1b, HDA_OUTPUT, 0 }, /* Aux */
-	{ 0x1c, HDA_OUTPUT, 0 }, /* Mic */
-	{ 0x1d, HDA_OUTPUT, 0 }, /* CD */
-	{ } /* end */
-};
-#endif
-
-/*
- * Patch for HP nx6320
- *
- * nx6320 uses EAPD in the reverse way - EAPD-on means the internal
- * speaker output enabled _and_ mute-LED off.
- */
-
-#define AD1981_HP_EVENT		0x37
-#define AD1981_MIC_EVENT	0x38
-
-static const struct hda_verb ad1981_hp_init_verbs[] = {
-	{0x05, AC_VERB_SET_EAPD_BTLENABLE, 0x00 }, /* default off */
-	/* pin sensing on HP and Mic jacks */
-	{0x06, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1981_HP_EVENT},
-	{0x08, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1981_MIC_EVENT},
-	{}
-};
-
-/* turn on/off EAPD (+ mute HP) as a master switch */
-static int ad1981_hp_master_sw_put(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-
-	if (! ad198x_eapd_put(kcontrol, ucontrol))
-		return 0;
-	/* change speaker pin appropriately */
-	snd_hda_set_pin_ctl(codec, 0x05, spec->cur_eapd ? PIN_OUT : 0);
-	/* toggle HP mute appropriately */
-	snd_hda_codec_amp_stereo(codec, 0x06, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE,
-				 spec->cur_eapd ? 0 : HDA_AMP_MUTE);
-	return 1;
-}
-
-/* bind volumes of both NID 0x05 and 0x06 */
-static const struct hda_bind_ctls ad1981_hp_bind_master_vol = {
-	.ops = &snd_hda_bind_vol,
-	.values = {
-		HDA_COMPOSE_AMP_VAL(0x05, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(0x06, 3, 0, HDA_OUTPUT),
-		0
-	},
-};
-
-/* mute internal speaker if HP is plugged */
-static void ad1981_hp_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-
-	present = snd_hda_jack_detect(codec, 0x06);
-	snd_hda_codec_amp_stereo(codec, 0x05, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
-}
-
-/* toggle input of built-in and mic jack appropriately */
-static void ad1981_hp_automic(struct hda_codec *codec)
-{
-	static const struct hda_verb mic_jack_on[] = {
-		{0x1f, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-		{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
-		{}
-	};
-	static const struct hda_verb mic_jack_off[] = {
-		{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-		{0x1f, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
-		{}
-	};
-	unsigned int present;
-
-	present = snd_hda_jack_detect(codec, 0x08);
-	if (present)
-		snd_hda_sequence_write(codec, mic_jack_on);
-	else
-		snd_hda_sequence_write(codec, mic_jack_off);
-}
-
-/* unsolicited event for HP jack sensing */
-static void ad1981_hp_unsol_event(struct hda_codec *codec,
-				  unsigned int res)
-{
-	res >>= 26;
-	switch (res) {
-	case AD1981_HP_EVENT:
-		ad1981_hp_automute(codec);
-		break;
-	case AD1981_MIC_EVENT:
-		ad1981_hp_automic(codec);
-		break;
-	}
-}
-
-static const struct hda_input_mux ad1981_hp_capture_source = {
-	.num_items = 3,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "Dock Mic", 0x1 },
-		{ "Mix", 0x2 },
-	},
-};
-
-static const struct snd_kcontrol_new ad1981_hp_mixers[] = {
-	HDA_BIND_VOL("Master Playback Volume", &ad1981_hp_bind_master_vol),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.subdevice = HDA_SUBDEV_NID_FLAG | 0x05,
-		.name = "Master Playback Switch",
-		.info = ad198x_eapd_info,
-		.get = ad198x_eapd_get,
-		.put = ad1981_hp_master_sw_put,
-		.private_value = 0x05,
-	},
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x11, 0x0, HDA_OUTPUT),
-#if 0
-	/* FIXME: analog mic/line loopback doesn't work with my tests...
-	 *        (although recording is OK)
-	 */
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Dock Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Dock Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x1c, 0x0, HDA_OUTPUT),
-	/* FIXME: does this laptop have analog CD connection? */
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
-#endif
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x18, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	{ } /* end */
-};
-
-/* initialize jack-sensing, too */
-static int ad1981_hp_init(struct hda_codec *codec)
-{
-	ad198x_init(codec);
-	ad1981_hp_automute(codec);
-	ad1981_hp_automic(codec);
-	return 0;
-}
-
-/* configuration for Toshiba Laptops */
-static const struct hda_verb ad1981_toshiba_init_verbs[] = {
-	{0x05, AC_VERB_SET_EAPD_BTLENABLE, 0x01 }, /* default on */
-	/* pin sensing on HP and Mic jacks */
-	{0x06, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1981_HP_EVENT},
-	{0x08, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1981_MIC_EVENT},
-	{}
-};
-
-static const struct snd_kcontrol_new ad1981_toshiba_mixers[] = {
-	HDA_CODEC_VOLUME("Amp Volume", 0x1a, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Amp Switch", 0x1a, 0x0, HDA_OUTPUT),
-	{ }
-};
-
-/* configuration for Lenovo Thinkpad T60 */
-static const struct snd_kcontrol_new ad1981_thinkpad_mixers[] = {
-	HDA_CODEC_VOLUME("Master Playback Volume", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Master Playback Switch", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	/* identical with AD1983 */
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-		.info = ad1983_spdif_route_info,
-		.get = ad1983_spdif_route_get,
-		.put = ad1983_spdif_route_put,
-	},
-	{ } /* end */
-};
-
-static const struct hda_input_mux ad1981_thinkpad_capture_source = {
-	.num_items = 3,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "Mix", 0x2 },
-		{ "CD", 0x4 },
-	},
-};
-
-/* models */
-enum {
-	AD1981_AUTO,
-	AD1981_BASIC,
-	AD1981_HP,
-	AD1981_THINKPAD,
-	AD1981_TOSHIBA,
-	AD1981_MODELS
-};
-
-static const char * const ad1981_models[AD1981_MODELS] = {
-	[AD1981_AUTO]		= "auto",
-	[AD1981_HP]		= "hp",
-	[AD1981_THINKPAD]	= "thinkpad",
-	[AD1981_BASIC]		= "basic",
-	[AD1981_TOSHIBA]	= "toshiba"
-};
-
-static const struct snd_pci_quirk ad1981_cfg_tbl[] = {
-	SND_PCI_QUIRK(0x1014, 0x0597, "Lenovo Z60", AD1981_THINKPAD),
-	SND_PCI_QUIRK(0x1014, 0x05b7, "Lenovo Z60m", AD1981_THINKPAD),
-	/* All HP models */
-	SND_PCI_QUIRK_VENDOR(0x103c, "HP nx", AD1981_HP),
-	SND_PCI_QUIRK(0x1179, 0x0001, "Toshiba U205", AD1981_TOSHIBA),
-	/* Lenovo Thinkpad T60/X60/Z6xx */
-	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo Thinkpad", AD1981_THINKPAD),
-	/* HP nx6320 (reversed SSID, H/W bug) */
-	SND_PCI_QUIRK(0x30b0, 0x103c, "HP nx6320", AD1981_HP),
-	{}
-};
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
-
 /* follow EAPD via vmaster hook */
 static void ad_vmaster_eapd_hook(void *private_data, int enabled)
 {
@@ -2172,7 +1596,7 @@ static const struct snd_pci_quirk ad1981_fixup_tbl[] = {
 	{}
 };
 
-static int ad1981_parse_auto_config(struct hda_codec *codec)
+static int patch_ad1981(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
 	int err;
@@ -2205,110 +1629,6 @@ static int ad1981_parse_auto_config(struct hda_codec *codec)
 	return err;
 }
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static int patch_ad1981(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec;
-	int err, board_config;
-
-	board_config = snd_hda_check_board_config(codec, AD1981_MODELS,
-						  ad1981_models,
-						  ad1981_cfg_tbl);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = AD1981_AUTO;
-	}
-
-	if (board_config == AD1981_AUTO)
-		return ad1981_parse_auto_config(codec);
-
-	err = alloc_ad_spec(codec);
-	if (err < 0)
-		return -ENOMEM;
-	spec = codec->spec;
-
-	err = snd_hda_attach_beep_device(codec, 0x10);
-	if (err < 0) {
-		ad198x_free(codec);
-		return err;
-	}
-	set_beep_amp(spec, 0x0d, 0, HDA_OUTPUT);
-
-	spec->multiout.max_channels = 2;
-	spec->multiout.num_dacs = ARRAY_SIZE(ad1981_dac_nids);
-	spec->multiout.dac_nids = ad1981_dac_nids;
-	spec->multiout.dig_out_nid = AD1981_SPDIF_OUT;
-	spec->num_adc_nids = 1;
-	spec->adc_nids = ad1981_adc_nids;
-	spec->capsrc_nids = ad1981_capsrc_nids;
-	spec->input_mux = &ad1981_capture_source;
-	spec->num_mixers = 1;
-	spec->mixers[0] = ad1981_mixers;
-	spec->num_init_verbs = 1;
-	spec->init_verbs[0] = ad1981_init_verbs;
-	spec->spdif_route = 0;
-#ifdef CONFIG_PM
-	spec->loopback.amplist = ad1981_loopbacks;
-#endif
-	spec->vmaster_nid = 0x05;
-
-	codec->patch_ops = ad198x_patch_ops;
-
-	/* override some parameters */
-	switch (board_config) {
-	case AD1981_HP:
-		spec->mixers[0] = ad1981_hp_mixers;
-		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = ad1981_hp_init_verbs;
-		if (!is_jack_available(codec, 0x0a))
-			spec->multiout.dig_out_nid = 0;
-		spec->input_mux = &ad1981_hp_capture_source;
-
-		codec->patch_ops.init = ad1981_hp_init;
-		codec->patch_ops.unsol_event = ad1981_hp_unsol_event;
-		/* set the upper-limit for mixer amp to 0dB for avoiding the
-		 * possible damage by overloading
-		 */
-		snd_hda_override_amp_caps(codec, 0x11, HDA_INPUT,
-					  (0x17 << AC_AMPCAP_OFFSET_SHIFT) |
-					  (0x17 << AC_AMPCAP_NUM_STEPS_SHIFT) |
-					  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
-					  (1 << AC_AMPCAP_MUTE_SHIFT));
-		break;
-	case AD1981_THINKPAD:
-		spec->mixers[0] = ad1981_thinkpad_mixers;
-		spec->input_mux = &ad1981_thinkpad_capture_source;
-		/* set the upper-limit for mixer amp to 0dB for avoiding the
-		 * possible damage by overloading
-		 */
-		snd_hda_override_amp_caps(codec, 0x11, HDA_INPUT,
-					  (0x17 << AC_AMPCAP_OFFSET_SHIFT) |
-					  (0x17 << AC_AMPCAP_NUM_STEPS_SHIFT) |
-					  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
-					  (1 << AC_AMPCAP_MUTE_SHIFT));
-		break;
-	case AD1981_TOSHIBA:
-		spec->mixers[0] = ad1981_hp_mixers;
-		spec->mixers[1] = ad1981_toshiba_mixers;
-		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = ad1981_toshiba_init_verbs;
-		spec->multiout.dig_out_nid = 0;
-		spec->input_mux = &ad1981_hp_capture_source;
-		codec->patch_ops.init = ad1981_hp_init;
-		codec->patch_ops.unsol_event = ad1981_hp_unsol_event;
-		break;
-	}
-
-	codec->no_trigger_sense = 1;
-	codec->no_sticky_stream = 1;
-
-	return 0;
-}
-#else /* ENABLE_AD_STATIC_QUIRKS */
-#define patch_ad1981	ad1981_parse_auto_config
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 
 /*
  * AD1988
-- 
1.8.3.1
