From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - make Cirrus codec use generic
	unsol event handler
Date: Mon,  8 Oct 2012 15:44:15 +0200
Message-ID: <1349703855-7775-3-git-send-email-david.henningsson@canonical.com>
References: <1349703855-7775-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 115FB26515E
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 15:44:27 +0200 (CEST)
In-Reply-To: <1349703855-7775-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_cirrus.c |   48 +++++++++---------------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index fcfc9f0..fc92819 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -897,7 +897,7 @@ static int build_digital_input(struct hda_codec *codec)
  * HP/SPK/SPDIF
  */
 
-static void cs_automute(struct hda_codec *codec)
+static void cs_automute(struct hda_codec *codec, struct hda_jack_tbl *tbl)
 {
 	struct cs_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
@@ -973,7 +973,7 @@ static void cs_automute(struct hda_codec *codec)
  * Switch max 3 inputs of a single ADC (nid 3)
 */
 
-static void cs_automic(struct hda_codec *codec)
+static void cs_automic(struct hda_codec *codec, struct hda_jack_tbl *tbl)
 {
 	struct cs_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
@@ -1035,7 +1035,7 @@ static void init_output(struct hda_codec *codec)
 		if (!cfg->speaker_outs)
 			continue;
 		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
-			snd_hda_jack_detect_enable(codec, nid, HP_EVENT);
+			snd_hda_jack_detect_enable_callback(codec, nid, HP_EVENT, cs_automute);
 			spec->hp_detect = 1;
 		}
 	}
@@ -1046,7 +1046,7 @@ static void init_output(struct hda_codec *codec)
 
 	/* SPDIF is enabled on presence detect for CS421x */
 	if (spec->hp_detect || spec->spdif_detect)
-		cs_automute(codec);
+		cs_automute(codec, NULL);
 }
 
 static void init_input(struct hda_codec *codec)
@@ -1070,13 +1070,13 @@ static void init_input(struct hda_codec *codec)
 				    AC_VERB_SET_AMP_GAIN_MUTE,
 				    AMP_IN_MUTE(spec->adc_idx[i]));
 		if (spec->mic_detect && spec->automic_idx == i)
-			snd_hda_jack_detect_enable(codec, pin, MIC_EVENT);
+			snd_hda_jack_detect_enable_callback(codec, pin, MIC_EVENT, cs_automic);
 	}
 	/* CS420x has multiple ADC, CS421x has single ADC */
 	if (spec->vendor_nid == CS420X_VENDOR_NID) {
 		change_cur_input(codec, spec->cur_input, 1);
 		if (spec->mic_detect)
-			cs_automic(codec);
+			cs_automic(codec, NULL);
 
 		coef = 0x000a; /* ADC1/2 - Digital and Analog Soft Ramp */
 		if (is_active_pin(codec, CS_DMIC2_PIN_NID))
@@ -1089,7 +1089,7 @@ static void init_input(struct hda_codec *codec)
 		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
 	} else {
 		if (spec->mic_detect)
-			cs_automic(codec);
+			cs_automic(codec, NULL);
 		else  {
 			spec->cur_adc = spec->adc_nid[spec->cur_input];
 			cs_update_input_select(codec);
@@ -1246,25 +1246,12 @@ static void cs_free(struct hda_codec *codec)
 	kfree(codec->spec);
 }
 
-static void cs_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	switch (snd_hda_jack_get_action(codec, res >> 26)) {
-	case HP_EVENT:
-		cs_automute(codec);
-		break;
-	case MIC_EVENT:
-		cs_automic(codec);
-		break;
-	}
-	snd_hda_jack_report_sync(codec);
-}
-
 static const struct hda_codec_ops cs_patch_ops = {
 	.build_controls = cs_build_controls,
 	.build_pcms = cs_build_pcms,
 	.init = cs_init,
 	.free = cs_free,
-	.unsol_event = cs_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 };
 
 static int cs_parse_auto_config(struct hda_codec *codec)
@@ -1674,7 +1661,7 @@ static void init_cs421x_digital(struct hda_codec *codec)
 		if (!cfg->speaker_outs)
 			continue;
 		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
-			snd_hda_jack_detect_enable(codec, nid, SPDIF_EVENT);
+			snd_hda_jack_detect_enable_callback(codec, nid, SPDIF_EVENT, cs_automute);
 			spec->spdif_detect = 1;
 		}
 	}
@@ -1889,21 +1876,6 @@ static int cs421x_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-static void cs421x_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	switch (snd_hda_jack_get_action(codec, res >> 26)) {
-	case HP_EVENT:
-	case SPDIF_EVENT:
-		cs_automute(codec);
-		break;
-
-	case MIC_EVENT:
-		cs_automic(codec);
-		break;
-	}
-	snd_hda_jack_report_sync(codec);
-}
-
 static int parse_cs421x_input(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
@@ -1977,7 +1949,7 @@ static struct hda_codec_ops cs421x_patch_ops = {
 	.build_pcms = cs_build_pcms,
 	.init = cs421x_init,
 	.free = cs_free,
-	.unsol_event = cs421x_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cs421x_suspend,
 #endif
-- 
1.7.9.5
