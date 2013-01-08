From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 090/112] ALSA: hda - Manage using
	output/loopback path indices
Date: Tue,  8 Jan 2013 12:39:23 +0100
Message-ID: <1357645185-7645-91-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DB753265223
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id B84CAA5387
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
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

Instead of search for the path with the certain route at each time,
keep the path index for each output and loopback, and just use it when
referred.

In this implementation, the path index number begins with one, not
zero (although I've been writing in C over decades).  It's just to
make the check for uninitialized values easier.

So far, the input paths aren't handled with indices yet, but still
picked up via snd_hda_get_nid_path() at each time.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 139 ++++++++++++++++++++++++++++----------------
 sound/pci/hda/hda_generic.h |   9 +++
 2 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 75a519c..2296839 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -147,6 +147,33 @@ struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_nid_path);
 
+/* get the index number corresponding to the path instance;
+ * the index starts from 1, for easier checking the invalid value
+ */
+int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *array = spec->paths.list;
+	ssize_t idx;
+
+	if (!spec->paths.used)
+		return 0;
+	idx = path - array;
+	if (idx < 0 || idx >= spec->paths.used)
+		return 0;
+	return idx + 1;
+}
+
+/* get the path instance corresponding to the given index number */
+struct nid_path *snd_hda_get_path_from_idx(struct hda_codec *codec, int idx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (idx <= 0 || idx > spec->paths.used)
+		return NULL;
+	return snd_array_elem(&spec->paths, idx - 1);
+}
+
 /* check whether the given DAC is already found in any existing paths */
 static bool is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -836,6 +863,7 @@ static struct badness_table extra_out_badness = {
 /* try to assign DACs to pins and return the resultant badness */
 static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			   const hda_nid_t *pins, hda_nid_t *dacs,
+			   int *path_idx,
 			   const struct badness_table *bad)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -862,6 +890,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 				if (is_reachable_path(codec, dacs[j], pin)) {
 					dacs[0] = dacs[j];
 					dacs[j] = 0;
+					path_idx[j] = 0;
 					break;
 				}
 			}
@@ -898,6 +927,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		else {
 			print_nid_path("output", path);
 			path->active = true;
+			path_idx[i] = snd_hda_get_path_idx(codec, path);
 		}
 		if (dac)
 			badness += assign_out_path_ctls(codec, pin, dac);
@@ -1025,6 +1055,8 @@ static int fill_multi_ios(struct hda_codec *codec,
 			print_nid_path("multiio", path);
 			spec->multi_io[spec->multi_ios].pin = nid;
 			spec->multi_io[spec->multi_ios].dac = dac;
+			spec->out_paths[cfg->line_outs + spec->multi_ios] =
+				snd_hda_get_path_idx(codec, path);
 			spec->multi_ios++;
 			if (spec->multi_ios >= 2)
 				break;
@@ -1056,7 +1088,7 @@ static int fill_multi_ios(struct hda_codec *codec,
 
 /* map DACs for all pins in the list if they are single connections */
 static bool map_singles(struct hda_codec *codec, int outs,
-			const hda_nid_t *pins, hda_nid_t *dacs)
+			const hda_nid_t *pins, hda_nid_t *dacs, int *path_idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
@@ -1077,6 +1109,7 @@ static bool map_singles(struct hda_codec *codec, int outs,
 			found = true;
 			print_nid_path("output", path);
 			path->active = true;
+			path_idx[i] = snd_hda_get_path_idx(codec, path);
 		}
 	}
 	return found;
@@ -1107,13 +1140,16 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		do {
 			mapped = map_singles(codec, cfg->line_outs,
 					     cfg->line_out_pins,
-					     spec->private_dac_nids);
+					     spec->private_dac_nids,
+					     spec->out_paths);
 			mapped |= map_singles(codec, cfg->hp_outs,
 					      cfg->hp_pins,
-					      spec->multiout.hp_out_nid);
+					      spec->multiout.hp_out_nid,
+					      spec->hp_paths);
 			mapped |= map_singles(codec, cfg->speaker_outs,
 					      cfg->speaker_pins,
-					      spec->multiout.extra_out_nid);
+					      spec->multiout.extra_out_nid,
+					      spec->speaker_paths);
 			if (fill_mio_first && cfg->line_outs == 1 &&
 			    cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
 				err = fill_multi_ios(codec, cfg->line_out_pins[0], true);
@@ -1124,7 +1160,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	}
 
 	badness += try_assign_dacs(codec, cfg->line_outs, cfg->line_out_pins,
-				   spec->private_dac_nids,
+				   spec->private_dac_nids, spec->out_paths,
 				   &main_out_badness);
 
 	/* re-count num_dacs and squash invalid entries */
@@ -1152,6 +1188,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	if (cfg->line_out_type != AUTO_PIN_HP_OUT) {
 		err = try_assign_dacs(codec, cfg->hp_outs, cfg->hp_pins,
 				      spec->multiout.hp_out_nid,
+				      spec->hp_paths,
 				      &extra_out_badness);
 		if (err < 0)
 			return err;
@@ -1161,7 +1198,8 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		err = try_assign_dacs(codec, cfg->speaker_outs,
 				      cfg->speaker_pins,
 				      spec->multiout.extra_out_nid,
-					 &extra_out_badness);
+				      spec->speaker_paths,
+				      &extra_out_badness);
 		if (err < 0)
 			return err;
 		badness += err;
@@ -1336,9 +1374,7 @@ static int parse_output_paths(struct hda_codec *codec)
 
 	if (cfg->line_out_pins[0]) {
 		struct nid_path *path;
-		path = snd_hda_get_nid_path(codec,
-					    spec->multiout.dac_nids[0],
-					    cfg->line_out_pins[0]);
+		path = snd_hda_get_path_from_idx(codec, spec->out_paths[0]);
 		if (path)
 			spec->vmaster_nid = look_for_out_vol_nid(codec, path);
 	}
@@ -1361,22 +1397,20 @@ static int create_multi_out_ctls(struct hda_codec *codec,
 	for (i = 0; i < noutputs; i++) {
 		const char *name;
 		int index;
-		hda_nid_t dac, pin;
+		hda_nid_t dac;
 		struct nid_path *path;
 
 		dac = spec->multiout.dac_nids[i];
 		if (!dac)
 			continue;
 		if (i >= cfg->line_outs) {
-			pin = spec->multi_io[i - cfg->line_outs].pin;
 			index = 0;
 			name = channel_name[i];
 		} else {
-			pin = cfg->line_out_pins[i];
 			name = get_line_out_pfx(spec, i, true, &index);
 		}
 
-		path = snd_hda_get_nid_path(codec, dac, pin);
+		path = snd_hda_get_path_from_idx(codec, spec->out_paths[i]);
 		if (!path)
 			continue;
 		if (!name || !strcmp(name, "CLFE")) {
@@ -1406,12 +1440,13 @@ static int create_multi_out_ctls(struct hda_codec *codec,
 }
 
 static int create_extra_out(struct hda_codec *codec, hda_nid_t pin,
-			    hda_nid_t dac, const char *pfx, int cidx)
+			    hda_nid_t dac, int path_idx,
+			    const char *pfx, int cidx)
 {
 	struct nid_path *path;
 	int err;
 
-	path = snd_hda_get_nid_path(codec, dac, pin);
+	path = snd_hda_get_path_from_idx(codec, path_idx);
 	if (!path)
 		return 0;
 	/* bind volume control will be created in the case of dac = 0 */
@@ -1429,7 +1464,7 @@ static int create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 /* add playback controls for speaker and HP outputs */
 static int create_extra_outs(struct hda_codec *codec, int num_pins,
 			     const hda_nid_t *pins, const hda_nid_t *dacs,
-			     const char *pfx)
+			     const int *paths, const char *pfx)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct hda_bind_ctls *ctl;
@@ -1443,7 +1478,7 @@ static int create_extra_outs(struct hda_codec *codec, int num_pins,
 		hda_nid_t dac = *dacs;
 		if (!dac)
 			dac = spec->multiout.dac_nids[0];
-		return create_extra_out(codec, *pins, dac, pfx, 0);
+		return create_extra_out(codec, *pins, dac, paths[0], pfx, 0);
 	}
 
 	for (i = 0; i < num_pins; i++) {
@@ -1453,14 +1488,16 @@ static int create_extra_outs(struct hda_codec *codec, int num_pins,
 		else
 			dac = 0;
 		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker")) {
-			err = create_extra_out(codec, pins[i], dac,
+			err = create_extra_out(codec, pins[i], dac, paths[i],
 					       "Bass Speaker", 0);
 		} else if (num_pins >= 3) {
 			snprintf(name, sizeof(name), "%s %s",
 				 pfx, channel_name[i]);
-			err = create_extra_out(codec, pins[i], dac, name, 0);
+			err = create_extra_out(codec, pins[i], dac, paths[i],
+					       name, 0);
 		} else {
-			err = create_extra_out(codec, pins[i], dac, pfx, i);
+			err = create_extra_out(codec, pins[i], dac, paths[i],
+					       pfx, i);
 		}
 		if (err < 0)
 			return err;
@@ -1478,7 +1515,7 @@ static int create_extra_outs(struct hda_codec *codec, int num_pins,
 		struct nid_path *path;
 		if (!pins[i] || !dacs[i])
 			continue;
-		path = snd_hda_get_nid_path(codec, dacs[i], pins[i]);
+		path = snd_hda_get_path_from_idx(codec, paths[i]);
 		if (!path)
 			continue;
 		vol = look_for_out_vol_nid(codec, path);
@@ -1501,6 +1538,7 @@ static int create_hp_out_ctls(struct hda_codec *codec)
 	return create_extra_outs(codec, spec->autocfg.hp_outs,
 				 spec->autocfg.hp_pins,
 				 spec->multiout.hp_out_nid,
+				 spec->hp_paths,
 				 "Headphone");
 }
 
@@ -1510,6 +1548,7 @@ static int create_speaker_out_ctls(struct hda_codec *codec)
 	return create_extra_outs(codec, spec->autocfg.speaker_outs,
 				 spec->autocfg.speaker_pins,
 				 spec->multiout.extra_out_nid,
+				 spec->speaker_paths,
 				 "Speaker");
 }
 
@@ -1613,13 +1652,21 @@ static int ch_mode_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static inline struct nid_path *
+get_multiio_path(struct hda_codec *codec, int idx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_get_path_from_idx(codec,
+		spec->out_paths[spec->autocfg.line_outs + idx]);
+}
+
 static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	hda_nid_t nid = spec->multi_io[idx].pin;
 	struct nid_path *path;
 
-	path = snd_hda_get_nid_path(codec, spec->multi_io[idx].dac, nid);
+	path = get_multiio_path(codec, idx);
 	if (!path)
 		return -EINVAL;
 
@@ -1773,8 +1820,8 @@ static void add_loopback_list(struct hda_gen_spec *spec, hda_nid_t mix, int idx)
 #endif
 
 /* create input playback/capture controls for the given pin */
-static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
-			    const char *ctlname, int ctlidx,
+static int new_analog_input(struct hda_codec *codec, int input_idx,
+			    hda_nid_t pin, const char *ctlname, int ctlidx,
 			    hda_nid_t mix_nid)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -1790,6 +1837,7 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 	if (!path)
 		return -EINVAL;
 	print_nid_path("loopback", path);
+	spec->loopback_paths[input_idx] = snd_hda_get_path_idx(codec, path);
 
 	idx = path->idx[path->depth - 1];
 	if (nid_has_volume(codec, mix_nid, HDA_INPUT)) {
@@ -1942,7 +1990,7 @@ static int create_input_ctls(struct hda_codec *codec)
 
 		if (mixer) {
 			if (is_reachable_path(codec, pin, mixer)) {
-				err = new_analog_input(codec, pin,
+				err = new_analog_input(codec, i, pin,
 						       label, type_idx, mixer);
 				if (err < 0)
 					return err;
@@ -2443,6 +2491,7 @@ static void parse_digital(struct hda_codec *codec)
 			continue;
 		print_nid_path("digout", path);
 		path->active = true;
+		spec->digout_paths[i] = snd_hda_get_path_idx(codec, path);
 		if (!nums) {
 			spec->multiout.dig_out_nid = dig_nid;
 			spec->dig_out_type = spec->autocfg.dig_out_type[0];
@@ -3573,12 +3622,12 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_build_pcms);
 
 /* configure the path from the given dac to the pin as the proper output */
 static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
-				  int pin_type, hda_nid_t dac)
+				  int pin_type, int path_idx)
 {
 	struct nid_path *path;
 
 	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
-	path = snd_hda_get_nid_path(codec, dac, pin);
+	path = snd_hda_get_path_from_idx(codec, path_idx);
 	if (!path)
 		return;
 	snd_hda_activate_path(codec, path, path->active, true);
@@ -3589,7 +3638,7 @@ static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 static void init_multi_out(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	hda_nid_t nid, dac;
+	hda_nid_t nid;
 	int pin_type;
 	int i;
 
@@ -3600,35 +3649,24 @@ static void init_multi_out(struct hda_codec *codec)
 
 	for (i = 0; i < spec->autocfg.line_outs; i++) {
 		nid = spec->autocfg.line_out_pins[i];
-		if (nid) {
-			dac = spec->multiout.dac_nids[i];
-			if (!dac)
-				dac = spec->multiout.dac_nids[0];
-			set_output_and_unmute(codec, nid, pin_type, dac);
-		}
+		if (nid)
+			set_output_and_unmute(codec, nid, pin_type,
+					      spec->out_paths[i]);
 	}
 }
 
 
 static void __init_extra_out(struct hda_codec *codec, int num_outs,
-			     hda_nid_t *pins, hda_nid_t *dacs, int type)
+			     hda_nid_t *pins, int *paths, int type)
 {
-	struct hda_gen_spec *spec = codec->spec;
 	int i;
-	hda_nid_t pin, dac;
+	hda_nid_t pin;
 
 	for (i = 0; i < num_outs; i++) {
 		pin = pins[i];
 		if (!pin)
 			break;
-		dac = dacs[i];
-		if (!dac) {
-			if (i > 0 && dacs[0])
-				dac = dacs[0];
-			else
-				dac = spec->multiout.dac_nids[0];
-		}
-		set_output_and_unmute(codec, pin, type, dac);
+		set_output_and_unmute(codec, pin, type, paths[i]);
 	}
 }
 
@@ -3640,11 +3678,11 @@ static void init_extra_out(struct hda_codec *codec)
 	if (spec->autocfg.line_out_type != AUTO_PIN_HP_OUT)
 		__init_extra_out(codec, spec->autocfg.hp_outs,
 				 spec->autocfg.hp_pins,
-				 spec->multiout.hp_out_nid, PIN_HP);
+				 spec->hp_paths, PIN_HP);
 	if (spec->autocfg.line_out_type != AUTO_PIN_SPEAKER_OUT)
 		__init_extra_out(codec, spec->autocfg.speaker_outs,
 				 spec->autocfg.speaker_pins,
-				 spec->multiout.extra_out_nid, PIN_OUT);
+				 spec->speaker_paths, PIN_OUT);
 }
 
 /* initialize multi-io paths */
@@ -3656,7 +3694,7 @@ static void init_multi_io(struct hda_codec *codec)
 	for (i = 0; i < spec->multi_ios; i++) {
 		hda_nid_t pin = spec->multi_io[i].pin;
 		struct nid_path *path;
-		path = snd_hda_get_nid_path(codec, spec->multi_io[i].dac, pin);
+		path = get_multiio_path(codec, i);
 		if (!path)
 			continue;
 		if (!spec->multi_io[i].ctl_in)
@@ -3692,7 +3730,7 @@ static void init_analog_input(struct hda_codec *codec)
 		/* init loopback inputs */
 		if (spec->mixer_nid) {
 			struct nid_path *path;
-			path = snd_hda_get_nid_path(codec, nid, spec->mixer_nid);
+			path = snd_hda_get_path_from_idx(codec, spec->loopback_paths[i]);
 			if (path)
 				snd_hda_activate_path(codec, path,
 						      path->active, false);
@@ -3744,7 +3782,8 @@ static void init_digital(struct hda_codec *codec)
 		pin = spec->autocfg.dig_out_pins[i];
 		if (!pin)
 			continue;
-		set_output_and_unmute(codec, pin, PIN_OUT, 0);
+		set_output_and_unmute(codec, pin, PIN_OUT,
+				      spec->digout_paths[i]);
 	}
 	pin = spec->autocfg.dig_in_pin;
 	if (pin)
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index f1cae2e..71d409f 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -130,6 +130,13 @@ struct hda_gen_spec {
 	/* path list */
 	struct snd_array paths;
 
+	/* path indices */
+	int out_paths[AUTO_CFG_MAX_OUTS];
+	int hp_paths[AUTO_CFG_MAX_OUTS];
+	int speaker_paths[AUTO_CFG_MAX_OUTS];
+	int digout_paths[AUTO_CFG_MAX_OUTS];
+	int loopback_paths[HDA_MAX_NUM_INPUTS];
+
 	/* auto-mic stuff */
 	int am_num_entries;
 	struct automic_entry am_entry[MAX_AUTO_MIC_PINS];
@@ -198,6 +205,8 @@ int snd_hda_gen_init(struct hda_codec *codec);
 
 struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 				      hda_nid_t from_nid, hda_nid_t to_nid);
+int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path);
+struct nid_path *snd_hda_get_path_from_idx(struct hda_codec *codec, int idx);
 
 enum {
 	HDA_PARSE_NO_AAMIX,
-- 
1.8.0.1
