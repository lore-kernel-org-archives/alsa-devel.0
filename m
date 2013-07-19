From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/13] ALSA: hda - Remove static quirks for
	AD1882
Date: Fri, 19 Jul 2013 17:12:13 +0200
Message-ID: <1374246742-14373-5-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E9FE26575A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4D86DA538C
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

Now the generic parser can work stably enough, we can get rid of the
static quirks.  Let's start from AD1882.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 384 +------------------------------------------
 1 file changed, 1 insertion(+), 383 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index a667256..876d836 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -4891,299 +4891,7 @@ static int patch_ad1884a(struct hda_codec *codec)
  * port-G - rear clfe-out (6stack)
  */
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static const hda_nid_t ad1882_dac_nids[3] = {
-	0x04, 0x03, 0x05
-};
-
-static const hda_nid_t ad1882_adc_nids[2] = {
-	0x08, 0x09,
-};
-
-static const hda_nid_t ad1882_capsrc_nids[2] = {
-	0x0c, 0x0d,
-};
-
-#define AD1882_SPDIF_OUT	0x02
-
-/* list: 0x11, 0x39, 0x3a, 0x18, 0x3c, 0x3b, 0x12, 0x20 */
-static const struct hda_input_mux ad1882_capture_source = {
-	.num_items = 5,
-	.items = {
-		{ "Front Mic", 0x1 },
-		{ "Mic", 0x4 },
-		{ "Line", 0x2 },
-		{ "CD", 0x3 },
-		{ "Mix", 0x7 },
-	},
-};
-
-/* list: 0x11, 0x39, 0x3a, 0x3c, 0x18, 0x1f, 0x12, 0x20 */
-static const struct hda_input_mux ad1882a_capture_source = {
-	.num_items = 5,
-	.items = {
-		{ "Front Mic", 0x1 },
-		{ "Mic", 0x4},
-		{ "Line", 0x2 },
-		{ "Digital Mic", 0x06 },
-		{ "Mix", 0x7 },
-	},
-};
-
-static const struct snd_kcontrol_new ad1882_base_mixers[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x11, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x13, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x13, 1, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Line-In Boost Volume", 0x3a, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x0d, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* The multiple "Capture Source" controls confuse alsamixer
-		 * So call somewhat different..
-		 */
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 2,
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	/* SPDIF controls */
-	HDA_CODEC_VOLUME("IEC958 Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-		/* identical with ad1983 */
-		.info = ad1983_spdif_route_info,
-		.get = ad1983_spdif_route_get,
-		.put = ad1983_spdif_route_put,
-	},
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1882_loopback_mixers[] = {
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x20, 0x00, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x20, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x06, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x06, HDA_INPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1882a_loopback_mixers[] = {
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x20, 0x00, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x20, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x20, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x06, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x06, HDA_INPUT),
-	HDA_CODEC_VOLUME("Digital Mic Boost Volume", 0x1f, 0x0, HDA_INPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1882_3stack_mixers[] = {
-	HDA_CODEC_MUTE("Surround Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x17, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x17, 2, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Channel Mode",
-		.info = ad198x_ch_mode_info,
-		.get = ad198x_ch_mode_get,
-		.put = ad198x_ch_mode_put,
-	},
-	{ } /* end */
-};
-
-/* simple auto-mute control for AD1882 3-stack board */
-#define AD1882_HP_EVENT	0x01
-
-static void ad1882_3stack_automute(struct hda_codec *codec)
-{
-	bool mute = snd_hda_jack_detect(codec, 0x11);
-	snd_hda_codec_write(codec, 0x12, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    mute ? 0 : PIN_OUT);
-}
-
-static int ad1882_3stack_automute_init(struct hda_codec *codec)
-{
-	ad198x_init(codec);
-	ad1882_3stack_automute(codec);
-	return 0;
-}
-
-static void ad1882_3stack_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	switch (res >> 26) {
-	case AD1882_HP_EVENT:
-		ad1882_3stack_automute(codec);
-		break;
-	}
-}
-
-static const struct snd_kcontrol_new ad1882_6stack_mixers[] = {
-	HDA_CODEC_MUTE("Surround Playback Switch", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x24, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x24, 2, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-static const struct hda_verb ad1882_ch2_init[] = {
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{ } /* end */
-};
-
-static const struct hda_verb ad1882_ch4_init[] = {
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{ } /* end */
-};
-
-static const struct hda_verb ad1882_ch6_init[] = {
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	{ } /* end */
-};
-
-static const struct hda_channel_mode ad1882_modes[3] = {
-	{ 2, ad1882_ch2_init },
-	{ 4, ad1882_ch4_init },
-	{ 6, ad1882_ch6_init },
-};
-
-/*
- * initialization verbs
- */
-static const struct hda_verb ad1882_init_verbs[] = {
-	/* DACs; mute as default */
-	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	/* Port-A (HP) mixer */
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	/* Port-A pin */
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	/* HP selector - select DAC2 */
-	{0x37, AC_VERB_SET_CONNECT_SEL, 0x1},
-	/* Port-D (Line-out) mixer */
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	/* Port-D pin */
-	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	/* Mono-out mixer */
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	/* Mono-out pin */
-	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	/* Port-B (front mic) pin */
-	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x39, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO}, /* boost */
-	/* Port-C (line-in) pin */
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x3a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO}, /* boost */
-	/* Port-C mixer - mute as input */
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x2c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	/* Port-E (mic-in) pin */
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x3c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO}, /* boost */
-	/* Port-E mixer - mute as input */
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x26, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	/* Port-F (surround) */
-	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	/* Port-G (CLFE) */
-	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	/* Analog mixer; mute as default */
-	/* list: 0x39, 0x3a, 0x11, 0x12, 0x3c, 0x3b, 0x18, 0x1a */
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)},
-	/* Analog Mix output amp */
-	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x1f}, /* 0dB */
-	/* SPDIF output selector */
-	{0x02, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
-	{0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
-	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
-	{ } /* end */
-};
-
-static const struct hda_verb ad1882_3stack_automute_verbs[] = {
-	{0x11, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1882_HP_EVENT},
-	{ } /* end */
-};
-
-#ifdef CONFIG_PM
-static const struct hda_amp_list ad1882_loopbacks[] = {
-	{ 0x20, HDA_INPUT, 0 }, /* Front Mic */
-	{ 0x20, HDA_INPUT, 1 }, /* Mic */
-	{ 0x20, HDA_INPUT, 4 }, /* Line */
-	{ 0x20, HDA_INPUT, 6 }, /* CD */
-	{ } /* end */
-};
-#endif
-
-/* models */
-enum {
-	AD1882_AUTO,
-	AD1882_3STACK,
-	AD1882_6STACK,
-	AD1882_3STACK_AUTOMUTE,
-	AD1882_MODELS
-};
-
-static const char * const ad1882_models[AD1986A_MODELS] = {
-	[AD1882_AUTO]		= "auto",
-	[AD1882_3STACK]		= "3stack",
-	[AD1882_6STACK]		= "6stack",
-	[AD1882_3STACK_AUTOMUTE] = "3stack-automute",
-};
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
-static int ad1882_parse_auto_config(struct hda_codec *codec)
+static int patch_ad1882(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
 	int err;
@@ -5210,96 +4918,6 @@ static int ad1882_parse_auto_config(struct hda_codec *codec)
 	return err;
 }
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static int patch_ad1882(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec;
-	int err, board_config;
-
-	board_config = snd_hda_check_board_config(codec, AD1882_MODELS,
-						  ad1882_models, NULL);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = AD1882_AUTO;
-	}
-
-	if (board_config == AD1882_AUTO)
-		return ad1882_parse_auto_config(codec);
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
-	spec->multiout.max_channels = 6;
-	spec->multiout.num_dacs = 3;
-	spec->multiout.dac_nids = ad1882_dac_nids;
-	spec->multiout.dig_out_nid = AD1882_SPDIF_OUT;
-	spec->num_adc_nids = ARRAY_SIZE(ad1882_adc_nids);
-	spec->adc_nids = ad1882_adc_nids;
-	spec->capsrc_nids = ad1882_capsrc_nids;
-	if (codec->vendor_id == 0x11d41882)
-		spec->input_mux = &ad1882_capture_source;
-	else
-		spec->input_mux = &ad1882a_capture_source;
-	spec->num_mixers = 2;
-	spec->mixers[0] = ad1882_base_mixers;
-	if (codec->vendor_id == 0x11d41882)
-		spec->mixers[1] = ad1882_loopback_mixers;
-	else
-		spec->mixers[1] = ad1882a_loopback_mixers;
-	spec->num_init_verbs = 1;
-	spec->init_verbs[0] = ad1882_init_verbs;
-	spec->spdif_route = 0;
-#ifdef CONFIG_PM
-	spec->loopback.amplist = ad1882_loopbacks;
-#endif
-	spec->vmaster_nid = 0x04;
-
-	codec->patch_ops = ad198x_patch_ops;
-
-	/* override some parameters */
-	switch (board_config) {
-	default:
-	case AD1882_3STACK:
-	case AD1882_3STACK_AUTOMUTE:
-		spec->num_mixers = 3;
-		spec->mixers[2] = ad1882_3stack_mixers;
-		spec->channel_mode = ad1882_modes;
-		spec->num_channel_mode = ARRAY_SIZE(ad1882_modes);
-		spec->need_dac_fix = 1;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		if (board_config != AD1882_3STACK) {
-			spec->init_verbs[spec->num_init_verbs++] =
-				ad1882_3stack_automute_verbs;
-			codec->patch_ops.unsol_event = ad1882_3stack_unsol_event;
-			codec->patch_ops.init = ad1882_3stack_automute_init;
-		}
-		break;
-	case AD1882_6STACK:
-		spec->num_mixers = 3;
-		spec->mixers[2] = ad1882_6stack_mixers;
-		break;
-	}
-
-	codec->no_trigger_sense = 1;
-	codec->no_sticky_stream = 1;
-
-	return 0;
-}
-#else /* ENABLE_AD_STATIC_QUIRKS */
-#define patch_ad1882	ad1882_parse_auto_config
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 
 /*
  * patch entries
-- 
1.8.3.1
