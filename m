From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Set patch_ops before calling
	auto-parser
Date: Fri, 29 May 2015 12:43:55 +0200
Message-ID: <1432896235-14437-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CE1F26673D
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 12:43:58 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C7255AD1F
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 10:43:57 +0000 (UTC)
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

... so that the parser code can overwrite some optional ops.  For
Realtek and others, it can be set solely in the spec allocator, so it
results in a good code cleanup, too.

With this change, we can finally remove the local stream_pm setup and
rely on the generic parser's automatic setting.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c   |  3 +--
 sound/pci/hda/patch_ca0110.c   |  3 +--
 sound/pci/hda/patch_ca0132.c   |  8 +++---
 sound/pci/hda/patch_cirrus.c   | 12 ++++-----
 sound/pci/hda/patch_cmedia.c   |  4 +--
 sound/pci/hda/patch_conexant.c |  3 +--
 sound/pci/hda/patch_realtek.c  | 61 ++++++++++++++++--------------------------
 sound/pci/hda/patch_sigmatel.c | 20 +-------------
 sound/pci/hda/patch_via.c      | 21 +++++----------
 9 files changed, 44 insertions(+), 91 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 231f89029779..c033a4ee6547 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -205,8 +205,6 @@ static int ad198x_parse_auto_config(struct hda_codec *codec, bool indep_hp)
 	if (err < 0)
 		return err;
 
-	codec->patch_ops = ad198x_auto_patch_ops;
-
 	return 0;
 }
 
@@ -223,6 +221,7 @@ static int alloc_ad_spec(struct hda_codec *codec)
 		return -ENOMEM;
 	codec->spec = spec;
 	snd_hda_gen_spec_init(&spec->gen);
+	codec->patch_ops = ad198x_auto_patch_ops;
 	return 0;
 }
 
diff --git a/sound/pci/hda/patch_ca0110.c b/sound/pci/hda/patch_ca0110.c
index 447302695195..484bbf4134cd 100644
--- a/sound/pci/hda/patch_ca0110.c
+++ b/sound/pci/hda/patch_ca0110.c
@@ -63,6 +63,7 @@ static int patch_ca0110(struct hda_codec *codec)
 		return -ENOMEM;
 	snd_hda_gen_spec_init(spec);
 	codec->spec = spec;
+	codec->patch_ops = ca0110_patch_ops;
 
 	spec->multi_cap_vol = 1;
 	codec->bus->needs_damn_long_delay = 1;
@@ -71,8 +72,6 @@ static int patch_ca0110(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = ca0110_patch_ops;
-
 	return 0;
 
  error:
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8dec790dae45..0f039abe9673 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4709,6 +4709,10 @@ static int patch_ca0132(struct hda_codec *codec)
 	codec->spec = spec;
 	spec->codec = codec;
 
+	codec->patch_ops = ca0132_patch_ops;
+	codec->pcm_format_first = 1;
+	codec->no_sticky_stream = 1;
+
 	/* Detect codec quirk */
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
 	if (quirk)
@@ -4737,10 +4741,6 @@ static int patch_ca0132(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	codec->patch_ops = ca0132_patch_ops;
-	codec->pcm_format_first = 1;
-	codec->no_sticky_stream = 1;
-
 	return 0;
 }
 
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 50e9dd675579..25ccf781fbe7 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -584,6 +584,7 @@ static int patch_cs420x(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 
+	codec->patch_ops = cs_patch_ops;
 	spec->gen.automute_hook = cs_automute;
 	codec->single_adc_amp = 1;
 
@@ -595,8 +596,6 @@ static int patch_cs420x(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cs_patch_ops;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -738,6 +737,7 @@ static int patch_cs4208(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 
+	codec->patch_ops = cs_patch_ops;
 	spec->gen.automute_hook = cs_automute;
 	/* exclude NID 0x10 (HP) from output volumes due to different steps */
 	spec->gen.out_vol_mask = 1ULL << 0x10;
@@ -756,8 +756,6 @@ static int patch_cs4208(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cs_patch_ops;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -1150,6 +1148,7 @@ static int patch_cs4210(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 
+	codec->patch_ops = cs421x_patch_ops;
 	spec->gen.automute_hook = cs_automute;
 
 	snd_hda_pick_fixup(codec, cs421x_models, cs421x_fixup_tbl,
@@ -1167,8 +1166,6 @@ static int patch_cs4210(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cs421x_patch_ops;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -1187,11 +1184,12 @@ static int patch_cs4213(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 
+	codec->patch_ops = cs421x_patch_ops;
+
 	err = cs421x_parse_auto_config(codec);
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cs421x_patch_ops;
 	return 0;
 
  error:
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 617d9012e78a..f5ed078710f8 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -57,6 +57,7 @@ static int patch_cmi9880(struct hda_codec *codec)
 		return -ENOMEM;
 
 	codec->spec = spec;
+	codec->patch_ops = cmi_auto_patch_ops;
 	cfg = &spec->gen.autocfg;
 	snd_hda_gen_spec_init(&spec->gen);
 
@@ -67,7 +68,6 @@ static int patch_cmi9880(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cmi_auto_patch_ops;
 	return 0;
 
  error:
@@ -86,6 +86,7 @@ static int patch_cmi8888(struct hda_codec *codec)
 		return -ENOMEM;
 
 	codec->spec = spec;
+	codec->patch_ops = cmi_auto_patch_ops;
 	cfg = &spec->gen.autocfg;
 	snd_hda_gen_spec_init(&spec->gen);
 
@@ -112,7 +113,6 @@ static int patch_cmi8888(struct hda_codec *codec)
 		}
 	}
 
-	codec->patch_ops = cmi_auto_patch_ops;
 	return 0;
 
  error:
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 78b719b5b34d..f788a91b544a 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -850,6 +850,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		return -ENOMEM;
 	snd_hda_gen_spec_init(&spec->gen);
 	codec->spec = spec;
+	codec->patch_ops = cx_auto_patch_ops;
 
 	cx_auto_parse_beep(codec);
 	cx_auto_parse_eapd(codec);
@@ -908,8 +909,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cx_auto_patch_ops;
-
 	/* Some laptops with Conexant chips show stalls in S3 resume,
 	 * which falls into the single-cmd mode.
 	 * Better to make reset, then.
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index da2d37158d70..376444a9f11e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1003,6 +1003,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	codec->single_adc_amp = 1;
 	/* FIXME: do we need this for all Realtek codec models? */
 	codec->spdif_status_reset = 1;
+	codec->patch_ops = alc_patch_ops;
 
 	err = alc_codec_rename_from_preset(codec);
 	if (err < 0) {
@@ -1447,6 +1448,8 @@ static int patch_alc880(struct hda_codec *codec)
 	spec->gen.need_dac_fix = 1;
 	spec->gen.beep_nid = 0x01;
 
+	codec->patch_ops.unsol_event = alc880_unsol_event;
+
 	snd_hda_pick_fixup(codec, alc880_fixup_models, alc880_fixup_tbl,
 		       alc880_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -1459,10 +1462,6 @@ static int patch_alc880(struct hda_codec *codec)
 	if (!spec->gen.no_analog)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 
-	codec->patch_ops = alc_patch_ops;
-	codec->patch_ops.unsol_event = alc880_unsol_event;
-
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -1699,6 +1698,8 @@ static int patch_alc260(struct hda_codec *codec)
 	spec->gen.prefer_hp_amp = 1;
 	spec->gen.beep_nid = 0x01;
 
+	spec->shutup = alc_eapd_shutup;
+
 	snd_hda_pick_fixup(codec, alc260_fixup_models, alc260_fixup_tbl,
 			   alc260_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -1711,9 +1712,6 @@ static int patch_alc260(struct hda_codec *codec)
 	if (!spec->gen.no_analog)
 		set_beep_amp(spec, 0x07, 0x05, HDA_INPUT);
 
-	codec->patch_ops = alc_patch_ops;
-	spec->shutup = alc_eapd_shutup;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -2298,8 +2296,6 @@ static int patch_alc882(struct hda_codec *codec)
 	if (!spec->gen.no_analog && spec->gen.beep_nid)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 
-	codec->patch_ops = alc_patch_ops;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -2435,6 +2431,8 @@ static int patch_alc262(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 
+	spec->shutup = alc_eapd_shutup;
+
 #if 0
 	/* pshou 07/11/05  set a zero PCM sample to DAC when FIFO is
 	 * under-run
@@ -2460,9 +2458,6 @@ static int patch_alc262(struct hda_codec *codec)
 	if (!spec->gen.no_analog && spec->gen.beep_nid)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 
-	codec->patch_ops = alc_patch_ops;
-	spec->shutup = alc_eapd_shutup;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -2566,6 +2561,8 @@ static int patch_alc268(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.beep_nid = 0x01;
 
+	spec->shutup = alc_eapd_shutup;
+
 	snd_hda_pick_fixup(codec, alc268_fixup_models, alc268_fixup_tbl, alc268_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
@@ -2587,9 +2584,6 @@ static int patch_alc268(struct hda_codec *codec)
 					  (0 << AC_AMPCAP_MUTE_SHIFT));
 	}
 
-	codec->patch_ops = alc_patch_ops;
-	spec->shutup = alc_eapd_shutup;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -5672,6 +5666,12 @@ static int patch_alc269(struct hda_codec *codec)
 	if (codec->core.vendor_id != 0x10ec0292)
 		codec->power_save_node = 1;
 
+#ifdef CONFIG_PM
+	codec->patch_ops.suspend = alc269_suspend;
+	codec->patch_ops.resume = alc269_resume;
+#endif
+	spec->shutup = alc269_shutup;
+
 	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
 	snd_hda_pick_pin_fixup(codec, alc269_pin_fixup_tbl, alc269_fixups);
@@ -5768,15 +5768,6 @@ static int patch_alc269(struct hda_codec *codec)
 	if (!spec->gen.no_analog && spec->gen.beep_nid && spec->gen.mixer_nid)
 		set_beep_amp(spec, spec->gen.mixer_nid, 0x04, HDA_INPUT);
 
-	codec->patch_ops = alc_patch_ops;
-	codec->patch_ops.stream_pm = snd_hda_gen_stream_pm;
-#ifdef CONFIG_PM
-	codec->patch_ops.suspend = alc269_suspend;
-	codec->patch_ops.resume = alc269_resume;
-#endif
-	if (!spec->shutup)
-		spec->shutup = alc269_shutup;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -5892,6 +5883,10 @@ static int patch_alc861(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.beep_nid = 0x23;
 
+#ifdef CONFIG_PM
+	spec->power_hook = alc_power_eapd;
+#endif
+
 	snd_hda_pick_fixup(codec, NULL, alc861_fixup_tbl, alc861_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
@@ -5903,11 +5898,6 @@ static int patch_alc861(struct hda_codec *codec)
 	if (!spec->gen.no_analog)
 		set_beep_amp(spec, 0x23, 0, HDA_OUTPUT);
 
-	codec->patch_ops = alc_patch_ops;
-#ifdef CONFIG_PM
-	spec->power_hook = alc_power_eapd;
-#endif
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -5984,6 +5974,8 @@ static int patch_alc861vd(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.beep_nid = 0x23;
 
+	spec->shutup = alc_eapd_shutup;
+
 	snd_hda_pick_fixup(codec, NULL, alc861vd_fixup_tbl, alc861vd_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
@@ -5995,10 +5987,6 @@ static int patch_alc861vd(struct hda_codec *codec)
 	if (!spec->gen.no_analog)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 
-	codec->patch_ops = alc_patch_ops;
-
-	spec->shutup = alc_eapd_shutup;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -6599,6 +6587,8 @@ static int patch_alc662(struct hda_codec *codec)
 
 	spec = codec->spec;
 
+	spec->shutup = alc_eapd_shutup;
+
 	/* handle multiple HPs as is */
 	spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 
@@ -6650,9 +6640,6 @@ static int patch_alc662(struct hda_codec *codec)
 		}
 	}
 
-	codec->patch_ops = alc_patch_ops;
-	spec->shutup = alc_eapd_shutup;
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -6689,8 +6676,6 @@ static int patch_alc680(struct hda_codec *codec)
 		return err;
 	}
 
-	codec->patch_ops = alc_patch_ops;
-
 	return 0;
 }
 
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6ff92aba0f57..bdcda6a41032 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4417,6 +4417,7 @@ static int alloc_stac_spec(struct hda_codec *codec)
 	codec->spec = spec;
 	codec->no_trigger_sense = 1; /* seems common with STAC/IDT codecs */
 	spec->gen.dac_min_mute = true;
+	codec->patch_ops = stac_patch_ops;
 	return 0;
 }
 
@@ -4433,7 +4434,6 @@ static int patch_stac9200(struct hda_codec *codec)
 	spec->linear_tone_beep = 1;
 	spec->gen.own_eapd_ctl = 1;
 
-	codec->patch_ops = stac_patch_ops;
 	codec->power_filter = snd_hda_codec_eapd_power_filter;
 
 	snd_hda_add_verbs(codec, stac9200_eapd_init);
@@ -4466,8 +4466,6 @@ static int patch_stac925x(struct hda_codec *codec)
 	spec->linear_tone_beep = 1;
 	spec->gen.own_eapd_ctl = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_add_verbs(codec, stac925x_core_init);
 
 	snd_hda_pick_fixup(codec, stac925x_models, stac925x_fixup_tbl,
@@ -4537,8 +4535,6 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_pick_fixup(codec, stac92hd73xx_models, stac92hd73xx_fixup_tbl,
 			   stac92hd73xx_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -4614,8 +4610,6 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec->num_pwrs = ARRAY_SIZE(stac92hd83xxx_pwr_nids);
 	spec->default_polarity = -1; /* no default cfg */
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_add_verbs(codec, stac92hd83xxx_core_init);
 
 	snd_hda_pick_fixup(codec, stac92hd83xxx_models, stac92hd83xxx_fixup_tbl,
@@ -4664,8 +4658,6 @@ static int patch_stac92hd95(struct hda_codec *codec)
 	spec->num_pwrs = ARRAY_SIZE(stac92hd95_pwr_nids);
 	spec->default_polarity = 0;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_pick_fixup(codec, stac92hd95_models, stac92hd95_fixup_tbl,
 			   stac92hd95_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -4704,8 +4696,6 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	spec->gen.mixer_nid = 0x17;
 	spec->have_spdif_mux = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	/* GPIO0 = EAPD */
 	spec->gpio_mask = 0x01;
 	spec->gpio_dir = 0x01;
@@ -4784,8 +4774,6 @@ static int patch_stac922x(struct hda_codec *codec)
 	spec->linear_tone_beep = 1;
 	spec->gen.own_eapd_ctl = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_add_verbs(codec, stac922x_core_init);
 
 	/* Fix Mux capture level; max to 2 */
@@ -4841,8 +4829,6 @@ static int patch_stac927x(struct hda_codec *codec)
 	spec->aloopback_shift = 0;
 	spec->eapd_switch = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_pick_fixup(codec, stac927x_models, stac927x_fixup_tbl,
 			   stac927x_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -4904,8 +4890,6 @@ static int patch_stac9205(struct hda_codec *codec)
 	/* Turn on/off EAPD per HP plugging */
 	spec->eapd_switch = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_pick_fixup(codec, stac9205_models, stac9205_fixup_tbl,
 			   stac9205_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -4977,8 +4961,6 @@ static int patch_stac9872(struct hda_codec *codec)
 	spec->linear_tone_beep = 1;
 	spec->gen.own_eapd_ctl = 1;
 
-	codec->patch_ops = stac_patch_ops;
-
 	snd_hda_add_verbs(codec, stac9872_core_init);
 
 	snd_hda_pick_fixup(codec, stac9872_models, stac9872_fixup_tbl,
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 31a95cca015d..2c6c6727ca93 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -117,6 +117,8 @@ static void via_playback_pcm_hook(struct hda_pcm_stream *hinfo,
 				  struct snd_pcm_substream *substream,
 				  int action);
 
+static const struct hda_codec_ops via_patch_ops; /* defined below */
+
 static struct via_spec *via_new_spec(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -137,6 +139,7 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 	spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
 	codec->power_save_node = 1;
 	spec->gen.power_down_unused = 1;
+	codec->patch_ops = via_patch_ops;
 	return spec;
 }
 
@@ -472,7 +475,6 @@ static const struct hda_codec_ops via_patch_ops = {
 	.init = via_init,
 	.free = via_free,
 	.unsol_event = snd_hda_jack_unsol_event,
-	.stream_pm = snd_hda_gen_stream_pm,
 #ifdef CONFIG_PM
 	.suspend = via_suspend,
 	.check_power_status = via_check_power_status,
@@ -651,6 +653,9 @@ static int patch_vt1708(struct hda_codec *codec)
 	if (spec == NULL)
 		return -ENOMEM;
 
+	/* override some patch_ops */
+	codec->patch_ops.build_controls = vt1708_build_controls;
+	codec->patch_ops.build_pcms = vt1708_build_pcms;
 	spec->gen.mixer_nid = 0x17;
 
 	/* set jackpoll_interval while parsing the codec */
@@ -679,10 +684,6 @@ static int patch_vt1708(struct hda_codec *codec)
 
 	spec->init_verbs[spec->num_iverbs++] = vt1708_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
-	codec->patch_ops.build_controls = vt1708_build_controls;
-	codec->patch_ops.build_pcms = vt1708_build_pcms;
-
 	/* clear jackpoll_interval again; it's set dynamically */
 	codec->jackpoll_interval = 0;
 
@@ -707,8 +708,6 @@ static int patch_vt1709(struct hda_codec *codec)
 		return err;
 	}
 
-	codec->patch_ops = via_patch_ops;
-
 	return 0;
 }
 
@@ -735,7 +734,6 @@ static int patch_vt1708B(struct hda_codec *codec)
 		return err;
 	}
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -800,7 +798,6 @@ static int patch_vt1708S(struct hda_codec *codec)
 
 	spec->init_verbs[spec->num_iverbs++] = vt1708S_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -842,7 +839,6 @@ static int patch_vt1702(struct hda_codec *codec)
 
 	spec->init_verbs[spec->num_iverbs++] = vt1702_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -915,7 +911,6 @@ static int patch_vt1718S(struct hda_codec *codec)
 
 	spec->init_verbs[spec->num_iverbs++] = vt1718S_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -1015,7 +1010,6 @@ static int patch_vt1716S(struct hda_codec *codec)
 	spec->mixers[spec->num_mixers++] = vt1716s_dmic_mixer;
 	spec->mixers[spec->num_mixers++] = vt1716S_mono_out_mixer;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -1123,7 +1117,6 @@ static int patch_vt2002P(struct hda_codec *codec)
 	else
 		spec->init_verbs[spec->num_iverbs++] = vt2002P_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -1162,7 +1155,6 @@ static int patch_vt1812(struct hda_codec *codec)
 
 	spec->init_verbs[spec->num_iverbs++]  = vt1812_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
@@ -1200,7 +1192,6 @@ static int patch_vt3476(struct hda_codec *codec)
 
 	spec->init_verbs[spec->num_iverbs++] = vt3476_init_verbs;
 
-	codec->patch_ops = via_patch_ops;
 	return 0;
 }
 
-- 
2.4.2
