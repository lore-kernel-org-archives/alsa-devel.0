From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 077/112] ALSA: hda - Define HDA_PARSE_* for
	snd_hda_parse_nid_path() argument
Date: Tue,  8 Jan 2013 12:39:10 +0100
Message-ID: <1357645185-7645-78-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 97D4B26520E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8543AA51CB
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

... instead of numbers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 28 +++++++++++++++-------------
 sound/pci/hda/hda_generic.h |  7 +++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b341450..18b5fae 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -211,9 +211,9 @@ static bool __parse_nid_path(struct hda_codec *codec,
 	int i, nums;
 
 	if (to_nid == spec->mixer_nid) {
-		if (!with_aa_mix)
+		if (with_aa_mix == HDA_PARSE_NO_AAMIX)
 			return false;
-		with_aa_mix = 2; /* mark aa-mix is included */
+		with_aa_mix = HDA_PARSE_ALL; /* mark aa-mix is included */
 	}
 
 	nums = snd_hda_get_connections(codec, to_nid, conn, ARRAY_SIZE(conn));
@@ -228,7 +228,7 @@ static bool __parse_nid_path(struct hda_codec *codec,
 				continue;
 		}
 		/* aa-mix is requested but not included? */
-		if (!(spec->mixer_nid && with_aa_mix == 1))
+		if (!(spec->mixer_nid && with_aa_mix == HDA_PARSE_ONLY_AAMIX))
 			goto found;
 	}
 	if (depth >= MAX_NID_PATH_DEPTH)
@@ -256,9 +256,11 @@ static bool __parse_nid_path(struct hda_codec *codec,
 
 /* parse the widget path from the given nid to the target nid;
  * when @from_nid is 0, try to find an empty DAC;
- * when @with_aa_mix is 0, paths with spec->mixer_nid are excluded.
- * when @with_aa_mix is 1, paths without spec->mixer_nid are excluded.
- * when @with_aa_mix is 2, no special handling about spec->mixer_nid.
+ * when @with_aa_mix is HDA_PARSE_NO_AAMIX, paths with spec->mixer_nid are
+ * excluded, only the paths that don't go through the mixer will be chosen.
+ * when @with_aa_mix is HDA_PARSE_ONLY_AAMIX, only the paths going through
+ * spec->mixer_nid will be chosen.
+ * when @with_aa_mix is HDA_PARSE_ALL, no special handling about mixer widget.
  */
 bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
 			    hda_nid_t to_nid, int with_aa_mix,
@@ -861,7 +863,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			else
 				badness += bad->no_dac;
 		}
-		path = snd_hda_add_new_path(codec, dac, pin, 0);
+		path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_NO_AAMIX);
 		if (!path)
 			dac = dacs[i] = 0;
 		else
@@ -977,7 +979,7 @@ static int fill_multi_ios(struct hda_codec *codec,
 				badness++;
 				continue;
 			}
-			path = snd_hda_add_new_path(codec, dac, nid, 0);
+			path = snd_hda_add_new_path(codec, dac, nid, HDA_PARSE_NO_AAMIX);
 			if (!path) {
 				badness++;
 				continue;
@@ -1028,7 +1030,7 @@ static bool map_singles(struct hda_codec *codec, int outs,
 		dac = get_dac_if_single(codec, pins[i]);
 		if (!dac)
 			continue;
-		path = snd_hda_add_new_path(codec, dac, pins[i], 0);
+		path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_NO_AAMIX);
 		if (path) {
 			dacs[i] = dac;
 			found = true;
@@ -1677,7 +1679,7 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
 		return 0; /* no need for analog loopback */
 
-	path = snd_hda_add_new_path(codec, pin, mix_nid, 2);
+	path = snd_hda_add_new_path(codec, pin, mix_nid, HDA_PARSE_ALL);
 	if (!path)
 		return -EINVAL;
 	print_nid_path("loopback", path);
@@ -1851,7 +1853,7 @@ static int create_input_ctls(struct hda_codec *codec)
 			if (!path)
 				return -ENOMEM;
 			memset(path, 0, sizeof(*path));
-			if (!snd_hda_parse_nid_path(codec, pin, adc, 2, path)) {
+			if (!snd_hda_parse_nid_path(codec, pin, adc, HDA_PARSE_ALL, path)) {
 				snd_printd(KERN_ERR
 					   "invalid input path 0x%x -> 0x%x\n",
 					   pin, adc);
@@ -2329,7 +2331,7 @@ static void parse_digital(struct hda_codec *codec)
 		dig_nid = look_for_dac(codec, pin, true);
 		if (!dig_nid)
 			continue;
-		path = snd_hda_add_new_path(codec, dig_nid, pin, 2);
+		path = snd_hda_add_new_path(codec, dig_nid, pin, HDA_PARSE_ALL);
 		if (!path)
 			continue;
 		print_nid_path("digout", path);
@@ -2355,7 +2357,7 @@ static void parse_digital(struct hda_codec *codec)
 				continue;
 			path = snd_hda_add_new_path(codec,
 						    spec->autocfg.dig_in_pin,
-						    dig_nid, 2);
+						    dig_nid, HDA_PARSE_ALL);
 			if (path) {
 				print_nid_path("digin", path);
 				path->active = true;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 6365140..85d138f 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -180,6 +180,13 @@ int snd_hda_gen_init(struct hda_codec *codec);
 
 struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 				      hda_nid_t from_nid, hda_nid_t to_nid);
+
+enum {
+	HDA_PARSE_NO_AAMIX,
+	HDA_PARSE_ONLY_AAMIX,
+	HDA_PARSE_ALL,
+};
+
 bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
 			    hda_nid_t to_nid, int with_aa_mix,
 			    struct nid_path *path);
-- 
1.8.0.1
