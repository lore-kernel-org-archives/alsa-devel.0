From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: HDA: Add support for Cirrus Logic
	4213
Date: Mon,  2 Jan 2012 12:40:17 +0100
Message-ID: <1325504417-7283-3-git-send-email-david.henningsson@canonical.com>
References: <1325504417-7283-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id DE55B246D2
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 12:40:31 +0100 (CET)
In-Reply-To: <1325504417-7283-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

The CS4213 chip is similar to the CS4210, but it does not have
SPDIF capabilities. Also, it has fewer pins, and the vendor specific
nid is different. With this patch, we have working inputs and outputs
(and automute/autoswitch). However, we don't know anything about
the vendor specific processing coefficients, so we don't read or write
to that node in this patch.

BugLink: https://bugs.launchpad.net/bugs/910792
Tested-by: Hsin-Yi Chen <hychen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_cirrus.c |  105 ++++++++++++++++++++++++++++--------------
 1 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index bde3a94..fcc6ef0 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -138,7 +138,7 @@ enum {
 */
 #define CS4210_DAC_NID		0x02
 #define CS4210_ADC_NID		0x03
-#define CS421X_VENDOR_NID	0x0B
+#define CS4210_VENDOR_NID	0x0B
 #define CS421X_DMIC_PIN_NID	0x09 /* Port E */
 #define CS421X_SPDIF_PIN_NID	0x0A /* Port H */
 
@@ -149,6 +149,10 @@ enum {
 
 #define SPDIF_EVENT		0x04
 
+/* Cirrus Logic CS4213 is like CS4210 but does not have SPDIF input/output */
+#define CS4213_VENDOR_NID	0x09
+
+
 static inline int cs_vendor_coef_get(struct hda_codec *codec, unsigned int idx)
 {
 	struct cs_spec *spec = codec->spec;
@@ -923,8 +927,8 @@ static void cs_automute(struct hda_codec *codec)
 	/* mute speakers if spdif or hp jack is plugged in */
 	for (i = 0; i < cfg->speaker_outs; i++) {
 		int pin_ctl = hp_present ? 0 : PIN_OUT;
-		/* detect on spdif is specific to CS421x */
-		if (spdif_present && (spec->vendor_nid == CS421X_VENDOR_NID))
+		/* detect on spdif is specific to CS4210 */
+		if (spdif_present && (spec->vendor_nid == CS4210_VENDOR_NID))
 			pin_ctl = 0;
 
 		nid = cfg->speaker_pins[i];
@@ -938,8 +942,8 @@ static void cs_automute(struct hda_codec *codec)
 				    AC_VERB_SET_GPIO_DATA, gpio);
 	}
 
-	/* specific to CS421x */
-	if (spec->vendor_nid == CS421X_VENDOR_NID) {
+	/* specific to CS4210 */
+	if (spec->vendor_nid == CS4210_VENDOR_NID) {
 		/* mute HPs if spdif jack (SENSE_B) is present */
 		for (i = 0; i < cfg->hp_outs; i++) {
 			nid = cfg->hp_pins[i];
@@ -976,7 +980,12 @@ static void cs_automic(struct hda_codec *codec)
 	present = snd_hda_jack_detect(codec, nid);
 
 	/* specific to CS421x, single ADC */
-	if (spec->vendor_nid == CS421X_VENDOR_NID) {
+	if (spec->vendor_nid == CS420X_VENDOR_NID) {
+		if (present)
+			change_cur_input(codec, spec->automic_idx, 0);
+		else
+			change_cur_input(codec, !spec->automic_idx, 0);
+	} else {
 		if (present) {
 			spec->last_input = spec->cur_input;
 			spec->cur_input = spec->automic_idx;
@@ -984,11 +993,6 @@ static void cs_automic(struct hda_codec *codec)
 			spec->cur_input = spec->last_input;
 		}
 		cs_update_input_select(codec);
-	} else {
-		if (present)
-			change_cur_input(codec, spec->automic_idx, 0);
-		else
-			change_cur_input(codec, !spec->automic_idx, 0);
 	}
 }
 
@@ -1070,15 +1074,8 @@ static void init_input(struct hda_codec *codec)
 		if (spec->mic_detect && spec->automic_idx == i)
 			snd_hda_jack_detect_enable(codec, pin, MIC_EVENT);
 	}
-	/* specific to CS421x */
-	if (spec->vendor_nid == CS421X_VENDOR_NID) {
-		if (spec->mic_detect)
-			cs_automic(codec);
-		else  {
-			spec->cur_adc = spec->adc_nid[spec->cur_input];
-			cs_update_input_select(codec);
-		}
-	} else {
+	/* CS420x has multiple ADC, CS421x has single ADC */
+	if (spec->vendor_nid == CS420X_VENDOR_NID) {
 		change_cur_input(codec, spec->cur_input, 1);
 		if (spec->mic_detect)
 			cs_automic(codec);
@@ -1092,6 +1089,13 @@ static void init_input(struct hda_codec *codec)
 					 * selected in IDX_SPDIF_CTL.
 					*/
 		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+	} else {
+		if (spec->mic_detect)
+			cs_automic(codec);
+		else  {
+			spec->cur_adc = spec->adc_nid[spec->cur_input];
+			cs_update_input_select(codec);
+		}
 	}
 }
 
@@ -1565,7 +1569,7 @@ static const struct snd_kcontrol_new cs421x_speaker_bost_ctl = {
 	.tlv = { .p = cs421x_speaker_boost_db_scale },
 };
 
-static void cs421x_pinmux_init(struct hda_codec *codec)
+static void cs4210_pinmux_init(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
 	unsigned int def_conf, coef;
@@ -1620,10 +1624,11 @@ static int cs421x_init(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
 
-	snd_hda_sequence_write(codec, cs421x_coef_init_verbs);
-	snd_hda_sequence_write(codec, cs421x_coef_init_verbs_A1_silicon_fixes);
-
-	cs421x_pinmux_init(codec);
+	if (spec->vendor_nid == CS4210_VENDOR_NID) {
+		snd_hda_sequence_write(codec, cs421x_coef_init_verbs);
+		snd_hda_sequence_write(codec, cs421x_coef_init_verbs_A1_silicon_fixes);
+		cs4210_pinmux_init(codec);
+	}
 
 	if (spec->gpio_mask) {
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
@@ -1791,7 +1796,7 @@ static int build_cs421x_output(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	if (cfg->speaker_outs) {
+	if (cfg->speaker_outs && (spec->vendor_nid == CS4210_VENDOR_NID)) {
 		err = snd_hda_ctl_add(codec, 0,
 			snd_ctl_new1(&cs421x_speaker_bost_ctl, codec));
 		if (err < 0)
@@ -1888,6 +1893,7 @@ static int cs421x_parse_auto_config(struct hda_codec *codec)
 */
 static int cs421x_suspend(struct hda_codec *codec, pm_message_t state)
 {
+	struct cs_spec *spec = codec->spec;
 	unsigned int coef;
 
 	snd_hda_shutup_pins(codec);
@@ -1897,15 +1903,17 @@ static int cs421x_suspend(struct hda_codec *codec, pm_message_t state)
 	snd_hda_codec_write(codec, CS4210_ADC_NID, 0,
 			    AC_VERB_SET_POWER_STATE,  AC_PWRST_D3);
 
-	coef = cs_vendor_coef_get(codec, CS421X_IDX_DEV_CFG);
-	coef |= 0x0004; /* PDREF */
-	cs_vendor_coef_set(codec, CS421X_IDX_DEV_CFG, coef);
+	if (spec->vendor_nid == CS4210_VENDOR_NID) {
+		coef = cs_vendor_coef_get(codec, CS421X_IDX_DEV_CFG);
+		coef |= 0x0004; /* PDREF */
+		cs_vendor_coef_set(codec, CS421X_IDX_DEV_CFG, coef);
+	}
 
 	return 0;
 }
 #endif
 
-static struct hda_codec_ops cs4210_patch_ops = {
+static struct hda_codec_ops cs421x_patch_ops = {
 	.build_controls = cs421x_build_controls,
 	.build_pcms = cs_build_pcms,
 	.init = cs421x_init,
@@ -1916,7 +1924,7 @@ static struct hda_codec_ops cs4210_patch_ops = {
 #endif
 };
 
-static int patch_cs421x(struct hda_codec *codec)
+static int patch_cs4210(struct hda_codec *codec)
 {
 	struct cs_spec *spec;
 	int err;
@@ -1926,7 +1934,7 @@ static int patch_cs421x(struct hda_codec *codec)
 		return -ENOMEM;
 	codec->spec = spec;
 
-	spec->vendor_nid = CS421X_VENDOR_NID;
+	spec->vendor_nid = CS4210_VENDOR_NID;
 
 	spec->board_config =
 		snd_hda_check_board_config(codec, CS421X_MODELS,
@@ -1954,14 +1962,39 @@ static int patch_cs421x(struct hda_codec *codec)
 	    is auto-parsed. If GPIO or SENSE_B is forced, DMIC input
 	    is disabled.
 	*/
-	cs421x_pinmux_init(codec);
+	cs4210_pinmux_init(codec);
 
 	err = cs421x_parse_auto_config(codec);
 	if (err < 0)
 		goto error;
 
-	codec->patch_ops = cs4210_patch_ops;
+	codec->patch_ops = cs421x_patch_ops;
+
+	return 0;
+
+ error:
+	kfree(codec->spec);
+	codec->spec = NULL;
+	return err;
+}
+
+static int patch_cs4213(struct hda_codec *codec)
+{
+	struct cs_spec *spec;
+	int err;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	codec->spec = spec;
+
+	spec->vendor_nid = CS4213_VENDOR_NID;
+
+	err = cs421x_parse_auto_config(codec);
+	if (err < 0)
+		goto error;
 
+	codec->patch_ops = cs421x_patch_ops;
 	return 0;
 
  error:
@@ -1977,13 +2010,15 @@ static int patch_cs421x(struct hda_codec *codec)
 static const struct hda_codec_preset snd_hda_preset_cirrus[] = {
 	{ .id = 0x10134206, .name = "CS4206", .patch = patch_cs420x },
 	{ .id = 0x10134207, .name = "CS4207", .patch = patch_cs420x },
-	{ .id = 0x10134210, .name = "CS4210", .patch = patch_cs421x },
+	{ .id = 0x10134210, .name = "CS4210", .patch = patch_cs4210 },
+	{ .id = 0x10134213, .name = "CS4213", .patch = patch_cs4213 },
 	{} /* terminator */
 };
 
 MODULE_ALIAS("snd-hda-codec-id:10134206");
 MODULE_ALIAS("snd-hda-codec-id:10134207");
 MODULE_ALIAS("snd-hda-codec-id:10134210");
+MODULE_ALIAS("snd-hda-codec-id:10134213");
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cirrus Logic HD-audio codec");
-- 
1.7.5.4
