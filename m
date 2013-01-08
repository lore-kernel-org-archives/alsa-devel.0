From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 041/112] ALSA: hda - Move fixup code into
	struct hda_codec
Date: Tue,  8 Jan 2013 12:38:34 +0100
Message-ID: <1357645185-7645-42-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E07B2651BF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id CA4DFA523A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Since the fixup code is used commonly, it's worth to move it to the
common place, struct hda_codec, instead of keeping in hda_gen_spec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 39 ++++++++++-----------
 sound/pci/hda/hda_auto_parser.h | 78 -----------------------------------------
 sound/pci/hda/hda_codec.c       |  2 ++
 sound/pci/hda/hda_codec.h       |  8 +++++
 sound/pci/hda/hda_local.h       | 53 ++++++++++++++++++++++++++++
 sound/pci/hda/patch_cirrus.c    |  8 +----
 sound/pci/hda/patch_conexant.c  |  6 +---
 sound/pci/hda/patch_realtek.c   | 10 ++----
 sound/pci/hda/patch_via.c       |  4 ---
 9 files changed, 86 insertions(+), 122 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 7da883a..d460688 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -622,28 +622,27 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_pin_label);
 
-int snd_hda_gen_add_verbs(struct hda_gen_spec *spec,
-			  const struct hda_verb *list)
+int snd_hda_add_verbs(struct hda_codec *codec,
+		      const struct hda_verb *list)
 {
 	const struct hda_verb **v;
-	v = snd_array_new(&spec->verbs);
+	v = snd_array_new(&codec->verbs);
 	if (!v)
 		return -ENOMEM;
 	*v = list;
 	return 0;
 }
-EXPORT_SYMBOL_HDA(snd_hda_gen_add_verbs);
+EXPORT_SYMBOL_HDA(snd_hda_add_verbs);
 
-void snd_hda_gen_apply_verbs(struct hda_codec *codec)
+void snd_hda_apply_verbs(struct hda_codec *codec)
 {
-	struct hda_gen_spec *spec = codec->spec;
 	int i;
-	for (i = 0; i < spec->verbs.used; i++) {
-		struct hda_verb **v = snd_array_elem(&spec->verbs, i);
+	for (i = 0; i < codec->verbs.used; i++) {
+		struct hda_verb **v = snd_array_elem(&codec->verbs, i);
 		snd_hda_sequence_write(codec, *v);
 	}
 }
-EXPORT_SYMBOL_HDA(snd_hda_gen_apply_verbs);
+EXPORT_SYMBOL_HDA(snd_hda_apply_verbs);
 
 void snd_hda_apply_pincfgs(struct hda_codec *codec,
 			   const struct hda_pintbl *cfg)
@@ -655,18 +654,17 @@ EXPORT_SYMBOL_HDA(snd_hda_apply_pincfgs);
 
 void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 {
-	struct hda_gen_spec *spec = codec->spec;
-	int id = spec->fixup_id;
+	int id = codec->fixup_id;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
-	const char *modelname = spec->fixup_name;
+	const char *modelname = codec->fixup_name;
 #endif
 	int depth = 0;
 
-	if (!spec->fixup_list)
+	if (!codec->fixup_list)
 		return;
 
 	while (id >= 0) {
-		const struct hda_fixup *fix = spec->fixup_list + id;
+		const struct hda_fixup *fix = codec->fixup_list + id;
 
 		switch (fix->type) {
 		case HDA_FIXUP_PINS:
@@ -683,7 +681,7 @@ void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 			snd_printdd(KERN_INFO SFX
 				    "%s: Apply fix-verbs for %s\n",
 				    codec->chip_name, modelname);
-			snd_hda_gen_add_verbs(codec->spec, fix->v.verbs);
+			snd_hda_add_verbs(codec, fix->v.verbs);
 			break;
 		case HDA_FIXUP_FUNC:
 			if (!fix->v.func)
@@ -713,15 +711,14 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 			const struct snd_pci_quirk *quirk,
 			const struct hda_fixup *fixlist)
 {
-	struct hda_gen_spec *spec = codec->spec;
 	const struct snd_pci_quirk *q;
 	int id = -1;
 	const char *name = NULL;
 
 	/* when model=nofixup is given, don't pick up any fixups */
 	if (codec->modelname && !strcmp(codec->modelname, "nofixup")) {
-		spec->fixup_list = NULL;
-		spec->fixup_id = -1;
+		codec->fixup_list = NULL;
+		codec->fixup_id = -1;
 		return;
 	}
 
@@ -759,10 +756,10 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 		}
 	}
 
-	spec->fixup_id = id;
+	codec->fixup_id = id;
 	if (id >= 0) {
-		spec->fixup_list = fixlist;
-		spec->fixup_name = name;
+		codec->fixup_list = fixlist;
+		codec->fixup_name = name;
 	}
 }
 EXPORT_SYMBOL_HDA(snd_hda_pick_fixup);
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index 632ad0a..ff11074 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -89,82 +89,4 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 #define snd_hda_parse_pin_def_config(codec, cfg, ignore) \
 	snd_hda_parse_pin_defcfg(codec, cfg, ignore, 0)
 
-/*
- */
-
-struct hda_gen_spec {
-	/* fix-up list */
-	int fixup_id;
-	const struct hda_fixup *fixup_list;
-	const char *fixup_name;
-
-	/* additional init verbs */
-	struct snd_array verbs;
-};
-
-
-/*
- * Fix-up pin default configurations and add default verbs
- */
-
-struct hda_pintbl {
-	hda_nid_t nid;
-	u32 val;
-};
-
-struct hda_model_fixup {
-	const int id;
-	const char *name;
-};
-
-struct hda_fixup {
-	int type;
-	bool chained;
-	int chain_id;
-	union {
-		const struct hda_pintbl *pins;
-		const struct hda_verb *verbs;
-		void (*func)(struct hda_codec *codec,
-			     const struct hda_fixup *fix,
-			     int action);
-	} v;
-};
-
-/* fixup types */
-enum {
-	HDA_FIXUP_INVALID,
-	HDA_FIXUP_PINS,
-	HDA_FIXUP_VERBS,
-	HDA_FIXUP_FUNC,
-};
-
-/* fixup action definitions */
-enum {
-	HDA_FIXUP_ACT_PRE_PROBE,
-	HDA_FIXUP_ACT_PROBE,
-	HDA_FIXUP_ACT_INIT,
-	HDA_FIXUP_ACT_BUILD,
-};
-
-int snd_hda_gen_add_verbs(struct hda_gen_spec *spec,
-			  const struct hda_verb *list);
-void snd_hda_gen_apply_verbs(struct hda_codec *codec);
-void snd_hda_apply_pincfgs(struct hda_codec *codec,
-			   const struct hda_pintbl *cfg);
-void snd_hda_apply_fixup(struct hda_codec *codec, int action);
-void snd_hda_pick_fixup(struct hda_codec *codec,
-			const struct hda_model_fixup *models,
-			const struct snd_pci_quirk *quirk,
-			const struct hda_fixup *fixlist);
-
-static inline void snd_hda_gen_init(struct hda_gen_spec *spec)
-{
-	snd_array_init(&spec->verbs, sizeof(struct hda_verb *), 8);
-}
-
-static inline void snd_hda_gen_free(struct hda_gen_spec *spec)
-{
-	snd_array_free(&spec->verbs);
-}
-
 #endif /* __SOUND_HDA_AUTO_PARSER_H */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7383746..12b88a2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1253,6 +1253,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	snd_array_init(&codec->conn_lists, sizeof(hda_nid_t), 64);
 	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
 	snd_array_init(&codec->jacktbl, sizeof(struct hda_jack_tbl), 16);
+	snd_array_init(&codec->verbs, sizeof(struct hda_verb *), 8);
 	INIT_DELAYED_WORK(&codec->jackpoll_work, hda_jackpoll_work);
 
 #ifdef CONFIG_PM
@@ -2407,6 +2408,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	snd_array_free(&codec->driver_pins);
 	snd_array_free(&codec->cvt_setups);
 	snd_array_free(&codec->spdif_out);
+	snd_array_free(&codec->verbs);
 	codec->num_pcms = 0;
 	codec->pcm_info = NULL;
 	codec->preset = NULL;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index cab39b2..a1cb28f 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -896,6 +896,14 @@ struct hda_codec {
 	/* jack detection */
 	struct snd_array jacks;
 #endif
+
+	/* fix-up list */
+	int fixup_id;
+	const struct hda_fixup *fixup_list;
+	const char *fixup_name;
+
+	/* additional init verbs */
+	struct snd_array verbs;
 };
 
 /* direction */
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index ff56da8..de12dcc 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -386,6 +386,59 @@ int snd_hda_add_new_ctls(struct hda_codec *codec,
 			 const struct snd_kcontrol_new *knew);
 
 /*
+ * Fix-up pin default configurations and add default verbs
+ */
+
+struct hda_pintbl {
+	hda_nid_t nid;
+	u32 val;
+};
+
+struct hda_model_fixup {
+	const int id;
+	const char *name;
+};
+
+struct hda_fixup {
+	int type;
+	bool chained;
+	int chain_id;
+	union {
+		const struct hda_pintbl *pins;
+		const struct hda_verb *verbs;
+		void (*func)(struct hda_codec *codec,
+			     const struct hda_fixup *fix,
+			     int action);
+	} v;
+};
+
+/* fixup types */
+enum {
+	HDA_FIXUP_INVALID,
+	HDA_FIXUP_PINS,
+	HDA_FIXUP_VERBS,
+	HDA_FIXUP_FUNC,
+};
+
+/* fixup action definitions */
+enum {
+	HDA_FIXUP_ACT_PRE_PROBE,
+	HDA_FIXUP_ACT_PROBE,
+	HDA_FIXUP_ACT_INIT,
+	HDA_FIXUP_ACT_BUILD,
+};
+
+int snd_hda_add_verbs(struct hda_codec *codec, const struct hda_verb *list);
+void snd_hda_apply_verbs(struct hda_codec *codec);
+void snd_hda_apply_pincfgs(struct hda_codec *codec,
+			   const struct hda_pintbl *cfg);
+void snd_hda_apply_fixup(struct hda_codec *codec, int action);
+void snd_hda_pick_fixup(struct hda_codec *codec,
+			const struct hda_model_fixup *models,
+			const struct snd_pci_quirk *quirk,
+			const struct hda_fixup *fixlist);
+
+/*
  * unsolicited event handler
  */
 
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index a2537b2..7b0b8c3 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -34,8 +34,6 @@
  */
 
 struct cs_spec {
-	struct hda_gen_spec gen;
-
 	struct auto_pin_cfg autocfg;
 	struct hda_multi_out multiout;
 	struct snd_kcontrol *vmaster_sw;
@@ -1201,7 +1199,7 @@ static int cs_init(struct hda_codec *codec)
 
 	snd_hda_sequence_write(codec, cs_coef_init_verbs);
 
-	snd_hda_gen_apply_verbs(codec);
+	snd_hda_apply_verbs(codec);
 
 	if (spec->gpio_mask) {
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
@@ -1252,7 +1250,6 @@ static void cs_free(struct hda_codec *codec)
 	struct cs_spec *spec = codec->spec;
 	kfree(spec->capture_bind[0]);
 	kfree(spec->capture_bind[1]);
-	snd_hda_gen_free(&spec->gen);
 	kfree(codec->spec);
 }
 
@@ -1443,7 +1440,6 @@ static int patch_cs420x(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	snd_hda_gen_init(&spec->gen);
 
 	spec->vendor_nid = CS420X_VENDOR_NID;
 
@@ -1981,7 +1977,6 @@ static int patch_cs4210(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	snd_hda_gen_init(&spec->gen);
 
 	spec->vendor_nid = CS4210_VENDOR_NID;
 
@@ -2021,7 +2016,6 @@ static int patch_cs4213(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	snd_hda_gen_init(&spec->gen);
 
 	spec->vendor_nid = CS4213_VENDOR_NID;
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 60890bf..727e678 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -67,8 +67,6 @@ struct imux_info {
 };
 
 struct conexant_spec {
-	struct hda_gen_spec gen;
-
 	const struct snd_kcontrol_new *mixers[5];
 	int num_mixers;
 	hda_nid_t vmaster_nid;
@@ -451,7 +449,6 @@ static int conexant_init(struct hda_codec *codec)
 static void conexant_free(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	snd_hda_gen_free(&spec->gen);
 	snd_hda_detach_beep_device(codec);
 	kfree(spec);
 }
@@ -4045,7 +4042,7 @@ static void cx_auto_init_digital(struct hda_codec *codec)
 static int cx_auto_init(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	snd_hda_gen_apply_verbs(codec);
+	snd_hda_apply_verbs(codec);
 	cx_auto_init_output(codec);
 	cx_auto_init_input(codec);
 	cx_auto_init_digital(codec);
@@ -4549,7 +4546,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	snd_hda_gen_init(&spec->gen);
 
 	switch (codec->vendor_id) {
 	case 0x14f15045:
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 558bd6d..1beb797 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -121,8 +121,6 @@ struct nid_path {
 };
 
 struct alc_spec {
-	struct hda_gen_spec gen;
-
 	/* codec parameterization */
 	const struct snd_kcontrol_new *mixers[5];	/* mixer arrays */
 	unsigned int num_mixers;
@@ -1727,7 +1725,7 @@ static int alc_init(struct hda_codec *codec)
 	alc_fix_pll(codec);
 	alc_auto_init_amp(codec, spec->init_amp);
 
-	snd_hda_gen_apply_verbs(codec);
+	snd_hda_apply_verbs(codec);
 	alc_auto_init_std(codec);
 
 	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
@@ -2117,7 +2115,6 @@ static void alc_free(struct hda_codec *codec)
 	alc_free_kctls(codec);
 	alc_free_bind_ctls(codec);
 	snd_array_free(&spec->paths);
-	snd_hda_gen_free(&spec->gen);
 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
 }
@@ -4525,7 +4522,6 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	codec->spec = spec;
 	codec->single_adc_amp = 1;
 	spec->mixer_nid = mixer_nid;
-	snd_hda_gen_init(&spec->gen);
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
 	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
 	snd_array_init(&spec->paths, sizeof(struct nid_path), 8);
@@ -5001,7 +4997,7 @@ static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
 		spec->autocfg.hp_pins[0] = 0x0f; /* copy it for automute */
 		snd_hda_jack_detect_enable_callback(codec, 0x0f, ALC_HP_EVENT,
 						    alc_hp_automute);
-		snd_hda_gen_add_verbs(&spec->gen, alc_gpio1_init_verbs);
+		snd_hda_add_verbs(codec, alc_gpio1_init_verbs);
 	}
 }
 
@@ -5878,7 +5874,7 @@ static int alc268_parse_auto_config(struct hda_codec *codec)
 	if (err > 0) {
 		if (!spec->no_analog && spec->autocfg.speaker_pins[0] != 0x1d) {
 			add_mixer(spec, alc268_beep_mixer);
-			snd_hda_gen_add_verbs(&spec->gen, alc268_beep_init_verbs);
+			snd_hda_add_verbs(codec, alc268_beep_init_verbs);
 		}
 	}
 	return err;
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 09bb649..b224b3d 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -120,8 +120,6 @@ enum {
 };
 
 struct via_spec {
-	struct hda_gen_spec gen;
-
 	/* codec parameterization */
 	const struct snd_kcontrol_new *mixers[6];
 	unsigned int num_mixers;
@@ -252,7 +250,6 @@ static struct via_spec * via_new_spec(struct hda_codec *codec)
 	/* VT1708BCE & VT1708S are almost same */
 	if (spec->codec_type == VT1708BCE)
 		spec->codec_type = VT1708S;
-	snd_hda_gen_init(&spec->gen);
 	return spec;
 }
 
@@ -1657,7 +1654,6 @@ static void via_free(struct hda_codec *codec)
 	vt1708_stop_hp_work(spec);
 	kfree(spec->bind_cap_vol);
 	kfree(spec->bind_cap_sw);
-	snd_hda_gen_free(&spec->gen);
 	kfree(spec);
 }
 
-- 
1.8.0.1
