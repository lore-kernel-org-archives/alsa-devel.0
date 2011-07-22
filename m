From: Tim Howe <tim.howe@cirrus.com>
Subject: [PATCH] Cirrus Logic CS421x support
Date: Fri, 22 Jul 2011 16:41:00 -0500
Message-ID: <1311370860-29731-1-git-send-email-tim.howe@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id E27DA103806
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 23:42:12 +0200 (CEST)
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
Cc: tiwai@suse.de, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

This update includes the changes necessary for supporting the
CS421x family of codecs.  Previously this file only supported
the CS420x family of codecs.

This file also contains init verbs to correct several issues in
the CS421x hardware.

Behavior between the CS421x and CS420x codec families is similar,
so several functions have been reused with "if" statements to
determine which codec family (CS421x or CS420x) is present.

Also, this file will be updated sometime in the near future in
order to add support for a system using CS421x that requires
mono mix on the speaker output only.

Signed-off-by: Tim Howe <tim.howe@cirrus.com>
---
 sound/pci/hda/patch_cirrus.c |  786 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 745 insertions(+), 41 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 7f93739..27dbd5c 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -25,6 +25,7 @@
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
+#include <sound/tlv.h>
 
 /*
  */
@@ -61,9 +62,15 @@ struct cs_spec {
 
 	unsigned int hp_detect:1;
 	unsigned int mic_detect:1;
+	/* CS421x */
+	unsigned int spdif_detect:1;
+	unsigned int sense_b:1;
+	hda_nid_t vendor_nid;
+	struct hda_input_mux input_mux;
+	unsigned int last_input;
 };
 
-/* available models */
+/* available models with CS420x */
 enum {
 	CS420X_MBP53,
 	CS420X_MBP55,
@@ -72,6 +79,12 @@ enum {
 	CS420X_MODELS
 };
 
+/* CS421x boards */
+enum {
+	CS421X_CDB4210,
+	CS421X_MODELS
+};
+
 /* Vendor-specific processing widget */
 #define CS420X_VENDOR_NID	0x11
 #define CS_DIG_OUT1_PIN_NID	0x10
@@ -111,21 +124,42 @@ enum {
 /* 0x0009 - 0x0014 -> 12 test regs */
 /* 0x0015 - visibility reg */
 
+/*
+ * Cirrus Logic CS4210
+ *
+ * 1 DAC => HP(sense) / Speakers,
+ * 1 ADC <= LineIn(sense) / MicIn / DMicIn,
+ * 1 SPDIF OUT => SPDIF Trasmitter(sense)
+*/
+#define CS4210_DAC_NID		0x02
+#define CS4210_ADC_NID		0x03
+#define CS421X_VENDOR_NID	0x0B
+#define CS421X_DMIC_PIN_NID	0x09 /* Port E */
+#define CS421X_SPDIF_PIN_NID	0x0A /* Port H */
+
+#define CS421X_IDX_DEV_CFG	0x01
+#define CS421X_IDX_ADC_CFG	0x02
+#define CS421X_IDX_DAC_CFG	0x03
+#define CS421X_IDX_SPK_CTL	0x04
+
+#define SPDIF_EVENT		0x04
 
 static inline int cs_vendor_coef_get(struct hda_codec *codec, unsigned int idx)
 {
-	snd_hda_codec_write(codec, CS420X_VENDOR_NID, 0,
+	struct cs_spec *spec = codec->spec;
+	snd_hda_codec_write(codec, spec->vendor_nid, 0,
 			    AC_VERB_SET_COEF_INDEX, idx);
-	return snd_hda_codec_read(codec, CS420X_VENDOR_NID, 0,
+	return snd_hda_codec_read(codec, spec->vendor_nid, 0,
 				  AC_VERB_GET_PROC_COEF, 0);
 }
 
 static inline void cs_vendor_coef_set(struct hda_codec *codec, unsigned int idx,
 				      unsigned int coef)
 {
-	snd_hda_codec_write(codec, CS420X_VENDOR_NID, 0,
+	struct cs_spec *spec = codec->spec;
+	snd_hda_codec_write(codec, spec->vendor_nid, 0,
 			    AC_VERB_SET_COEF_INDEX, idx);
-	snd_hda_codec_write(codec, CS420X_VENDOR_NID, 0,
+	snd_hda_codec_write(codec, spec->vendor_nid, 0,
 			    AC_VERB_SET_PROC_COEF, coef);
 }
 
@@ -343,18 +377,44 @@ static hda_nid_t get_adc(struct hda_codec *codec, hda_nid_t pin,
 {
 	int i;
 	hda_nid_t nid;
+	struct cs_spec *spec = codec->spec;
 
 	nid = codec->start_nid;
 	for (i = 0; i < codec->num_nodes; i++, nid++) {
 		unsigned int type;
-		int idx;
-		type = get_wcaps_type(get_wcaps(codec, nid));
-		if (type != AC_WID_AUD_IN)
-			continue;
-		idx = snd_hda_get_conn_index(codec, nid, pin, 0);
-		if (idx >= 0) {
-			*idxp = idx;
-			return nid;
+		int j, nums;
+		/* specific to CS421x */
+		if (spec->vendor_nid == CS421X_VENDOR_NID) {
+			hda_nid_t pins[HDA_MAX_NUM_INPUTS];
+			type = (get_wcaps(codec, nid) & AC_WCAP_TYPE)
+			>> AC_WCAP_TYPE_SHIFT;
+			if (type != AC_WID_AUD_IN)
+				continue;
+			nums = snd_hda_get_connections(codec, nid, pins,
+							ARRAY_SIZE(pins));
+			if (nums <= 0)
+				continue;
+			for (j = 0; j < nums; j++) {
+				if (pins[j] == pin) {
+					*idxp = j;
+					return nid;
+				}
+			}
+		} else {
+			hda_nid_t pins[2];
+			type = get_wcaps_type(get_wcaps(codec, nid));
+			if (type != AC_WID_AUD_IN)
+				continue;
+			nums = snd_hda_get_connections(codec, nid, pins,
+							ARRAY_SIZE(pins));
+			if (nums <= 0)
+				continue;
+			for (j = 0; j < nums; j++) {
+				if (pins[j] == pin) {
+					*idxp = j;
+					return nid;
+				}
+			}
 		}
 	}
 	return 0;
@@ -835,6 +895,8 @@ static int build_digital_input(struct hda_codec *codec)
 
 /*
  * auto-mute and auto-mic switching
+ * CS421x auto-output redirecting
+ * HP/SPK/SPDIF
  */
 
 static void cs_automute(struct hda_codec *codec)
@@ -842,9 +904,25 @@ static void cs_automute(struct hda_codec *codec)
 	struct cs_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	unsigned int hp_present;
+	unsigned int spdif_present;
 	hda_nid_t nid;
 	int i;
 
+	spdif_present = 0;
+	if (cfg->dig_outs) {
+		nid = cfg->dig_out_pins[0];
+		if (is_jack_detectable(codec, nid)) {
+			/*
+			TODO: SPDIF output redirect when SENSE_B is enabled.
+			Shared (SENSE_A) jack (e.g HP/mini-TOSLINK)
+			assumed.
+			*/
+			if (snd_hda_jack_detect(codec, nid)
+				/* && spec->sense_b */)
+				spdif_present = 1;
+		}
+	}
+
 	hp_present = 0;
 	for (i = 0; i < cfg->hp_outs; i++) {
 		nid = cfg->hp_pins[i];
@@ -854,11 +932,19 @@ static void cs_automute(struct hda_codec *codec)
 		if (hp_present)
 			break;
 	}
+
+	/* mute speakers if spdif or hp jack is plugged in */
 	for (i = 0; i < cfg->speaker_outs; i++) {
 		nid = cfg->speaker_pins[i];
 		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
 				    hp_present ? 0 : PIN_OUT);
+		/* detect on spdif is specific to CS421x */
+		if (spec->vendor_nid == CS421X_VENDOR_NID) {
+			snd_hda_codec_write(codec, nid, 0,
+					AC_VERB_SET_PIN_WIDGET_CONTROL,
+					spdif_present ? 0 : PIN_OUT);
+		}
 	}
 	if (spec->board_config == CS420X_MBP53 ||
 	    spec->board_config == CS420X_MBP55 ||
@@ -867,21 +953,62 @@ static void cs_automute(struct hda_codec *codec)
 		snd_hda_codec_write(codec, 0x01, 0,
 				    AC_VERB_SET_GPIO_DATA, gpio);
 	}
+
+	/* specific to CS421x */
+	if (spec->vendor_nid == CS421X_VENDOR_NID) {
+		/* mute HPs if spdif jack (SENSE_B) is present */
+		for (i = 0; i < cfg->hp_outs; i++) {
+			nid = cfg->hp_pins[i];
+			snd_hda_codec_write(codec, nid, 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL,
+				(spdif_present && spec->sense_b) ? 0 : PIN_HP);
+		}
+
+		/* SPDIF TX on/off */
+		if (cfg->dig_outs) {
+			nid = cfg->dig_out_pins[0];
+			snd_hda_codec_write(codec, nid, 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL,
+				spdif_present ? PIN_OUT : 0);
+
+		}
+		/* Update board GPIOs if neccessary ... */
+	}
 }
 
+/*
+ * Auto-input redirect for CS421x
+ * Switch max 3 inputs of a single ADC (nid 3)
+*/
+
 static void cs_automic(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	hda_nid_t nid;
 	unsigned int present;
-	
+
 	nid = cfg->inputs[spec->automic_idx].pin;
 	present = snd_hda_jack_detect(codec, nid);
-	if (present)
-		change_cur_input(codec, spec->automic_idx, 0);
-	else
-		change_cur_input(codec, !spec->automic_idx, 0);
+
+	/* specific to CS421x, single ADC */
+	if (spec->vendor_nid == CS421X_VENDOR_NID) {
+		if (present) {
+			spec->last_input = spec->cur_input;
+			spec->cur_input = spec->automic_idx;
+		} else  {
+			spec->cur_input = spec->last_input;
+		}
+
+		snd_hda_codec_write_cache(codec, spec->cur_adc, 0,
+					AC_VERB_SET_CONNECT_SEL,
+					spec->adc_idx[spec->cur_input]);
+	} else {
+		if (present)
+			change_cur_input(codec, spec->automic_idx, 0);
+		else
+			change_cur_input(codec, !spec->automic_idx, 0);
+	}
 }
 
 /*
@@ -911,23 +1038,28 @@ static void init_output(struct hda_codec *codec)
 	for (i = 0; i < cfg->line_outs; i++)
 		snd_hda_codec_write(codec, cfg->line_out_pins[i], 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	/* HP */
 	for (i = 0; i < cfg->hp_outs; i++) {
 		hda_nid_t nid = cfg->hp_pins[i];
 		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP);
 		if (!cfg->speaker_outs)
 			continue;
-		if (is_jack_detectable(codec, nid)) {
+		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
 			snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_UNSOLICITED_ENABLE,
 					    AC_USRSP_EN | HP_EVENT);
 			spec->hp_detect = 1;
 		}
 	}
+
+	/* Speaker */
 	for (i = 0; i < cfg->speaker_outs; i++)
 		snd_hda_codec_write(codec, cfg->speaker_pins[i], 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-	if (spec->hp_detect)
+
+	/* SPDIF is enabled on presence detect for CS421x */
+	if (spec->hp_detect || spec->spdif_detect)
 		cs_automute(codec);
 }
 
@@ -961,19 +1093,31 @@ static void init_input(struct hda_codec *codec)
 					    AC_VERB_SET_UNSOLICITED_ENABLE,
 					    AC_USRSP_EN | MIC_EVENT);
 	}
-	change_cur_input(codec, spec->cur_input, 1);
-	if (spec->mic_detect)
-		cs_automic(codec);
-
-	coef = 0x000a; /* ADC1/2 - Digital and Analog Soft Ramp */
-	if (is_active_pin(codec, CS_DMIC2_PIN_NID))
-		coef |= 0x0500; /* DMIC2 enable 2 channels, disable GPIO1 */
-	if (is_active_pin(codec, CS_DMIC1_PIN_NID))
-		coef |= 0x1800; /* DMIC1 enable 2 channels, disable GPIO0 
-				 * No effect if SPDIF_OUT2 is selected in 
-				 * IDX_SPDIF_CTL.
-				  */
-	cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+	/* specific to CS421x */
+	if (spec->vendor_nid == CS421X_VENDOR_NID) {
+		if (spec->mic_detect)
+			cs_automic(codec);
+		else  {
+			spec->cur_adc = spec->adc_nid[spec->cur_input];
+			snd_hda_codec_write(codec, spec->cur_adc, 0,
+					AC_VERB_SET_CONNECT_SEL,
+					spec->adc_idx[spec->cur_input]);
+		}
+	} else {
+		change_cur_input(codec, spec->cur_input, 1);
+		if (spec->mic_detect)
+			cs_automic(codec);
+
+		coef = 0x000a; /* ADC1/2 - Digital and Analog Soft Ramp */
+		if (is_active_pin(codec, CS_DMIC2_PIN_NID))
+			coef |= 0x0500; /* DMIC2 2 chan on, GPIO1 off */
+		if (is_active_pin(codec, CS_DMIC1_PIN_NID))
+			coef |= 0x1800; /* DMIC1 2 chan on, GPIO0 off
+					 * No effect if SPDIF_OUT2 is
+					 * selected in IDX_SPDIF_CTL.
+					*/
+		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+	}
 }
 
 static const struct hda_verb cs_coef_init_verbs[] = {
@@ -1173,7 +1317,7 @@ struct cs_pincfg {
 	u32 val;
 };
 
-static const struct cs_pincfg mbp53_pincfgs[] = {
+static struct cs_pincfg mbp53_pincfgs[] = {
 	{ 0x09, 0x012b4050 },
 	{ 0x0a, 0x90100141 },
 	{ 0x0b, 0x90100140 },
@@ -1187,7 +1331,7 @@ static const struct cs_pincfg mbp53_pincfgs[] = {
 	{} /* terminator */
 };
 
-static const struct cs_pincfg mbp55_pincfgs[] = {
+static struct cs_pincfg mbp55_pincfgs[] = {
 	{ 0x09, 0x012b4030 },
 	{ 0x0a, 0x90100121 },
 	{ 0x0b, 0x90100120 },
@@ -1201,7 +1345,7 @@ static const struct cs_pincfg mbp55_pincfgs[] = {
 	{} /* terminator */
 };
 
-static const struct cs_pincfg imac27_pincfgs[] = {
+static struct cs_pincfg imac27_pincfgs[] = {
 	{ 0x09, 0x012b4050 },
 	{ 0x0a, 0x90100140 },
 	{ 0x0b, 0x90100142 },
@@ -1215,22 +1359,22 @@ static const struct cs_pincfg imac27_pincfgs[] = {
 	{} /* terminator */
 };
 
-static const struct cs_pincfg *cs_pincfgs[CS420X_MODELS] = {
+static struct cs_pincfg *cs_pincfgs[CS420X_MODELS] = {
 	[CS420X_MBP53] = mbp53_pincfgs,
 	[CS420X_MBP55] = mbp55_pincfgs,
 	[CS420X_IMAC27] = imac27_pincfgs,
 };
 
-static void fix_pincfg(struct hda_codec *codec, int model)
+static void fix_pincfg(struct hda_codec *codec, int model,
+	struct cs_pincfg **pin_configs)
 {
-	const struct cs_pincfg *cfg = cs_pincfgs[model];
+	const struct cs_pincfg *cfg = pin_configs[model];
 	if (!cfg)
 		return;
 	for (; cfg->nid; cfg++)
 		snd_hda_codec_set_pincfg(codec, cfg->nid, cfg->val);
 }
 
-
 static int patch_cs420x(struct hda_codec *codec)
 {
 	struct cs_spec *spec;
@@ -1241,11 +1385,13 @@ static int patch_cs420x(struct hda_codec *codec)
 		return -ENOMEM;
 	codec->spec = spec;
 
+	spec->vendor_nid = CS420X_VENDOR_NID;
+
 	spec->board_config =
 		snd_hda_check_board_config(codec, CS420X_MODELS,
 					   cs420x_models, cs420x_cfg_tbl);
 	if (spec->board_config >= 0)
-		fix_pincfg(codec, spec->board_config);
+		fix_pincfg(codec, spec->board_config, cs_pincfgs);
 
 	switch (spec->board_config) {
 	case CS420X_IMAC27:
@@ -1272,6 +1418,562 @@ static int patch_cs420x(struct hda_codec *codec)
 	return err;
 }
 
+/*
+ * Cirrus Logic CS4210
+ *
+ * 1 DAC => HP(sense) / Speakers,
+ * 1 ADC <= LineIn(sense) / MicIn / DMicIn,
+ * 1 SPDIF OUT => SPDIF Trasmitter(sense)
+*/
+
+/* CS4210 board names */
+static const char *cs421x_models[CS421X_MODELS] = {
+	[CS421X_CDB4210] = "cdb4210",
+};
+
+static struct snd_pci_quirk cs421x_cfg_tbl[] = {
+	/* Test Intel board + CDB2410  */
+	SND_PCI_QUIRK(0x8086, 0x5001, "DP45SG/CDB4210", CS421X_CDB4210),
+	{} /* terminator */
+};
+
+/* CS4210 board pinconfigs */
+/* Default CS4210 (CDB4210)*/
+static struct cs_pincfg cdb4210_pincfgs[] = {
+	{ 0x05, 0x0321401f },
+	{ 0x06, 0x90170010 },
+	{ 0x07, 0x03813031 },
+	{ 0x08, 0xb7a70037 },
+	{ 0x09, 0xb7a6003e },
+	{ 0x0a, 0x034510f0 },
+	{} /* terminator */
+};
+
+static struct cs_pincfg *cs421x_pincfgs[CS421X_MODELS] = {
+	[CS421X_CDB4210] = cdb4210_pincfgs,
+};
+
+static struct hda_verb cs421x_coef_init_verbs[] = {
+	{0x0B, AC_VERB_SET_PROC_STATE, 1},
+	{0x0B, AC_VERB_SET_COEF_INDEX, CS421X_IDX_DEV_CFG},
+	/*
+	    Disable Coefficient Index Auto-Increment(DAI)=1,
+	    PDREF=0
+	*/
+	{0x0B, AC_VERB_SET_PROC_COEF, 0x0001 },
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, CS421X_IDX_ADC_CFG},
+	/* ADC SZCMode = Digital Soft Ramp */
+	{0x0B, AC_VERB_SET_PROC_COEF, 0x0002 },
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, CS421X_IDX_DAC_CFG},
+	{0x0B, AC_VERB_SET_PROC_COEF,
+	 (0x0002 /* DAC SZCMode = Digital Soft Ramp */
+	  | 0x0004 /* Mute DAC on FIFO error */
+	  | 0x0008 /* Enable DAC High Pass Filter */
+	  )},
+	{} /* terminator */
+};
+
+/* Errata: CS4210 rev A1 Silicon
+ *
+ * http://www.cirrus.com/en/pubs/errata/
+ *
+ * Description:
+ * 1. Performance degredation is present in the ADC.
+ * 2. Speaker output is not completely muted upon HP detect.
+ * 3. Noise is present when clipping occurs on the amplified
+ *    speaker outputs.
+ *
+ * Workaround:
+ * The following verb sequence written to the registers during
+ * initialization will correct the issues listed above.
+ */
+
+static struct hda_verb cs421x_coef_init_verbs_A1_silicon_fixes[] = {
+	{0x0B, AC_VERB_SET_PROC_STATE, 0x01},  /* VPW: processing on */
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, 0x0006},
+	{0x0B, AC_VERB_SET_PROC_COEF, 0x9999}, /* Test mode: on */
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, 0x000A},
+	{0x0B, AC_VERB_SET_PROC_COEF, 0x14CB}, /* Chop double */
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, 0x0011},
+	{0x0B, AC_VERB_SET_PROC_COEF, 0xA2D0}, /* Increase ADC current */
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, 0x001A},
+	{0x0B, AC_VERB_SET_PROC_COEF, 0x02A9}, /* Mute speaker */
+
+	{0x0B, AC_VERB_SET_COEF_INDEX, 0x001B},
+	{0x0B, AC_VERB_SET_PROC_COEF, 0X1006}, /* Remove noise */
+
+	{} /* terminator */
+};
+
+/* Speaker Amp Gain is controlled by the vendor widget's coef 4 */
+static const DECLARE_TLV_DB_SCALE(cs421x_speaker_boost_db_scale, 900, 300, 0);
+
+static int cs421x_boost_vol_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 3;
+	return 0;
+}
+
+static int cs421x_boost_vol_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] =
+		cs_vendor_coef_get(codec, CS421X_IDX_SPK_CTL) & 0x0003;
+	return 0;
+}
+
+static int cs421x_boost_vol_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	unsigned int vol = ucontrol->value.integer.value[0];
+	unsigned int coef =
+		cs_vendor_coef_get(codec, CS421X_IDX_SPK_CTL);
+	unsigned int original_coef = coef;
+
+	coef &= ~0x0003;
+	coef |= (vol & 0x0003);
+	if (original_coef == coef)
+		return 0;
+	else {
+		cs_vendor_coef_set(codec, CS421X_IDX_SPK_CTL, coef);
+		return 1;
+	}
+}
+
+static const struct snd_kcontrol_new cs421x_speaker_bost_ctl = {
+
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+	.name = "Speaker Boost Playback Volume",
+	.info = cs421x_boost_vol_info,
+	.get = cs421x_boost_vol_get,
+	.put = cs421x_boost_vol_put,
+	.tlv = { .p = cs421x_speaker_boost_db_scale },
+};
+
+static void cs421x_pinmux_init(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+	unsigned int def_conf, coef;
+
+	/* GPIO, DMIC_SCL, DMIC_SDA and SENSE_B are multiplexed */
+	coef = cs_vendor_coef_get(codec, CS421X_IDX_DEV_CFG);
+
+	if (spec->gpio_mask)
+		coef |= 0x0008; /* B1,B2 are GPIOs */
+	else
+		coef &= ~0x0008;
+
+	if (spec->sense_b)
+		coef |= 0x0010; /* B2 is SENSE_B, not inverted  */
+	else
+		coef &= ~0x0010;
+
+	cs_vendor_coef_set(codec, CS421X_IDX_DEV_CFG, coef);
+
+	if ((spec->gpio_mask || spec->sense_b) &&
+	    is_active_pin(codec, CS421X_DMIC_PIN_NID)) {
+
+		/*
+		    GPIO or SENSE_B forced - disconnect the DMIC pin.
+		*/
+		def_conf = snd_hda_codec_get_pincfg(codec, CS421X_DMIC_PIN_NID);
+		def_conf &= ~AC_DEFCFG_PORT_CONN;
+		def_conf |= (AC_JACK_PORT_NONE << AC_DEFCFG_PORT_CONN_SHIFT);
+		snd_hda_codec_set_pincfg(codec, CS421X_DMIC_PIN_NID, def_conf);
+	}
+}
+
+static void init_cs421x_digital(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
+
+
+	for (i = 0; i < cfg->dig_outs; i++) {
+		hda_nid_t nid = cfg->dig_out_pins[i];
+		if (!cfg->speaker_outs)
+			continue;
+		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
+
+			snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_UNSOLICITED_ENABLE,
+				    AC_USRSP_EN | SPDIF_EVENT);
+			spec->spdif_detect = 1;
+		}
+	}
+}
+
+static int cs421x_init(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+
+	snd_hda_sequence_write(codec, cs421x_coef_init_verbs);
+	snd_hda_sequence_write(codec, cs421x_coef_init_verbs_A1_silicon_fixes);
+
+	cs421x_pinmux_init(codec);
+
+	if (spec->gpio_mask) {
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
+				    spec->gpio_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
+				    spec->gpio_dir);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+				    spec->gpio_data);
+	}
+
+	init_output(codec);
+	init_input(codec);
+	init_cs421x_digital(codec);
+
+	return 0;
+}
+
+/*
+ * CS4210 Input MUX (1 ADC)
+ */
+static int cs421x_mux_enum_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
+}
+
+static int cs421x_mux_enum_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_input;
+	return 0;
+}
+
+static int cs421x_mux_enum_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_put(codec, &spec->input_mux, ucontrol,
+				spec->adc_nid[0], &spec->cur_input);
+
+}
+
+static struct snd_kcontrol_new cs421x_capture_source = {
+
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Source",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = cs421x_mux_enum_info,
+	.get = cs421x_mux_enum_get,
+	.put = cs421x_mux_enum_put,
+};
+
+static int cs421x_add_input_volume_control(struct hda_codec *codec, int item)
+{
+	struct cs_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	const struct hda_input_mux *imux = &spec->input_mux;
+	hda_nid_t pin = cfg->inputs[item].pin;
+	struct snd_kcontrol *kctl;
+	u32 caps;
+
+	if (!(get_wcaps(codec, pin) & AC_WCAP_IN_AMP))
+		return 0;
+
+	caps = query_amp_caps(codec, pin, HDA_INPUT);
+	caps = (caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
+	if (caps <= 1)
+		return 0;
+
+	return add_volume(codec,  imux->items[item].label, 0,
+			  HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_INPUT), 1, &kctl);
+}
+
+/* add a (input-boost) volume control to the given input pin */
+static int build_cs421x_input(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	struct hda_input_mux *imux = &spec->input_mux;
+	int i, err, type_idx;
+	const char *label;
+
+	if (!spec->num_inputs)
+		return 0;
+
+	/* make bind-capture */
+	spec->capture_bind[0] = make_bind_capture(codec, &snd_hda_bind_sw);
+	spec->capture_bind[1] = make_bind_capture(codec, &snd_hda_bind_vol);
+	for (i = 0; i < 2; i++) {
+		struct snd_kcontrol *kctl;
+		int n;
+		if (!spec->capture_bind[i])
+			return -ENOMEM;
+		kctl = snd_ctl_new1(&cs_capture_ctls[i], codec);
+		if (!kctl)
+			return -ENOMEM;
+		kctl->private_value = (long)spec->capture_bind[i];
+		err = snd_hda_ctl_add(codec, 0, kctl);
+		if (err < 0)
+			return err;
+		for (n = 0; n < AUTO_PIN_LAST; n++) {
+			if (!spec->adc_nid[n])
+				continue;
+			err = snd_hda_add_nid(codec, kctl, 0, spec->adc_nid[n]);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/* Add Input MUX Items + Capture Volume/Switch */
+	for (i = 0; i < spec->num_inputs; i++) {
+		label = hda_get_autocfg_input_label(codec, cfg, i);
+		snd_hda_add_imux_item(imux, label, spec->adc_idx[i], &type_idx);
+
+		err = cs421x_add_input_volume_control(codec, i);
+		if (err < 0)
+			return err;
+	}
+
+	/*
+	    Add 'Capture Source' Switch if
+		* 2 inputs and no mic detec
+		* 3 inputs
+	*/
+	if ((spec->num_inputs == 2 && !spec->mic_detect) ||
+	    (spec->num_inputs == 3)) {
+
+		err = snd_hda_ctl_add(codec, spec->adc_nid[0],
+			      snd_ctl_new1(&cs421x_capture_source, codec));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Single DAC (Mute/Gain) */
+static int build_cs421x_output(struct hda_codec *codec)
+{
+	hda_nid_t dac = CS4210_DAC_NID;
+	struct cs_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	struct snd_kcontrol *kctl;
+	int err;
+	char *name = "HP/Speakers";
+
+	fix_volume_caps(codec, dac);
+	if (!spec->vmaster_sw) {
+		err = add_vmaster(codec, dac);
+		if (err < 0)
+			return err;
+	}
+
+	err = add_mute(codec, name, 0,
+			HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
+	if (err < 0)
+		return err;
+	err = snd_ctl_add_slave(spec->vmaster_sw, kctl);
+	if (err < 0)
+		return err;
+
+	err = add_volume(codec, name, 0,
+			HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
+	if (err < 0)
+		return err;
+	err = snd_ctl_add_slave(spec->vmaster_vol, kctl);
+	if (err < 0)
+		return err;
+
+	if (cfg->speaker_outs) {
+		err = snd_hda_ctl_add(codec, 0,
+			snd_ctl_new1(&cs421x_speaker_bost_ctl, codec));
+		if (err < 0)
+			return err;
+	}
+	return err;
+}
+
+static int cs421x_build_controls(struct hda_codec *codec)
+{
+	int err;
+
+	err = build_cs421x_output(codec);
+	if (err < 0)
+		return err;
+	err = build_cs421x_input(codec);
+	if (err < 0)
+		return err;
+	err = build_digital_output(codec);
+	if (err < 0)
+		return err;
+	return cs421x_init(codec);
+}
+
+static void cs421x_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	switch ((res >> 26) & 0x3f) {
+	case HP_EVENT:
+	case SPDIF_EVENT:
+		cs_automute(codec);
+		break;
+
+	case MIC_EVENT:
+		cs_automic(codec);
+		break;
+	}
+}
+
+static int parse_cs421x_input(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
+
+	for (i = 0; i < cfg->num_inputs; i++) {
+		hda_nid_t pin = cfg->inputs[i].pin;
+		spec->adc_nid[i] = get_adc(codec, pin, &spec->adc_idx[i]);
+		spec->cur_input = spec->last_input = i;
+		spec->num_inputs++;
+
+		/* check whether the automatic mic switch is available */
+		if (is_ext_mic(codec, i) && cfg->num_inputs >= 2) {
+			spec->mic_detect = 1;
+			spec->automic_idx = i;
+		}
+	}
+	return 0;
+}
+
+static int cs421x_parse_auto_config(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+	int err;
+
+	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
+	if (err < 0)
+		return err;
+	err = parse_output(codec);
+	if (err < 0)
+		return err;
+	err = parse_cs421x_input(codec);
+	if (err < 0)
+		return err;
+	err = parse_digital_output(codec);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+#ifdef SND_HDA_NEEDS_RESUME
+/*
+	Manage PDREF, when transitioning to D3hot
+	(DAC,ADC) -> D3, PDREF=1, AFG->D3
+*/
+static int cs421x_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	unsigned int coef;
+
+	snd_hda_shutup_pins(codec);
+
+	snd_hda_codec_write(codec, CS4210_DAC_NID, 0,
+			    AC_VERB_SET_POWER_STATE,  AC_PWRST_D3);
+	snd_hda_codec_write(codec, CS4210_ADC_NID, 0,
+			    AC_VERB_SET_POWER_STATE,  AC_PWRST_D3);
+
+	coef = cs_vendor_coef_get(codec, CS421X_IDX_DEV_CFG);
+	coef |= 0x0004; /* PDREF */
+	cs_vendor_coef_set(codec, CS421X_IDX_DEV_CFG, coef);
+
+	return 0;
+}
+#endif
+
+static struct hda_codec_ops cs4210_patch_ops = {
+	.build_controls = cs421x_build_controls,
+	.build_pcms = cs_build_pcms,
+	.init = cs421x_init,
+	.free = cs_free,
+	.unsol_event = cs421x_unsol_event,
+#ifdef SND_HDA_NEEDS_RESUME
+	.suspend = cs421x_suspend,
+#endif
+};
+
+static int patch_cs421x(struct hda_codec *codec)
+{
+	struct cs_spec *spec;
+	int err;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	codec->spec = spec;
+
+	spec->vendor_nid = CS421X_VENDOR_NID;
+
+	spec->board_config =
+		snd_hda_check_board_config(codec, CS421X_MODELS,
+					   cs421x_models, cs421x_cfg_tbl);
+	if (spec->board_config >= 0)
+		fix_pincfg(codec, spec->board_config, cs421x_pincfgs);
+	/*
+	    Setup GPIO/SENSE for each board (if used)
+	*/
+	switch (spec->board_config) {
+	case CS421X_CDB4210:
+		snd_printd("CS4210 board: %s\n",
+			cs421x_models[spec->board_config]);
+/*		spec->gpio_mask = 3;
+		spec->gpio_dir = 3;
+		spec->gpio_data = 3;
+*/
+		spec->sense_b = 1;
+
+		break;
+	}
+
+	/*
+	    Update the GPIO/DMIC/SENSE_B pinmux before the configuration
+	    is auto-parsed. If GPIO or SENSE_B is forced, DMIC input
+	    is disabled.
+	*/
+	cs421x_pinmux_init(codec);
+
+	err = cs421x_parse_auto_config(codec);
+	if (err < 0)
+		goto error;
+
+	codec->patch_ops = cs4210_patch_ops;
+
+	return 0;
+
+ error:
+	kfree(codec->spec);
+	codec->spec = NULL;
+	return err;
+}
+
 
 /*
  * patch entries
@@ -1279,11 +1981,13 @@ static int patch_cs420x(struct hda_codec *codec)
 static const struct hda_codec_preset snd_hda_preset_cirrus[] = {
 	{ .id = 0x10134206, .name = "CS4206", .patch = patch_cs420x },
 	{ .id = 0x10134207, .name = "CS4207", .patch = patch_cs420x },
+	{ .id = 0x10134210, .name = "CS4210", .patch = patch_cs421x },
 	{} /* terminator */
 };
 
 MODULE_ALIAS("snd-hda-codec-id:10134206");
 MODULE_ALIAS("snd-hda-codec-id:10134207");
+MODULE_ALIAS("snd-hda-codec-id:10134210");
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cirrus Logic HD-audio codec");
-- 
1.7.0.4
