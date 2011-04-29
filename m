From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: hda - Consolidate auto-mute with
	master-switch for Realtek
Date: Fri, 29 Apr 2011 19:18:32 +0200
Message-ID: <1304097516-7258-7-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 52690103A31
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id EE89F5362F
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

Yet another consolidation of auto-mute functions for the devices
controlling the output muts together with the master mixer switch,
typically found for ALC262 machines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  323 +++++++++++++----------------------------
 1 files changed, 99 insertions(+), 224 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 222abba..a97e460 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -393,7 +393,7 @@ struct alc_spec {
 	unsigned int sense_updated: 1;
 	unsigned int jack_present: 1;
 	unsigned int line_jack_present:1;
-	unsigned int master_sw: 1;
+	unsigned int master_mute:1;
 	unsigned int auto_mic:1;
 	unsigned int automute:1;	/* HP automute enabled */
 	unsigned int detect_line:1;	/* Line-out detection enabled */
@@ -1092,11 +1092,11 @@ static int detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 }
 
 static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
-			bool mute)
+			bool mute, bool hp_out)
 {
 	struct alc_spec *spec = codec->spec;
 	unsigned int mute_bits = mute ? HDA_AMP_MUTE : 0;
-	unsigned int pin_bits = mute ? 0 : PIN_OUT;
+	unsigned int pin_bits = mute ? 0 : (hp_out ? PIN_HP : PIN_OUT);
 	int i;
 
 	for (i = 0; i < num_pins; i++) {
@@ -1133,14 +1133,15 @@ static void update_speakers(struct hda_codec *codec)
 
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
 		    spec->autocfg.speaker_pins,
-		    spec->jack_present | spec->line_jack_present);
+		    spec->jack_present | spec->line_jack_present |
+		    spec->master_mute, false);
 
 	/* toggle line-out mutes if needed, too */
 	if (!spec->automute_lines)
 		return;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 		    spec->autocfg.line_out_pins,
-		    spec->jack_present);
+		    spec->jack_present | spec->master_mute, false);
 }
 
 static void alc_hp_automute(struct hda_codec *codec)
@@ -6010,21 +6011,14 @@ static struct snd_kcontrol_new alc260_input_mixer[] = {
 };
 
 /* update HP, line and mono out pins according to the master switch */
-static void alc260_hp_master_update(struct hda_codec *codec,
-				    hda_nid_t hp, hda_nid_t line,
-				    hda_nid_t mono)
+static void alc260_hp_master_update(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int val = spec->master_sw ? PIN_HP : 0;
-	/* change HP and line-out pins */
-	snd_hda_codec_write(codec, hp, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    val);
-	snd_hda_codec_write(codec, line, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    val);
-	/* mono (speaker) depending on the HP jack sense */
-	val = (val && !spec->jack_present) ? PIN_OUT : 0;
-	snd_hda_codec_write(codec, mono, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    val);
+
+	/* change HP pins */
+	do_automute(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
+		    spec->autocfg.hp_pins, spec->master_mute, true);
+	update_speakers(codec);
 }
 
 static int alc260_hp_master_sw_get(struct snd_kcontrol *kcontrol,
@@ -6032,7 +6026,7 @@ static int alc260_hp_master_sw_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	*ucontrol->value.integer.value = spec->master_sw;
+	*ucontrol->value.integer.value = !spec->master_mute;
 	return 0;
 }
 
@@ -6041,16 +6035,12 @@ static int alc260_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	int val = !!*ucontrol->value.integer.value;
-	hda_nid_t hp, line, mono;
+	int val = !*ucontrol->value.integer.value;
 
-	if (val == spec->master_sw)
+	if (val == spec->master_mute)
 		return 0;
-	spec->master_sw = val;
-	hp = (kcontrol->private_value >> 16) & 0xff;
-	line = (kcontrol->private_value >> 8) & 0xff;
-	mono = kcontrol->private_value & 0xff;
-	alc260_hp_master_update(codec, hp, line, mono);
+	spec->master_mute = val;
+	alc260_hp_master_update(codec);
 	return 1;
 }
 
@@ -6062,7 +6052,6 @@ static struct snd_kcontrol_new alc260_hp_output_mixer[] = {
 		.info = snd_ctl_boolean_mono_info,
 		.get = alc260_hp_master_sw_get,
 		.put = alc260_hp_master_sw_put,
-		.private_value = (0x0f << 16) | (0x10 << 8) | 0x11
 	},
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x08, 2, HDA_INPUT),
@@ -6079,18 +6068,15 @@ static struct hda_verb alc260_hp_unsol_verbs[] = {
 	{},
 };
 
-static void alc260_hp_automute(struct hda_codec *codec)
+static void alc260_hp_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	spec->jack_present = snd_hda_jack_detect(codec, 0x10);
-	alc260_hp_master_update(codec, 0x0f, 0x10, 0x11);
-}
-
-static void alc260_hp_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc260_hp_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x0f;
+	spec->autocfg.speaker_pins[0] = 0x10;
+	spec->autocfg.speaker_pins[1] = 0x11;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 static struct snd_kcontrol_new alc260_hp_3013_mixer[] = {
@@ -6101,7 +6087,6 @@ static struct snd_kcontrol_new alc260_hp_3013_mixer[] = {
 		.info = snd_ctl_boolean_mono_info,
 		.get = alc260_hp_master_sw_get,
 		.put = alc260_hp_master_sw_put,
-		.private_value = (0x15 << 16) | (0x10 << 8) | 0x11
 	},
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x09, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Front Playback Switch", 0x10, 0x0, HDA_OUTPUT),
@@ -6114,6 +6099,17 @@ static struct snd_kcontrol_new alc260_hp_3013_mixer[] = {
 	{ } /* end */
 };
 
+static void alc260_hp_3013_setup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x10;
+	spec->autocfg.speaker_pins[1] = 0x11;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+}
+
 static struct hda_bind_ctls alc260_dc7600_bind_master_vol = {
 	.ops = &snd_hda_bind_vol,
 	.values = {
@@ -6146,38 +6142,16 @@ static struct hda_verb alc260_hp_3013_unsol_verbs[] = {
 	{},
 };
 
-static void alc260_hp_3013_automute(struct hda_codec *codec)
+static void alc260_hp_3012_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	spec->jack_present = snd_hda_jack_detect(codec, 0x15);
-	alc260_hp_master_update(codec, 0x15, 0x10, 0x11);
-}
-
-static void alc260_hp_3013_unsol_event(struct hda_codec *codec,
-				       unsigned int res)
-{
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc260_hp_3013_automute(codec);
-}
-
-static void alc260_hp_3012_automute(struct hda_codec *codec)
-{
-	unsigned int bits = snd_hda_jack_detect(codec, 0x10) ? 0 : PIN_OUT;
-
-	snd_hda_codec_write(codec, 0x0f, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    bits);
-	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    bits);
-	snd_hda_codec_write(codec, 0x15, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    bits);
-}
-
-static void alc260_hp_3012_unsol_event(struct hda_codec *codec,
-				       unsigned int res)
-{
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc260_hp_3012_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x10;
+	spec->autocfg.speaker_pins[0] = 0x0f;
+	spec->autocfg.speaker_pins[1] = 0x11;
+	spec->autocfg.speaker_pins[2] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 /* Fujitsu S702x series laptops.  ALC260 pin usage: Mic/Line jack = 0x12,
@@ -7302,8 +7276,9 @@ static struct alc_config_preset alc260_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_capture_source,
-		.unsol_event = alc260_hp_unsol_event,
-		.init_hook = alc260_hp_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc260_hp_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC260_HP_DC7600] = {
 		.mixers = { alc260_hp_dc7600_mixer,
@@ -7317,8 +7292,9 @@ static struct alc_config_preset alc260_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_capture_source,
-		.unsol_event = alc260_hp_3012_unsol_event,
-		.init_hook = alc260_hp_3012_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc260_hp_3012_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC260_HP_3013] = {
 		.mixers = { alc260_hp_3013_mixer,
@@ -7332,8 +7308,9 @@ static struct alc_config_preset alc260_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_capture_source,
-		.unsol_event = alc260_hp_3013_unsol_event,
-		.init_hook = alc260_hp_3013_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc260_hp_3013_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC260_FUJITSU_S702X] = {
 		.mixers = { alc260_fujitsu_mixer },
@@ -11291,71 +11268,30 @@ static struct snd_kcontrol_new alc262_base_mixer[] = {
 };
 
 /* update HP, line and mono-out pins according to the master switch */
-static void alc262_hp_master_update(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	int val = spec->master_sw;
-
-	/* HP & line-out */
-	snd_hda_codec_write_cache(codec, 0x1b, 0,
-				  AC_VERB_SET_PIN_WIDGET_CONTROL,
-				  val ? PIN_HP : 0);
-	snd_hda_codec_write_cache(codec, 0x15, 0,
-				  AC_VERB_SET_PIN_WIDGET_CONTROL,
-				  val ? PIN_HP : 0);
-	/* mono (speaker) depending on the HP jack sense */
-	val = val && !spec->jack_present;
-	snd_hda_codec_write_cache(codec, 0x16, 0,
-				  AC_VERB_SET_PIN_WIDGET_CONTROL,
-				  val ? PIN_OUT : 0);
-}
+#define alc262_hp_master_update		alc260_hp_master_update
 
-static void alc262_hp_bpc_automute(struct hda_codec *codec)
+static void alc262_hp_bpc_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	spec->jack_present = snd_hda_jack_detect(codec, 0x1b);
-	alc262_hp_master_update(codec);
-}
-
-static void alc262_hp_bpc_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	if ((res >> 26) != ALC880_HP_EVENT)
-		return;
-	alc262_hp_bpc_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.speaker_pins[0] = 0x16;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
-static void alc262_hp_wildwest_automute(struct hda_codec *codec)
+static void alc262_hp_wildwest_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	spec->jack_present = snd_hda_jack_detect(codec, 0x15);
-	alc262_hp_master_update(codec);
-}
-
-static void alc262_hp_wildwest_unsol_event(struct hda_codec *codec,
-					   unsigned int res)
-{
-	if ((res >> 26) != ALC880_HP_EVENT)
-		return;
-	alc262_hp_wildwest_automute(codec);
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x16;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
 }
 
 #define alc262_hp_master_sw_get		alc260_hp_master_sw_get
-
-static int alc262_hp_master_sw_put(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct alc_spec *spec = codec->spec;
-	int val = !!*ucontrol->value.integer.value;
-
-	if (val == spec->master_sw)
-		return 0;
-	spec->master_sw = val;
-	alc262_hp_master_update(codec);
-	return 1;
-}
+#define alc262_hp_master_sw_put		alc260_hp_master_sw_put
 
 #define ALC262_HP_MASTER_SWITCH					\
 	{							\
@@ -11485,44 +11421,9 @@ static struct hda_input_mux alc262_hp_rp5700_capture_source = {
 };
 
 /* bind hp and internal speaker mute (with plug check) as master switch */
-static void alc262_hippo_master_update(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_nid = spec->autocfg.hp_pins[0];
-	hda_nid_t line_nid = spec->autocfg.line_out_pins[0];
-	hda_nid_t speaker_nid = spec->autocfg.speaker_pins[0];
-	unsigned int mute;
-
-	/* HP */
-	mute = spec->master_sw ? 0 : HDA_AMP_MUTE;
-	snd_hda_codec_amp_stereo(codec, hp_nid, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, mute);
-	/* mute internal speaker per jack sense */
-	if (spec->jack_present)
-		mute = HDA_AMP_MUTE;
-	if (line_nid)
-		snd_hda_codec_amp_stereo(codec, line_nid, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, mute);
-	if (speaker_nid && speaker_nid != line_nid)
-		snd_hda_codec_amp_stereo(codec, speaker_nid, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, mute);
-}
-
+#define alc262_hippo_master_update	alc262_hp_master_update
 #define alc262_hippo_master_sw_get	alc262_hp_master_sw_get
-
-static int alc262_hippo_master_sw_put(struct snd_kcontrol *kcontrol,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct alc_spec *spec = codec->spec;
-	int val = !!*ucontrol->value.integer.value;
-
-	if (val == spec->master_sw)
-		return 0;
-	spec->master_sw = val;
-	alc262_hippo_master_update(codec);
-	return 1;
-}
+#define alc262_hippo_master_sw_put	alc262_hp_master_sw_put
 
 #define ALC262_HIPPO_MASTER_SWITCH				\
 	{							\
@@ -11573,28 +11474,14 @@ static struct snd_kcontrol_new alc262_hippo1_mixer[] = {
 };
 
 /* mute/unmute internal speaker according to the hp jack and mute state */
-static void alc262_hippo_automute(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	hda_nid_t hp_nid = spec->autocfg.hp_pins[0];
-
-	spec->jack_present = snd_hda_jack_detect(codec, hp_nid);
-	alc262_hippo_master_update(codec);
-}
-
-static void alc262_hippo_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	if ((res >> 26) != ALC880_HP_EVENT)
-		return;
-	alc262_hippo_automute(codec);
-}
-
 static void alc262_hippo_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static void alc262_hippo1_setup(struct hda_codec *codec)
@@ -11603,6 +11490,8 @@ static void alc262_hippo1_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 
@@ -12816,9 +12705,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_capture_source,
-		.unsol_event = alc262_hippo_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc262_hippo_setup,
-		.init_hook = alc262_hippo_automute,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_HIPPO_1] = {
 		.mixers = { alc262_hippo1_mixer },
@@ -12830,9 +12719,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_capture_source,
-		.unsol_event = alc262_hippo_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc262_hippo1_setup,
-		.init_hook = alc262_hippo_automute,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_FUJITSU] = {
 		.mixers = { alc262_fujitsu_mixer },
@@ -12857,8 +12746,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_HP_capture_source,
-		.unsol_event = alc262_hp_bpc_unsol_event,
-		.init_hook = alc262_hp_bpc_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc262_hp_bpc_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_HP_BPC_D7000_WF] = {
 		.mixers = { alc262_HP_BPC_WildWest_mixer },
@@ -12869,8 +12759,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_HP_D7000_capture_source,
-		.unsol_event = alc262_hp_wildwest_unsol_event,
-		.init_hook = alc262_hp_wildwest_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc262_hp_wildwest_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_HP_BPC_D7000_WL] = {
 		.mixers = { alc262_HP_BPC_WildWest_mixer,
@@ -12882,8 +12773,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_HP_D7000_capture_source,
-		.unsol_event = alc262_hp_wildwest_unsol_event,
-		.init_hook = alc262_hp_wildwest_automute,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc262_hp_wildwest_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_HP_TC_T5735] = {
 		.mixers = { alc262_hp_t5735_mixer },
@@ -12926,9 +12818,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_capture_source,
-		.unsol_event = alc262_hippo_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc262_hippo_setup,
-		.init_hook = alc262_hippo_automute,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_BENQ_T31] = {
 		.mixers = { alc262_benq_t31_mixer },
@@ -12940,9 +12832,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_capture_source,
-		.unsol_event = alc262_hippo_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc262_hippo_setup,
-		.init_hook = alc262_hippo_automute,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_ULTRA] = {
 		.mixers = { alc262_ultra_mixer },
@@ -13008,9 +12900,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_capture_source,
-		.unsol_event = alc262_hippo_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc262_hippo_setup,
-		.init_hook = alc262_hippo_automute,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_TYAN] = {
 		.mixers = { alc262_tyan_mixer },
@@ -13347,9 +13239,7 @@ static struct hda_verb alc268_acer_verbs[] = {
 };
 
 /* unsolicited event for HP jack sensing */
-#define alc268_toshiba_unsol_event	alc262_hippo_unsol_event
 #define alc268_toshiba_setup		alc262_hippo_setup
-#define alc268_toshiba_automute		alc262_hippo_automute
 
 static void alc268_acer_unsol_event(struct hda_codec *codec,
 				       unsigned int res)
@@ -13985,9 +13875,9 @@ static struct alc_config_preset alc268_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc268_modes),
 		.channel_mode = alc268_modes,
 		.input_mux = &alc268_capture_source,
-		.unsol_event = alc268_toshiba_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc268_toshiba_setup,
-		.init_hook = alc268_toshiba_automute,
+		.init_hook = alc_inithook,
 	},
 	[ALC268_ACER] = {
 		.mixers = { alc268_acer_mixer, alc268_capture_alt_mixer,
@@ -14073,8 +13963,9 @@ static struct alc_config_preset alc268_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc268_modes),
 		.channel_mode = alc268_modes,
 		.input_mux = &alc268_capture_source,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc268_toshiba_setup,
-		.init_hook = alc268_toshiba_automute,
+		.init_hook = alc_inithook,
 	},
 #ifdef CONFIG_SND_DEBUG
 	[ALC268_TEST] = {
@@ -18249,16 +18140,6 @@ static void alc662_lenovo_101e_setup(struct hda_codec *codec)
 	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
-/* unsolicited event for HP jack sensing */
-static void alc662_eeepc_unsol_event(struct hda_codec *codec,
-				     unsigned int res)
-{
-	if ((res >> 26) == ALC880_MIC_EVENT)
-		alc_mic_automute(codec);
-	else
-		alc262_hippo_unsol_event(codec, res);
-}
-
 static void alc662_eeepc_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -18271,22 +18152,16 @@ static void alc662_eeepc_setup(struct hda_codec *codec)
 	spec->auto_mic = 1;
 }
 
-static void alc662_eeepc_inithook(struct hda_codec *codec)
-{
-	alc262_hippo_automute(codec);
-	alc_mic_automute(codec);
-}
-
 static void alc662_eeepc_ep20_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x1b;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
-#define alc662_eeepc_ep20_inithook	alc262_hippo_master_update
-
 static void alc663_m51va_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -18675,9 +18550,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dac_nids = alc662_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc662_eeepc_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc662_eeepc_setup,
-		.init_hook = alc662_eeepc_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC662_ASUS_EEEPC_EP20] = {
 		.mixers = { alc662_eeepc_ep20_mixer,
@@ -18690,9 +18565,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_6ch_modes),
 		.channel_mode = alc662_3ST_6ch_modes,
 		.input_mux = &alc662_lenovo_101e_capture_source,
-		.unsol_event = alc662_eeepc_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc662_eeepc_ep20_setup,
-		.init_hook = alc662_eeepc_ep20_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC662_ECS] = {
 		.mixers = { alc662_ecs_mixer },
@@ -18703,9 +18578,9 @@ static struct alc_config_preset alc662_presets[] = {
 		.dac_nids = alc662_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,
-		.unsol_event = alc662_eeepc_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
 		.setup = alc662_eeepc_setup,
-		.init_hook = alc662_eeepc_inithook,
+		.init_hook = alc_inithook,
 	},
 	[ALC663_ASUS_M51VA] = {
 		.mixers = { alc663_m51va_mixer },
-- 
1.7.4.2
