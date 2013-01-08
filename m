From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 075/112] ALSA: hda - Add more debug prints
	about new paths
Date: Tue,  8 Jan 2013 12:39:08 +0100
Message-ID: <1357645185-7645-76-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F7D826520A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7D427A5336
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

Add a better debug print code to show the new assigned paths in
generic parser.  It appears only with CONFIG_SND_DEBUG_VERBOSE=y.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 46 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 43acf3d..8af5324 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -186,6 +186,21 @@ static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
 		is_ctl_used(codec, val, NID_PATH_MUTE_CTL);
 }
 
+static void print_nid_path(const char *pfx, struct nid_path *path)
+{
+	char buf[40];
+	int i;
+
+
+	buf[0] = 0;
+	for (i = 0; i < path->depth; i++) {
+		char tmp[4];
+		sprintf(tmp, ":%02x", path->path[i]);
+		strlcat(buf, tmp, sizeof(buf));
+	}
+	snd_printdd("%s path: depth=%d %s\n", pfx, path->depth, buf);
+}
+
 /* called recursively */
 static bool __parse_nid_path(struct hda_codec *codec,
 			     hda_nid_t from_nid, hda_nid_t to_nid,
@@ -252,11 +267,6 @@ bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
 	if (__parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path, 1)) {
 		path->path[path->depth] = to_nid;
 		path->depth++;
-#if 0
-		snd_printdd("path: depth=%d, %02x/%02x/%02x/%02x/%02x\n",
-			    path->depth, path->path[0], path->path[1],
-			    path->path[2], path->path[3], path->path[4]);
-#endif
 		return true;
 	}
 	return false;
@@ -816,6 +826,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		return 0;
 
 	for (i = 0; i < num_outs; i++) {
+		struct nid_path *path;
 		hda_nid_t pin = pins[i];
 		if (!dacs[i])
 			dacs[i] = look_for_dac(codec, pin, false);
@@ -850,8 +861,11 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			else
 				badness += bad->no_dac;
 		}
-		if (!snd_hda_add_new_path(codec, dac, pin, 0))
+		path = snd_hda_add_new_path(codec, dac, pin, 0);
+		if (!path)
 			dac = dacs[i] = 0;
+		else
+			print_nid_path("output", path);
 		if (dac)
 			badness += assign_out_path_ctls(codec, pin, dac);
 	}
@@ -935,6 +949,7 @@ static int fill_multi_ios(struct hda_codec *codec,
 	dacs = spec->multiout.num_dacs;
 	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
 		for (i = 0; i < cfg->num_inputs; i++) {
+			struct nid_path *path;
 			hda_nid_t nid = cfg->inputs[i].pin;
 			hda_nid_t dac = 0;
 
@@ -962,10 +977,12 @@ static int fill_multi_ios(struct hda_codec *codec,
 				badness++;
 				continue;
 			}
-			if (!snd_hda_add_new_path(codec, dac, nid, 0)) {
+			path = snd_hda_add_new_path(codec, dac, nid, 0);
+			if (!path) {
 				badness++;
 				continue;
 			}
+			print_nid_path("multiio", path);
 			spec->multi_io[spec->multi_ios].pin = nid;
 			spec->multi_io[spec->multi_ios].dac = dac;
 			spec->multi_ios++;
@@ -1004,15 +1021,18 @@ static bool map_singles(struct hda_codec *codec, int outs,
 	int i;
 	bool found = false;
 	for (i = 0; i < outs; i++) {
+		struct nid_path *path;
 		hda_nid_t dac;
 		if (dacs[i])
 			continue;
 		dac = get_dac_if_single(codec, pins[i]);
 		if (!dac)
 			continue;
-		if (snd_hda_add_new_path(codec, dac, pins[i], 0)) {
+		path = snd_hda_add_new_path(codec, dac, pins[i], 0);
+		if (path) {
 			dacs[i] = dac;
 			found = true;
+			print_nid_path("output", path);
 		}
 	}
 	return found;
@@ -1268,6 +1288,7 @@ static int parse_output_paths(struct hda_codec *codec)
 	}
 
 	if (badness) {
+		debug_badness("==> restoring best_cfg\n");
 		*cfg = *best_cfg;
 		fill_and_eval_dacs(codec, best_wired, best_mio);
 	}
@@ -1659,6 +1680,7 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 	path = snd_hda_add_new_path(codec, pin, mix_nid, 2);
 	if (!path)
 		return -EINVAL;
+	print_nid_path("loopback", path);
 
 	idx = path->idx[path->depth - 1];
 	if (nid_has_volume(codec, mix_nid, HDA_INPUT)) {
@@ -1836,6 +1858,7 @@ static int create_input_ctls(struct hda_codec *codec)
 				spec->paths.used--;
 				continue;
 			}
+			print_nid_path("input", path);
 
 			if (!imux_added) {
 				spec->imux_pins[imux->num_items] = pin;
@@ -2295,6 +2318,7 @@ static int parse_mic_boost(struct hda_codec *codec)
 static void parse_digital(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *path;
 	int i, nums;
 	hda_nid_t dig_nid;
 
@@ -2305,8 +2329,10 @@ static void parse_digital(struct hda_codec *codec)
 		dig_nid = look_for_dac(codec, pin, true);
 		if (!dig_nid)
 			continue;
-		if (!snd_hda_add_new_path(codec, dig_nid, pin, 2))
+		path = snd_hda_add_new_path(codec, dig_nid, pin, 2);
+		if (!path)
 			continue;
+		print_nid_path("digout", path);
 		if (!nums) {
 			spec->multiout.dig_out_nid = dig_nid;
 			spec->dig_out_type = spec->autocfg.dig_out_type[0];
@@ -2322,7 +2348,6 @@ static void parse_digital(struct hda_codec *codec)
 	if (spec->autocfg.dig_in_pin) {
 		dig_nid = codec->start_nid;
 		for (i = 0; i < codec->num_nodes; i++, dig_nid++) {
-			struct nid_path *path;
 			unsigned int wcaps = get_wcaps(codec, dig_nid);
 			if (get_wcaps_type(wcaps) != AC_WID_AUD_IN)
 				continue;
@@ -2332,6 +2357,7 @@ static void parse_digital(struct hda_codec *codec)
 						    spec->autocfg.dig_in_pin,
 						    dig_nid, 2);
 			if (path) {
+				print_nid_path("digin", path);
 				path->active = true;
 				spec->dig_in_nid = dig_nid;
 				break;
-- 
1.8.0.1
