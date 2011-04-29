From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ALSA: hda - More reduction of redundant
	automute codes in Realtek parser
Date: Fri, 29 Apr 2011 19:18:33 +0200
Message-ID: <1304097516-7258-8-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 589B8103A36
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0E56774609
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
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

Removed the redundant codes by replacing with the common helper
functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  222 +++++++++--------------------------------
 1 files changed, 49 insertions(+), 173 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a97e460..b76d3b3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -390,7 +390,6 @@ struct alc_spec {
 	void (*shutup)(struct hda_codec *codec);
 
 	/* for pin sensing */
-	unsigned int sense_updated: 1;
 	unsigned int jack_present: 1;
 	unsigned int line_jack_present:1;
 	unsigned int master_mute:1;
@@ -11797,40 +11796,15 @@ static struct hda_input_mux alc262_HP_D7000_capture_source = {
 	},
 };
 
-/* mute/unmute internal speaker according to the hp jacks and mute state */
-static void alc262_fujitsu_automute(struct hda_codec *codec, int force)
+static void alc262_fujitsu_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int mute;
-
-	if (force || !spec->sense_updated) {
-		spec->jack_present = snd_hda_jack_detect(codec, 0x14) ||
-				     snd_hda_jack_detect(codec, 0x1b);
-		spec->sense_updated = 1;
-	}
-	/* unmute internal speaker only if both HPs are unplugged and
-	 * master switch is on
-	 */
-	if (spec->jack_present)
-		mute = HDA_AMP_MUTE;
-	else
-		mute = snd_hda_codec_amp_read(codec, 0x14, 0, HDA_OUTPUT, 0);
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, mute);
-}
-
-/* unsolicited event for HP jack sensing */
-static void alc262_fujitsu_unsol_event(struct hda_codec *codec,
-				       unsigned int res)
-{
-	if ((res >> 26) != ALC_HP_EVENT)
-		return;
-	alc262_fujitsu_automute(codec, 1);
-}
 
-static void alc262_fujitsu_init_hook(struct hda_codec *codec)
-{
-	alc262_fujitsu_automute(codec, 1);
+	spec->autocfg.hp_pins[0] = 0x14;
+	spec->autocfg.hp_pins[1] = 0x1b;
+	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 /* bind volumes of both NID 0x0c and 0x0d */
@@ -11843,78 +11817,15 @@ static struct hda_bind_ctls alc262_fujitsu_bind_master_vol = {
 	},
 };
 
-/* mute/unmute internal speaker according to the hp jack and mute state */
-static void alc262_lenovo_3000_automute(struct hda_codec *codec, int force)
-{
-	struct alc_spec *spec = codec->spec;
-	unsigned int mute;
-
-	if (force || !spec->sense_updated) {
-		spec->jack_present = snd_hda_jack_detect(codec, 0x1b);
-		spec->sense_updated = 1;
-	}
-	if (spec->jack_present) {
-		/* mute internal speaker */
-		snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, HDA_AMP_MUTE);
-		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, HDA_AMP_MUTE);
-	} else {
-		/* unmute internal speaker if necessary */
-		mute = snd_hda_codec_amp_read(codec, 0x1b, 0, HDA_OUTPUT, 0);
-		snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, mute);
-		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
-					 HDA_AMP_MUTE, mute);
-	}
-}
-
-/* unsolicited event for HP jack sensing */
-static void alc262_lenovo_3000_unsol_event(struct hda_codec *codec,
-				       unsigned int res)
-{
-	if ((res >> 26) != ALC_HP_EVENT)
-		return;
-	alc262_lenovo_3000_automute(codec, 1);
-}
-
-static int amp_stereo_mute_update(struct hda_codec *codec, hda_nid_t nid,
-				  int dir, int idx, long *valp)
-{
-	int i, change = 0;
-
-	for (i = 0; i < 2; i++, valp++)
-		change |= snd_hda_codec_amp_update(codec, nid, i, dir, idx,
-						   HDA_AMP_MUTE,
-						   *valp ? 0 : HDA_AMP_MUTE);
-	return change;
-}
-
-/* bind hp and internal speaker mute (with plug check) */
-static int alc262_fujitsu_master_sw_put(struct snd_kcontrol *kcontrol,
-					 struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	long *valp = ucontrol->value.integer.value;
-	int change;
-
-	change = amp_stereo_mute_update(codec, 0x14, HDA_OUTPUT, 0, valp);
-	change |= amp_stereo_mute_update(codec, 0x1b, HDA_OUTPUT, 0, valp);
-	if (change)
-		alc262_fujitsu_automute(codec, 0);
-	return change;
-}
-
 static struct snd_kcontrol_new alc262_fujitsu_mixer[] = {
 	HDA_BIND_VOL("Master Playback Volume", &alc262_fujitsu_bind_master_vol),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.subdevice = HDA_SUBDEV_AMP_FLAG,
-		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_amp_switch_get,
-		.put = alc262_fujitsu_master_sw_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
+		.subdevice = HDA_SUBDEV_NID_FLAG | 0x14,
+		.info = snd_ctl_boolean_mono_info,
+		.get = alc262_hp_master_sw_get,
+		.put = alc262_hp_master_sw_put,
 	},
 	{
 		.iface = NID_MAPPING,
@@ -11932,18 +11843,15 @@ static struct snd_kcontrol_new alc262_fujitsu_mixer[] = {
 	{ } /* end */
 };
 
-/* bind hp and internal speaker mute (with plug check) */
-static int alc262_lenovo_3000_master_sw_put(struct snd_kcontrol *kcontrol,
-					 struct snd_ctl_elem_value *ucontrol)
+static void alc262_lenovo_3000_setup(struct hda_codec *codec)
 {
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	long *valp = ucontrol->value.integer.value;
-	int change;
+	struct alc_spec *spec = codec->spec;
 
-	change = amp_stereo_mute_update(codec, 0x1b, HDA_OUTPUT, 0, valp);
-	if (change)
-		alc262_lenovo_3000_automute(codec, 0);
-	return change;
+	spec->autocfg.hp_pins[0] = 0x1b;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
 static struct snd_kcontrol_new alc262_lenovo_3000_mixer[] = {
@@ -11951,11 +11859,10 @@ static struct snd_kcontrol_new alc262_lenovo_3000_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.subdevice = HDA_SUBDEV_AMP_FLAG,
-		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_amp_switch_get,
-		.put = alc262_lenovo_3000_master_sw_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x1b, 3, 0, HDA_OUTPUT),
+		.subdevice = HDA_SUBDEV_NID_FLAG | 0x1b,
+		.info = snd_ctl_boolean_mono_info,
+		.get = alc262_hp_master_sw_get,
+		.put = alc262_hp_master_sw_put,
 	},
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
@@ -12734,8 +12641,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_fujitsu_capture_source,
-		.unsol_event = alc262_fujitsu_unsol_event,
-		.init_hook = alc262_fujitsu_init_hook,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc262_fujitsu_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_HP_BPC] = {
 		.mixers = { alc262_HP_BPC_mixer },
@@ -12863,7 +12771,9 @@ static struct alc_config_preset alc262_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
 		.input_mux = &alc262_fujitsu_capture_source,
-		.unsol_event = alc262_lenovo_3000_unsol_event,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc262_lenovo_3000_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC262_NEC] = {
 		.mixers = { alc262_nec_mixer },
@@ -13133,38 +13043,18 @@ static struct hda_bind_ctls alc268_acer_bind_master_vol = {
 	},
 };
 
-/* mute/unmute internal speaker according to the hp jack and mute state */
-static void alc268_acer_automute(struct hda_codec *codec, int force)
+static void alc268_acer_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int mute;
 
-	if (force || !spec->sense_updated) {
-		spec->jack_present = snd_hda_jack_detect(codec, 0x14);
-		spec->sense_updated = 1;
-	}
-	if (spec->jack_present)
-		mute = HDA_AMP_MUTE; /* mute internal speaker */
-	else /* unmute internal speaker if necessary */
-		mute = snd_hda_codec_amp_read(codec, 0x14, 0, HDA_OUTPUT, 0);
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, mute);
+	spec->autocfg.hp_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x15;
+	spec->automute = 1;
+	spec->automute_mode = ALC_AUTOMUTE_AMP;
 }
 
-
-/* bind hp and internal speaker mute (with plug check) */
-static int alc268_acer_master_sw_put(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	long *valp = ucontrol->value.integer.value;
-	int change;
-
-	change = amp_stereo_mute_update(codec, 0x14, HDA_OUTPUT, 0, valp);
-	if (change)
-		alc268_acer_automute(codec, 0);
-	return change;
-}
+#define alc268_acer_master_sw_get	alc262_hp_master_sw_get
+#define alc268_acer_master_sw_put	alc262_hp_master_sw_put
 
 static struct snd_kcontrol_new alc268_acer_aspire_one_mixer[] = {
 	/* output mixer control */
@@ -13172,11 +13062,10 @@ static struct snd_kcontrol_new alc268_acer_aspire_one_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.subdevice = HDA_SUBDEV_AMP_FLAG,
-		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_amp_switch_get,
+		.subdevice = HDA_SUBDEV_NID_FLAG | 0x15,
+		.info = snd_ctl_boolean_mono_info,
+		.get = alc268_acer_master_sw_get,
 		.put = alc268_acer_master_sw_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
 	},
 	HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x18, 0, HDA_INPUT),
 	{ }
@@ -13188,11 +13077,10 @@ static struct snd_kcontrol_new alc268_acer_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.subdevice = HDA_SUBDEV_AMP_FLAG,
-		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_amp_switch_get,
+		.subdevice = HDA_SUBDEV_NID_FLAG | 0x14,
+		.info = snd_ctl_boolean_mono_info,
+		.get = alc268_acer_master_sw_get,
 		.put = alc268_acer_master_sw_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
 	},
 	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
@@ -13206,11 +13094,10 @@ static struct snd_kcontrol_new alc268_acer_dmic_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.subdevice = HDA_SUBDEV_AMP_FLAG,
-		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_amp_switch_get,
+		.subdevice = HDA_SUBDEV_NID_FLAG | 0x14,
+		.info = snd_ctl_boolean_mono_info,
+		.get = alc268_acer_master_sw_get,
 		.put = alc268_acer_master_sw_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
 	},
 	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line In Boost Volume", 0x1a, 0, HDA_INPUT),
@@ -13241,19 +13128,6 @@ static struct hda_verb alc268_acer_verbs[] = {
 /* unsolicited event for HP jack sensing */
 #define alc268_toshiba_setup		alc262_hippo_setup
 
-static void alc268_acer_unsol_event(struct hda_codec *codec,
-				       unsigned int res)
-{
-	if ((res >> 26) != ALC880_HP_EVENT)
-		return;
-	alc268_acer_automute(codec, 1);
-}
-
-static void alc268_acer_init_hook(struct hda_codec *codec)
-{
-	alc268_acer_automute(codec, 1);
-}
-
 static void alc268_acer_lc_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -13893,8 +13767,9 @@ static struct alc_config_preset alc268_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc268_modes),
 		.channel_mode = alc268_modes,
 		.input_mux = &alc268_acer_capture_source,
-		.unsol_event = alc268_acer_unsol_event,
-		.init_hook = alc268_acer_init_hook,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc268_acer_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC268_ACER_DMIC] = {
 		.mixers = { alc268_acer_dmic_mixer, alc268_capture_alt_mixer,
@@ -13910,8 +13785,9 @@ static struct alc_config_preset alc268_presets[] = {
 		.num_channel_mode = ARRAY_SIZE(alc268_modes),
 		.channel_mode = alc268_modes,
 		.input_mux = &alc268_acer_dmic_capture_source,
-		.unsol_event = alc268_acer_unsol_event,
-		.init_hook = alc268_acer_init_hook,
+		.unsol_event = alc_sku_unsol_event,
+		.setup = alc268_acer_setup,
+		.init_hook = alc_inithook,
 	},
 	[ALC268_ACER_ASPIRE_ONE] = {
 		.mixers = { alc268_acer_aspire_one_mixer,
-- 
1.7.4.2
