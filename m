From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/10] ALSA: hda - Add common automute support
	for mxier-amp on/off for Reatek
Date: Fri, 29 Apr 2011 19:18:30 +0200
Message-ID: <1304097516-7258-5-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B95E103A37
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id DC39986EE4
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

Some models do mute on/off the connected mixer widget for the automatic
muting, instead of controlling the pin widget itself.  This patch adds
the implementation of such type of auto-mute in the common helper
function, and reduces the redundant codes for each model preset.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  651 ++++++++++++-----------------------------
 1 files changed, 194 insertions(+), 457 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5715b6f..af9bb96 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -306,8 +306,9 @@ struct alc_multi_io {
 };
 
 enum {
-	ALC_AUTOMUTE_PIN,
-	ALC_AUTOMUTE_AMP,
+	ALC_AUTOMUTE_PIN,	/* change the pin control */
+	ALC_AUTOMUTE_AMP,	/* mute/unmute the pin AMP */
+	ALC_AUTOMUTE_MIXER,	/* mute/unmute mixer widget AMP */
 };
 
 struct alc_spec {
@@ -402,6 +403,7 @@ struct alc_spec {
 
 	/* auto-mute control */
 	int automute_mode;
+	hda_nid_t automute_mixer_nid[AUTO_CFG_MAX_OUTS];
 
 	int init_amp;
 	int codec_variant;	/* flag for other variants */
@@ -1097,13 +1099,25 @@ static void alc_hp_automute(struct hda_codec *codec)
 		nid = spec->autocfg.speaker_pins[i];
 		if (!nid)
 			break;
-		if (spec->automute_mode == ALC_AUTOMUTE_PIN) {
+		switch (spec->automute_mode) {
+		case ALC_AUTOMUTE_PIN:
 			snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
 				    spec->jack_present ? 0 : PIN_OUT);
-		} else {
+			break;
+		case ALC_AUTOMUTE_AMP:
 			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
 					 HDA_AMP_MUTE, mute);
+			break;
+		case ALC_AUTOMUTE_MIXER:
+			nid = spec->automute_mixer_nid[i];
+			if (!nid)
+				break;
+			snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT, 0,
+						 HDA_AMP_MUTE, mute);
+			snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT, 1,
+						 HDA_AMP_MUTE, mute);
+			break;
 		}
 	}
 }
@@ -13331,36 +13345,14 @@ static void alc268_acer_init_hook(struct hda_codec *codec)
 	alc268_acer_automute(codec, 1);
 }
 
-/* toggle speaker-output according to the hp-jack state */
-static void alc268_aspire_one_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x15);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0f, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0f, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc268_acer_lc_unsol_event(struct hda_codec *codec,
-				    unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc268_aspire_one_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
 static void alc268_acer_lc_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0f;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x12;
@@ -13368,12 +13360,6 @@ static void alc268_acer_lc_setup(struct hda_codec *codec)
 	spec->auto_mic = 1;
 }
 
-static void alc268_acer_lc_init_hook(struct hda_codec *codec)
-{
-	alc268_aspire_one_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
-
 static struct snd_kcontrol_new alc268_dell_mixer[] = {
 	/* output mixer control */
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x02, 0x0, HDA_OUTPUT),
@@ -14032,9 +14018,9 @@ static struct alc_config_preset alc268_presets[] = {
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc268_modes),
 		.channel_mode = alc268_modes,
-		.unsol_event = alc268_acer_lc_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc268_acer_lc_setup,
-		.init_hook = alc268_acer_lc_init_hook,
+		.init_hook = alc_inithook,
 	},
 	[ALC268_DELL] = {
 		.mixers = { alc268_dell_mixer, alc268_beep_mixer,
@@ -14374,15 +14360,7 @@ static struct hda_verb alc269_lifebook_verbs[] = {
 /* toggle speaker-output according to the hp-jack state */
 static void alc269_quanta_fl1_speaker_automute(struct hda_codec *codec)
 {
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x15);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
+	alc_hp_automute(codec);
 
 	snd_hda_codec_write(codec, 0x20, 0,
 			AC_VERB_SET_COEF_INDEX, 0x0c);
@@ -14395,34 +14373,8 @@ static void alc269_quanta_fl1_speaker_automute(struct hda_codec *codec)
 			AC_VERB_SET_PROC_COEF, 0x480);
 }
 
-/* toggle speaker-output according to the hp-jacks state */
-static void alc269_lifebook_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	/* Check laptop headphone socket */
-	present = snd_hda_jack_detect(codec, 0x15);
-
-	/* Check port replicator headphone socket */
-	present |= snd_hda_jack_detect(codec, 0x1a);
-
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_COEF_INDEX, 0x0c);
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_PROC_COEF, 0x680);
-
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_COEF_INDEX, 0x0c);
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_PROC_COEF, 0x480);
-}
+#define alc269_lifebook_speaker_automute \
+	alc269_quanta_fl1_speaker_automute
 
 static void alc269_lifebook_mic_autoswitch(struct hda_codec *codec)
 {
@@ -14471,6 +14423,9 @@ static void alc269_quanta_fl1_setup(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x19;
@@ -14484,6 +14439,17 @@ static void alc269_quanta_fl1_init_hook(struct hda_codec *codec)
 	alc_mic_automute(codec);
 }
 
+static void alc269_lifebook_setup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.hp_pins[1] = 0x1a;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
+}
+
 static void alc269_lifebook_init_hook(struct hda_codec *codec)
 {
 	alc269_lifebook_speaker_automute(codec);
@@ -14547,42 +14513,14 @@ static struct hda_verb alc271_acer_dmic_verbs[] = {
 	{ }
 };
 
-/* toggle speaker-output according to the hp-jack state */
-static void alc269_speaker_automute(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	unsigned int nid = spec->autocfg.hp_pins[0];
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, nid);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_input_jack_report(codec, nid);
-}
-
-/* unsolicited event for HP jack sensing */
-static void alc269_laptop_unsol_event(struct hda_codec *codec,
-				     unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc269_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
 static void alc269_laptop_amic_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x19;
@@ -14595,6 +14533,9 @@ static void alc269_laptop_dmic_setup(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x12;
@@ -14607,6 +14548,9 @@ static void alc269vb_laptop_amic_setup(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	spec->autocfg.hp_pins[0] = 0x21;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x19;
@@ -14619,6 +14563,9 @@ static void alc269vb_laptop_dmic_setup(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	spec->autocfg.hp_pins[0] = 0x21;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x12;
@@ -14626,12 +14573,6 @@ static void alc269vb_laptop_dmic_setup(struct hda_codec *codec)
 	spec->auto_mic = 1;
 }
 
-static void alc269_laptop_inithook(struct hda_codec *codec)
-{
-	alc269_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
-
 /*
  * generic initialization of ADC, input mixers and output mixers
  */
@@ -15168,9 +15109,9 @@ static struct alc_config_preset alc269_presets[] = {
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc269_modes),
 		.channel_mode = alc269_modes,
-		.unsol_event = alc269_laptop_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc269_laptop_amic_setup,
-		.init_hook = alc269_laptop_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC269_DMIC] = {
 		.mixers = { alc269_laptop_mixer },
@@ -15182,9 +15123,9 @@ static struct alc_config_preset alc269_presets[] = {
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc269_modes),
 		.channel_mode = alc269_modes,
-		.unsol_event = alc269_laptop_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc269_laptop_dmic_setup,
-		.init_hook = alc269_laptop_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC269VB_AMIC] = {
 		.mixers = { alc269vb_laptop_mixer },
@@ -15196,9 +15137,9 @@ static struct alc_config_preset alc269_presets[] = {
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc269_modes),
 		.channel_mode = alc269_modes,
-		.unsol_event = alc269_laptop_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc269vb_laptop_amic_setup,
-		.init_hook = alc269_laptop_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC269VB_DMIC] = {
 		.mixers = { alc269vb_laptop_mixer },
@@ -15210,9 +15151,9 @@ static struct alc_config_preset alc269_presets[] = {
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc269_modes),
 		.channel_mode = alc269_modes,
-		.unsol_event = alc269_laptop_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc269vb_laptop_dmic_setup,
-		.init_hook = alc269_laptop_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC269_FUJITSU] = {
 		.mixers = { alc269_fujitsu_mixer },
@@ -15224,9 +15165,9 @@ static struct alc_config_preset alc269_presets[] = {
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc269_modes),
 		.channel_mode = alc269_modes,
-		.unsol_event = alc269_laptop_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc269_laptop_dmic_setup,
-		.init_hook = alc269_laptop_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC269_LIFEBOOK] = {
 		.mixers = { alc269_lifebook_mixer },
@@ -15238,6 +15179,7 @@ static struct alc_config_preset alc269_presets[] = {
 		.channel_mode = alc269_modes,
 		.input_mux = &alc269_capture_source,
 		.unsol_event = alc269_lifebook_unsol_event,
+		.setup = alc269_lifebook_setup,
 		.init_hook = alc269_lifebook_init_hook,
 	},
 	[ALC271_ACER] = {
@@ -18348,164 +18290,14 @@ static void alc662_eeepc_ep20_setup(struct hda_codec *codec)
 
 #define alc662_eeepc_ep20_inithook	alc262_hippo_master_update
 
-static void alc663_m51va_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x21);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc663_21jd_two_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x21);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0e, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0e, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc663_15jd_two_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x15);
-	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0e, HDA_INPUT, 0,
-				 HDA_AMP_MUTE, bits);
-	snd_hda_codec_amp_stereo(codec, 0x0e, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-}
-
-static void alc662_f5z_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x1b);
-	bits = present ? 0 : PIN_OUT;
-	snd_hda_codec_write(codec, 0x14, 0,
-			 AC_VERB_SET_PIN_WIDGET_CONTROL, bits);
-}
-
-static void alc663_two_hp_m1_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present1, present2;
-
-	present1 = snd_hda_jack_detect(codec, 0x21);
-	present2 = snd_hda_jack_detect(codec, 0x15);
-
-	if (present1 || present2) {
-		snd_hda_codec_write_cache(codec, 0x14, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
-	} else {
-		snd_hda_codec_write_cache(codec, 0x14, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-	}
-}
-
-static void alc663_two_hp_m2_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present1, present2;
-
-	present1 = snd_hda_jack_detect(codec, 0x1b);
-	present2 = snd_hda_jack_detect(codec, 0x15);
-
-	if (present1 || present2) {
-		snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-					 HDA_AMP_MUTE, HDA_AMP_MUTE);
-		snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-					 HDA_AMP_MUTE, HDA_AMP_MUTE);
-	} else {
-		snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
-					 HDA_AMP_MUTE, 0);
-		snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
-					 HDA_AMP_MUTE, 0);
-	}
-}
-
-static void alc663_two_hp_m7_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present1, present2;
-
-	present1 = snd_hda_codec_read(codec, 0x1b, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
-	present2 = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
-
-	if (present1 || present2) {
-		snd_hda_codec_write_cache(codec, 0x14, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_codec_write_cache(codec, 0x17, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
-	} else {
-		snd_hda_codec_write_cache(codec, 0x14, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		snd_hda_codec_write_cache(codec, 0x17, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-	}
-}
-
-static void alc663_two_hp_m8_speaker_automute(struct hda_codec *codec)
-{
-	unsigned int present1, present2;
-
-	present1 = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
-	present2 = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
-
-	if (present1 || present2) {
-		snd_hda_codec_write_cache(codec, 0x14, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_codec_write_cache(codec, 0x17, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
-	} else {
-		snd_hda_codec_write_cache(codec, 0x14, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		snd_hda_codec_write_cache(codec, 0x17, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-	}
-}
-
-static void alc663_m51va_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_m51va_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
 static void alc663_m51va_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x12;
@@ -18513,18 +18305,15 @@ static void alc663_m51va_setup(struct hda_codec *codec)
 	spec->auto_mic = 1;
 }
 
-static void alc663_m51va_inithook(struct hda_codec *codec)
-{
-	alc663_m51va_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
-
 /* ***************** Mode1 ******************************/
-#define alc663_mode1_unsol_event	alc663_m51va_unsol_event
-
 static void alc663_mode1_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin = 0x18;
 	spec->ext_mic.mux_idx = 0;
 	spec->int_mic.pin = 0x19;
@@ -18532,156 +18321,122 @@ static void alc663_mode1_setup(struct hda_codec *codec)
 	spec->auto_mic = 1;
 }
 
-#define alc663_mode1_inithook		alc663_m51va_inithook
-
 /* ***************** Mode2 ******************************/
-static void alc662_mode2_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
+static void alc662_mode2_setup(struct hda_codec *codec)
 {
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc662_f5z_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x19;
+	spec->int_mic.mux_idx = 1;
+	spec->auto_mic = 1;
 }
 
-#define alc662_mode2_setup	alc663_mode1_setup
-
-static void alc662_mode2_inithook(struct hda_codec *codec)
-{
-	alc662_f5z_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
 /* ***************** Mode3 ******************************/
-static void alc663_mode3_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
+static void alc663_mode3_setup(struct hda_codec *codec)
 {
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_two_hp_m1_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x19;
+	spec->int_mic.mux_idx = 1;
+	spec->auto_mic = 1;
 }
 
-#define alc663_mode3_setup	alc663_mode1_setup
-
-static void alc663_mode3_inithook(struct hda_codec *codec)
-{
-	alc663_two_hp_m1_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
 /* ***************** Mode4 ******************************/
-static void alc663_mode4_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
+static void alc663_mode4_setup(struct hda_codec *codec)
 {
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_21jd_two_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute_mixer_nid[1] = 0x0e;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x19;
+	spec->int_mic.mux_idx = 1;
+	spec->auto_mic = 1;
 }
 
-#define alc663_mode4_setup	alc663_mode1_setup
-
-static void alc663_mode4_inithook(struct hda_codec *codec)
-{
-	alc663_21jd_two_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
 /* ***************** Mode5 ******************************/
-static void alc663_mode5_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
+static void alc663_mode5_setup(struct hda_codec *codec)
 {
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_15jd_two_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute_mixer_nid[1] = 0x0e;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x19;
+	spec->int_mic.mux_idx = 1;
+	spec->auto_mic = 1;
 }
 
-#define alc663_mode5_setup	alc663_mode1_setup
-
-static void alc663_mode5_inithook(struct hda_codec *codec)
-{
-	alc663_15jd_two_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
 /* ***************** Mode6 ******************************/
-static void alc663_mode6_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
+static void alc663_mode6_setup(struct hda_codec *codec)
 {
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_two_hp_m2_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
-#define alc663_mode6_setup	alc663_mode1_setup
-
-static void alc663_mode6_inithook(struct hda_codec *codec)
-{
-	alc663_two_hp_m2_speaker_automute(codec);
-	alc_mic_automute(codec);
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute_mixer_nid[0] = 0x0c;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_MIXER;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x19;
+	spec->int_mic.mux_idx = 1;
+	spec->auto_mic = 1;
 }
 
 /* ***************** Mode7 ******************************/
-static void alc663_mode7_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_two_hp_m7_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
-#define alc663_mode7_setup	alc663_mode1_setup
-
-static void alc663_mode7_inithook(struct hda_codec *codec)
+static void alc663_mode7_setup(struct hda_codec *codec)
 {
-	alc663_two_hp_m7_speaker_automute(codec);
-	alc_mic_automute(codec);
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x19;
+	spec->int_mic.mux_idx = 1;
+	spec->auto_mic = 1;
 }
 
 /* ***************** Mode8 ******************************/
-static void alc663_mode8_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_two_hp_m8_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
-#define alc663_mode8_setup	alc663_m51va_setup
-
-static void alc663_mode8_inithook(struct hda_codec *codec)
+static void alc663_mode8_setup(struct hda_codec *codec)
 {
-	alc663_two_hp_m8_speaker_automute(codec);
-	alc_mic_automute(codec);
+	struct alc_spec *spec = codec->spec;
+	spec->autocfg.hp_pins[0] = 0x21;
+	spec->autocfg.hp_pins[1] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x17;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+	spec->ext_mic.pin = 0x18;
+	spec->ext_mic.mux_idx = 0;
+	spec->int_mic.pin = 0x12;
+	spec->int_mic.mux_idx = 9;
+	spec->auto_mic = 1;
 }
 
 static void alc663_g71v_hp_automute(struct hda_codec *codec)
@@ -18733,27 +18488,8 @@ static void alc663_g71v_inithook(struct hda_codec *codec)
 	alc_mic_automute(codec);
 }
 
-static void alc663_g50v_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	switch (res >> 26) {
-	case ALC880_HP_EVENT:
-		alc663_m51va_speaker_automute(codec);
-		break;
-	case ALC880_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-}
-
 #define alc663_g50v_setup	alc663_m51va_setup
 
-static void alc663_g50v_inithook(struct hda_codec *codec)
-{
-	alc663_m51va_speaker_automute(codec);
-	alc_mic_automute(codec);
-}
-
 static struct snd_kcontrol_new alc662_ecs_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
@@ -19015,9 +18751,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_m51va_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_m51va_setup,
-		.init_hook = alc663_m51va_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_G71V] = {
 		.mixers = { alc663_g71v_mixer },
@@ -19042,8 +18778,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dac_nids = alc662_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_m51va_unsol_event,
-		.init_hook = alc663_m51va_inithook,
+		.setup = alc663_m51va_setup,
+		.unsol_event = alc_sku_unsol_event,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_G50V] = {
 		.mixers = { alc663_g50v_mixer },
@@ -19056,9 +18793,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_6ch_modes),
 		.channel_mode = alc662_3ST_6ch_modes,
 		.input_mux = &alc663_capture_source,
-		.unsol_event = alc663_g50v_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_g50v_setup,
-		.init_hook = alc663_g50v_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE1] = {
 		.mixers = { alc663_m51va_mixer },
@@ -19072,9 +18809,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode1_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode1_setup,
-		.init_hook = alc663_mode1_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC662_ASUS_MODE2] = {
 		.mixers = { alc662_1bjd_mixer },
@@ -19087,9 +18824,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc662_mode2_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc662_mode2_setup,
-		.init_hook = alc662_mode2_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE3] = {
 		.mixers = { alc663_two_hp_m1_mixer },
@@ -19103,9 +18840,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode3_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode3_setup,
-		.init_hook = alc663_mode3_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE4] = {
 		.mixers = { alc663_asus_21jd_clfe_mixer },
@@ -19119,9 +18856,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode4_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode4_setup,
-		.init_hook = alc663_mode4_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE5] = {
 		.mixers = { alc663_asus_15jd_clfe_mixer },
@@ -19135,9 +18872,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode5_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode5_setup,
-		.init_hook = alc663_mode5_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE6] = {
 		.mixers = { alc663_two_hp_m2_mixer },
@@ -19151,9 +18888,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode6_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode6_setup,
-		.init_hook = alc663_mode6_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE7] = {
 		.mixers = { alc663_mode7_mixer },
@@ -19167,9 +18904,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode7_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode7_setup,
-		.init_hook = alc663_mode7_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_MODE8] = {
 		.mixers = { alc663_mode8_mixer },
@@ -19183,9 +18920,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dig_out_nid = ALC662_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_mode8_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode8_setup,
-		.init_hook = alc663_mode8_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC272_DELL] = {
 		.mixers = { alc663_m51va_mixer },
@@ -19200,9 +18937,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.num_adc_nids = ARRAY_SIZE(alc272_adc_nids),
 		.capsrc_nids = alc272_capsrc_nids,
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_m51va_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_m51va_setup,
-		.init_hook = alc663_m51va_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC272_DELL_ZM1] = {
 		.mixers = { alc663_m51va_mixer },
@@ -19217,9 +18954,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.num_adc_nids = 1,
 		.capsrc_nids = alc662_capsrc_nids,
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc663_m51va_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_m51va_setup,
-		.init_hook = alc663_m51va_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC272_SAMSUNG_NC10] = {
 		.mixers = { alc272_nc10_mixer },
@@ -19231,9 +18968,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
 		/*.input_mux = &alc272_nc10_capture_source,*/
-		.unsol_event = alc663_mode4_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc663_mode4_setup,
-		.init_hook = alc663_mode4_inithook,
+		.init_hook = alc_inithook,
 	},
 };
 
-- 
1.7.4.2
