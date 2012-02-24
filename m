From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/38] ALSA: hda/realtek - Adjust badness
	calculation for multi-ios
Date: Fri, 24 Feb 2012 17:36:08 +0100
Message-ID: <1330101391-8788-16-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 538E8104319
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 806DD916B4
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Try harder to fit the multi-io pins also by checking the hard-wired
connections for multi-ios.  Also, the badness values are adjusted to
prioritize the multi-ios as more valuable.  These changes will enable
the multi-io on some machines without losing the current capability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  196 ++++++++++++++++++++++++++++-------------
 1 files changed, 134 insertions(+), 62 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4b2ecbc..d0c71d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2929,6 +2929,7 @@ static int alc_auto_select_dac(struct hda_codec *codec, hda_nid_t pin,
 static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct alc_spec *spec = codec->spec;
+	int i;
 	if (found_in_nid_list(nid, spec->multiout.dac_nids,
 			      ARRAY_SIZE(spec->private_dac_nids)) ||
 	    found_in_nid_list(nid, spec->multiout.hp_out_nid,
@@ -2936,6 +2937,10 @@ static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 	    found_in_nid_list(nid, spec->multiout.extra_out_nid,
 			      ARRAY_SIZE(spec->multiout.extra_out_nid)))
 		return true;
+	for (i = 0; i < spec->multi_ios; i++) {
+		if (spec->multi_io[i].dac == nid)
+			return true;
+	}
 	return false;
 }
 
@@ -3028,20 +3033,20 @@ enum {
 	BAD_NO_PRIMARY_DAC = 0x10000,
 	/* No DAC is found for the extra output */
 	BAD_NO_DAC = 0x4000,
+	/* No possible multi-ios */
+	BAD_MULTI_IO = 0x103,
 	/* No individual DAC for extra output */
-	BAD_NO_EXTRA_DAC = 0x1000,
+	BAD_NO_EXTRA_DAC = 0x102,
 	/* No individual DAC for extra surrounds */
-	BAD_NO_EXTRA_SURR_DAC = 0x200,
+	BAD_NO_EXTRA_SURR_DAC = 0x101,
 	/* Primary DAC shared with main surrounds */
 	BAD_SHARED_SURROUND = 0x100,
-	/* Volume widget is shared */
-	BAD_SHARED_VOL = 0x10,
 	/* Primary DAC shared with main CLFE */
 	BAD_SHARED_CLFE = 0x10,
 	/* Primary DAC shared with extra surrounds */
 	BAD_SHARED_EXTRA_SURROUND = 0x10,
-	/* No possible multi-ios */
-	BAD_MULTI_IO = 0x1,
+	/* Volume widget is shared */
+	BAD_SHARED_VOL = 0x10,
 };
 
 static hda_nid_t alc_look_for_out_mute_nid(struct hda_codec *codec,
@@ -3140,7 +3145,8 @@ static int alc_auto_fill_extra_dacs(struct hda_codec *codec, int num_outs,
 }
 
 static int alc_auto_fill_multi_ios(struct hda_codec *codec,
-				   unsigned int location, int offset);
+				   hda_nid_t reference_pin,
+				   bool hardwired, int offset);
 
 static bool alc_map_singles(struct hda_codec *codec, int outs,
 			    const hda_nid_t *pins, hda_nid_t *dacs)
@@ -3159,11 +3165,11 @@ static bool alc_map_singles(struct hda_codec *codec, int outs,
 
 /* fill in the dac_nids table from the parsed pin configuration */
 static int fill_and_eval_dacs(struct hda_codec *codec,
-			      bool fill_hardwired)
+			      bool fill_hardwired,
+			      bool fill_mio_first)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	unsigned int location, defcfg;
 	int i, j, err, badness;
 
 	/* set num_dacs once to full for alc_auto_look_for_dac() */
@@ -3181,14 +3187,20 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		bool mapped;
 		do {
 			mapped = alc_map_singles(codec, cfg->line_outs,
-						     cfg->line_out_pins,
-						     spec->private_dac_nids);
+						 cfg->line_out_pins,
+						 spec->private_dac_nids);
 			mapped |= alc_map_singles(codec, cfg->hp_outs,
 						  cfg->hp_pins,
 						  spec->multiout.hp_out_nid);
 			mapped |= alc_map_singles(codec, cfg->speaker_outs,
 						  cfg->speaker_pins,
 						  spec->multiout.extra_out_nid);
+			if (fill_mio_first && cfg->line_outs == 1 &&
+			    cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+				err = alc_auto_fill_multi_ios(codec, cfg->line_out_pins[0], true, 0);
+				if (!err)
+					mapped = true;
+			}
 		} while (mapped);
 	}
 
@@ -3240,14 +3252,13 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		}
 	}
 
-	if (cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+	if (fill_mio_first &&
+	    cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
 		/* try to fill multi-io first */
-		defcfg = snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]);
-		location = get_defcfg_location(defcfg);
-		err = alc_auto_fill_multi_ios(codec, location, 0);
+		err = alc_auto_fill_multi_ios(codec, cfg->line_out_pins[0], false, 0);
 		if (err < 0)
 			return err;
-		badness += err;
+		/* we don't count badness at this stage yet */
 	}
 
 	if (cfg->line_out_type != AUTO_PIN_HP_OUT) {
@@ -3266,18 +3277,30 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 			return err;
 		badness += err;
 	}
-	if (!spec->multi_ios &&
-	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT &&
-	    cfg->hp_outs) {
+	if (cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		err = alc_auto_fill_multi_ios(codec, cfg->line_out_pins[0], false, 0);
+		if (err < 0)
+			return err;
+		badness += err;
+	}
+	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
 		/* try multi-ios with HP + inputs */
-		defcfg = snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0]);
-		location = get_defcfg_location(defcfg);
-		err = alc_auto_fill_multi_ios(codec, location, 1);
+		err = alc_auto_fill_multi_ios(codec, cfg->hp_pins[0], false, 1);
 		if (err < 0)
 			return err;
 		badness += err;
 	}
 
+	if (spec->multi_ios == 2) {
+		for (i = 0; i < 2; i++)
+			spec->private_dac_nids[spec->multiout.num_dacs++] =
+				spec->multi_io[i].dac;
+		spec->ext_channel_count = 2;
+	} else if (spec->multi_ios) {
+		spec->multi_ios = 0;
+		badness += BAD_MULTI_IO;
+	}
+
 	return badness;
 }
 
@@ -3326,8 +3349,8 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 	struct auto_pin_cfg *best_cfg;
 	int best_badness = INT_MAX;
 	int badness;
-	bool fill_hardwired = true;
-	bool best_wired = true;
+	bool fill_hardwired = true, fill_mio_first = true;
+	bool best_wired = true, best_mio = true;
 	bool hp_spk_swapped = false;
 
 	best_cfg = kmalloc(sizeof(*best_cfg), GFP_KERNEL);
@@ -3336,23 +3359,28 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 	*best_cfg = *cfg;
 
 	for (;;) {
-		badness = fill_and_eval_dacs(codec, fill_hardwired);
+		badness = fill_and_eval_dacs(codec, fill_hardwired,
+					     fill_mio_first);
 		if (badness < 0)
 			return badness;
-		debug_badness("==> lo_type=%d, wired=%d, badness=0x%x\n",
-			      cfg->line_out_type, fill_hardwired, badness);
+		debug_badness("==> lo_type=%d, wired=%d, mio=%d, badness=0x%x\n",
+			      cfg->line_out_type, fill_hardwired, fill_mio_first,
+			      badness);
 		debug_show_configs(spec, cfg);
 		if (badness < best_badness) {
 			best_badness = badness;
 			*best_cfg = *cfg;
 			best_wired = fill_hardwired;
+			best_mio = fill_mio_first;
 		}
 		if (!badness)
 			break;
-		if (fill_hardwired) {
-			fill_hardwired = false;
+		fill_mio_first = !fill_mio_first;
+		if (!fill_mio_first)
+			continue;
+		fill_hardwired = !fill_hardwired;
+		if (!fill_hardwired)
 			continue;
-		}
 		if (hp_spk_swapped)
 			break;
 		hp_spk_swapped = true;
@@ -3389,10 +3417,10 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 
 	if (badness) {
 		*cfg = *best_cfg;
-		fill_and_eval_dacs(codec, best_wired);
+		fill_and_eval_dacs(codec, best_wired, best_mio);
 	}
-	debug_badness("==> Best config: lo_type=%d, wired=%d\n",
-		      cfg->line_out_type, best_wired);
+	debug_badness("==> Best config: lo_type=%d, wired=%d, mio=%d\n",
+		      cfg->line_out_type, best_wired, best_mio);
 	debug_show_configs(spec, cfg);
 
 	if (cfg->line_out_pins[0])
@@ -3791,66 +3819,110 @@ static void alc_auto_init_extra_out(struct hda_codec *codec)
 	}
 }
 
+/* check whether the given pin can be a multi-io pin */
+static bool can_be_multiio_pin(struct hda_codec *codec,
+			       unsigned int location, hda_nid_t nid)
+{
+	unsigned int defcfg, caps;
+
+	defcfg = snd_hda_codec_get_pincfg(codec, nid);
+	if (get_defcfg_connect(defcfg) != AC_JACK_PORT_COMPLEX)
+		return false;
+	if (location && get_defcfg_location(defcfg) != location)
+		return false;
+	caps = snd_hda_query_pin_caps(codec, nid);
+	if (!(caps & AC_PINCAP_OUT))
+		return false;
+	return true;
+}
+
 /*
  * multi-io helper
+ *
+ * When hardwired is set, try to fill ony hardwired pins, and returns
+ * zero if any pins are filled, non-zero if nothing found.
+ * When hardwired is off, try to fill possible input pins, and returns
+ * the badness value.
  */
 static int alc_auto_fill_multi_ios(struct hda_codec *codec,
-				   unsigned int location,
-				   int offset)
+				   hda_nid_t reference_pin,
+				   bool hardwired, int offset)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t prime_dac = spec->private_dac_nids[0];
-	int type, i, dacs, num_pins = 0;
+	int type, i, j, dacs, num_pins, old_pins;
+	unsigned int defcfg = snd_hda_codec_get_pincfg(codec, reference_pin);
+	unsigned int location = get_defcfg_location(defcfg);
 	int badness = 0;
 
+	old_pins = spec->multi_ios;
+	if (old_pins >= 2)
+		goto end_fill;
+
+	num_pins = 0;
+	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
+		for (i = 0; i < cfg->num_inputs; i++) {
+			if (cfg->inputs[i].type != type)
+				continue;
+			if (can_be_multiio_pin(codec, location,
+					       cfg->inputs[i].pin))
+				num_pins++;
+		}
+	}
+	if (num_pins < 2)
+		goto end_fill;
+
 	dacs = spec->multiout.num_dacs;
 	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
 		for (i = 0; i < cfg->num_inputs; i++) {
 			hda_nid_t nid = cfg->inputs[i].pin;
 			hda_nid_t dac = 0;
-			unsigned int defcfg, caps;
+
 			if (cfg->inputs[i].type != type)
 				continue;
-			defcfg = snd_hda_codec_get_pincfg(codec, nid);
-			if (get_defcfg_connect(defcfg) != AC_JACK_PORT_COMPLEX)
-				continue;
-			if (location && get_defcfg_location(defcfg) != location)
+			if (!can_be_multiio_pin(codec, location, nid))
 				continue;
-			caps = snd_hda_query_pin_caps(codec, nid);
-			if (!(caps & AC_PINCAP_OUT))
+			for (j = 0; j < spec->multi_ios; j++) {
+				if (nid == spec->multi_io[j].pin)
+					break;
+			}
+			if (j < spec->multi_ios)
 				continue;
-			if (offset && offset + num_pins < dacs) {
-				dac = spec->private_dac_nids[offset + num_pins];
+
+			if (offset && offset + spec->multi_ios < dacs) {
+				dac = spec->private_dac_nids[offset + spec->multi_ios];
 				if (!alc_auto_is_dac_reachable(codec, nid, dac))
 					dac = 0;
 			}
-			if (!dac)
+			if (hardwired)
+				dac = get_dac_if_single(codec, nid);
+			else if (!dac)
 				dac = alc_auto_look_for_dac(codec, nid);
 			if (!dac) {
-				badness += BAD_MULTI_IO;
+				badness++;
 				continue;
 			}
-			spec->multi_io[num_pins].pin = nid;
-			spec->multi_io[num_pins].dac = dac;
-			num_pins++;
-			spec->private_dac_nids[spec->multiout.num_dacs++] = dac;
-			if (num_pins >= 2)
+			spec->multi_io[spec->multi_ios].pin = nid;
+			spec->multi_io[spec->multi_ios].dac = dac;
+			spec->multi_ios++;
+			if (spec->multi_ios >= 2)
 				break;
 		}
 	}
-	spec->multiout.num_dacs = dacs;
-	if (num_pins < 2) {
-		/* clear up again */
-		memset(spec->private_dac_nids + dacs, 0,
-		       sizeof(hda_nid_t) * (AUTO_CFG_MAX_OUTS - dacs));
-		spec->private_dac_nids[0] = prime_dac;
+ end_fill:
+	if (badness)
+		badness = BAD_MULTI_IO;
+	if (old_pins == spec->multi_ios) {
+		if (hardwired)
+			return 1; /* nothing found */
+		else
+			return badness; /* no badness if nothing found */
+	}
+	if (!hardwired && spec->multi_ios < 2) {
+		spec->multi_ios = old_pins;
 		return badness;
 	}
 
-	spec->multi_ios = num_pins;
-	spec->ext_channel_count = 2;
-	spec->multiout.num_dacs = num_pins + 1;
 	return 0;
 }
 
-- 
1.7.9
