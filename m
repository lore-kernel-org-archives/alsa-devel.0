From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/38] ALSA: hda/realtek - Try harder to fit
	the single-connections
Date: Fri, 24 Feb 2012 17:36:06 +0100
Message-ID: <1330101391-8788-14-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 21723104317
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 797D5914CD
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

So far, the Realtek driver tires to assign the single-connected routes
for all pins only once at the beginning.  However, since some DACs have
been already mapped, the rest pins might have also single conections.

In this patch, the driver does the single-connection assignment in a
loop until all possbile single-connections are checked.  This will
improve the DAC assignment, e.g. for ASUS G72.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  124 ++++++++++++++++++++++++++++++-----------
 1 files changed, 91 insertions(+), 33 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4746afa..29c1925 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2926,10 +2926,22 @@ static int alc_auto_select_dac(struct hda_codec *codec, hda_nid_t pin,
 	return 0;
 }
 
+static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct alc_spec *spec = codec->spec;
+	if (found_in_nid_list(nid, spec->multiout.dac_nids,
+			      ARRAY_SIZE(spec->private_dac_nids)) ||
+	    found_in_nid_list(nid, spec->multiout.hp_out_nid,
+			      ARRAY_SIZE(spec->multiout.hp_out_nid)) ||
+	    found_in_nid_list(nid, spec->multiout.extra_out_nid,
+			      ARRAY_SIZE(spec->multiout.extra_out_nid)))
+		return true;
+	return false;
+}
+
 /* look for an empty DAC slot */
 static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 {
-	struct alc_spec *spec = codec->spec;
 	hda_nid_t srcs[5];
 	int i, num;
 
@@ -2939,16 +2951,8 @@ static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 		hda_nid_t nid = alc_auto_mix_to_dac(codec, srcs[i]);
 		if (!nid)
 			continue;
-		if (found_in_nid_list(nid, spec->multiout.dac_nids,
-				      ARRAY_SIZE(spec->private_dac_nids)))
-			continue;
-		if (found_in_nid_list(nid, spec->multiout.hp_out_nid,
-				      ARRAY_SIZE(spec->multiout.hp_out_nid)))
-		    continue;
-		if (found_in_nid_list(nid, spec->multiout.extra_out_nid,
-				      ARRAY_SIZE(spec->multiout.extra_out_nid)))
-		    continue;
-		return nid;
+		if (!alc_is_dac_already_used(codec, nid))
+			return nid;
 	}
 	return 0;
 }
@@ -2974,12 +2978,23 @@ static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t sel = alc_go_down_to_selector(codec, pin);
-	hda_nid_t srcs[5];
-	int num = snd_hda_get_connections(codec, sel, srcs,
+	hda_nid_t nid, nid_found, srcs[5];
+	int i, num = snd_hda_get_connections(codec, sel, srcs,
 					  ARRAY_SIZE(srcs));
-	if (num == 1 || (num == 2 && srcs[1] == spec->mixer_nid))
+	if (num == 1)
 		return alc_auto_look_for_dac(codec, pin);
-	return 0;
+	nid_found = 0;
+	for (i = 0; i < num; i++) {
+		if (srcs[i] == spec->mixer_nid)
+			continue;
+		nid = alc_auto_mix_to_dac(codec, srcs[i]);
+		if (nid && !alc_is_dac_already_used(codec, nid)) {
+			if (nid_found)
+				return 0;
+			nid_found = nid;
+		}
+	}
+	return nid_found;
 }
 
 /* mark up volume and mute control NIDs: used during badness parsing and
@@ -3076,16 +3091,30 @@ static int alc_auto_fill_extra_dacs(struct hda_codec *codec, int num_outs,
 	int badness = 0;
 	hda_nid_t dac;
 
-	if (num_outs && !dacs[0]) {
-		dac = dacs[0] = alc_auto_look_for_dac(codec, pins[0]);
-		if (!dacs[0]) {
-			dac = spec->private_dac_nids[0];
-			if (!alc_auto_is_dac_reachable(codec, pins[0], dac))
-				return BAD_NO_DAC;
-			badness += BAD_NO_EXTRA_DAC;
+	if (!num_outs)
+		return 0;
+
+	if (!dacs[0])
+		dacs[0] = alc_auto_look_for_dac(codec, pins[0]);
+	if (!dacs[0]) {
+		for (i = 1; i < num_outs; i++) {
+			dac = dacs[i];
+			if (dac && alc_auto_is_dac_reachable(codec, pins[0], dac)) {
+				dacs[0] = dac;
+				dacs[i] = 0;
+				break;
+			}
 		}
-		badness += eval_shared_vol_badness(codec, pins[0], dac);
 	}
+	dac = dacs[0];
+	if (!dac) {
+		dac = spec->private_dac_nids[0];
+		if (!alc_auto_is_dac_reachable(codec, pins[0], dac))
+			return BAD_NO_DAC;
+		badness += BAD_NO_EXTRA_DAC;
+	}
+	if (dac)
+		badness += eval_shared_vol_badness(codec, pins[0], dac);
 
 	for (i = 1; i < num_outs; i++)
 		dacs[i] = get_dac_if_single(codec, pins[i]);
@@ -3113,6 +3142,21 @@ static int alc_auto_fill_extra_dacs(struct hda_codec *codec, int num_outs,
 static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 				   unsigned int location, int offset);
 
+static bool alc_map_singles(struct hda_codec *codec, int outs,
+			    const hda_nid_t *pins, hda_nid_t *dacs)
+{
+	int i;
+	bool found = false;
+	for (i = 0; i < outs; i++) {
+		if (dacs[i])
+			continue;
+		dacs[i] = get_dac_if_single(codec, pins[i]);
+		if (dacs[i])
+			found = true;
+	}
+	return found;
+}
+
 /* fill in the dac_nids table from the parsed pin configuration */
 static int fill_and_eval_dacs(struct hda_codec *codec,
 			      bool fill_hardwired)
@@ -3120,7 +3164,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	unsigned int location, defcfg;
-	int i, err, badness;
+	int i, j, err, badness;
 
 	/* set num_dacs once to full for alc_auto_look_for_dac() */
 	spec->multiout.num_dacs = cfg->line_outs;
@@ -3134,15 +3178,18 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 
 	/* fill hard-wired DACs first */
 	if (fill_hardwired) {
-		for (i = 0; i < cfg->line_outs; i++)
-			spec->private_dac_nids[i] =
-				get_dac_if_single(codec, cfg->line_out_pins[i]);
-		for (i = 0; i < cfg->hp_outs; i++)
-			spec->multiout.hp_out_nid[i] =
-				get_dac_if_single(codec, cfg->hp_pins[i]);
-		for (i = 0; i < cfg->speaker_outs; i++)
-			spec->multiout.extra_out_nid[i] =
-				get_dac_if_single(codec, cfg->speaker_pins[i]);
+		bool mapped;
+		do {
+			mapped = alc_map_singles(codec, cfg->line_outs,
+						     cfg->line_out_pins,
+						     spec->private_dac_nids);
+			mapped |= alc_map_singles(codec, cfg->hp_outs,
+						  cfg->hp_pins,
+						  spec->multiout.hp_out_nid);
+			mapped |= alc_map_singles(codec, cfg->speaker_outs,
+						  cfg->speaker_pins,
+						  spec->multiout.extra_out_nid);
+		} while (mapped);
 	}
 
 	for (i = 0; i < cfg->line_outs; i++) {
@@ -3152,6 +3199,17 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 			spec->private_dac_nids[i] =
 				alc_auto_look_for_dac(codec, pin);
 		dac = spec->private_dac_nids[i];
+		if (!dac && !i) {
+			for (j = 1; j < cfg->line_outs; j++) {
+				hda_nid_t dac2 = spec->private_dac_nids[j];
+				if (dac2 &&
+				    alc_auto_is_dac_reachable(codec, pin, dac2)) {
+					dac = spec->private_dac_nids[0] = dac2;
+					spec->private_dac_nids[j] = 0;
+					break;
+				}
+			}
+		}
 		if (!dac) {
 			if (!i)
 				badness += BAD_NO_PRIMARY_DAC;
-- 
1.7.9
