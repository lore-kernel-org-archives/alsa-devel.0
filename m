From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 030/112] ALSA: hda/realtek - Rename
	add_new_out_path() with add_new_nid_path()
Date: Tue,  8 Jan 2013 12:38:23 +0100
Message-ID: <1357645185-7645-31-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C102651B0
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 98F8FA522A
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

Make the function more generic for both input and output directions,
and returns the assigned path pointer.  The argument order is changed
to follow the standard (from, to) way.

Now this new function is used for analog input and loopback path
parser codes, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b1222cc..a8febe4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1342,8 +1342,12 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 					   hda_nid_t dac);
 static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin,
 				       bool is_digital);
-static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
-			     hda_nid_t dac);
+static bool parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
+			   hda_nid_t to_nid, int with_aa_mix,
+			   struct nid_path *path);
+static struct nid_path *add_new_nid_path(struct hda_codec *codec,
+					 hda_nid_t from_nid, hda_nid_t to_nid,
+					 int with_aa_mix);
 
 /*
  * Digital I/O handling
@@ -1371,7 +1375,7 @@ static void alc_auto_init_digital(struct hda_codec *codec)
 static void alc_auto_parse_digital(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	int i, err, nums;
+	int i, nums;
 	hda_nid_t dig_nid;
 
 	/* support multiple SPDIFs; the secondary is set up as a slave */
@@ -1381,6 +1385,8 @@ static void alc_auto_parse_digital(struct hda_codec *codec)
 		dig_nid = alc_auto_look_for_dac(codec, pin, true);
 		if (!dig_nid)
 			continue;
+		if (!add_new_nid_path(codec, dig_nid, pin, 2))
+			continue;
 		if (!nums) {
 			spec->multiout.dig_out_nid = dig_nid;
 			spec->dig_out_type = spec->autocfg.dig_out_type[0];
@@ -1390,7 +1396,6 @@ static void alc_auto_parse_digital(struct hda_codec *codec)
 				break;
 			spec->slave_dig_outs[nums - 1] = dig_nid;
 		}
-		add_new_out_path(codec, pin, dig_nid);
 		nums++;
 	}
 
@@ -1404,8 +1409,6 @@ static void alc_auto_parse_digital(struct hda_codec *codec)
 				continue;
 			if (!(wcaps & AC_WCAP_CONN_LIST))
 				continue;
-			err = get_connection_index(codec, dig_nid,
-						   spec->autocfg.dig_in_pin);
 			if (err >= 0) {
 				spec->dig_in_nid = dig_nid;
 				break;
@@ -2343,10 +2346,6 @@ static const char *alc_get_line_out_pfx(struct alc_spec *spec, int ch,
 	return channel_name[ch];
 }
 
-static bool parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
-			   hda_nid_t to_nid, int with_aa_mix,
-			   struct nid_path *path);
-
 #ifdef CONFIG_PM
 /* add the powersave loopback-list entry */
 static void add_loopback_list(struct alc_spec *spec, hda_nid_t mix, int idx)
@@ -2380,11 +2379,8 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
 		return 0; /* no need for analog loopback */
 
-	path = snd_array_new(&spec->paths);
+	path = add_new_nid_path(codec, pin, mix_nid, 2);
 	if (!path)
-		return -ENOMEM;
-	memset(path, 0, sizeof(*path));
-	if (!parse_nid_path(codec, pin, mix_nid, 2, path))
 		return -EINVAL;
 
 	idx = path->idx[path->depth - 1];
@@ -2937,21 +2933,25 @@ static hda_nid_t alc_look_for_out_mute_nid(struct hda_codec *codec,
 static hda_nid_t alc_look_for_out_vol_nid(struct hda_codec *codec,
 					  struct nid_path *path);
 
-static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
-			     hda_nid_t dac)
+static struct nid_path *add_new_nid_path(struct hda_codec *codec,
+					 hda_nid_t from_nid, hda_nid_t to_nid,
+					 int with_aa_mix)
 {
 	struct alc_spec *spec = codec->spec;
 	struct nid_path *path;
 
+	if (from_nid && to_nid && !is_reachable_path(codec, from_nid, to_nid))
+		return NULL;
+
 	path = snd_array_new(&spec->paths);
 	if (!path)
-		return false;
+		return NULL;
 	memset(path, 0, sizeof(*path));
-	if (parse_nid_path(codec, dac, pin, 0, path))
-		return true;
+	if (parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path))
+		return path;
 	/* push back */
 	spec->paths.used--;
-	return false;
+	return NULL;
 }
 
 /* get the path between the given NIDs;
@@ -3093,7 +3093,7 @@ static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
 			else
 				badness += bad->no_dac;
 		}
-		if (!add_new_out_path(codec, pin, dac))
+		if (!add_new_nid_path(codec, dac, pin, 0))
 			dac = dacs[i] = 0;
 		if (dac)
 			badness += assign_out_path_ctls(codec, pin, dac);
@@ -3118,7 +3118,7 @@ static bool alc_map_singles(struct hda_codec *codec, int outs,
 		dac = get_dac_if_single(codec, pins[i]);
 		if (!dac)
 			continue;
-		if (add_new_out_path(codec, pins[i], dac)) {
+		if (add_new_nid_path(codec, dac, pins[i], 0)) {
 			dacs[i] = dac;
 			found = true;
 		}
@@ -4015,7 +4015,7 @@ static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 				badness++;
 				continue;
 			}
-			if (!add_new_out_path(codec, nid, dac)) {
+			if (!add_new_nid_path(codec, dac, nid, 0)) {
 				badness++;
 				continue;
 			}
-- 
1.8.0.1
