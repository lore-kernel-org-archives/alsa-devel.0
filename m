From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/20] ALSA: hda - Allow aamix as a capture
	source
Date: Tue, 15 Jan 2013 12:05:31 +0100
Message-ID: <1358247947-13992-5-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B518C265321
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7E4E6A5212
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Since some codecs can choose the aamix as a capture source, we should
support it as well.  When spec->add_stereo_mix_input flag is set, the
parser checks the availability of aamix as the input source, and adds
the paths automatically when possible.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 69 +++++++++++++++++++++++++++++----------------
 sound/pci/hda/hda_generic.h |  1 +
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index d16ef1d..26e8d83 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2067,6 +2067,40 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 	return 0;
 }
 
+/* parse capture source paths from the given pin and create imux items */
+static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
+				int num_adcs, const char *label, int anchor)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->input_mux;
+	int imux_idx = imux->num_items;
+	bool imux_added = false;
+	int c;
+
+	for (c = 0; c < num_adcs; c++) {
+		struct nid_path *path;
+		hda_nid_t adc = spec->adc_nids[c];
+
+		if (!is_reachable_path(codec, pin, adc))
+			continue;
+		path = snd_hda_add_new_path(codec, pin, adc, anchor);
+		if (!path)
+			continue;
+		print_nid_path("input", path);
+		spec->input_paths[imux_idx][c] =
+			snd_hda_get_path_idx(codec, path);
+
+		if (!imux_added) {
+			spec->imux_pins[imux->num_items] = pin;
+			snd_hda_add_imux_item(imux, label,
+					      imux->num_items, NULL);
+			imux_added = true;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * create playback/capture controls for input pins
  */
@@ -2075,9 +2109,8 @@ static int create_input_ctls(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 	const struct auto_pin_cfg *cfg = &spec->autocfg;
 	hda_nid_t mixer = spec->mixer_nid;
-	struct hda_input_mux *imux = &spec->input_mux;
 	int num_adcs;
-	int i, c, err, type_idx = 0;
+	int i, err, type_idx = 0;
 	const char *prev_label = NULL;
 
 	num_adcs = fill_adc_nids(codec);
@@ -2087,8 +2120,6 @@ static int create_input_ctls(struct hda_codec *codec)
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t pin;
 		const char *label;
-		int imux_idx;
-		bool imux_added;
 
 		pin = cfg->inputs[i].pin;
 		if (!is_input_pin(codec, pin))
@@ -2110,28 +2141,16 @@ static int create_input_ctls(struct hda_codec *codec)
 			}
 		}
 
-		imux_added = false;
-		imux_idx = imux->num_items;
-		for (c = 0; c < num_adcs; c++) {
-			struct nid_path *path;
-			hda_nid_t adc = spec->adc_nids[c];
-
-			if (!is_reachable_path(codec, pin, adc))
-				continue;
-			path = snd_hda_add_new_path(codec, pin, adc, -mixer);
-			if (!path)
-				continue;
-			print_nid_path("input", path);
-			spec->input_paths[imux_idx][c] =
-				snd_hda_get_path_idx(codec, path);
+		err = parse_capture_source(codec, pin, num_adcs, label, -mixer);
+		if (err < 0)
+			return err;
+	}
 
-			if (!imux_added) {
-				spec->imux_pins[imux->num_items] = pin;
-				snd_hda_add_imux_item(imux, label,
-						      imux->num_items, NULL);
-				imux_added = true;
-			}
-		}
+	if (mixer && spec->add_stereo_mix_input) {
+		err = parse_capture_source(codec, mixer, num_adcs,
+					   "Stereo Mix", 0);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 1763e33..89683c7 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -190,6 +190,7 @@ struct hda_gen_spec {
 	unsigned int vmaster_mute_enum:1; /* add vmaster mute mode enum */
 	unsigned int indep_hp:1; /* independent HP supported */
 	unsigned int indep_hp_enabled:1; /* independent HP enabled */
+	unsigned int add_stereo_mix_input:1; /* add aamix as a capture src */
 
 	/* loopback mixing mode */
 	bool aamix_mode;
-- 
1.8.1
