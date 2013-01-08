From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 110/112] ALSA: hda - Re-define
	snd_hda_parse_nid_path()
Date: Tue,  8 Jan 2013 12:39:43 +0100
Message-ID: <1357645185-7645-111-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 72520265239
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 198F5A5464
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
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

This commit modifies the definition of snd_hda_parse_nid_path()
slightly, now with_aa_mix argument is changed to anchor_nid, so that
it can handle any NID generically as an anchor point to include or
exclude.

The with_aa_mix field in struct nid_path is removed again by this
change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 102 ++++++++++++++++++++++++--------------------
 sound/pci/hda/hda_generic.h |  12 +-----
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f04a568..ba88be2 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -87,9 +87,25 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_spec_free);
  * parsing paths
  */
 
+/* return the position of NID in the list, or -1 if not found */
+static int find_idx_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
+{
+	int i;
+	for (i = 0; i < nums; i++)
+		if (list[i] == nid)
+			return i;
+	return -1;
+}
+
+/* return true if the given NID is contained in the path */
+static bool is_nid_contained(struct nid_path *path, hda_nid_t nid)
+{
+	return find_idx_in_nid_list(nid, path->path, path->depth) >= 0;
+}
+
 static struct nid_path *get_nid_path(struct hda_codec *codec,
 				     hda_nid_t from_nid, hda_nid_t to_nid,
-				     int with_aa_mix)
+				     int anchor_nid)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
@@ -100,8 +116,9 @@ static struct nid_path *get_nid_path(struct hda_codec *codec,
 			continue;
 		if ((!from_nid || path->path[0] == from_nid) &&
 		    (!to_nid || path->path[path->depth - 1] == to_nid)) {
-			if (with_aa_mix == HDA_PARSE_ALL ||
-			    path->with_aa_mix == with_aa_mix)
+			if (!anchor_nid ||
+			    (anchor_nid > 0 && is_nid_contained(path, anchor_nid)) ||
+			    (anchor_nid < 0 && !is_nid_contained(path, anchor_nid)))
 				return path;
 		}
 	}
@@ -114,7 +131,7 @@ static struct nid_path *get_nid_path(struct hda_codec *codec,
 struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 				      hda_nid_t from_nid, hda_nid_t to_nid)
 {
-	return get_nid_path(codec, from_nid, to_nid, HDA_PARSE_ALL);
+	return get_nid_path(codec, from_nid, to_nid, 0);
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_nid_path);
 
@@ -213,17 +230,16 @@ static void print_nid_path(const char *pfx, struct nid_path *path)
 /* called recursively */
 static bool __parse_nid_path(struct hda_codec *codec,
 			     hda_nid_t from_nid, hda_nid_t to_nid,
-			     int with_aa_mix, struct nid_path *path, int depth)
+			     int anchor_nid, struct nid_path *path,
+			     int depth)
 {
-	struct hda_gen_spec *spec = codec->spec;
 	const hda_nid_t *conn;
 	int i, nums;
 
-	if (to_nid == spec->mixer_nid) {
-		if (with_aa_mix == HDA_PARSE_NO_AAMIX)
-			return false;
-		with_aa_mix = HDA_PARSE_ALL; /* mark aa-mix is included */
-	}
+	if (to_nid == anchor_nid)
+		anchor_nid = 0; /* anchor passed */
+	else if (to_nid == (hda_nid_t)(-anchor_nid))
+		return false; /* hit the exclusive nid */
 
 	nums = snd_hda_get_conn_list(codec, to_nid, &conn);
 	for (i = 0; i < nums; i++) {
@@ -236,8 +252,8 @@ static bool __parse_nid_path(struct hda_codec *codec,
 			    is_dac_already_used(codec, conn[i]))
 				continue;
 		}
-		/* aa-mix is requested but not included? */
-		if (!(spec->mixer_nid && with_aa_mix == HDA_PARSE_ONLY_AAMIX))
+		/* anchor is not requested or already passed? */
+		if (anchor_nid <= 0)
 			goto found;
 	}
 	if (depth >= MAX_NID_PATH_DEPTH)
@@ -249,15 +265,13 @@ static bool __parse_nid_path(struct hda_codec *codec,
 		    type == AC_WID_PIN)
 			continue;
 		if (__parse_nid_path(codec, from_nid, conn[i],
-				     with_aa_mix, path, depth + 1))
+				     anchor_nid, path, depth + 1))
 			goto found;
 	}
 	return false;
 
  found:
 	path->path[path->depth] = conn[i];
-	if (conn[i] == spec->mixer_nid)
-		path->with_aa_mix = true;
 	path->idx[path->depth + 1] = i;
 	if (nums > 1 && get_wcaps_type(get_wcaps(codec, to_nid)) != AC_WID_AUD_MIX)
 		path->multi[path->depth + 1] = 1;
@@ -267,17 +281,17 @@ static bool __parse_nid_path(struct hda_codec *codec,
 
 /* parse the widget path from the given nid to the target nid;
  * when @from_nid is 0, try to find an empty DAC;
- * when @with_aa_mix is HDA_PARSE_NO_AAMIX, paths with spec->mixer_nid are
- * excluded, only the paths that don't go through the mixer will be chosen.
- * when @with_aa_mix is HDA_PARSE_ONLY_AAMIX, only the paths going through
- * spec->mixer_nid will be chosen.
- * when @with_aa_mix is HDA_PARSE_ALL, no special handling about mixer widget.
+ * when @anchor_nid is set to a positive value, only paths through the widget
+ * with the given value are evaluated.
+ * when @anchor_nid is set to a negative value, paths through the widget
+ * with the negative of given value are excluded, only other paths are chosen.
+ * when @anchor_nid is zero, no special handling about path selection.
  */
 bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
-			    hda_nid_t to_nid, int with_aa_mix,
+			    hda_nid_t to_nid, int anchor_nid,
 			    struct nid_path *path)
 {
-	if (__parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path, 1)) {
+	if (__parse_nid_path(codec, from_nid, to_nid, anchor_nid, path, 1)) {
 		path->path[path->depth] = to_nid;
 		path->depth++;
 		return true;
@@ -292,7 +306,7 @@ EXPORT_SYMBOL_HDA(snd_hda_parse_nid_path);
  */
 struct nid_path *
 snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
-		     hda_nid_t to_nid, int with_aa_mix)
+		     hda_nid_t to_nid, int anchor_nid)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
@@ -301,7 +315,7 @@ snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
 		return NULL;
 
 	/* check whether the path has been already added */
-	path = get_nid_path(codec, from_nid, to_nid, with_aa_mix);
+	path = get_nid_path(codec, from_nid, to_nid, anchor_nid);
 	if (path)
 		return path;
 
@@ -309,7 +323,7 @@ snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
 	if (!path)
 		return NULL;
 	memset(path, 0, sizeof(*path));
-	if (snd_hda_parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path))
+	if (snd_hda_parse_nid_path(codec, from_nid, to_nid, anchor_nid, path))
 		return path;
 	/* push back */
 	spec->paths.used--;
@@ -909,10 +923,10 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			else
 				badness += bad->no_dac;
 		}
-		path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_NO_AAMIX);
+		path = snd_hda_add_new_path(codec, dac, pin, -spec->mixer_nid);
 		if (!path && !i && spec->mixer_nid) {
 			/* try with aamix */
-			path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_ALL);
+			path = snd_hda_add_new_path(codec, dac, pin, 0);
 		}
 		if (!path)
 			dac = dacs[i] = 0;
@@ -1038,7 +1052,8 @@ static int fill_multi_ios(struct hda_codec *codec,
 				badness++;
 				continue;
 			}
-			path = snd_hda_add_new_path(codec, dac, nid, HDA_PARSE_NO_AAMIX);
+			path = snd_hda_add_new_path(codec, dac, nid,
+						    -spec->mixer_nid);
 			if (!path) {
 				badness++;
 				continue;
@@ -1093,9 +1108,10 @@ static bool map_singles(struct hda_codec *codec, int outs,
 		dac = get_dac_if_single(codec, pins[i]);
 		if (!dac)
 			continue;
-		path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_NO_AAMIX);
+		path = snd_hda_add_new_path(codec, dac, pins[i],
+					    -spec->mixer_nid);
 		if (!path && !i && spec->mixer_nid)
-			path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_ALL);
+			path = snd_hda_add_new_path(codec, dac, pins[i], 0);
 		if (path) {
 			dacs[i] = dac;
 			found = true;
@@ -1110,14 +1126,16 @@ static bool map_singles(struct hda_codec *codec, int outs,
 /* create a new path including aamix if available, and return its index */
 static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
 
 	path = snd_hda_get_path_from_idx(codec, path_idx);
-	if (!path || !path->depth || path->with_aa_mix)
+	if (!path || !path->depth ||
+	    is_nid_contained(path, spec->mixer_nid))
 		return 0;
 	path = snd_hda_add_new_path(codec, path->path[0],
 				    path->path[path->depth - 1],
-				    HDA_PARSE_ONLY_AAMIX);
+				    spec->mixer_nid);
 	if (!path)
 		return 0;
 	print_nid_path("output-aamix", path);
@@ -1917,7 +1935,7 @@ static int new_analog_input(struct hda_codec *codec, int input_idx,
 	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
 		return 0; /* no need for analog loopback */
 
-	path = snd_hda_add_new_path(codec, pin, mix_nid, HDA_PARSE_ALL);
+	path = snd_hda_add_new_path(codec, pin, mix_nid, 0);
 	if (!path)
 		return -EINVAL;
 	print_nid_path("loopback", path);
@@ -2090,7 +2108,7 @@ static int create_input_ctls(struct hda_codec *codec)
 
 			if (!is_reachable_path(codec, pin, adc))
 				continue;
-			path = snd_hda_add_new_path(codec, pin, adc, HDA_PARSE_ALL);
+			path = snd_hda_add_new_path(codec, pin, adc, 0);
 			if (!path) {
 				snd_printd(KERN_ERR
 					   "invalid input path 0x%x -> 0x%x\n",
@@ -2565,7 +2583,7 @@ static void parse_digital(struct hda_codec *codec)
 		dig_nid = look_for_dac(codec, pin, true);
 		if (!dig_nid)
 			continue;
-		path = snd_hda_add_new_path(codec, dig_nid, pin, HDA_PARSE_ALL);
+		path = snd_hda_add_new_path(codec, dig_nid, pin, 0);
 		if (!path)
 			continue;
 		print_nid_path("digout", path);
@@ -2593,7 +2611,7 @@ static void parse_digital(struct hda_codec *codec)
 				continue;
 			path = snd_hda_add_new_path(codec,
 						    spec->autocfg.dig_in_pin,
-						    dig_nid, HDA_PARSE_ALL);
+						    dig_nid, 0);
 			if (path) {
 				print_nid_path("digin", path);
 				path->active = true;
@@ -2969,16 +2987,6 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 	return 0;
 }
 
-/* return the position of NID in the list, or -1 if not found */
-static int find_idx_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
-{
-	int i;
-	for (i = 0; i < nums; i++)
-		if (list[i] == nid)
-			return i;
-	return -1;
-}
-
 /* check whether all auto-mic pins are valid; setup indices if OK */
 static bool auto_mic_check_imux(struct hda_codec *codec)
 {
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 1ad9127..343195c 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -53,7 +53,6 @@ struct nid_path {
 	unsigned char multi[MAX_NID_PATH_DEPTH];
 	unsigned int ctls[NID_PATH_NUM_CTLS]; /* NID_PATH_XXX_CTL */
 	bool active;
-	bool with_aa_mix;
 };
 
 /* mic/line-in auto switching entry */
@@ -237,19 +236,12 @@ struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 				      hda_nid_t from_nid, hda_nid_t to_nid);
 int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path);
 struct nid_path *snd_hda_get_path_from_idx(struct hda_codec *codec, int idx);
-
-enum {
-	HDA_PARSE_NO_AAMIX,
-	HDA_PARSE_ONLY_AAMIX,
-	HDA_PARSE_ALL,
-};
-
 bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
-			    hda_nid_t to_nid, int with_aa_mix,
+			    hda_nid_t to_nid, int anchor_nid,
 			    struct nid_path *path);
 struct nid_path *
 snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
-		     hda_nid_t to_nid, int with_aa_mix);
+		     hda_nid_t to_nid, int anchor_nid);
 void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 			   bool enable, bool add_aamix);
 
-- 
1.8.0.1
