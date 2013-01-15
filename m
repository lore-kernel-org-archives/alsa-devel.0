From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/20] ALSA: hda/realtek - Drop aliases for old
	fixups
Date: Tue, 15 Jan 2013 12:05:37 +0100
Message-ID: <1358247947-13992-11-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B57D8265322
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 92CC7A522E
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Now the whole codebase has been changed from the earlier kernels, it
makes little sense to keep these aliases.  Simply replace with the
official names.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 521 ++++++++++++++++++++----------------------
 1 file changed, 252 insertions(+), 269 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bcb258b..183b951 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -66,23 +66,6 @@ struct alc_customize_define {
 	unsigned int  fixup:1; /* Means that this sku is set by driver, not read from hw */
 };
 
-/* make compatible with old code */
-#define alc_apply_pincfgs	snd_hda_apply_pincfgs
-#define alc_apply_fixup		snd_hda_apply_fixup
-#define alc_pick_fixup		snd_hda_pick_fixup
-#define alc_fixup		hda_fixup
-#define alc_pincfg		hda_pintbl
-#define alc_model_fixup		hda_model_fixup
-
-#define ALC_FIXUP_PINS	HDA_FIXUP_PINS
-#define ALC_FIXUP_VERBS	HDA_FIXUP_VERBS
-#define ALC_FIXUP_FUNC	HDA_FIXUP_FUNC
-
-#define ALC_FIXUP_ACT_PRE_PROBE	HDA_FIXUP_ACT_PRE_PROBE
-#define ALC_FIXUP_ACT_PROBE	HDA_FIXUP_ACT_PROBE
-#define ALC_FIXUP_ACT_INIT	HDA_FIXUP_ACT_INIT
-#define ALC_FIXUP_ACT_BUILD	HDA_FIXUP_ACT_BUILD
-
 struct alc_spec {
 	struct hda_gen_spec gen; /* must be at head */
 
@@ -734,9 +717,9 @@ static int alc_add_inv_dmic_mixer(struct hda_codec *codec, hda_nid_t nid)
 
 /* typically the digital mic is put at node 0x12 */
 static void alc_fixup_inv_dmic_0x12(struct hda_codec *codec,
-				    const struct alc_fixup *fix, int action)
+				    const struct hda_fixup *fix, int action)
 {
-	if (action == ALC_FIXUP_ACT_PROBE)
+	if (action == HDA_FIXUP_ACT_PROBE)
 		alc_add_inv_dmic_mixer(codec, 0x12);
 }
 
@@ -782,7 +765,7 @@ static int alc_build_controls(struct hda_codec *codec)
 	}
 #endif
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_BUILD);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_BUILD);
 	return 0;
 }
 
@@ -803,7 +786,7 @@ static int alc_init(struct hda_codec *codec)
 
 	snd_hda_gen_init(codec);
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_INIT);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
 	return 0;
 }
@@ -1050,23 +1033,23 @@ enum {
 
 /* enable the volume-knob widget support on NID 0x21 */
 static void alc880_fixup_vol_knob(struct hda_codec *codec,
-				  const struct alc_fixup *fix, int action)
+				  const struct hda_fixup *fix, int action)
 {
-	if (action == ALC_FIXUP_ACT_PROBE)
+	if (action == HDA_FIXUP_ACT_PROBE)
 		snd_hda_jack_detect_enable_callback(codec, 0x21, ALC_DCVOL_EVENT, alc_update_knob_master);
 }
 
-static const struct alc_fixup alc880_fixups[] = {
+static const struct hda_fixup alc880_fixups[] = {
 	[ALC880_FIXUP_GPIO1] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio1_init_verbs,
 	},
 	[ALC880_FIXUP_GPIO2] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio2_init_verbs,
 	},
 	[ALC880_FIXUP_MEDION_RIM] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
 			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3060 },
@@ -1076,8 +1059,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_GPIO2,
 	},
 	[ALC880_FIXUP_LG] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			/* disable bogus unused pins */
 			{ 0x16, 0x411111f0 },
 			{ 0x18, 0x411111f0 },
@@ -1086,8 +1069,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		}
 	},
 	[ALC880_FIXUP_W810] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			/* disable bogus unused pins */
 			{ 0x17, 0x411111f0 },
 			{ }
@@ -1096,7 +1079,7 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_GPIO2,
 	},
 	[ALC880_FIXUP_EAPD_COEF] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* change to EAPD mode */
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
@@ -1105,7 +1088,7 @@ static const struct alc_fixup alc880_fixups[] = {
 		},
 	},
 	[ALC880_FIXUP_TCL_S700] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* change to EAPD mode */
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
@@ -1116,13 +1099,13 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_GPIO2,
 	},
 	[ALC880_FIXUP_VOL_KNOB] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc880_fixup_vol_knob,
 	},
 	[ALC880_FIXUP_FUJITSU] = {
 		/* override all pins as BIOS on old Amilo is broken */
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x0121411f }, /* HP */
 			{ 0x15, 0x99030120 }, /* speaker */
 			{ 0x16, 0x99030130 }, /* bass speaker */
@@ -1141,8 +1124,8 @@ static const struct alc_fixup alc880_fixups[] = {
 	},
 	[ALC880_FIXUP_F1734] = {
 		/* almost compatible with FUJITSU, but no bass and SPDIF */
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x0121411f }, /* HP */
 			{ 0x15, 0x99030120 }, /* speaker */
 			{ 0x16, 0x411111f0 }, /* N/A */
@@ -1161,8 +1144,8 @@ static const struct alc_fixup alc880_fixups[] = {
 	},
 	[ALC880_FIXUP_UNIWILL] = {
 		/* need to fix HP and speaker pins to be parsed correctly */
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x0121411f }, /* HP */
 			{ 0x15, 0x99030120 }, /* speaker */
 			{ 0x16, 0x99030130 }, /* bass speaker */
@@ -1170,8 +1153,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		},
 	},
 	[ALC880_FIXUP_UNIWILL_DIG] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			/* disable bogus unused pins */
 			{ 0x17, 0x411111f0 },
 			{ 0x19, 0x411111f0 },
@@ -1181,8 +1164,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		}
 	},
 	[ALC880_FIXUP_Z71V] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			/* set up the whole pins as BIOS is utterly broken */
 			{ 0x14, 0x99030120 }, /* speaker */
 			{ 0x15, 0x0121411f }, /* HP */
@@ -1199,8 +1182,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		}
 	},
 	[ALC880_FIXUP_3ST_BASE] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x01014010 }, /* line-out */
 			{ 0x15, 0x411111f0 }, /* N/A */
 			{ 0x16, 0x411111f0 }, /* N/A */
@@ -1217,8 +1200,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		}
 	},
 	[ALC880_FIXUP_3ST] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1e, 0x411111f0 }, /* N/A */
 			{ }
 		},
@@ -1226,8 +1209,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_3ST_BASE,
 	},
 	[ALC880_FIXUP_3ST_DIG] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1e, 0x0144111e }, /* SPDIF */
 			{ }
 		},
@@ -1235,8 +1218,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_3ST_BASE,
 	},
 	[ALC880_FIXUP_5ST_BASE] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x01014010 }, /* front */
 			{ 0x15, 0x411111f0 }, /* N/A */
 			{ 0x16, 0x01011411 }, /* CLFE */
@@ -1253,8 +1236,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		}
 	},
 	[ALC880_FIXUP_5ST] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1e, 0x411111f0 }, /* N/A */
 			{ }
 		},
@@ -1262,8 +1245,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_5ST_BASE,
 	},
 	[ALC880_FIXUP_5ST_DIG] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1e, 0x0144111e }, /* SPDIF */
 			{ }
 		},
@@ -1271,8 +1254,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_5ST_BASE,
 	},
 	[ALC880_FIXUP_6ST_BASE] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x01014010 }, /* front */
 			{ 0x15, 0x01016412 }, /* surr */
 			{ 0x16, 0x01011411 }, /* CLFE */
@@ -1289,8 +1272,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		}
 	},
 	[ALC880_FIXUP_6ST] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1e, 0x411111f0 }, /* N/A */
 			{ }
 		},
@@ -1298,8 +1281,8 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chain_id = ALC880_FIXUP_6ST_BASE,
 	},
 	[ALC880_FIXUP_6ST_DIG] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1e, 0x0144111e }, /* SPDIF */
 			{ }
 		},
@@ -1375,7 +1358,7 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	{}
 };
 
-static const struct alc_model_fixup alc880_fixup_models[] = {
+static const struct hda_model_fixup alc880_fixup_models[] = {
 	{.id = ALC880_FIXUP_3ST, .name = "3stack"},
 	{.id = ALC880_FIXUP_3ST_DIG, .name = "3stack-digout"},
 	{.id = ALC880_FIXUP_5ST, .name = "5stack"},
@@ -1401,9 +1384,9 @@ static int patch_alc880(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.need_dac_fix = 1;
 
-	alc_pick_fixup(codec, alc880_fixup_models, alc880_fixup_tbl,
+	snd_hda_pick_fixup(codec, alc880_fixup_models, alc880_fixup_tbl,
 		       alc880_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	/* automatic parse from the BIOS config */
 	err = alc880_parse_auto_config(codec);
@@ -1421,7 +1404,7 @@ static int patch_alc880(struct hda_codec *codec)
 	codec->patch_ops.unsol_event = alc880_unsol_event;
 
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -1463,10 +1446,10 @@ static void alc260_gpio1_automute(struct hda_codec *codec)
 }
 
 static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
-				      const struct alc_fixup *fix, int action)
+				      const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == ALC_FIXUP_ACT_PROBE) {
+	if (action == HDA_FIXUP_ACT_PROBE) {
 		/* although the machine has only one output pin, we need to
 		 * toggle GPIO1 according to the jack state
 		 */
@@ -1481,10 +1464,10 @@ static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
 }
 
 static void alc260_fixup_kn1(struct hda_codec *codec,
-			     const struct alc_fixup *fix, int action)
+			     const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	static const struct alc_pincfg pincfgs[] = {
+	static const struct hda_pintbl pincfgs[] = {
 		{ 0x0f, 0x02214000 }, /* HP/speaker */
 		{ 0x12, 0x90a60160 }, /* int mic */
 		{ 0x13, 0x02a19000 }, /* ext mic */
@@ -1501,32 +1484,32 @@ static void alc260_fixup_kn1(struct hda_codec *codec,
 	};
 
 	switch (action) {
-	case ALC_FIXUP_ACT_PRE_PROBE:
-		alc_apply_pincfgs(codec, pincfgs);
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
 		break;
-	case ALC_FIXUP_ACT_PROBE:
+	case HDA_FIXUP_ACT_PROBE:
 		spec->init_amp = ALC_INIT_NONE;
 		break;
 	}
 }
 
-static const struct alc_fixup alc260_fixups[] = {
+static const struct hda_fixup alc260_fixups[] = {
 	[ALC260_FIXUP_HP_DC5750] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x11, 0x90130110 }, /* speaker */
 			{ }
 		}
 	},
 	[ALC260_FIXUP_HP_PIN_0F] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x0f, 0x01214000 }, /* HP */
 			{ }
 		}
 	},
 	[ALC260_FIXUP_COEF] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
 			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3040 },
@@ -1536,17 +1519,17 @@ static const struct alc_fixup alc260_fixups[] = {
 		.chain_id = ALC260_FIXUP_HP_PIN_0F,
 	},
 	[ALC260_FIXUP_GPIO1] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio1_init_verbs,
 	},
 	[ALC260_FIXUP_GPIO1_TOGGLE] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc260_fixup_gpio1_toggle,
 		.chained = true,
 		.chain_id = ALC260_FIXUP_HP_PIN_0F,
 	},
 	[ALC260_FIXUP_REPLACER] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
 			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3050 },
@@ -1556,13 +1539,13 @@ static const struct alc_fixup alc260_fixups[] = {
 		.chain_id = ALC260_FIXUP_GPIO1_TOGGLE,
 	},
 	[ALC260_FIXUP_HP_B1900] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc260_fixup_gpio1_toggle,
 		.chained = true,
 		.chain_id = ALC260_FIXUP_COEF,
 	},
 	[ALC260_FIXUP_KN1] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc260_fixup_kn1,
 	},
 };
@@ -1593,8 +1576,8 @@ static int patch_alc260(struct hda_codec *codec)
 
 	spec = codec->spec;
 
-	alc_pick_fixup(codec, NULL, alc260_fixup_tbl, alc260_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_pick_fixup(codec, NULL, alc260_fixup_tbl, alc260_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	/* automatic parse from the BIOS config */
 	err = alc260_parse_auto_config(codec);
@@ -1611,7 +1594,7 @@ static int patch_alc260(struct hda_codec *codec)
 	codec->patch_ops = alc_patch_ops;
 	spec->shutup = alc_eapd_shutup;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -1665,9 +1648,9 @@ enum {
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
-			      const struct alc_fixup *fix, int action)
+			      const struct hda_fixup *fix, int action)
 {
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	alc889_coef_init(codec);
 }
@@ -1707,9 +1690,9 @@ static void alc882_gpio_mute(struct hda_codec *codec, int pin, int muted)
 
 /* set up GPIO at initialization */
 static void alc885_fixup_macpro_gpio(struct hda_codec *codec,
-				     const struct alc_fixup *fix, int action)
+				     const struct hda_fixup *fix, int action)
 {
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	alc882_gpio_mute(codec, 0, 0);
 	alc882_gpio_mute(codec, 1, 0);
@@ -1720,9 +1703,9 @@ static void alc885_fixup_macpro_gpio(struct hda_codec *codec,
  * work correctly (bko#42740)
  */
 static void alc889_fixup_dac_route(struct hda_codec *codec,
-				   const struct alc_fixup *fix, int action)
+				   const struct hda_fixup *fix, int action)
 {
-	if (action == ALC_FIXUP_ACT_PRE_PROBE) {
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		/* fake the connections during parsing the tree */
 		hda_nid_t conn1[2] = { 0x0c, 0x0d };
 		hda_nid_t conn2[2] = { 0x0e, 0x0f };
@@ -1730,7 +1713,7 @@ static void alc889_fixup_dac_route(struct hda_codec *codec,
 		snd_hda_override_conn_list(codec, 0x15, 2, conn1);
 		snd_hda_override_conn_list(codec, 0x18, 2, conn2);
 		snd_hda_override_conn_list(codec, 0x1a, 2, conn2);
-	} else if (action == ALC_FIXUP_ACT_PROBE) {
+	} else if (action == HDA_FIXUP_ACT_PROBE) {
 		/* restore the connections */
 		hda_nid_t conn[5] = { 0x0c, 0x0d, 0x0e, 0x0f, 0x26 };
 		snd_hda_override_conn_list(codec, 0x14, 5, conn);
@@ -1742,13 +1725,13 @@ static void alc889_fixup_dac_route(struct hda_codec *codec,
 
 /* Set VREF on HP pin */
 static void alc889_fixup_mbp_vref(struct hda_codec *codec,
-				  const struct alc_fixup *fix, int action)
+				  const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 	static hda_nid_t nids[2] = { 0x14, 0x15 };
 	int i;
 
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	for (i = 0; i < ARRAY_SIZE(nids); i++) {
 		unsigned int val = snd_hda_codec_get_pincfg(codec, nids[i]);
@@ -1765,13 +1748,13 @@ static void alc889_fixup_mbp_vref(struct hda_codec *codec,
 
 /* Set VREF on speaker pins on imac91 */
 static void alc889_fixup_imac91_vref(struct hda_codec *codec,
-				     const struct alc_fixup *fix, int action)
+				     const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 	static hda_nid_t nids[2] = { 0x18, 0x1a };
 	int i;
 
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	for (i = 0; i < ARRAY_SIZE(nids); i++) {
 		unsigned int val;
@@ -1787,17 +1770,17 @@ static void alc889_fixup_imac91_vref(struct hda_codec *codec,
  * strangely, the speaker output doesn't work on VAIO Z through DAC 0x05
  */
 static void alc882_fixup_no_primary_hp(struct hda_codec *codec,
-				       const struct alc_fixup *fix, int action)
+				       const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == ALC_FIXUP_ACT_PRE_PROBE)
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
 		spec->gen.no_primary_hp = 1;
 }
 
-static const struct alc_fixup alc882_fixups[] = {
+static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x15, 0x01080104 }, /* side */
 			{ 0x16, 0x01011012 }, /* rear */
 			{ 0x17, 0x01016011 }, /* clfe */
@@ -1805,47 +1788,47 @@ static const struct alc_fixup alc882_fixups[] = {
 		}
 	},
 	[ALC882_FIXUP_LENOVO_Y530] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x15, 0x99130112 }, /* rear int speakers */
 			{ 0x16, 0x99130111 }, /* subwoofer */
 			{ }
 		}
 	},
 	[ALC882_FIXUP_PB_M5210] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50 },
 			{}
 		}
 	},
 	[ALC882_FIXUP_ACER_ASPIRE_7736] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_sku_ignore,
 	},
 	[ALC882_FIXUP_ASUS_W90V] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x16, 0x99130110 }, /* fix sequence for CLFE */
 			{ }
 		}
 	},
 	[ALC889_FIXUP_CD] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1c, 0x993301f0 }, /* CD */
 			{ }
 		}
 	},
 	[ALC889_FIXUP_VAIO_TT] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x17, 0x90170111 }, /* hidden surround speaker */
 			{ }
 		}
 	},
 	[ALC888_FIXUP_EEE1601] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x0b },
 			{ 0x20, AC_VERB_SET_PROC_COEF,  0x0838 },
@@ -1853,7 +1836,7 @@ static const struct alc_fixup alc882_fixups[] = {
 		}
 	},
 	[ALC882_FIXUP_EAPD] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* change to EAPD mode */
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
@@ -1862,7 +1845,7 @@ static const struct alc_fixup alc882_fixups[] = {
 		}
 	},
 	[ALC883_FIXUP_EAPD] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* change to EAPD mode */
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
@@ -1871,7 +1854,7 @@ static const struct alc_fixup alc882_fixups[] = {
 		}
 	},
 	[ALC883_FIXUP_ACER_EAPD] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* eanable EAPD on Acer laptops */
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
@@ -1880,30 +1863,30 @@ static const struct alc_fixup alc882_fixups[] = {
 		}
 	},
 	[ALC882_FIXUP_GPIO1] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio1_init_verbs,
 	},
 	[ALC882_FIXUP_GPIO2] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio2_init_verbs,
 	},
 	[ALC882_FIXUP_GPIO3] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio3_init_verbs,
 	},
 	[ALC882_FIXUP_ASUS_W2JC] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = alc_gpio1_init_verbs,
 		.chained = true,
 		.chain_id = ALC882_FIXUP_EAPD,
 	},
 	[ALC889_FIXUP_COEF] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc889_fixup_coef,
 	},
 	[ALC882_FIXUP_ACER_ASPIRE_4930G] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x16, 0x99130111 }, /* CLFE speaker */
 			{ 0x17, 0x99130112 }, /* surround speaker */
 			{ }
@@ -1912,8 +1895,8 @@ static const struct alc_fixup alc882_fixups[] = {
 		.chain_id = ALC882_FIXUP_GPIO1,
 	},
 	[ALC882_FIXUP_ACER_ASPIRE_8930G] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x16, 0x99130111 }, /* CLFE speaker */
 			{ 0x1b, 0x99130112 }, /* surround speaker */
 			{ }
@@ -1923,7 +1906,7 @@ static const struct alc_fixup alc882_fixups[] = {
 	},
 	[ALC882_FIXUP_ASPIRE_8930G_VERBS] = {
 		/* additional init verbs for Acer Aspire 8930G */
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* Enable all DACs */
 			/* DAC DISABLE/MUTE 1? */
@@ -1957,31 +1940,31 @@ static const struct alc_fixup alc882_fixups[] = {
 		.chain_id = ALC882_FIXUP_GPIO1,
 	},
 	[ALC885_FIXUP_MACPRO_GPIO] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc885_fixup_macpro_gpio,
 	},
 	[ALC889_FIXUP_DAC_ROUTE] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc889_fixup_dac_route,
 	},
 	[ALC889_FIXUP_MBP_VREF] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc889_fixup_mbp_vref,
 		.chained = true,
 		.chain_id = ALC882_FIXUP_GPIO1,
 	},
 	[ALC889_FIXUP_IMAC91_VREF] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc889_fixup_imac91_vref,
 		.chained = true,
 		.chain_id = ALC882_FIXUP_GPIO1,
 	},
 	[ALC882_FIXUP_INV_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
 	[ALC882_FIXUP_NO_PRIMARY_HP] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc882_fixup_no_primary_hp,
 	},
 };
@@ -2056,7 +2039,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	{}
 };
 
-static const struct alc_model_fixup alc882_fixup_models[] = {
+static const struct hda_model_fixup alc882_fixup_models[] = {
 	{.id = ALC882_FIXUP_ACER_ASPIRE_4930G, .name = "acer-aspire-4930g"},
 	{.id = ALC882_FIXUP_ACER_ASPIRE_8930G, .name = "acer-aspire-8930g"},
 	{.id = ALC883_FIXUP_ACER_EAPD, .name = "acer-aspire"},
@@ -2099,9 +2082,9 @@ static int patch_alc882(struct hda_codec *codec)
 		break;
 	}
 
-	alc_pick_fixup(codec, alc882_fixup_models, alc882_fixup_tbl,
+	snd_hda_pick_fixup(codec, alc882_fixup_models, alc882_fixup_tbl,
 		       alc882_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
 
@@ -2119,7 +2102,7 @@ static int patch_alc882(struct hda_codec *codec)
 
 	codec->patch_ops = alc_patch_ops;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -2152,10 +2135,10 @@ enum {
 	ALC262_FIXUP_INV_DMIC,
 };
 
-static const struct alc_fixup alc262_fixups[] = {
+static const struct hda_fixup alc262_fixups[] = {
 	[ALC262_FIXUP_FSC_H270] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x15, 0x0221142f }, /* front HP */
 			{ 0x1b, 0x0121141f }, /* rear HP */
@@ -2163,21 +2146,21 @@ static const struct alc_fixup alc262_fixups[] = {
 		}
 	},
 	[ALC262_FIXUP_HP_Z200] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x16, 0x99130120 }, /* internal speaker */
 			{ }
 		}
 	},
 	[ALC262_FIXUP_TYAN] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x1993e1f0 }, /* int AUX */
 			{ }
 		}
 	},
 	[ALC262_FIXUP_LENOVO_3000] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50 },
 			{}
@@ -2186,7 +2169,7 @@ static const struct alc_fixup alc262_fixups[] = {
 		.chain_id = ALC262_FIXUP_BENQ,
 	},
 	[ALC262_FIXUP_BENQ] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
 			{ 0x20, AC_VERB_SET_PROC_COEF, 0x3070 },
@@ -2194,7 +2177,7 @@ static const struct alc_fixup alc262_fixups[] = {
 		}
 	},
 	[ALC262_FIXUP_BENQ_T31] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
 			{ 0x20, AC_VERB_SET_PROC_COEF, 0x3050 },
@@ -2202,7 +2185,7 @@ static const struct alc_fixup alc262_fixups[] = {
 		}
 	},
 	[ALC262_FIXUP_INV_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
 };
@@ -2219,7 +2202,7 @@ static const struct snd_pci_quirk alc262_fixup_tbl[] = {
 	{}
 };
 
-static const struct alc_model_fixup alc262_fixup_models[] = {
+static const struct hda_model_fixup alc262_fixup_models[] = {
 	{.id = ALC262_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{}
 };
@@ -2252,9 +2235,9 @@ static int patch_alc262(struct hda_codec *codec)
 #endif
 	alc_fix_pll_init(codec, 0x20, 0x0a, 10);
 
-	alc_pick_fixup(codec, alc262_fixup_models, alc262_fixup_tbl,
+	snd_hda_pick_fixup(codec, alc262_fixup_models, alc262_fixup_tbl,
 		       alc262_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
 
@@ -2273,7 +2256,7 @@ static int patch_alc262(struct hda_codec *codec)
 	codec->patch_ops = alc_patch_ops;
 	spec->shutup = alc_eapd_shutup;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -2314,13 +2297,13 @@ enum {
 	ALC268_FIXUP_HP_EAPD,
 };
 
-static const struct alc_fixup alc268_fixups[] = {
+static const struct hda_fixup alc268_fixups[] = {
 	[ALC268_FIXUP_INV_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
 	[ALC268_FIXUP_HP_EAPD] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{0x15, AC_VERB_SET_EAPD_BTLENABLE, 0},
 			{}
@@ -2328,7 +2311,7 @@ static const struct alc_fixup alc268_fixups[] = {
 	},
 };
 
-static const struct alc_model_fixup alc268_fixup_models[] = {
+static const struct hda_model_fixup alc268_fixup_models[] = {
 	{.id = ALC268_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC268_FIXUP_HP_EAPD, .name = "hp-eapd"},
 	{}
@@ -2374,8 +2357,8 @@ static int patch_alc268(struct hda_codec *codec)
 
 	spec = codec->spec;
 
-	alc_pick_fixup(codec, alc268_fixup_models, alc268_fixup_tbl, alc268_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_pick_fixup(codec, alc268_fixup_models, alc268_fixup_tbl, alc268_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	/* automatic parse from the BIOS config */
 	err = alc268_parse_auto_config(codec);
@@ -2406,7 +2389,7 @@ static int patch_alc268(struct hda_codec *codec)
 	codec->patch_ops = alc_patch_ops;
 	spec->shutup = alc_eapd_shutup;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -2564,27 +2547,27 @@ static int alc269_resume(struct hda_codec *codec)
 #endif /* CONFIG_PM */
 
 static void alc269_fixup_pincfg_no_hp_to_lineout(struct hda_codec *codec,
-						 const struct alc_fixup *fix, int action)
+						 const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (action == ALC_FIXUP_ACT_PRE_PROBE)
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 }
 
 static void alc269_fixup_hweq(struct hda_codec *codec,
-			       const struct alc_fixup *fix, int action)
+			       const struct hda_fixup *fix, int action)
 {
 	int coef;
 
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	coef = alc_read_coef_idx(codec, 0x1e);
 	alc_write_coef_idx(codec, 0x1e, coef | 0x80);
 }
 
 static void alc271_fixup_dmic(struct hda_codec *codec,
-			      const struct alc_fixup *fix, int action)
+			      const struct hda_fixup *fix, int action)
 {
 	static const struct hda_verb verbs[] = {
 		{0x20, AC_VERB_SET_COEF_INDEX, 0x0d},
@@ -2601,11 +2584,11 @@ static void alc271_fixup_dmic(struct hda_codec *codec,
 }
 
 static void alc269_fixup_pcm_44k(struct hda_codec *codec,
-				 const struct alc_fixup *fix, int action)
+				 const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (action != ALC_FIXUP_ACT_PROBE)
+	if (action != HDA_FIXUP_ACT_PROBE)
 		return;
 
 	/* Due to a hardware problem on Lenovo Ideadpad, we need to
@@ -2616,11 +2599,11 @@ static void alc269_fixup_pcm_44k(struct hda_codec *codec,
 }
 
 static void alc269_fixup_stereo_dmic(struct hda_codec *codec,
-				     const struct alc_fixup *fix, int action)
+				     const struct hda_fixup *fix, int action)
 {
 	int coef;
 
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	/* The digital-mic unit sends PDM (differential signal) instead of
 	 * the standard PCM, thus you can't record a valid mono stream as is.
@@ -2647,10 +2630,10 @@ static void alc269_quanta_automute(struct hda_codec *codec)
 }
 
 static void alc269_fixup_quanta_mute(struct hda_codec *codec,
-				     const struct alc_fixup *fix, int action)
+				     const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action != ALC_FIXUP_ACT_PROBE)
+	if (action != HDA_FIXUP_ACT_PROBE)
 		return;
 	spec->gen.automute_hook = alc269_quanta_automute;
 }
@@ -2665,10 +2648,10 @@ static void alc269_fixup_mic1_mute_hook(void *private_data, int enabled)
 }
 
 static void alc269_fixup_mic1_mute(struct hda_codec *codec,
-				   const struct alc_fixup *fix, int action)
+				   const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == ALC_FIXUP_ACT_PROBE) {
+	if (action == HDA_FIXUP_ACT_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic1_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
 	}
@@ -2683,17 +2666,17 @@ static void alc269_fixup_mic2_mute_hook(void *private_data, int enabled)
 }
 
 static void alc269_fixup_mic2_mute(struct hda_codec *codec,
-				   const struct alc_fixup *fix, int action)
+				   const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == ALC_FIXUP_ACT_PROBE) {
+	if (action == HDA_FIXUP_ACT_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic2_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
 	}
 }
 
 static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
-				    const struct alc_fixup *fix,
+				    const struct hda_fixup *fix,
 				    int action)
 {
 	struct alc_spec *spec = codec->spec;
@@ -2701,7 +2684,7 @@ static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
 	if (snd_BUG_ON(!spec->gen.am_entry[1].pin ||
 		       !spec->gen.autocfg.hp_pins[0]))
 		return;
-	if (action == ALC_FIXUP_ACT_PROBE)
+	if (action == HDA_FIXUP_ACT_PROBE)
 		snd_hda_jack_set_gating_jack(codec, spec->gen.am_entry[1].pin,
 					     spec->gen.autocfg.hp_pins[0]);
 }
@@ -2732,16 +2715,16 @@ enum {
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
 };
 
-static const struct alc_fixup alc269_fixups[] = {
+static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_SONY_VAIO] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREFGRD},
 			{}
 		}
 	},
 	[ALC275_FIXUP_SONY_VAIO_GPIO2] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{0x01, AC_VERB_SET_GPIO_MASK, 0x04},
 			{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04},
@@ -2752,7 +2735,7 @@ static const struct alc_fixup alc269_fixups[] = {
 		.chain_id = ALC269_FIXUP_SONY_VAIO
 	},
 	[ALC269_FIXUP_DELL_M101Z] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* Enables internal speaker */
 			{0x20, AC_VERB_SET_COEF_INDEX, 13},
@@ -2761,50 +2744,50 @@ static const struct alc_fixup alc269_fixups[] = {
 		}
 	},
 	[ALC269_FIXUP_SKU_IGNORE] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_sku_ignore,
 	},
 	[ALC269_FIXUP_ASUS_G73JW] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x17, 0x99130111 }, /* subwoofer */
 			{ }
 		}
 	},
 	[ALC269_FIXUP_LENOVO_EAPD] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{0x14, AC_VERB_SET_EAPD_BTLENABLE, 0},
 			{}
 		}
 	},
 	[ALC275_FIXUP_SONY_HWEQ] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hweq,
 		.chained = true,
 		.chain_id = ALC275_FIXUP_SONY_VAIO_GPIO2
 	},
 	[ALC271_FIXUP_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc271_fixup_dmic,
 	},
 	[ALC269_FIXUP_PCM_44K] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pcm_44k,
 		.chained = true,
 		.chain_id = ALC269_FIXUP_QUANTA_MUTE
 	},
 	[ALC269_FIXUP_STEREO_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_stereo_dmic,
 	},
 	[ALC269_FIXUP_QUANTA_MUTE] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_quanta_mute,
 	},
 	[ALC269_FIXUP_LIFEBOOK] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1a, 0x2101103f }, /* dock line-out */
 			{ 0x1b, 0x23a11040 }, /* dock mic-in */
 			{ }
@@ -2813,8 +2796,8 @@ static const struct alc_fixup alc269_fixups[] = {
 		.chain_id = ALC269_FIXUP_QUANTA_MUTE
 	},
 	[ALC269_FIXUP_AMIC] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x15, 0x0121401f }, /* HP out */
 			{ 0x18, 0x01a19c20 }, /* mic */
@@ -2823,8 +2806,8 @@ static const struct alc_fixup alc269_fixups[] = {
 		},
 	},
 	[ALC269_FIXUP_DMIC] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x12, 0x99a3092f }, /* int-mic */
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x15, 0x0121401f }, /* HP out */
@@ -2833,8 +2816,8 @@ static const struct alc_fixup alc269_fixups[] = {
 		},
 	},
 	[ALC269VB_FIXUP_AMIC] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x18, 0x01a19c20 }, /* mic */
 			{ 0x19, 0x99a3092f }, /* int-mic */
@@ -2843,8 +2826,8 @@ static const struct alc_fixup alc269_fixups[] = {
 		},
 	},
 	[ALC269VB_FIXUP_DMIC] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x12, 0x99a3092f }, /* int-mic */
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x18, 0x01a19c20 }, /* mic */
@@ -2853,20 +2836,20 @@ static const struct alc_fixup alc269_fixups[] = {
 		},
 	},
 	[ALC269_FIXUP_MIC1_MUTE_LED] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_mic1_mute,
 	},
 	[ALC269_FIXUP_MIC2_MUTE_LED] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_mic2_mute,
 	},
 	[ALC269_FIXUP_INV_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
 	[ALC269_FIXUP_LENOVO_DOCK] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x19, 0x23a11040 }, /* dock mic */
 			{ 0x1b, 0x2121103f }, /* dock headphone */
 			{ }
@@ -2875,12 +2858,12 @@ static const struct alc_fixup alc269_fixups[] = {
 		.chain_id = ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT
 	},
 	[ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
 	[ALC271_FIXUP_AMIC_MIC2] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x19, 0x01a19c20 }, /* mic */
 			{ 0x1b, 0x99a7012f }, /* int-mic */
@@ -2889,7 +2872,7 @@ static const struct alc_fixup alc269_fixups[] = {
 		},
 	},
 	[ALC271_FIXUP_HP_GATE_MIC_JACK] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc271_hp_gate_mic_jack,
 		.chained = true,
 		.chain_id = ALC271_FIXUP_AMIC_MIC2,
@@ -2982,7 +2965,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	{}
 };
 
-static const struct alc_model_fixup alc269_fixup_models[] = {
+static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_AMIC, .name = "laptop-amic"},
 	{.id = ALC269_FIXUP_DMIC, .name = "laptop-dmic"},
 	{.id = ALC269_FIXUP_STEREO_DMIC, .name = "alc269-dmic"},
@@ -3051,9 +3034,9 @@ static int patch_alc269(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 
-	alc_pick_fixup(codec, alc269_fixup_models,
+	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
 
@@ -3117,7 +3100,7 @@ static int patch_alc269(struct hda_codec *codec)
 #endif
 	spec->shutup = alc269_shutup;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -3147,12 +3130,12 @@ enum {
 
 /* On some laptops, VREF of pin 0x0f is abused for controlling the main amp */
 static void alc861_fixup_asus_amp_vref_0f(struct hda_codec *codec,
-			const struct alc_fixup *fix, int action)
+			const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 	unsigned int val;
 
-	if (action != ALC_FIXUP_ACT_INIT)
+	if (action != HDA_FIXUP_ACT_INIT)
 		return;
 	val = snd_hda_codec_read(codec, 0x0f, 0,
 				 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
@@ -3165,31 +3148,31 @@ static void alc861_fixup_asus_amp_vref_0f(struct hda_codec *codec,
 
 /* suppress the jack-detection */
 static void alc_fixup_no_jack_detect(struct hda_codec *codec,
-				     const struct alc_fixup *fix, int action)
+				     const struct hda_fixup *fix, int action)
 {
-	if (action == ALC_FIXUP_ACT_PRE_PROBE)
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
 		codec->no_jack_detect = 1;
 }
 
-static const struct alc_fixup alc861_fixups[] = {
+static const struct hda_fixup alc861_fixups[] = {
 	[ALC861_FIXUP_FSC_AMILO_PI1505] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x0b, 0x0221101f }, /* HP */
 			{ 0x0f, 0x90170310 }, /* speaker */
 			{ }
 		}
 	},
 	[ALC861_FIXUP_AMP_VREF_0F] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc861_fixup_asus_amp_vref_0f,
 	},
 	[ALC861_FIXUP_NO_JACK_DETECT] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_no_jack_detect,
 	},
 	[ALC861_FIXUP_ASUS_A6RP] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc861_fixup_asus_amp_vref_0f,
 		.chained = true,
 		.chain_id = ALC861_FIXUP_NO_JACK_DETECT,
@@ -3219,8 +3202,8 @@ static int patch_alc861(struct hda_codec *codec)
 
 	spec = codec->spec;
 
-	alc_pick_fixup(codec, NULL, alc861_fixup_tbl, alc861_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_pick_fixup(codec, NULL, alc861_fixup_tbl, alc861_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	/* automatic parse from the BIOS config */
 	err = alc861_parse_auto_config(codec);
@@ -3239,7 +3222,7 @@ static int patch_alc861(struct hda_codec *codec)
 	spec->power_hook = alc_power_eapd;
 #endif
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -3269,17 +3252,17 @@ enum {
 
 /* exclude VREF80 */
 static void alc861vd_fixup_dallas(struct hda_codec *codec,
-				  const struct alc_fixup *fix, int action)
+				  const struct hda_fixup *fix, int action)
 {
-	if (action == ALC_FIXUP_ACT_PRE_PROBE) {
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		snd_hda_override_pin_caps(codec, 0x18, 0x00000734);
 		snd_hda_override_pin_caps(codec, 0x19, 0x0000073c);
 	}
 }
 
-static const struct alc_fixup alc861vd_fixups[] = {
+static const struct hda_fixup alc861vd_fixups[] = {
 	[ALC660VD_FIX_ASUS_GPIO1] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			/* reset GPIO1 */
 			{0x01, AC_VERB_SET_GPIO_MASK, 0x03},
@@ -3289,7 +3272,7 @@ static const struct alc_fixup alc861vd_fixups[] = {
 		}
 	},
 	[ALC861VD_FIX_DALLAS] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc861vd_fixup_dallas,
 	},
 };
@@ -3314,8 +3297,8 @@ static int patch_alc861vd(struct hda_codec *codec)
 
 	spec = codec->spec;
 
-	alc_pick_fixup(codec, NULL, alc861vd_fixup_tbl, alc861vd_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_pick_fixup(codec, NULL, alc861vd_fixup_tbl, alc861vd_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	/* automatic parse from the BIOS config */
 	err = alc861vd_parse_auto_config(codec);
@@ -3333,7 +3316,7 @@ static int patch_alc861vd(struct hda_codec *codec)
 
 	spec->shutup = alc_eapd_shutup;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
@@ -3374,9 +3357,9 @@ static int alc662_parse_auto_config(struct hda_codec *codec)
 }
 
 static void alc272_fixup_mario(struct hda_codec *codec,
-			       const struct alc_fixup *fix, int action)
+			       const struct hda_fixup *fix, int action)
 {
-	if (action != ALC_FIXUP_ACT_PROBE)
+	if (action != HDA_FIXUP_ACT_PROBE)
 		return;
 	if (snd_hda_override_amp_caps(codec, 0x2, HDA_OUTPUT,
 				      (0x3b << AC_AMPCAP_OFFSET_SHIFT) |
@@ -3407,39 +3390,39 @@ enum {
 	ALC662_FIXUP_INV_DMIC,
 };
 
-static const struct alc_fixup alc662_fixups[] = {
+static const struct hda_fixup alc662_fixups[] = {
 	[ALC662_FIXUP_ASPIRE] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x15, 0x99130112 }, /* subwoofer */
 			{ }
 		}
 	},
 	[ALC662_FIXUP_IDEAPAD] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x17, 0x99130112 }, /* subwoofer */
 			{ }
 		}
 	},
 	[ALC272_FIXUP_MARIO] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc272_fixup_mario,
 	},
 	[ALC662_FIXUP_CZC_P10T] = {
-		.type = ALC_FIXUP_VERBS,
+		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{0x14, AC_VERB_SET_EAPD_BTLENABLE, 0},
 			{}
 		}
 	},
 	[ALC662_FIXUP_SKU_IGNORE] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_sku_ignore,
 	},
 	[ALC662_FIXUP_HP_RP5800] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x0221201f }, /* HP out */
 			{ }
 		},
@@ -3447,8 +3430,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE1] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x18, 0x01a19c20 }, /* mic */
 			{ 0x19, 0x99a3092f }, /* int-mic */
@@ -3459,8 +3442,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE2] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x18, 0x01a19820 }, /* mic */
 			{ 0x19, 0x99a3092f }, /* int-mic */
@@ -3471,8 +3454,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE3] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x15, 0x0121441f }, /* HP */
 			{ 0x18, 0x01a19840 }, /* mic */
@@ -3484,8 +3467,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE4] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x16, 0x99130111 }, /* speaker */
 			{ 0x18, 0x01a19840 }, /* mic */
@@ -3497,8 +3480,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE5] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x15, 0x0121441f }, /* HP */
 			{ 0x16, 0x99130111 }, /* speaker */
@@ -3510,8 +3493,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE6] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x15, 0x01211420 }, /* HP2 */
 			{ 0x18, 0x01a19840 }, /* mic */
@@ -3523,8 +3506,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE7] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x17, 0x99130111 }, /* speaker */
 			{ 0x18, 0x01a19840 }, /* mic */
@@ -3537,8 +3520,8 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_ASUS_MODE8] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x14, 0x99130110 }, /* speaker */
 			{ 0x12, 0x99a30970 }, /* int-mic */
 			{ 0x15, 0x01214020 }, /* HP */
@@ -3551,18 +3534,18 @@ static const struct alc_fixup alc662_fixups[] = {
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
 	[ALC662_FIXUP_NO_JACK_DETECT] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_no_jack_detect,
 	},
 	[ALC662_FIXUP_ZOTAC_Z68] = {
-		.type = ALC_FIXUP_PINS,
-		.v.pins = (const struct alc_pincfg[]) {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1b, 0x02214020 }, /* Front HP */
 			{ }
 		}
 	},
 	[ALC662_FIXUP_INV_DMIC] = {
-		.type = ALC_FIXUP_FUNC,
+		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
 };
@@ -3642,7 +3625,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	{}
 };
 
-static const struct alc_model_fixup alc662_fixup_models[] = {
+static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC272_FIXUP_MARIO, .name = "mario"},
 	{.id = ALC662_FIXUP_ASUS_MODE1, .name = "asus-mode1"},
 	{.id = ALC662_FIXUP_ASUS_MODE2, .name = "asus-mode2"},
@@ -3703,9 +3686,9 @@ static int patch_alc662(struct hda_codec *codec)
 	spec->init_hook = alc662_fill_coef;
 	alc662_fill_coef(codec);
 
-	alc_pick_fixup(codec, alc662_fixup_models,
+	snd_hda_pick_fixup(codec, alc662_fixup_models,
 		       alc662_fixup_tbl, alc662_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
 
@@ -3743,7 +3726,7 @@ static int patch_alc662(struct hda_codec *codec)
 	codec->patch_ops = alc_patch_ops;
 	spec->shutup = alc_eapd_shutup;
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 
-- 
1.8.1
