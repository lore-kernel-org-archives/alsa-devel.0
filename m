From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: hda - Add support of line-out
	automute for Realtek
Date: Fri, 29 Apr 2011 19:18:31 +0200
Message-ID: <1304097516-7258-6-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 51409103A3B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id DC2D586A2E
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

Add the common helper function and flags to support the auto-mute
per line-out jack detection, and also the mute of line-out jacks.

A few model-specific implementations are replaced with the common
helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  274 ++++++++++++++++++-----------------------
 1 files changed, 120 insertions(+), 154 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index af9bb96..222abba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -392,9 +392,12 @@ struct alc_spec {
 	/* for pin sensing */
 	unsigned int sense_updated: 1;
 	unsigned int jack_present: 1;
+	unsigned int line_jack_present:1;
 	unsigned int master_sw: 1;
 	unsigned int auto_mic:1;
 	unsigned int automute:1;	/* HP automute enabled */
+	unsigned int detect_line:1;	/* Line-out detection enabled */
+	unsigned int automute_lines:1;	/* automute line-out as well */
 
 	/* other flags */
 	unsigned int no_analog :1; /* digital I/O only */
@@ -1074,54 +1077,96 @@ static int alc_init_jacks(struct hda_codec *codec)
 	return 0;
 }
 
-static void alc_hp_automute(struct hda_codec *codec)
+static int detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 {
-	struct alc_spec *spec = codec->spec;
-	unsigned int mute;
-	hda_nid_t nid;
-	int i;
+	int i, present = 0;
 
-	if (!spec->automute)
-		return;
-
-	spec->jack_present = 0;
-	for (i = 0; i < ARRAY_SIZE(spec->autocfg.hp_pins); i++) {
-		nid = spec->autocfg.hp_pins[i];
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t nid = pins[i];
 		if (!nid)
 			break;
 		snd_hda_input_jack_report(codec, nid);
-		spec->jack_present |= snd_hda_jack_detect(codec, nid);
+		present |= snd_hda_jack_detect(codec, nid);
 	}
+	return present;
+}
 
-	mute = spec->jack_present ? HDA_AMP_MUTE : 0;
-	/* Toggle internal speakers muting */
-	for (i = 0; i < ARRAY_SIZE(spec->autocfg.speaker_pins); i++) {
-		nid = spec->autocfg.speaker_pins[i];
+static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
+			bool mute)
+{
+	struct alc_spec *spec = codec->spec;
+	unsigned int mute_bits = mute ? HDA_AMP_MUTE : 0;
+	unsigned int pin_bits = mute ? 0 : PIN_OUT;
+	int i;
+
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t nid = pins[i];
 		if (!nid)
 			break;
 		switch (spec->automute_mode) {
 		case ALC_AUTOMUTE_PIN:
 			snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    spec->jack_present ? 0 : PIN_OUT);
+					    AC_VERB_SET_PIN_WIDGET_CONTROL,
+					    pin_bits);
 			break;
 		case ALC_AUTOMUTE_AMP:
 			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, mute);
+						 HDA_AMP_MUTE, mute_bits);
 			break;
 		case ALC_AUTOMUTE_MIXER:
 			nid = spec->automute_mixer_nid[i];
 			if (!nid)
 				break;
 			snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT, 0,
-						 HDA_AMP_MUTE, mute);
+						 HDA_AMP_MUTE, mute_bits);
 			snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT, 1,
-						 HDA_AMP_MUTE, mute);
+						 HDA_AMP_MUTE, mute_bits);
 			break;
 		}
 	}
 }
 
+/* Toggle internal speakers muting */
+static void update_speakers(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
+		    spec->autocfg.speaker_pins,
+		    spec->jack_present | spec->line_jack_present);
+
+	/* toggle line-out mutes if needed, too */
+	if (!spec->automute_lines)
+		return;
+	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
+		    spec->autocfg.line_out_pins,
+		    spec->jack_present);
+}
+
+static void alc_hp_automute(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (!spec->automute)
+		return;
+	spec->jack_present =
+		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
+			     spec->autocfg.hp_pins);
+	update_speakers(codec);
+}
+
+static void alc_line_automute(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (!spec->automute || !spec->detect_line)
+		return;
+	spec->line_jack_present =
+		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
+			     spec->autocfg.line_out_pins);
+	update_speakers(codec);
+}
+
 static int get_connection_index(struct hda_codec *codec, hda_nid_t mux,
 				hda_nid_t nid)
 {
@@ -1219,6 +1264,9 @@ static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
 	case ALC880_HP_EVENT:
 		alc_hp_automute(codec);
 		break;
+	case ALC880_FRONT_EVENT:
+		alc_line_automute(codec);
+		break;
 	case ALC880_MIC_EVENT:
 		alc_mic_automute(codec);
 		break;
@@ -1228,6 +1276,7 @@ static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
 static void alc_inithook(struct hda_codec *codec)
 {
 	alc_hp_automute(codec);
+	alc_line_automute(codec);
 	alc_mic_automute(codec);
 }
 
@@ -9551,33 +9600,15 @@ static struct hda_channel_mode alc888_3st_hp_modes[3] = {
 	{ 6, alc888_3st_hp_6ch_init },
 };
 
-/* toggle front-jack and RCA according to the hp-jack state */
-static void alc888_lenovo_ms7195_front_automute(struct hda_codec *codec)
-{
- 	unsigned int present = snd_hda_jack_detect(codec, 0x1b);
-
-	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
-}
-
-/* toggle RCA according to the front-jack state */
-static void alc888_lenovo_ms7195_rca_automute(struct hda_codec *codec)
+static void alc888_lenovo_ms7195_setup(struct hda_codec *codec)
 {
- 	unsigned int present = snd_hda_jack_detect(codec, 0x14);
-
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
-}
+	struct alc_spec *spec = codec->spec;
 
-static void alc883_lenovo_ms7195_unsol_event(struct hda_codec *codec,
-					     unsigned int res)
-{
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc888_lenovo_ms7195_front_automute(codec);
-	if ((res >> 26) == ALC880_FRONT_EVENT)
-		alc888_lenovo_ms7195_rca_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.line_out_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -9645,31 +9676,17 @@ static void alc883_haier_w66_setup(struct hda_codec *codec)
 	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
-static void alc883_lenovo_101e_ispeaker_automute(struct hda_codec *codec)
+static void alc883_lenovo_101e_setup(struct hda_codec *codec)
 {
-	int bits = snd_hda_jack_detect(codec, 0x14) ? HDA_AMP_MUTE : 0;
-
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc883_lenovo_101e_all_automute(struct hda_codec *codec)
-{
-	int bits = snd_hda_jack_detect(codec, 0x1b) ? HDA_AMP_MUTE : 0;
-
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-}
+	struct alc_spec *spec = codec->spec;
 
-static void alc883_lenovo_101e_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc883_lenovo_101e_all_automute(codec);
-	if ((res >> 26) == ALC880_FRONT_EVENT)
-		alc883_lenovo_101e_ispeaker_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.line_out_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->detect_line = 1;
+	spec->automute_lines = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -10584,8 +10601,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_lenovo_101e_capture_source,
-		.unsol_event = alc883_lenovo_101e_unsol_event,
-		.init_hook = alc883_lenovo_101e_all_automute,
+		.setup = alc883_lenovo_101e_setup,
+		.unsol_event = alc_sku_unsol_event,
+		.init_hook = alc_inithook,
 	},
 	[ALC883_LENOVO_NB0763] = {
 		.mixers = { alc883_lenovo_nb0763_mixer },
@@ -10610,8 +10628,9 @@ static struct alc_config_preset alc882_presets[] = {
 		.channel_mode = alc883_3ST_6ch_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc883_lenovo_ms7195_unsol_event,
-		.init_hook = alc888_lenovo_ms7195_front_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc888_lenovo_ms7195_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC883_HAIER_W66] = {
 		.mixers = { alc883_targa_2ch_mixer},
@@ -18217,39 +18236,17 @@ static struct snd_kcontrol_new alc272_auto_capture_mixer[] = {
 	{ } /* end */
 };
 
-static void alc662_lenovo_101e_ispeaker_automute(struct hda_codec *codec)
+static void alc662_lenovo_101e_setup(struct hda_codec *codec)
 {
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x14);
-	bits = present ? HDA_AMP_MUTE : 0;
-
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc662_lenovo_101e_all_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
- 	present = snd_hda_jack_detect(codec, 0x1b);
-	bits = present ? HDA_AMP_MUTE : 0;
-
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-}
+	struct alc_spec *spec = codec->spec;
 
-static void alc662_lenovo_101e_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc662_lenovo_101e_all_automute(codec);
-	if ((res >> 26) == ALC880_FRONT_EVENT)
-		alc662_lenovo_101e_ispeaker_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.line_out_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->detect_line = 1;
+	spec->automute_lines = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /* unsolicited event for HP jack sensing */
@@ -18439,53 +18436,21 @@ static void alc663_mode8_setup(struct hda_codec *codec)
 	spec->auto_mic = 1;
 }
 
-static void alc663_g71v_hp_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x21);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc663_g71v_front_automute(struct hda_codec *codec)
+static void alc663_g71v_setup(struct hda_codec *codec)
 {
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x15);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc663_g71v_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_g71v_hp_automute(codec);
-		break;
-	case ALC880_FRONT_EVENT:
-		alc663_g71v_front_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
-#define alc663_g71v_setup	alc663_m51va_setup
-
-static void alc663_g71v_inithook(struct hda_codec *codec)
-{
-	alc663_g71v_front_automute(codec);
-	alc663_g71v_hp_automute(codec);
-	alc_mic_automute(codec);
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.line_out_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	spec->detect_line = 1;
+	spec->automute_lines = 1;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x12;
+	spec->int_mic.mux_idx = 9;
+	spec->auto_mic = 1;
 }
 
 #define alc663_g50v_setup	alc663_m51va_setup
@@ -18697,8 +18662,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
 		.input_mux = &alc662_lenovo_101e_capture_source,
-		.unsol_event = alc662_lenovo_101e_unsol_event,
-		.init_hook = alc662_lenovo_101e_all_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc662_lenovo_101e_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC662_ASUS_EEEPC_P701] = {
 		.mixers = { alc662_eeepc_p701_mixer },
@@ -18765,9 +18731,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_g71v_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_g71v_setup,
-		.init_hook = alc663_g71v_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_H13] = {
 		.mixers = { alc663_m51va_mixer },
-- 
1.7.4.2
