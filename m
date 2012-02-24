From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/38] ALSA: hda/realtek - Refactor the DAC
	filler function
Date: Fri, 24 Feb 2012 17:36:11 +0100
Message-ID: <1330101391-8788-19-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 58C8810431D
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8736E91C69
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Refactor the DAC filling function to be used for both the primary
line outputs and extra outputs using the individual badness tables.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  154 ++++++++++++++++++++--------------------
 1 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1cad674..a0df05d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2969,6 +2969,8 @@ static bool alc_auto_is_dac_reachable(struct hda_codec *codec,
 	hda_nid_t srcs[5];
 	int i, num;
 
+	if (!pin || !dac)
+		return false;
 	pin = alc_go_down_to_selector(codec, pin);
 	num = snd_hda_get_connections(codec, pin, srcs, ARRAY_SIZE(srcs));
 	for (i = 0; i < num; i++) {
@@ -3087,60 +3089,88 @@ static int eval_shared_vol_badness(struct hda_codec *codec, hda_nid_t pin,
 	return badness;
 }
 
-/* try to assign DACs to extra pins and return the resultant badness */
-static int alc_auto_fill_extra_dacs(struct hda_codec *codec, int num_outs,
-				    const hda_nid_t *pins, hda_nid_t *dacs)
+struct badness_table {
+	int no_primary_dac;	/* no primary DAC */
+	int no_dac;		/* no secondary DACs */
+	int shared_primary;	/* primary DAC is shared with main output */
+	int shared_surr;	/* secondary DAC shared with main or primary */
+	int shared_clfe;	/* third DAC shared with main or primary */
+	int shared_surr_main;	/* secondary DAC sahred with main/DAC0 */
+};
+
+static struct badness_table main_out_badness = {
+	.no_primary_dac = BAD_NO_PRIMARY_DAC,
+	.no_dac = BAD_NO_DAC,
+	.shared_primary = BAD_NO_PRIMARY_DAC,
+	.shared_surr = BAD_SHARED_SURROUND,
+	.shared_clfe = BAD_SHARED_CLFE,
+	.shared_surr_main = BAD_SHARED_SURROUND,
+};
+
+static struct badness_table extra_out_badness = {
+	.no_primary_dac = BAD_NO_DAC,
+	.no_dac = BAD_NO_DAC,
+	.shared_primary = BAD_NO_EXTRA_DAC,
+	.shared_surr = BAD_SHARED_EXTRA_SURROUND,
+	.shared_clfe = BAD_SHARED_EXTRA_SURROUND,
+	.shared_surr_main = BAD_NO_EXTRA_SURR_DAC,
+};
+
+/* try to assign DACs to pins and return the resultant badness */
+static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
+			      const hda_nid_t *pins, hda_nid_t *dacs,
+			      const struct badness_table *bad)
 {
 	struct alc_spec *spec = codec->spec;
-	int i;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i, j;
 	int badness = 0;
 	hda_nid_t dac;
 
 	if (!num_outs)
 		return 0;
 
-	if (!dacs[0])
-		dacs[0] = alc_auto_look_for_dac(codec, pins[0]);
-	if (!dacs[0]) {
-		for (i = 1; i < num_outs; i++) {
-			dac = dacs[i];
-			if (dac && alc_auto_is_dac_reachable(codec, pins[0], dac)) {
-				dacs[0] = dac;
-				dacs[i] = 0;
-				break;
+	for (i = 0; i < num_outs; i++) {
+		hda_nid_t pin = pins[i];
+		if (!dacs[i])
+			dacs[i] = alc_auto_look_for_dac(codec, pin);
+		if (!dacs[i] && !i) {
+			for (j = 1; j < num_outs; j++) {
+				if (alc_auto_is_dac_reachable(codec, pin, dacs[j])) {
+					dacs[0] = dacs[j];
+					dacs[j] = 0;
+					break;
+				}
 			}
 		}
-	}
-	dac = dacs[0];
-	if (!dac) {
-		dac = spec->private_dac_nids[0];
-		if (!alc_auto_is_dac_reachable(codec, pins[0], dac))
-			return BAD_NO_DAC;
-		badness += BAD_NO_EXTRA_DAC;
-	}
-	if (dac)
-		badness += eval_shared_vol_badness(codec, pins[0], dac);
-
-	for (i = 1; i < num_outs; i++)
-		dacs[i] = get_dac_if_single(codec, pins[i]);
-	for (i = 1; i < num_outs; i++) {
 		dac = dacs[i];
-		if (!dac)
-			dac = dacs[i] = alc_auto_look_for_dac(codec, pins[i]);
 		if (!dac) {
-			if (alc_auto_is_dac_reachable(codec, pins[i], dacs[0])) {
+			if (alc_auto_is_dac_reachable(codec, pin, dacs[0]))
 				dac = dacs[0];
-				badness += BAD_SHARED_EXTRA_SURROUND;
-			} else if (alc_auto_is_dac_reachable(codec, pins[i],
+			else if (cfg->line_outs > i &&
+				 alc_auto_is_dac_reachable(codec, pin,
+					spec->private_dac_nids[i]))
+				dac = spec->private_dac_nids[i];
+			if (dac) {
+				if (!i)
+					badness += bad->shared_primary;
+				else if (i == 1)
+					badness += bad->shared_surr;
+				else
+					badness += bad->shared_clfe;
+			} else if (alc_auto_is_dac_reachable(codec, pin,
 					spec->private_dac_nids[0])) {
 				dac = spec->private_dac_nids[0];
-				badness += BAD_NO_EXTRA_SURR_DAC;
-			} else
-				badness += BAD_NO_DAC;
+				badness += bad->shared_surr_main;
+			} else if (!i)
+				badness += bad->no_primary_dac;
+			else
+				badness += bad->no_dac;
 		}
 		if (dac)
-			badness += eval_shared_vol_badness(codec, pins[i], dac);
+			badness += eval_shared_vol_badness(codec, pin, dac);
 	}
+
 	return badness;
 }
 
@@ -3170,7 +3200,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, j, err, badness;
+	int i, err, badness;
 
 	/* set num_dacs once to full for alc_auto_look_for_dac() */
 	spec->multiout.num_dacs = cfg->line_outs;
@@ -3204,40 +3234,9 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		} while (mapped);
 	}
 
-	for (i = 0; i < cfg->line_outs; i++) {
-		hda_nid_t pin = cfg->line_out_pins[i];
-		hda_nid_t dac;
-		if (!spec->private_dac_nids[i])
-			spec->private_dac_nids[i] =
-				alc_auto_look_for_dac(codec, pin);
-		dac = spec->private_dac_nids[i];
-		if (!dac && !i) {
-			for (j = 1; j < cfg->line_outs; j++) {
-				hda_nid_t dac2 = spec->private_dac_nids[j];
-				if (dac2 &&
-				    alc_auto_is_dac_reachable(codec, pin, dac2)) {
-					dac = spec->private_dac_nids[0] = dac2;
-					spec->private_dac_nids[j] = 0;
-					break;
-				}
-			}
-		}
-		if (!dac) {
-			if (!i)
-				badness += BAD_NO_PRIMARY_DAC;
-			else if (alc_auto_is_dac_reachable(codec, pin,
-					spec->private_dac_nids[0])) {
-				if (i == 1)
-					badness += BAD_SHARED_SURROUND;
-				else
-					badness += BAD_SHARED_CLFE;
-				dac = spec->private_dac_nids[0];
-			} else
-				badness += BAD_NO_DAC;
-		}
-		if (dac)
-			badness += eval_shared_vol_badness(codec, pin, dac);
-	}
+	badness += alc_auto_fill_dacs(codec, cfg->line_outs, cfg->line_out_pins,
+				      spec->private_dac_nids,
+				      &main_out_badness);
 
 	/* re-count num_dacs and squash invalid entries */
 	spec->multiout.num_dacs = 0;
@@ -3262,17 +3261,18 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	}
 
 	if (cfg->line_out_type != AUTO_PIN_HP_OUT) {
-		err = alc_auto_fill_extra_dacs(codec, cfg->hp_outs,
-					       cfg->hp_pins,
-					       spec->multiout.hp_out_nid);
+		err = alc_auto_fill_dacs(codec, cfg->hp_outs, cfg->hp_pins,
+					 spec->multiout.hp_out_nid,
+					 &extra_out_badness);
 		if (err < 0)
 			return err;
 		badness += err;
 	}
 	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
-		err = alc_auto_fill_extra_dacs(codec, cfg->speaker_outs,
-					       cfg->speaker_pins,
-					       spec->multiout.extra_out_nid);
+		err = alc_auto_fill_dacs(codec, cfg->speaker_outs,
+					 cfg->speaker_pins,
+					 spec->multiout.extra_out_nid,
+					 &extra_out_badness);
 		if (err < 0)
 			return err;
 		badness += err;
-- 
1.7.9
