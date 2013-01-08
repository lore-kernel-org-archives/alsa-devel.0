From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 088/112] ALSA: hda - Simplify the multi-io
	assignment with multi speakers
Date: Tue,  8 Jan 2013 12:39:21 +0100
Message-ID: <1357645185-7645-89-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3D5265220
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id AD6C0A5381
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

When speakers are chosen as the the primary output during evaluation,
we did some tricks to assign the possible multi-io jacks with a
certain offset value to multi_out dacs.  This was a workaround for the
case with multiple speakers like Acer Aspire.  But this is quite ugly
at the same time and the resultant code is hard to understand.  More
badly, it works wrongly for 2.1 speakers like Apple iMac91.

In this patch, instead of fiddling with the offset to multi_out dacs,
simply add a certain badness number if headphone(s) + multi-ios are
possible.  This simplify the code a bit, and it's more robust.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 63 +++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 5516905..c928b38 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -943,6 +943,28 @@ static bool can_be_multiio_pin(struct hda_codec *codec,
 	return true;
 }
 
+/* count the number of input pins that are capable to be multi-io */
+static int count_multiio_pins(struct hda_codec *codec, hda_nid_t reference_pin)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int defcfg = snd_hda_codec_get_pincfg(codec, reference_pin);
+	unsigned int location = get_defcfg_location(defcfg);
+	int type, i;
+	int num_pins = 0;
+
+	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
+		for (i = 0; i < cfg->num_inputs; i++) {
+			if (cfg->inputs[i].type != type)
+				continue;
+			if (can_be_multiio_pin(codec, location,
+					       cfg->inputs[i].pin))
+				num_pins++;
+		}
+	}
+	return num_pins;
+}
+
 /*
  * multi-io helper
  *
@@ -953,11 +975,11 @@ static bool can_be_multiio_pin(struct hda_codec *codec,
  */
 static int fill_multi_ios(struct hda_codec *codec,
 			  hda_nid_t reference_pin,
-			  bool hardwired, int offset)
+			  bool hardwired)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int type, i, j, dacs, num_pins, old_pins;
+	int type, i, j, num_pins, old_pins;
 	unsigned int defcfg = snd_hda_codec_get_pincfg(codec, reference_pin);
 	unsigned int location = get_defcfg_location(defcfg);
 	int badness = 0;
@@ -966,20 +988,10 @@ static int fill_multi_ios(struct hda_codec *codec,
 	if (old_pins >= 2)
 		goto end_fill;
 
-	num_pins = 0;
-	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
-		for (i = 0; i < cfg->num_inputs; i++) {
-			if (cfg->inputs[i].type != type)
-				continue;
-			if (can_be_multiio_pin(codec, location,
-					       cfg->inputs[i].pin))
-				num_pins++;
-		}
-	}
+	num_pins = count_multiio_pins(codec, reference_pin);
 	if (num_pins < 2)
 		goto end_fill;
 
-	dacs = spec->multiout.num_dacs;
 	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
 		for (i = 0; i < cfg->num_inputs; i++) {
 			struct nid_path *path;
@@ -997,11 +1009,6 @@ static int fill_multi_ios(struct hda_codec *codec,
 			if (j < spec->multi_ios)
 				continue;
 
-			if (offset && offset + spec->multi_ios < dacs) {
-				dac = spec->private_dac_nids[offset + spec->multi_ios];
-				if (!is_reachable_path(codec, dac, nid))
-					dac = 0;
-			}
 			if (hardwired)
 				dac = get_dac_if_single(codec, nid);
 			else if (!dac)
@@ -1109,7 +1116,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 					      spec->multiout.extra_out_nid);
 			if (fill_mio_first && cfg->line_outs == 1 &&
 			    cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
-				err = fill_multi_ios(codec, cfg->line_out_pins[0], true, 0);
+				err = fill_multi_ios(codec, cfg->line_out_pins[0], true);
 				if (!err)
 					mapped = true;
 			}
@@ -1136,7 +1143,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	if (fill_mio_first &&
 	    cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
 		/* try to fill multi-io first */
-		err = fill_multi_ios(codec, cfg->line_out_pins[0], false, 0);
+		err = fill_multi_ios(codec, cfg->line_out_pins[0], false);
 		if (err < 0)
 			return err;
 		/* we don't count badness at this stage yet */
@@ -1160,22 +1167,16 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		badness += err;
 	}
 	if (cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
-		err = fill_multi_ios(codec, cfg->line_out_pins[0], false, 0);
-		if (err < 0)
-			return err;
-		badness += err;
-	}
-	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
-		/* try multi-ios with HP + inputs */
-		int offset = 0;
-		if (cfg->line_outs >= 3)
-			offset = 1;
-		err = fill_multi_ios(codec, cfg->hp_pins[0], false, offset);
+		err = fill_multi_ios(codec, cfg->line_out_pins[0], false);
 		if (err < 0)
 			return err;
 		badness += err;
 	}
 
+	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
+		if (count_multiio_pins(codec, cfg->hp_pins[0]) >= 2)
+			spec->multi_ios = 1; /* give badness */
+
 	if (spec->multi_ios == 2) {
 		for (i = 0; i < 2; i++)
 			spec->private_dac_nids[spec->multiout.num_dacs++] =
-- 
1.8.0.1
