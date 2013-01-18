From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: hda - Keep autocfg.input idx value
	in imux table
Date: Fri, 18 Jan 2013 11:24:00 +0100
Message-ID: <1358504643-13593-2-git-send-email-tiwai@suse.de>
References: <1358504643-13593-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1270E2650FF
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:05 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D9263A3A78
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:04 +0100 (CET)
In-Reply-To: <1358504643-13593-1-git-send-email-tiwai@suse.de>
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

Since the imux table entries can be a subset of autocfg.input table,
the indices of these aren't always same.  For passing the proper index
value of autocfg.input at creating input ctl labels (via
snd_hda_autocfg_input_label()), keep the corresponding autocfg.input
idx value in the index field of each imux item, which isn't used in
the generic driver.

Also, this makes easier to check the invalid imux pin for stereo mix.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ef4c04a..7444d2e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2478,7 +2478,8 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 
 /* parse capture source paths from the given pin and create imux items */
 static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
-				int num_adcs, const char *label, int anchor)
+				int cfg_idx, int num_adcs,
+				const char *label, int anchor)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct hda_input_mux *imux = &spec->input_mux;
@@ -2501,8 +2502,7 @@ static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
 
 		if (!imux_added) {
 			spec->imux_pins[imux->num_items] = pin;
-			snd_hda_add_imux_item(imux, label,
-					      imux->num_items, NULL);
+			snd_hda_add_imux_item(imux, label, cfg_idx, NULL);
 			imux_added = true;
 		}
 	}
@@ -2513,6 +2513,9 @@ static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
 /*
  * create playback/capture controls for input pins
  */
+
+#define CFG_IDX_MIX	99	/* a dummy cfg->input idx for stereo mix */
+
 static int create_input_ctls(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -2556,7 +2559,8 @@ static int create_input_ctls(struct hda_codec *codec)
 			}
 		}
 
-		err = parse_capture_source(codec, pin, num_adcs, label, -mixer);
+		err = parse_capture_source(codec, pin, i,
+					   num_adcs, label, -mixer);
 		if (err < 0)
 			return err;
 
@@ -2568,7 +2572,7 @@ static int create_input_ctls(struct hda_codec *codec)
 	}
 
 	if (mixer && spec->add_stereo_mix_input) {
-		err = parse_capture_source(codec, mixer, num_adcs,
+		err = parse_capture_source(codec, mixer, CFG_IDX_MIX, num_adcs,
 					   "Stereo Mix", 0);
 		if (err < 0)
 			return err;
@@ -2909,7 +2913,11 @@ static int create_multi_cap_vol_ctl(struct hda_codec *codec)
 	for (i = 0; i < imux->num_items; i++) {
 		const char *label;
 		bool inv_dmic;
-		label = hda_get_autocfg_input_label(codec, &spec->autocfg, i);
+
+		if (imux->items[i].index >= spec->autocfg.num_inputs)
+			continue;
+		label = hda_get_autocfg_input_label(codec, &spec->autocfg,
+						    imux->items[i].index);
 		if (prev_label && !strcmp(label, prev_label))
 			type_idx++;
 		else
-- 
1.8.1
