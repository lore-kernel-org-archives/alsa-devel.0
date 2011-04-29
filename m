From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: hda - Consolidate default automute
	functions for Realtek
Date: Fri, 29 Apr 2011 19:18:29 +0200
Message-ID: <1304097516-7258-4-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DE7D103A39
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id DC223867E2
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:09 +0200 (CEST)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

There are two entry points for the headphone automute functions for
Realtek, alc_automute_amp() and alc_automute_pin().  These call the
same function in the end, so we can basically consolidate these
with a flag in spec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  260 ++++++++++++++++++++++++++---------------
 1 files changed, 163 insertions(+), 97 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4c4d51a2..5715b6f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -305,6 +305,11 @@ struct alc_multi_io {
 	unsigned int ctl_in;	/* cached input-pin control value */
 };
 
+enum {
+	ALC_AUTOMUTE_PIN,
+	ALC_AUTOMUTE_AMP,
+};
+
 struct alc_spec {
 	/* codec parameterization */
 	struct snd_kcontrol_new *mixers[5];	/* mixer arrays */
@@ -388,11 +393,16 @@ struct alc_spec {
 	unsigned int jack_present: 1;
 	unsigned int master_sw: 1;
 	unsigned int auto_mic:1;
+	unsigned int automute:1;	/* HP automute enabled */
 
 	/* other flags */
 	unsigned int no_analog :1; /* digital I/O only */
 	unsigned int dual_adc_switch:1; /* switch ADCs (for ALC275) */
 	unsigned int single_input_src:1;
+
+	/* auto-mute control */
+	int automute_mode;
+
 	int init_amp;
 	int codec_variant;	/* flag for other variants */
 
@@ -1062,13 +1072,16 @@ static int alc_init_jacks(struct hda_codec *codec)
 	return 0;
 }
 
-static void alc_automute_speaker(struct hda_codec *codec, int pinctl)
+static void alc_hp_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	unsigned int mute;
 	hda_nid_t nid;
 	int i;
 
+	if (!spec->automute)
+		return;
+
 	spec->jack_present = 0;
 	for (i = 0; i < ARRAY_SIZE(spec->autocfg.hp_pins); i++) {
 		nid = spec->autocfg.hp_pins[i];
@@ -1084,7 +1097,7 @@ static void alc_automute_speaker(struct hda_codec *codec, int pinctl)
 		nid = spec->autocfg.speaker_pins[i];
 		if (!nid)
 			break;
-		if (pinctl) {
+		if (spec->automute_mode == ALC_AUTOMUTE_PIN) {
 			snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
 				    spec->jack_present ? 0 : PIN_OUT);
@@ -1095,11 +1108,6 @@ static void alc_automute_speaker(struct hda_codec *codec, int pinctl)
 	}
 }
 
-static void alc_automute_pin(struct hda_codec *codec)
-{
-	alc_automute_speaker(codec, 1);
-}
-
 static int get_connection_index(struct hda_codec *codec, hda_nid_t mux,
 				hda_nid_t nid)
 {
@@ -1195,7 +1203,7 @@ static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
 		res >>= 26;
 	switch (res) {
 	case ALC880_HP_EVENT:
-		alc_automute_pin(codec);
+		alc_hp_automute(codec);
 		break;
 	case ALC880_MIC_EVENT:
 		alc_mic_automute(codec);
@@ -1205,7 +1213,7 @@ static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
 
 static void alc_inithook(struct hda_codec *codec)
 {
-	alc_automute_pin(codec);
+	alc_hp_automute(codec);
 	alc_mic_automute(codec);
 }
 
@@ -1374,6 +1382,8 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		snd_hda_codec_write_cache(codec, cfg->hp_pins[i], 0,
 				  AC_VERB_SET_UNSOLICITED_ENABLE,
 				  AC_USRSP_EN | ALC880_HP_EVENT);
+		spec->automute = 1;
+		spec->automute_mode = ALC_AUTOMUTE_PIN;
 	}
 	spec->unsol_event = alc_sku_unsol_event;
 }
@@ -1971,22 +1981,6 @@ static struct hda_verb alc888_fujitsu_xa3530_verbs[] = {
 	{}
 };
 
-static void alc_automute_amp(struct hda_codec *codec)
-{
-	alc_automute_speaker(codec, 0);
-}
-
-static void alc_automute_amp_unsol_event(struct hda_codec *codec,
-					 unsigned int res)
-{
-	if (codec->vendor_id == 0x10ec0880)
-		res >>= 28;
-	else
-		res >>= 26;
-	if (res == ALC880_HP_EVENT)
-		alc_automute_amp(codec);
-}
-
 static void alc889_automute_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -1997,12 +1991,14 @@ static void alc889_automute_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[2] = 0x17;
 	spec->autocfg.speaker_pins[3] = 0x19;
 	spec->autocfg.speaker_pins[4] = 0x1a;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc889_intel_init_hook(struct hda_codec *codec)
 {
 	alc889_coef_init(codec);
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 }
 
 static void alc888_fujitsu_xa3530_setup(struct hda_codec *codec)
@@ -2013,6 +2009,8 @@ static void alc888_fujitsu_xa3530_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[1] = 0x1b; /* hp */
 	spec->autocfg.speaker_pins[0] = 0x14; /* speaker */
 	spec->autocfg.speaker_pins[1] = 0x15; /* bass */
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /*
@@ -2295,6 +2293,8 @@ static void alc888_acer_aspire_4930g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc888_acer_aspire_6530g_setup(struct hda_codec *codec)
@@ -2305,6 +2305,8 @@ static void alc888_acer_aspire_6530g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc888_acer_aspire_7730g_setup(struct hda_codec *codec)
@@ -2315,6 +2317,8 @@ static void alc888_acer_aspire_7730g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc889_acer_aspire_8930g_setup(struct hda_codec *codec)
@@ -2325,6 +2329,8 @@ static void alc889_acer_aspire_8930g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x1b;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /*
@@ -3400,11 +3406,13 @@ static void alc880_uniwill_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x16;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc880_uniwill_init_hook(struct hda_codec *codec)
 {
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 	alc88x_simple_mic_automute(codec);
 }
 
@@ -3419,7 +3427,7 @@ static void alc880_uniwill_unsol_event(struct hda_codec *codec,
 		alc88x_simple_mic_automute(codec);
 		break;
 	default:
-		alc_automute_amp_unsol_event(codec, res);
+		alc_sku_unsol_event(codec, res);
 		break;
 	}
 }
@@ -3430,6 +3438,8 @@ static void alc880_uniwill_p53_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc880_uniwill_p53_dcvol_automute(struct hda_codec *codec)
@@ -3454,7 +3464,7 @@ static void alc880_uniwill_p53_unsol_event(struct hda_codec *codec,
 	if ((res >> 28) == ALC880_DCVOL_EVENT)
 		alc880_uniwill_p53_dcvol_automute(codec);
 	else
-		alc_automute_amp_unsol_event(codec, res);
+		alc_sku_unsol_event(codec, res);
 }
 
 /*
@@ -3698,6 +3708,8 @@ static void alc880_lg_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /*
@@ -3782,6 +3794,8 @@ static void alc880_lg_lw_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct snd_kcontrol_new alc880_medion_rim_mixer[] = {
@@ -3829,7 +3843,7 @@ static struct hda_verb alc880_medion_rim_init_verbs[] = {
 static void alc880_medion_rim_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 	/* toggle EAPD */
 	if (spec->jack_present)
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
@@ -3853,6 +3867,8 @@ static void alc880_medion_rim_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x1b;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
@@ -4806,7 +4822,7 @@ static struct alc_config_preset alc880_presets[] = {
 		.input_mux = &alc880_f1734_capture_source,
 		.unsol_event = alc880_uniwill_p53_unsol_event,
 		.setup = alc880_uniwill_p53_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC880_ASUS] = {
 		.mixers = { alc880_asus_mixer },
@@ -4897,7 +4913,7 @@ static struct alc_config_preset alc880_presets[] = {
 		.input_mux = &alc880_capture_source,
 		.unsol_event = alc880_uniwill_p53_unsol_event,
 		.setup = alc880_uniwill_p53_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC880_FUJITSU] = {
 		.mixers = { alc880_fujitsu_mixer },
@@ -4912,7 +4928,7 @@ static struct alc_config_preset alc880_presets[] = {
 		.input_mux = &alc880_capture_source,
 		.unsol_event = alc880_uniwill_p53_unsol_event,
 		.setup = alc880_uniwill_p53_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC880_CLEVO] = {
 		.mixers = { alc880_three_stack_mixer },
@@ -4937,9 +4953,9 @@ static struct alc_config_preset alc880_presets[] = {
 		.channel_mode = alc880_lg_ch_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc880_lg_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc880_lg_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 		.loopbacks = alc880_lg_loopbacks,
 #endif
@@ -4954,9 +4970,9 @@ static struct alc_config_preset alc880_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc880_lg_lw_modes),
 		.channel_mode = alc880_lg_lw_modes,
 		.input_mux = &alc880_lg_lw_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc880_lg_lw_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC880_MEDION_RIM] = {
 		.mixers = { alc880_medion_rim_mixer },
@@ -8629,6 +8645,8 @@ static void alc885_imac24_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x18;
 	spec->autocfg.speaker_pins[1] = 0x1a;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 #define alc885_mb5_setup	alc885_imac24_setup
@@ -8641,6 +8659,8 @@ static void alc885_mba21_setup(struct hda_codec *codec)
 
        spec->autocfg.hp_pins[0] = 0x14;
        spec->autocfg.speaker_pins[0] = 0x18;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 
@@ -8651,6 +8671,8 @@ static void alc885_mbp3_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc885_imac91_setup(struct hda_codec *codec)
@@ -8660,6 +8682,8 @@ static void alc885_imac91_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x18;
 	spec->autocfg.speaker_pins[1] = 0x1a;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct hda_verb alc882_targa_verbs[] = {
@@ -8681,7 +8705,7 @@ static struct hda_verb alc882_targa_verbs[] = {
 static void alc882_targa_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 	snd_hda_codec_write_cache(codec, 1, 0, AC_VERB_SET_GPIO_DATA,
 				  spec->jack_present ? 1 : 3);
 }
@@ -8692,6 +8716,8 @@ static void alc882_targa_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x1b;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc882_targa_unsol_event(struct hda_codec *codec, unsigned int res)
@@ -8779,7 +8805,7 @@ static void alc885_macpro_init_hook(struct hda_codec *codec)
 static void alc885_imac24_init_hook(struct hda_codec *codec)
 {
 	alc885_macpro_init_hook(codec);
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 }
 
 /*
@@ -9137,6 +9163,8 @@ static void alc883_medion_wim2160_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1a;
 	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct snd_kcontrol_new alc883_acer_aspire_mixer[] = {
@@ -9289,6 +9317,8 @@ static void alc883_mitac_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct hda_verb alc883_mitac_verbs[] = {
@@ -9453,6 +9483,8 @@ static void alc888_3st_hp_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x18;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct hda_verb alc888_3st_hp_verbs[] = {
@@ -9541,6 +9573,8 @@ static void alc883_lenovo_nb0763_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -9553,11 +9587,13 @@ static void alc883_clevo_m720_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc883_clevo_m720_init_hook(struct hda_codec *codec)
 {
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 	alc88x_simple_mic_automute(codec);
 }
 
@@ -9569,7 +9605,7 @@ static void alc883_clevo_m720_unsol_event(struct hda_codec *codec,
 		alc88x_simple_mic_automute(codec);
 		break;
 	default:
-		alc_automute_amp_unsol_event(codec, res);
+		alc_sku_unsol_event(codec, res);
 		break;
 	}
 }
@@ -9581,6 +9617,8 @@ static void alc883_2ch_fujitsu_pi2515_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc883_haier_w66_setup(struct hda_codec *codec)
@@ -9589,6 +9627,8 @@ static void alc883_haier_w66_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc883_lenovo_101e_ispeaker_automute(struct hda_codec *codec)
@@ -9626,6 +9666,8 @@ static void alc883_acer_aspire_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct hda_verb alc883_acer_eapd_verbs[] = {
@@ -9655,6 +9697,8 @@ static void alc888_6st_dell_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[1] = 0x15;
 	spec->autocfg.speaker_pins[2] = 0x16;
 	spec->autocfg.speaker_pins[3] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc888_lenovo_sky_setup(struct hda_codec *codec)
@@ -9667,6 +9711,8 @@ static void alc888_lenovo_sky_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[2] = 0x16;
 	spec->autocfg.speaker_pins[3] = 0x17;
 	spec->autocfg.speaker_pins[4] = 0x1a;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc883_vaiott_setup(struct hda_codec *codec)
@@ -9676,6 +9722,8 @@ static void alc883_vaiott_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct hda_verb alc888_asus_m90v_verbs[] = {
@@ -9701,6 +9749,8 @@ static void alc883_mode2_setup(struct hda_codec *codec)
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.mux_idx = 1;
 	spec->auto_mic = 1;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct hda_verb alc888_asus_eee1601_verbs[] = {
@@ -9722,7 +9772,7 @@ static void alc883_eee1601_inithook(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x1b;
-	alc_automute_pin(codec);
+	alc_hp_automute(codec);
 }
 
 static struct hda_verb alc889A_mb31_verbs[] = {
@@ -10043,9 +10093,9 @@ static struct alc_config_preset alc882_presets[] = {
 			.channel_mode = alc885_mba21_ch_modes,
 			.num_channel_mode = ARRAY_SIZE(alc885_mba21_ch_modes),
 			.input_mux = &alc882_capture_source,
-			.unsol_event = alc_automute_amp_unsol_event,
+			.unsol_event = alc_sku_unsol_event,
 			.setup = alc885_mba21_setup,
-			.init_hook = alc_automute_amp,
+			.init_hook = alc_hp_automute,
        },
 	[ALC885_MBP3] = {
 		.mixers = { alc885_mbp3_mixer, alc882_chmode_mixer },
@@ -10059,9 +10109,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.input_mux = &alc882_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 		.dig_in_nid = ALC882_DIGIN_NID,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc885_mbp3_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC885_MB5] = {
 		.mixers = { alc885_mb5_mixer, alc882_chmode_mixer },
@@ -10074,9 +10124,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.input_mux = &mb5_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 		.dig_in_nid = ALC882_DIGIN_NID,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc885_mb5_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC885_MACMINI3] = {
 		.mixers = { alc885_macmini3_mixer, alc882_chmode_mixer },
@@ -10089,9 +10139,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.input_mux = &macmini3_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 		.dig_in_nid = ALC882_DIGIN_NID,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc885_macmini3_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC885_MACPRO] = {
 		.mixers = { alc882_macpro_mixer },
@@ -10115,7 +10165,7 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc882_ch_modes),
 		.channel_mode = alc882_ch_modes,
 		.input_mux = &alc882_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc885_imac24_setup,
 		.init_hook = alc885_imac24_init_hook,
 	},
@@ -10130,9 +10180,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.input_mux = &alc889A_imac91_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 		.dig_in_nid = ALC882_DIGIN_NID,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc885_imac91_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC882_TARGA] = {
 		.mixers = { alc882_targa_mixer, alc882_chmode_mixer },
@@ -10148,7 +10198,7 @@ static struct alc_config_preset alc882_presets[] = {
 		.channel_mode = alc882_3ST_6ch_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc882_capture_source,
-		.unsol_event = alc882_targa_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc882_targa_setup,
 		.init_hook = alc882_targa_automute,
 	},
@@ -10242,8 +10292,8 @@ static struct alc_config_preset alc882_presets[] = {
 		.capsrc_nids = alc889_capsrc_nids,
 		.input_mux = &alc889_capture_source,
 		.setup = alc889_automute_setup,
-		.init_hook = alc_automute_amp,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.init_hook = alc_hp_automute,
+		.unsol_event = alc_sku_unsol_event,
 		.need_dac_fix = 1,
 	},
 	[ALC889_INTEL] = {
@@ -10263,7 +10313,7 @@ static struct alc_config_preset alc882_presets[] = {
 		.input_mux = &alc889_capture_source,
 		.setup = alc889_automute_setup,
 		.init_hook = alc889_intel_init_hook,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.need_dac_fix = 1,
 	},
 	[ALC883_6ST_DIG] = {
@@ -10352,9 +10402,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_acer_aspire_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_ACER_ASPIRE_4930G] = {
 		.mixers = { alc888_acer_aspire_4930g_mixer,
@@ -10374,9 +10424,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_mux_defs =
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux = alc888_2_capture_sources,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_acer_aspire_4930g_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_ACER_ASPIRE_6530G] = {
 		.mixers = { alc888_acer_aspire_6530_mixer },
@@ -10393,9 +10443,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_mux_defs =
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux = alc888_acer_aspire_6530_sources,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_acer_aspire_6530g_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_ACER_ASPIRE_8930G] = {
 		.mixers = { alc889_acer_aspire_8930g_mixer,
@@ -10416,9 +10466,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_mux_defs =
 			ARRAY_SIZE(alc889_capture_sources),
 		.input_mux = alc889_capture_sources,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc889_acer_aspire_8930g_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 		.power_hook = alc_power_eapd,
 #endif
@@ -10439,9 +10489,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.need_dac_fix = 1,
 		.const_channel_count = 6,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_acer_aspire_7730g_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC883_MEDION] = {
 		.mixers = { alc883_fivestack_mixer,
@@ -10468,9 +10518,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_medion_wim2160_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC883_LAPTOP_EAPD] = {
 		.mixers = { alc883_base_mixer },
@@ -10532,9 +10582,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.channel_mode = alc883_3ST_2ch_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc883_lenovo_nb0763_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_lenovo_nb0763_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_LENOVO_MS7195_DIG] = {
 		.mixers = { alc883_3ST_6ch_mixer, alc883_chmode_mixer },
@@ -10558,9 +10608,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_haier_w66_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_3ST_HP] = {
 		.mixers = { alc883_3ST_6ch_mixer, alc883_chmode_mixer },
@@ -10571,9 +10621,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.channel_mode = alc888_3st_hp_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_3st_hp_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_6ST_DELL] = {
 		.mixers = { alc883_base_mixer, alc883_chmode_mixer },
@@ -10585,9 +10635,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
 		.channel_mode = alc883_sixstack_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_6st_dell_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC883_MITAC] = {
 		.mixers = { alc883_mitac_mixer },
@@ -10597,9 +10647,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_mitac_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC883_FUJITSU_PI2515] = {
 		.mixers = { alc883_2ch_fujitsu_pi2515_mixer },
@@ -10611,9 +10661,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_fujitsu_pi2515_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_2ch_fujitsu_pi2515_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_FUJITSU_XA3530] = {
 		.mixers = { alc888_base_mixer, alc883_chmode_mixer },
@@ -10630,9 +10680,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_mux_defs =
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux = alc888_2_capture_sources,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_fujitsu_xa3530_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_LENOVO_SKY] = {
 		.mixers = { alc888_lenovo_sky_mixer, alc883_chmode_mixer },
@@ -10644,9 +10694,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.channel_mode = alc883_sixstack_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc883_lenovo_sky_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc888_lenovo_sky_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC888_ASUS_M90V] = {
 		.mixers = { alc883_3ST_6ch_mixer, alc883_chmode_mixer },
@@ -10714,9 +10764,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc883_vaiott_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 };
 
@@ -11347,6 +11397,8 @@ static void alc262_hp_t5735_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 static struct snd_kcontrol_new alc262_hp_t5735_mixer[] = {
@@ -11580,6 +11632,8 @@ static void alc262_tyan_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 
@@ -11723,6 +11777,8 @@ static void alc262_toshiba_s06_setup(struct hda_codec *codec)
 	spec->int_mic.pin = 0x12;
 	spec->int_mic.mux_idx = 9;
 	spec->auto_mic = 1;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 /*
@@ -12933,9 +12989,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc262_tyan_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 };
 
@@ -13349,6 +13405,8 @@ static void alc268_dell_setup(struct hda_codec *codec)
 	spec->int_mic.pin = 0x19;
 	spec->int_mic.mux_idx = 1;
 	spec->auto_mic = 1;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 static struct snd_kcontrol_new alc267_quanta_il1_mixer[] = {
@@ -13379,6 +13437,8 @@ static void alc267_quanta_il1_setup(struct hda_codec *codec)
 	spec->int_mic.pin = 0x19;
 	spec->int_mic.mux_idx = 1;
 	spec->auto_mic = 1;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 /*
@@ -16878,11 +16938,13 @@ static void alc861vd_lenovo_setup(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc861vd_lenovo_init_hook(struct hda_codec *codec)
 {
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 	alc88x_simple_mic_automute(codec);
 }
 
@@ -16894,7 +16956,7 @@ static void alc861vd_lenovo_unsol_event(struct hda_codec *codec,
 		alc88x_simple_mic_automute(codec);
 		break;
 	default:
-		alc_automute_amp_unsol_event(codec, res);
+		alc_sku_unsol_event(codec, res);
 		break;
 	}
 }
@@ -16951,6 +17013,8 @@ static void alc861vd_dallas_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
@@ -17075,9 +17139,9 @@ static struct alc_config_preset alc861vd_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
 		.channel_mode = alc861vd_3stack_2ch_modes,
 		.input_mux = &alc861vd_dallas_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc861vd_dallas_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC861VD_HP] = {
 		.mixers = { alc861vd_hp_mixer },
@@ -17088,9 +17152,9 @@ static struct alc_config_preset alc861vd_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
 		.channel_mode = alc861vd_3stack_2ch_modes,
 		.input_mux = &alc861vd_hp_capture_source,
-		.unsol_event = alc_automute_amp_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc861vd_dallas_setup,
-		.init_hook = alc_automute_amp,
+		.init_hook = alc_hp_automute,
 	},
 	[ALC660VD_ASUS_V1S] = {
 		.mixers = { alc861vd_lenovo_mixer },
@@ -20081,20 +20145,22 @@ static void alc680_base_setup(struct hda_codec *codec)
 	spec->autocfg.inputs[0].type = AUTO_PIN_MIC;
 	spec->autocfg.inputs[1].pin = 0x19;
 	spec->autocfg.inputs[1].type = AUTO_PIN_LINE_IN;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc680_unsol_event(struct hda_codec *codec,
 					   unsigned int res)
 {
 	if ((res >> 26) == ALC880_HP_EVENT)
-		alc_automute_amp(codec);
+		alc_hp_automute(codec);
 	if ((res >> 26) == ALC880_MIC_EVENT)
 		alc680_rec_autoswitch(codec);
 }
 
 static void alc680_inithook(struct hda_codec *codec)
 {
-	alc_automute_amp(codec);
+	alc_hp_automute(codec);
 	alc680_rec_autoswitch(codec);
 }
 
-- 
1.7.4.2
