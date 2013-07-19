From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/13] ALSA: hda - Remove static quirks for
	AD1988 codecs
Date: Fri, 19 Jul 2013 17:12:16 +0200
Message-ID: <1374246742-14373-8-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A4C7C265766
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80615A5386
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

For removing static quirks for AD1988 variants, a new fixup defining
the 6stack pinconfig has been added for the buggy BIOS.  Other than
that, we can cut off straightforwardly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 845 ++-----------------------------------------
 1 file changed, 35 insertions(+), 810 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 4fedd9d..7777a3a 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1715,90 +1715,7 @@ static int patch_ad1981(struct hda_codec *codec)
  *      E/F quad mic array
  */
 
-
 #ifdef ENABLE_AD_STATIC_QUIRKS
-/* models */
-enum {
-	AD1988_AUTO,
-	AD1988_6STACK,
-	AD1988_6STACK_DIG,
-	AD1988_3STACK,
-	AD1988_3STACK_DIG,
-	AD1988_LAPTOP,
-	AD1988_LAPTOP_DIG,
-	AD1988_MODEL_LAST,
-};
-
-/* reivision id to check workarounds */
-#define AD1988A_REV2		0x100200
-
-#define is_rev2(codec) \
-	((codec)->vendor_id == 0x11d41988 && \
-	 (codec)->revision_id == AD1988A_REV2)
-
-/*
- * mixers
- */
-
-static const hda_nid_t ad1988_6stack_dac_nids[4] = {
-	0x04, 0x06, 0x05, 0x0a
-};
-
-static const hda_nid_t ad1988_3stack_dac_nids[3] = {
-	0x04, 0x05, 0x0a
-};
-
-/* for AD1988A revision-2, DAC2-4 are swapped */
-static const hda_nid_t ad1988_6stack_dac_nids_rev2[4] = {
-	0x04, 0x05, 0x0a, 0x06
-};
-
-static const hda_nid_t ad1988_alt_dac_nid[1] = {
-	0x03
-};
-
-static const hda_nid_t ad1988_3stack_dac_nids_rev2[3] = {
-	0x04, 0x0a, 0x06
-};
-
-static const hda_nid_t ad1988_adc_nids[3] = {
-	0x08, 0x09, 0x0f
-};
-
-static const hda_nid_t ad1988_capsrc_nids[3] = {
-	0x0c, 0x0d, 0x0e
-};
-
-#define AD1988_SPDIF_OUT		0x02
-#define AD1988_SPDIF_OUT_HDMI	0x0b
-#define AD1988_SPDIF_IN		0x07
-
-static const hda_nid_t ad1989b_slave_dig_outs[] = {
-	AD1988_SPDIF_OUT, AD1988_SPDIF_OUT_HDMI, 0
-};
-
-static const struct hda_input_mux ad1988_6stack_capture_source = {
-	.num_items = 5,
-	.items = {
-		{ "Front Mic", 0x1 },	/* port-B */
-		{ "Line", 0x2 },	/* port-C */
-		{ "Mic", 0x4 },		/* port-E */
-		{ "CD", 0x5 },
-		{ "Mix", 0x9 },
-	},
-};
-
-static const struct hda_input_mux ad1988_laptop_capture_source = {
-	.num_items = 3,
-	.items = {
-		{ "Mic/Line", 0x1 },	/* port-B */
-		{ "CD", 0x5 },
-		{ "Mix", 0x9 },
-	},
-};
-
-/*
- */
 static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
@@ -1829,569 +1746,6 @@ static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
 		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
 	return err;
 }
-
-/* 6-stack mode */
-static const struct snd_kcontrol_new ad1988_6stack_mixers1[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x06, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Side Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1988_6stack_mixers1_rev2[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x05, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0a, 2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Side Playback Volume", 0x06, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1988_6stack_mixers2[] = {
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x29, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x2a, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x27, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x27, 2, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Side Playback Switch", 0x28, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Headphone Playback Switch", 0x22, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Mono Playback Switch", 0x1e, 2, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x6, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x6, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x20, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x20, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x20, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x4, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-/* 3-stack mode */
-static const struct snd_kcontrol_new ad1988_3stack_mixers1[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1988_3stack_mixers1_rev2[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x06, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x06, 2, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1988_3stack_mixers2[] = {
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x29, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x2c, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x26, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x26, 2, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Headphone Playback Switch", 0x22, 2, HDA_INPUT),
-	HDA_BIND_MUTE("Mono Playback Switch", 0x1e, 2, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x6, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x6, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x20, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x20, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x20, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x4, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Channel Mode",
-		.info = ad198x_ch_mode_info,
-		.get = ad198x_ch_mode_get,
-		.put = ad198x_ch_mode_put,
-	},
-
-	{ } /* end */
-};
-
-/* laptop mode */
-static const struct snd_kcontrol_new ad1988_laptop_mixers[] = {
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x04, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x29, 0x0, HDA_INPUT),
-	HDA_BIND_MUTE("Mono Playback Switch", 0x1e, 2, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x6, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x6, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x20, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x1, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
-
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "External Amplifier",
-		.subdevice = HDA_SUBDEV_NID_FLAG | 0x12,
-		.info = ad198x_eapd_info,
-		.get = ad198x_eapd_get,
-		.put = ad198x_eapd_put,
-		.private_value = 0x12, /* port-D */
-	},
-
-	{ } /* end */
-};
-
-/* capture */
-static const struct snd_kcontrol_new ad1988_capture_mixers[] = {
-	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x0d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 2, 0x0e, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 2, 0x0e, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* The multiple "Capture Source" controls confuse alsamixer
-		 * So call somewhat different..
-		 */
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 3,
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	{ } /* end */
-};
-
-static int ad1988_spdif_playback_source_info(struct snd_kcontrol *kcontrol,
-					     struct snd_ctl_elem_info *uinfo)
-{
-	static const char * const texts[] = {
-		"PCM", "ADC1", "ADC2", "ADC3"
-	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= 4)
-		uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
-}
-
-static int ad1988_spdif_playback_source_get(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int sel;
-
-	sel = snd_hda_codec_read(codec, 0x1d, 0, AC_VERB_GET_AMP_GAIN_MUTE,
-				 AC_AMP_GET_INPUT);
-	if (!(sel & 0x80))
-		ucontrol->value.enumerated.item[0] = 0;
-	else {
-		sel = snd_hda_codec_read(codec, 0x0b, 0,
-					 AC_VERB_GET_CONNECT_SEL, 0);
-		if (sel < 3)
-			sel++;
-		else
-			sel = 0;
-		ucontrol->value.enumerated.item[0] = sel;
-	}
-	return 0;
-}
-
-static int ad1988_spdif_playback_source_put(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int val, sel;
-	int change;
-
-	val = ucontrol->value.enumerated.item[0];
-	if (val > 3)
-		return -EINVAL;
-	if (!val) {
-		sel = snd_hda_codec_read(codec, 0x1d, 0,
-					 AC_VERB_GET_AMP_GAIN_MUTE,
-					 AC_AMP_GET_INPUT);
-		change = sel & 0x80;
-		if (change) {
-			snd_hda_codec_write_cache(codec, 0x1d, 0,
-						  AC_VERB_SET_AMP_GAIN_MUTE,
-						  AMP_IN_UNMUTE(0));
-			snd_hda_codec_write_cache(codec, 0x1d, 0,
-						  AC_VERB_SET_AMP_GAIN_MUTE,
-						  AMP_IN_MUTE(1));
-		}
-	} else {
-		sel = snd_hda_codec_read(codec, 0x1d, 0,
-					 AC_VERB_GET_AMP_GAIN_MUTE,
-					 AC_AMP_GET_INPUT | 0x01);
-		change = sel & 0x80;
-		if (change) {
-			snd_hda_codec_write_cache(codec, 0x1d, 0,
-						  AC_VERB_SET_AMP_GAIN_MUTE,
-						  AMP_IN_MUTE(0));
-			snd_hda_codec_write_cache(codec, 0x1d, 0,
-						  AC_VERB_SET_AMP_GAIN_MUTE,
-						  AMP_IN_UNMUTE(1));
-		}
-		sel = snd_hda_codec_read(codec, 0x0b, 0,
-					 AC_VERB_GET_CONNECT_SEL, 0) + 1;
-		change |= sel != val;
-		if (change)
-			snd_hda_codec_write_cache(codec, 0x0b, 0,
-						  AC_VERB_SET_CONNECT_SEL,
-						  val - 1);
-	}
-	return change;
-}
-
-static const struct snd_kcontrol_new ad1988_spdif_out_mixers[] = {
-	HDA_CODEC_VOLUME("IEC958 Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "IEC958 Playback Source",
-		.subdevice = HDA_SUBDEV_NID_FLAG | 0x1b,
-		.info = ad1988_spdif_playback_source_info,
-		.get = ad1988_spdif_playback_source_get,
-		.put = ad1988_spdif_playback_source_put,
-	},
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1988_spdif_in_mixers[] = {
-	HDA_CODEC_VOLUME("IEC958 Capture Volume", 0x1c, 0x0, HDA_INPUT),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1989_spdif_out_mixers[] = {
-	HDA_CODEC_VOLUME("IEC958 Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("HDMI Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-/*
- * initialization verbs
- */
-
-/*
- * for 6-stack (+dig)
- */
-static const struct hda_verb ad1988_6stack_init_verbs[] = {
-	/* Front, Surround, CLFE, side DAC; unmute as default */
-	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Port-A front headphon path */
-	{0x37, AC_VERB_SET_CONNECT_SEL, 0x00}, /* DAC0:03h */
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	/* Port-D line-out path */
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	/* Port-F surround path */
-	{0x2a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x2a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	/* Port-G CLFE path */
-	{0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	/* Port-H side path */
-	{0x28, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x28, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x25, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	/* Mono out path */
-	{0x36, AC_VERB_SET_CONNECT_SEL, 0x1}, /* DAC1:04h */
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb01f}, /* unmute, 0dB */
-	/* Port-B front mic-in path */
-	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x39, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	/* Port-C line-in path */
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
-	{0x3a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x33, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Port-E mic-in path */
-	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x3c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Analog CD Input */
-	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
-	/* Analog Mix output amp */
-	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x1f}, /* 0dB */
-
-	{ }
-};
-
-static const struct hda_verb ad1988_6stack_fp_init_verbs[] = {
-	/* Headphone; unmute as default */
-	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Port-A front headphon path */
-	{0x37, AC_VERB_SET_CONNECT_SEL, 0x00}, /* DAC0:03h */
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-
-	{ }
-};
-
-static const struct hda_verb ad1988_capture_init_verbs[] = {
-	/* mute analog mix */
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)},
-	/* select ADCs - front-mic */
-	{0x0c, AC_VERB_SET_CONNECT_SEL, 0x1},
-	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x1},
-	{0x0e, AC_VERB_SET_CONNECT_SEL, 0x1},
-
-	{ }
-};
-
-static const struct hda_verb ad1988_spdif_init_verbs[] = {
-	/* SPDIF out sel */
-	{0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
-	{0x0b, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1 */
-	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	/* SPDIF out pin */
-	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
-
-	{ }
-};
-
-static const struct hda_verb ad1988_spdif_in_init_verbs[] = {
-	/* unmute SPDIF input pin */
-	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ }
-};
-
-/* AD1989 has no ADC -> SPDIF route */
-static const struct hda_verb ad1989_spdif_init_verbs[] = {
-	/* SPDIF-1 out pin */
-	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
-	/* SPDIF-2/HDMI out pin */
-	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
-	{ }
-};
-
-/*
- * verbs for 3stack (+dig)
- */
-static const struct hda_verb ad1988_3stack_ch2_init[] = {
-	/* set port-C to line-in */
-	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
-	{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
-	/* set port-E to mic-in */
-	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
-	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
-	{ } /* end */
-};
-
-static const struct hda_verb ad1988_3stack_ch6_init[] = {
-	/* set port-C to surround out */
-	{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	/* set port-E to CLFE out */
-	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ } /* end */
-};
-
-static const struct hda_channel_mode ad1988_3stack_modes[2] = {
-	{ 2, ad1988_3stack_ch2_init },
-	{ 6, ad1988_3stack_ch6_init },
-};
-
-static const struct hda_verb ad1988_3stack_init_verbs[] = {
-	/* Front, Surround, CLFE, side DAC; unmute as default */
-	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Port-A front headphon path */
-	{0x37, AC_VERB_SET_CONNECT_SEL, 0x00}, /* DAC0:03h */
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	/* Port-D line-out path */
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	/* Mono out path */
-	{0x36, AC_VERB_SET_CONNECT_SEL, 0x1}, /* DAC1:04h */
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb01f}, /* unmute, 0dB */
-	/* Port-B front mic-in path */
-	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x39, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	/* Port-C line-in/surround path - 6ch mode as default */
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x3a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x31, AC_VERB_SET_CONNECT_SEL, 0x0}, /* output sel: DAC 0x05 */
-	{0x33, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Port-E mic-in/CLFE path - 6ch mode as default */
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x3c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x32, AC_VERB_SET_CONNECT_SEL, 0x1}, /* output sel: DAC 0x0a */
-	{0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* mute analog mix */
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)},
-	/* select ADCs - front-mic */
-	{0x0c, AC_VERB_SET_CONNECT_SEL, 0x1},
-	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x1},
-	{0x0e, AC_VERB_SET_CONNECT_SEL, 0x1},
-	/* Analog Mix output amp */
-	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x1f}, /* 0dB */
-	{ }
-};
-
-/*
- * verbs for laptop mode (+dig)
- */
-static const struct hda_verb ad1988_laptop_hp_on[] = {
-	/* unmute port-A and mute port-D */
-	{ 0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
-	{ } /* end */
-};
-static const struct hda_verb ad1988_laptop_hp_off[] = {
-	/* mute port-A and unmute port-D */
-	{ 0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
-	{ 0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ } /* end */
-};
-
-#define AD1988_HP_EVENT	0x01
-
-static const struct hda_verb ad1988_laptop_init_verbs[] = {
-	/* Front, Surround, CLFE, side DAC; unmute as default */
-	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Port-A front headphon path */
-	{0x37, AC_VERB_SET_CONNECT_SEL, 0x00}, /* DAC0:03h */
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	/* unsolicited event for pin-sense */
-	{0x11, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1988_HP_EVENT },
-	/* Port-D line-out path + EAPD */
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x12, AC_VERB_SET_EAPD_BTLENABLE, 0x00}, /* EAPD-off */
-	/* Mono out path */
-	{0x36, AC_VERB_SET_CONNECT_SEL, 0x1}, /* DAC1:04h */
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb01f}, /* unmute, 0dB */
-	/* Port-B mic-in path */
-	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x39, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	/* Port-C docking station - try to output */
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x3a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	{0x33, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* mute analog mix */
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)},
-	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)},
-	/* select ADCs - mic */
-	{0x0c, AC_VERB_SET_CONNECT_SEL, 0x1},
-	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x1},
-	{0x0e, AC_VERB_SET_CONNECT_SEL, 0x1},
-	/* Analog Mix output amp */
-	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x1f}, /* 0dB */
-	{ }
-};
-
-static void ad1988_laptop_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	if ((res >> 26) != AD1988_HP_EVENT)
-		return;
-	if (snd_hda_jack_detect(codec, 0x11))
-		snd_hda_sequence_write(codec, ad1988_laptop_hp_on);
-	else
-		snd_hda_sequence_write(codec, ad1988_laptop_hp_off);
-} 
-
-#ifdef CONFIG_PM
-static const struct hda_amp_list ad1988_loopbacks[] = {
-	{ 0x20, HDA_INPUT, 0 }, /* Front Mic */
-	{ 0x20, HDA_INPUT, 1 }, /* Line */
-	{ 0x20, HDA_INPUT, 4 }, /* Mic */
-	{ 0x20, HDA_INPUT, 6 }, /* CD */
-	{ } /* end */
-};
-#endif
 #endif /* ENABLE_AD_STATIC_QUIRKS */
 
 static int ad1988_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
@@ -2540,7 +1894,34 @@ static int ad1988_add_spdif_mux_ctl(struct hda_codec *codec)
 /*
  */
 
-static int ad1988_parse_auto_config(struct hda_codec *codec)
+enum {
+	AD1988_FIXUP_6STACK_DIG,
+};
+
+static const struct hda_fixup ad1988_fixups[] = {
+	[AD1988_FIXUP_6STACK_DIG] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x11, 0x02214130 }, /* front-hp */
+			{ 0x12, 0x01014010 }, /* line-out */
+			{ 0x14, 0x02a19122 }, /* front-mic */
+			{ 0x15, 0x01813021 }, /* line-in */
+			{ 0x16, 0x01011012 }, /* line-out */
+			{ 0x17, 0x01a19020 }, /* mic */
+			{ 0x1b, 0x0145f1f0 }, /* SPDIF */
+			{ 0x24, 0x01016011 }, /* line-out */
+			{ 0x25, 0x01012013 }, /* line-out */
+			{ }
+		}
+	},
+};
+
+static const struct hda_model_fixup ad1988_fixup_models[] = {
+	{ .id = AD1988_FIXUP_6STACK_DIG, .name = "6stack-dig" },
+	{}
+};
+
+static int patch_ad1988(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
 	int err;
@@ -2554,12 +1935,19 @@ static int ad1988_parse_auto_config(struct hda_codec *codec)
 	spec->gen.mixer_merge_nid = 0x21;
 	spec->gen.beep_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
+
+	snd_hda_pick_fixup(codec, ad1988_fixup_models, NULL, ad1988_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
 	err = ad198x_parse_auto_config(codec);
 	if (err < 0)
 		goto error;
 	err = ad1988_add_spdif_mux_ctl(codec);
 	if (err < 0)
 		goto error;
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -2567,169 +1955,6 @@ static int ad1988_parse_auto_config(struct hda_codec *codec)
 	return err;
 }
 
-/*
- */
-
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static const char * const ad1988_models[AD1988_MODEL_LAST] = {
-	[AD1988_6STACK]		= "6stack",
-	[AD1988_6STACK_DIG]	= "6stack-dig",
-	[AD1988_3STACK]		= "3stack",
-	[AD1988_3STACK_DIG]	= "3stack-dig",
-	[AD1988_LAPTOP]		= "laptop",
-	[AD1988_LAPTOP_DIG]	= "laptop-dig",
-	[AD1988_AUTO]		= "auto",
-};
-
-static const struct snd_pci_quirk ad1988_cfg_tbl[] = {
-	SND_PCI_QUIRK(0x1043, 0x81ec, "Asus P5B-DLX", AD1988_6STACK_DIG),
-	SND_PCI_QUIRK(0x1043, 0x81f6, "Asus M2N-SLI", AD1988_6STACK_DIG),
-	SND_PCI_QUIRK(0x1043, 0x8277, "Asus P5K-E/WIFI-AP", AD1988_6STACK_DIG),
-	SND_PCI_QUIRK(0x1043, 0x82c0, "Asus M3N-HT Deluxe", AD1988_6STACK_DIG),
-	SND_PCI_QUIRK(0x1043, 0x8311, "Asus P5Q-Premium/Pro", AD1988_6STACK_DIG),
-	{}
-};
-
-static int patch_ad1988(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec;
-	int err, board_config;
-
-	board_config = snd_hda_check_board_config(codec, AD1988_MODEL_LAST,
-						  ad1988_models, ad1988_cfg_tbl);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = AD1988_AUTO;
-	}
-
-	if (board_config == AD1988_AUTO)
-		return ad1988_parse_auto_config(codec);
-
-	err = alloc_ad_spec(codec);
-	if (err < 0)
-		return err;
-	spec = codec->spec;
-
-	if (is_rev2(codec))
-		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
-
-	err = snd_hda_attach_beep_device(codec, 0x10);
-	if (err < 0) {
-		ad198x_free(codec);
-		return err;
-	}
-	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
-
-	if (!spec->multiout.hp_nid)
-		spec->multiout.hp_nid = ad1988_alt_dac_nid[0];
-	switch (board_config) {
-	case AD1988_6STACK:
-	case AD1988_6STACK_DIG:
-		spec->multiout.max_channels = 8;
-		spec->multiout.num_dacs = 4;
-		if (is_rev2(codec))
-			spec->multiout.dac_nids = ad1988_6stack_dac_nids_rev2;
-		else
-			spec->multiout.dac_nids = ad1988_6stack_dac_nids;
-		spec->input_mux = &ad1988_6stack_capture_source;
-		spec->num_mixers = 2;
-		if (is_rev2(codec))
-			spec->mixers[0] = ad1988_6stack_mixers1_rev2;
-		else
-			spec->mixers[0] = ad1988_6stack_mixers1;
-		spec->mixers[1] = ad1988_6stack_mixers2;
-		spec->num_init_verbs = 1;
-		spec->init_verbs[0] = ad1988_6stack_init_verbs;
-		if (board_config == AD1988_6STACK_DIG) {
-			spec->multiout.dig_out_nid = AD1988_SPDIF_OUT;
-			spec->dig_in_nid = AD1988_SPDIF_IN;
-		}
-		break;
-	case AD1988_3STACK:
-	case AD1988_3STACK_DIG:
-		spec->multiout.max_channels = 6;
-		spec->multiout.num_dacs = 3;
-		if (is_rev2(codec))
-			spec->multiout.dac_nids = ad1988_3stack_dac_nids_rev2;
-		else
-			spec->multiout.dac_nids = ad1988_3stack_dac_nids;
-		spec->input_mux = &ad1988_6stack_capture_source;
-		spec->channel_mode = ad1988_3stack_modes;
-		spec->num_channel_mode = ARRAY_SIZE(ad1988_3stack_modes);
-		spec->num_mixers = 2;
-		if (is_rev2(codec))
-			spec->mixers[0] = ad1988_3stack_mixers1_rev2;
-		else
-			spec->mixers[0] = ad1988_3stack_mixers1;
-		spec->mixers[1] = ad1988_3stack_mixers2;
-		spec->num_init_verbs = 1;
-		spec->init_verbs[0] = ad1988_3stack_init_verbs;
-		if (board_config == AD1988_3STACK_DIG)
-			spec->multiout.dig_out_nid = AD1988_SPDIF_OUT;
-		break;
-	case AD1988_LAPTOP:
-	case AD1988_LAPTOP_DIG:
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1988_3stack_dac_nids;
-		spec->input_mux = &ad1988_laptop_capture_source;
-		spec->num_mixers = 1;
-		spec->mixers[0] = ad1988_laptop_mixers;
-		codec->inv_eapd = 1; /* inverted EAPD */
-		spec->num_init_verbs = 1;
-		spec->init_verbs[0] = ad1988_laptop_init_verbs;
-		if (board_config == AD1988_LAPTOP_DIG)
-			spec->multiout.dig_out_nid = AD1988_SPDIF_OUT;
-		break;
-	}
-
-	spec->num_adc_nids = ARRAY_SIZE(ad1988_adc_nids);
-	spec->adc_nids = ad1988_adc_nids;
-	spec->capsrc_nids = ad1988_capsrc_nids;
-	spec->mixers[spec->num_mixers++] = ad1988_capture_mixers;
-	spec->init_verbs[spec->num_init_verbs++] = ad1988_capture_init_verbs;
-	if (spec->multiout.dig_out_nid) {
-		if (codec->vendor_id >= 0x11d4989a) {
-			spec->mixers[spec->num_mixers++] =
-				ad1989_spdif_out_mixers;
-			spec->init_verbs[spec->num_init_verbs++] =
-				ad1989_spdif_init_verbs;
-			codec->slave_dig_outs = ad1989b_slave_dig_outs;
-		} else {
-			spec->mixers[spec->num_mixers++] =
-				ad1988_spdif_out_mixers;
-			spec->init_verbs[spec->num_init_verbs++] =
-				ad1988_spdif_init_verbs;
-		}
-	}
-	if (spec->dig_in_nid && codec->vendor_id < 0x11d4989a) {
-		spec->mixers[spec->num_mixers++] = ad1988_spdif_in_mixers;
-		spec->init_verbs[spec->num_init_verbs++] =
-			ad1988_spdif_in_init_verbs;
-	}
-
-	codec->patch_ops = ad198x_patch_ops;
-	switch (board_config) {
-	case AD1988_LAPTOP:
-	case AD1988_LAPTOP_DIG:
-		codec->patch_ops.unsol_event = ad1988_laptop_unsol_event;
-		break;
-	}
-#ifdef CONFIG_PM
-	spec->loopback.amplist = ad1988_loopbacks;
-#endif
-	spec->vmaster_nid = 0x04;
-
-	codec->no_trigger_sense = 1;
-	codec->no_sticky_stream = 1;
-
-	return 0;
-}
-#else /* ENABLE_AD_STATIC_QUIRKS */
-#define patch_ad1988	ad1988_parse_auto_config
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 
 /*
  * AD1884 / AD1984
-- 
1.8.3.1
