From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 003/112] ALSA: hda/realtek - Add output path
	parser
Date: Tue,  8 Jan 2013 12:37:56 +0100
Message-ID: <1357645185-7645-4-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 30FFE2615D7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0A1C5A51C9
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

Add the output path parser to Realtek codec driver as we already have
in patch_via.c.  The nid_path struct represents the complete output
path from a DAC to a pin.  The alc_spec contains an array of these
paths, and a new path is added at each time when a new DAC is
assigned.

So far, this path list is used only in limited codes: namely in this
patch, only alc_is_dac_already_used() checks the list instead of dac
arrays in all possible outputs.  In the later development, the path
list will be referred from more places, such as the mixer control
assignment / check, the mute/unmute of active routes, etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 139 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 50e079f..9e0516d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -99,6 +99,23 @@ enum {
 #define ALC_FIXUP_ACT_BUILD	HDA_FIXUP_ACT_BUILD
 
 
+#define MAX_NID_PATH_DEPTH	5
+
+/* output-path: DAC -> ... -> pin
+ * idx[] contains the source index number of the next widget;
+ * e.g. idx[0] is the index of the DAC selected by path[1] widget
+ * multi[] indicates whether it's a selector widget with multi-connectors
+ * (i.e. the connection selection is mandatory)
+ * vol_ctl and mute_ctl contains the NIDs for the assigned mixers
+ */
+struct nid_path {
+	int depth;
+	hda_nid_t path[MAX_NID_PATH_DEPTH];
+	unsigned char idx[MAX_NID_PATH_DEPTH];
+	unsigned char multi[MAX_NID_PATH_DEPTH];
+	unsigned int ctls[2]; /* 0 = volume, 1 = mute */
+};
+
 struct alc_spec {
 	struct hda_gen_spec gen;
 
@@ -176,6 +193,9 @@ struct alc_spec {
 	int num_all_dacs;
 	hda_nid_t all_dacs[16];
 
+	/* output paths */
+	struct snd_array out_path;
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -2407,6 +2427,7 @@ static void alc_free(struct hda_codec *codec)
 
 	alc_free_kctls(codec);
 	alc_free_bind_ctls(codec);
+	snd_array_free(&spec->out_path);
 	snd_hda_gen_free(&spec->gen);
 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
@@ -2906,15 +2927,10 @@ static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct alc_spec *spec = codec->spec;
 	int i;
-	if (found_in_nid_list(nid, spec->multiout.dac_nids,
-			      ARRAY_SIZE(spec->private_dac_nids)) ||
-	    found_in_nid_list(nid, spec->multiout.hp_out_nid,
-			      ARRAY_SIZE(spec->multiout.hp_out_nid)) ||
-	    found_in_nid_list(nid, spec->multiout.extra_out_nid,
-			      ARRAY_SIZE(spec->multiout.extra_out_nid)))
-		return true;
-	for (i = 0; i < spec->multi_ios; i++) {
-		if (spec->multi_io[i].dac == nid)
+
+	for (i = 0; i < spec->out_path.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+		if (path->path[0] == nid)
 			return true;
 	}
 	return false;
@@ -2945,6 +2961,75 @@ static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 	return 0;
 }
 
+/* called recursively */
+static bool __parse_output_path(struct hda_codec *codec, hda_nid_t nid,
+				hda_nid_t target_dac, int with_aa_mix,
+				struct nid_path *path, int depth)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t conn[8];
+	int i, nums;
+
+	if (nid == spec->mixer_nid) {
+		if (!with_aa_mix)
+			return false;
+		with_aa_mix = 2; /* mark aa-mix is included */
+	}
+
+	nums = snd_hda_get_connections(codec, nid, conn, ARRAY_SIZE(conn));
+	for (i = 0; i < nums; i++) {
+		if (get_wcaps_type(get_wcaps(codec, conn[i])) != AC_WID_AUD_OUT)
+			continue;
+		if (conn[i] == target_dac ||
+		    (!target_dac && !alc_is_dac_already_used(codec, conn[i]))) {
+			/* aa-mix is requested but not included? */
+			if (!(spec->mixer_nid && with_aa_mix == 1))
+				goto found;
+		}
+	}
+	if (depth >= MAX_NID_PATH_DEPTH)
+		return false;
+	for (i = 0; i < nums; i++) {
+		unsigned int type;
+		type = get_wcaps_type(get_wcaps(codec, conn[i]));
+		if (type == AC_WID_AUD_OUT)
+			continue;
+		if (__parse_output_path(codec, conn[i], target_dac,
+					with_aa_mix, path, depth + 1))
+			goto found;
+	}
+	return false;
+
+ found:
+	path->path[path->depth] = conn[i];
+	path->idx[path->depth] = i;
+	if (nums > 1 && get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_MIX)
+		path->multi[path->depth] = 1;
+	path->depth++;
+	return true;
+}
+
+/* parse the output path from the given nid to the target DAC;
+ * when target_dac is 0, try to find an empty DAC;
+ * when with_aa_mix is 0, paths with spec->mixer_nid are excluded
+ */
+static bool parse_output_path(struct hda_codec *codec, hda_nid_t nid,
+			      hda_nid_t target_dac, int with_aa_mix,
+			      struct nid_path *path)
+{
+	if (__parse_output_path(codec, nid, target_dac, with_aa_mix, path, 1)) {
+		path->path[path->depth] = nid;
+		path->depth++;
+#if 0
+		snd_printdd("output-path: depth=%d, %02x/%02x/%02x/%02x/%02x\n",
+			    path->depth, path->path[0], path->path[1],
+			    path->path[2], path->path[3], path->path[4]);
+#endif
+		return true;
+	}
+	return false;
+}
+
 static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 {
 	struct alc_spec *spec = codec->spec;
@@ -3016,6 +3101,23 @@ static hda_nid_t alc_look_for_out_mute_nid(struct hda_codec *codec,
 static hda_nid_t alc_look_for_out_vol_nid(struct hda_codec *codec,
 					  hda_nid_t pin, hda_nid_t dac);
 
+static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
+			     hda_nid_t dac)
+{
+	struct alc_spec *spec = codec->spec;
+	struct nid_path *path;
+
+	path = snd_array_new(&spec->out_path);
+	if (!path)
+		return false;
+	memset(path, 0, sizeof(*path));
+	if (parse_output_path(codec, pin, dac, 0, path))
+		return true;
+	/* push back */
+	spec->out_path.used--;
+	return false;
+}
+
 static int eval_shared_vol_badness(struct hda_codec *codec, hda_nid_t pin,
 				   hda_nid_t dac)
 {
@@ -3127,6 +3229,8 @@ static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
 			else
 				badness += bad->no_dac;
 		}
+		if (!add_new_out_path(codec, pin, dac))
+			dac = dacs[i] = 0;
 		if (dac)
 			badness += eval_shared_vol_badness(codec, pin, dac);
 	}
@@ -3144,11 +3248,16 @@ static bool alc_map_singles(struct hda_codec *codec, int outs,
 	int i;
 	bool found = false;
 	for (i = 0; i < outs; i++) {
+		hda_nid_t dac;
 		if (dacs[i])
 			continue;
-		dacs[i] = get_dac_if_single(codec, pins[i]);
-		if (dacs[i])
+		dac = get_dac_if_single(codec, pins[i]);
+		if (!dac)
+			continue;
+		if (add_new_out_path(codec, pins[i], dac)) {
+			dacs[i] = dac;
 			found = true;
+		}
 	}
 	return found;
 }
@@ -3169,6 +3278,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	memset(spec->multiout.hp_out_nid, 0, sizeof(spec->multiout.hp_out_nid));
 	memset(spec->multiout.extra_out_nid, 0, sizeof(spec->multiout.extra_out_nid));
 	spec->multi_ios = 0;
+	snd_array_free(&spec->out_path);
 	clear_vol_marks(codec);
 	badness = 0;
 
@@ -3882,6 +3992,10 @@ static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 				badness++;
 				continue;
 			}
+			if (!add_new_out_path(codec, nid, dac)) {
+				badness++;
+				continue;
+			}
 			spec->multi_io[spec->multi_ios].pin = nid;
 			spec->multi_io[spec->multi_ios].dac = dac;
 			spec->multi_ios++;
@@ -3899,6 +4013,8 @@ static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 			return badness; /* no badness if nothing found */
 	}
 	if (!hardwired && spec->multi_ios < 2) {
+		/* cancel newly assigned paths */
+		spec->out_path.used -= spec->multi_ios - old_pins;
 		spec->multi_ios = old_pins;
 		return badness;
 	}
@@ -4388,6 +4504,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	snd_hda_gen_init(&spec->gen);
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
 	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
+	snd_array_init(&spec->out_path, sizeof(struct nid_path), 8);
 
 	err = alc_codec_rename_from_preset(codec);
 	if (err < 0) {
-- 
1.8.0.1
