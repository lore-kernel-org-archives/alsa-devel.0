From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/13] ALSA: hda - Fix missing path between
	aamix and outputs in AD codecs
Date: Thu, 24 Jan 2013 18:37:51 +0100
Message-ID: <1359049082-5880-3-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AE57A2616F1
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E6EBAA4F28
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

AD1988 family and AD1882 codecs have another mixer widget (0x21)
between the analog-loopback mixer widget (0x20) and the actual
outputs.  Due to this hole, the analog-loopbacks aren't sent properly
to the output pins.

As a band-aid fix, introduce another fields holding the aamix merge
path, and activate it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c  | 23 ++++++++++++++++++++++-
 sound/pci/hda/hda_generic.h  |  2 ++
 sound/pci/hda/patch_analog.c |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 758dcc1..06e203d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -688,7 +688,7 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 	 * when aa-mixer is available, we need to enable the path as well
 	 */
 	for (n = 0; n < nums; n++) {
-		if (n != idx && (!add_aamix || conn[n] != spec->mixer_nid))
+		if (n != idx && (!add_aamix || conn[n] != spec->mixer_merge_nid))
 			continue;
 		activate_amp(codec, nid, HDA_INPUT, n, idx, enable);
 	}
@@ -2492,6 +2492,19 @@ static int new_analog_input(struct hda_codec *codec, int input_idx,
 
 	path->active = true;
 	add_loopback_list(spec, mix_nid, idx);
+
+	if (spec->mixer_nid != spec->mixer_merge_nid &&
+	    !spec->loopback_merge_path) {
+		path = snd_hda_add_new_path(codec, spec->mixer_nid,
+					    spec->mixer_merge_nid, 0);
+		if (path) {
+			print_nid_path("loopback-merge", path);
+			path->active = true;
+			spec->loopback_merge_path =
+				snd_hda_get_path_idx(codec, path);
+		}
+	}
+
 	return 0;
 }
 
@@ -3847,6 +3860,9 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 
 	parse_user_hints(codec);
 
+	if (spec->mixer_nid && !spec->mixer_merge_nid)
+		spec->mixer_merge_nid = spec->mixer_nid;
+
 	if (cfg != &spec->autocfg) {
 		spec->autocfg = *cfg;
 		cfg = &spec->autocfg;
@@ -4673,6 +4689,11 @@ static void init_analog_input(struct hda_codec *codec)
 			if (path)
 				snd_hda_activate_path(codec, path,
 						      path->active, false);
+			path = snd_hda_get_path_from_idx(codec,
+							 spec->loopback_merge_path);
+			if (path)
+				snd_hda_activate_path(codec, path, path->active,
+						      false);
 		}
 	}
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 980707f..d226856 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -107,6 +107,7 @@ struct hda_gen_spec {
 	hda_nid_t adc_nids[AUTO_CFG_MAX_INS];
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 	hda_nid_t mixer_nid;		/* analog-mixer NID */
+	hda_nid_t mixer_merge_nid;	/* aamix merge-point NID (optional) */
 	const char *input_labels[HDA_MAX_NUM_INPUTS];
 	int input_label_idxs[HDA_MAX_NUM_INPUTS];
 
@@ -163,6 +164,7 @@ struct hda_gen_spec {
 	int digout_paths[AUTO_CFG_MAX_OUTS];
 	int input_paths[HDA_MAX_NUM_INPUTS][AUTO_CFG_MAX_INS];
 	int loopback_paths[HDA_MAX_NUM_INPUTS];
+	int loopback_merge_path;
 	int digin_path;
 
 	/* auto-mic stuff */
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 9d82aab..df8014b 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3235,6 +3235,7 @@ static int ad1988_parse_auto_config(struct hda_codec *codec)
 	spec = codec->spec;
 
 	spec->gen.mixer_nid = 0x20;
+	spec->gen.mixer_merge_nid = 0x21;
 	spec->beep_dev_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 	err = ad198x_parse_auto_config(codec);
@@ -5153,6 +5154,7 @@ static int ad1882_parse_auto_config(struct hda_codec *codec)
 	spec = codec->spec;
 
 	spec->gen.mixer_nid = 0x20;
+	spec->gen.mixer_merge_nid = 0x21;
 	spec->beep_dev_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 	err = ad198x_parse_auto_config(codec);
-- 
1.8.1.1
