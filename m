From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 009/112] ALSA: hda/realtek - Parse input paths
Date: Tue,  8 Jan 2013 12:38:02 +0100
Message-ID: <1357645185-7645-10-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DD4265167
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 214C9A51F6
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

Just like the output paths, parse the whole paths for inputs as well
and store in a path list.  For that purpose, rewrite the output parser
code to be generically usable.

The input path list is not referred at all in this patch.  It'll be
used to replace the fixed adc/capsrc array in later patches for more
flexible input path selections.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 103 ++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5b8308d..9d983a2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -101,7 +101,11 @@ enum {
 
 #define MAX_NID_PATH_DEPTH	5
 
-/* output-path: DAC -> ... -> pin
+/* Widget connection path
+ *
+ * For output, stored in the order of DAC -> ... -> pin,
+ * for input, pin -> ... -> ADC.
+ *
  * idx[i] contains the source index number to select on of the widget path[i];
  * e.g. idx[1] is the index of the DAC (path[0]) selected by path[1] widget
  * multi[] indicates whether it's a selector widget with multi-connectors
@@ -196,6 +200,9 @@ struct alc_spec {
 	/* output paths */
 	struct snd_array out_path;
 
+	/* input paths */
+	struct snd_array in_path;
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -2428,6 +2435,7 @@ static void alc_free(struct hda_codec *codec)
 	alc_free_kctls(codec);
 	alc_free_bind_ctls(codec);
 	snd_array_free(&spec->out_path);
+	snd_array_free(&spec->in_path);
 	snd_hda_gen_free(&spec->gen);
 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
@@ -2628,6 +2636,10 @@ static const char *alc_get_line_out_pfx(struct alc_spec *spec, int ch,
 	return channel_name[ch];
 }
 
+static bool parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
+			   hda_nid_t to_nid, int with_aa_mix,
+			   struct nid_path *path);
+
 #ifdef CONFIG_PM
 /* add the powersave loopback-list entry */
 static void add_loopback_list(struct alc_spec *spec, hda_nid_t mix, int idx)
@@ -2666,6 +2678,28 @@ static int new_analog_input(struct alc_spec *spec, hda_nid_t pin,
 	return 0;
 }
 
+static int new_capture_source(struct hda_codec *codec, int adc_idx,
+			      hda_nid_t pin, int idx, const char *label)
+{
+	struct alc_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->private_imux[0];
+	struct nid_path *path;
+
+	path = snd_array_new(&spec->in_path);
+	if (!path)
+		return -ENOMEM;
+	memset(path, 0, sizeof(*path));
+	if (!parse_nid_path(codec, pin, spec->adc_nids[adc_idx], 2, path)) {
+		snd_printd(KERN_ERR "invalid input path 0x%x -> 0x%x\n",
+			   pin, spec->adc_nids[adc_idx]);
+		return -EINVAL;
+	}
+
+	spec->imux_pins[imux->num_items] = pin;
+	snd_hda_add_imux_item(imux, label, idx, NULL);
+	return 0;
+}
+
 static int alc_is_input_pin(struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int pincap = snd_hda_query_pin_caps(codec, nid);
@@ -2767,8 +2801,9 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 			hda_nid_t cap = get_capsrc(spec, c);
 			idx = get_connection_index(codec, cap, pin);
 			if (idx >= 0) {
-				spec->imux_pins[imux->num_items] = pin;
-				snd_hda_add_imux_item(imux, label, idx, NULL);
+				err = new_capture_source(codec, c, pin, idx, label);
+				if (err < 0)
+					return err;
 				break;
 			}
 		}
@@ -2897,40 +2932,45 @@ static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 }
 
 /* called recursively */
-static bool __parse_output_path(struct hda_codec *codec, hda_nid_t nid,
-				hda_nid_t target_dac, int with_aa_mix,
-				struct nid_path *path, int depth)
+static bool __parse_nid_path(struct hda_codec *codec,
+			     hda_nid_t from_nid, hda_nid_t to_nid,
+			     int with_aa_mix, struct nid_path *path, int depth)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t conn[8];
+	hda_nid_t conn[16];
 	int i, nums;
 
-	if (nid == spec->mixer_nid) {
+	if (to_nid == spec->mixer_nid) {
 		if (!with_aa_mix)
 			return false;
 		with_aa_mix = 2; /* mark aa-mix is included */
 	}
 
-	nums = snd_hda_get_connections(codec, nid, conn, ARRAY_SIZE(conn));
+	nums = snd_hda_get_connections(codec, to_nid, conn, ARRAY_SIZE(conn));
 	for (i = 0; i < nums; i++) {
-		if (get_wcaps_type(get_wcaps(codec, conn[i])) != AC_WID_AUD_OUT)
-			continue;
-		if (conn[i] == target_dac ||
-		    (!target_dac && !alc_is_dac_already_used(codec, conn[i]))) {
-			/* aa-mix is requested but not included? */
-			if (!(spec->mixer_nid && with_aa_mix == 1))
-				goto found;
+		if (conn[i] != from_nid) {
+			/* special case: when from_nid is 0,
+			 * try to find an empty DAC
+			 */
+			if (from_nid ||
+			    get_wcaps_type(get_wcaps(codec, conn[i])) != AC_WID_AUD_OUT ||
+			    alc_is_dac_already_used(codec, conn[i]))
+				continue;
 		}
+		/* aa-mix is requested but not included? */
+		if (!(spec->mixer_nid && with_aa_mix == 1))
+			goto found;
 	}
 	if (depth >= MAX_NID_PATH_DEPTH)
 		return false;
 	for (i = 0; i < nums; i++) {
 		unsigned int type;
 		type = get_wcaps_type(get_wcaps(codec, conn[i]));
-		if (type == AC_WID_AUD_OUT)
+		if (type == AC_WID_AUD_OUT || type == AC_WID_AUD_IN ||
+		    type == AC_WID_PIN)
 			continue;
-		if (__parse_output_path(codec, conn[i], target_dac,
-					with_aa_mix, path, depth + 1))
+		if (__parse_nid_path(codec, from_nid, conn[i],
+				     with_aa_mix, path, depth + 1))
 			goto found;
 	}
 	return false;
@@ -2938,25 +2978,27 @@ static bool __parse_output_path(struct hda_codec *codec, hda_nid_t nid,
  found:
 	path->path[path->depth] = conn[i];
 	path->idx[path->depth + 1] = i;
-	if (nums > 1 && get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_MIX)
+	if (nums > 1 && get_wcaps_type(get_wcaps(codec, to_nid)) != AC_WID_AUD_MIX)
 		path->multi[path->depth + 1] = 1;
 	path->depth++;
 	return true;
 }
 
-/* parse the output path from the given nid to the target DAC;
- * when target_dac is 0, try to find an empty DAC;
- * when with_aa_mix is 0, paths with spec->mixer_nid are excluded
+/* parse the widget path from the given nid to the target nid;
+ * when @from_nid is 0, try to find an empty DAC;
+ * when @with_aa_mix is 0, paths with spec->mixer_nid are excluded.
+ * when @with_aa_mix is 1, paths without spec->mixer_nid are excluded.
+ * when @with_aa_mix is 2, no special handling about spec->mixer_nid.
  */
-static bool parse_output_path(struct hda_codec *codec, hda_nid_t nid,
-			      hda_nid_t target_dac, int with_aa_mix,
-			      struct nid_path *path)
+static bool parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
+			   hda_nid_t to_nid, int with_aa_mix,
+			   struct nid_path *path)
 {
-	if (__parse_output_path(codec, nid, target_dac, with_aa_mix, path, 1)) {
-		path->path[path->depth] = nid;
+	if (__parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path, 1)) {
+		path->path[path->depth] = to_nid;
 		path->depth++;
 #if 0
-		snd_printdd("output-path: depth=%d, %02x/%02x/%02x/%02x/%02x\n",
+		snd_printdd("path: depth=%d, %02x/%02x/%02x/%02x/%02x\n",
 			    path->depth, path->path[0], path->path[1],
 			    path->path[2], path->path[3], path->path[4]);
 #endif
@@ -3034,7 +3076,7 @@ static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
 	if (!path)
 		return false;
 	memset(path, 0, sizeof(*path));
-	if (parse_output_path(codec, pin, dac, 0, path))
+	if (parse_nid_path(codec, dac, pin, 0, path))
 		return true;
 	/* push back */
 	spec->out_path.used--;
@@ -4529,6 +4571,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
 	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
 	snd_array_init(&spec->out_path, sizeof(struct nid_path), 8);
+	snd_array_init(&spec->in_path, sizeof(struct nid_path), 8);
 
 	err = alc_codec_rename_from_preset(codec);
 	if (err < 0) {
-- 
1.8.0.1
