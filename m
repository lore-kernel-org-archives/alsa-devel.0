From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: add rt5639 support
Date: Tue, 8 Apr 2014 11:32:09 +0800
Message-ID: <1396927929-31775-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 43CC026545B
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 05:32:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch adds the rt5639 support

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 365 +++++++++++++++++++++++++++++++---------------
 sound/soc/codecs/rt5640.h |   3 +
 2 files changed, 250 insertions(+), 118 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6b8778f..f5b9ecc 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -361,24 +361,23 @@ static unsigned int bst_tlv[] = {
 static const char * const rt5640_data_select[] = {
 	"Normal", "left copy to right", "right copy to left", "Swap"};
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
+	RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if1_adc_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF1_ADC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if1_adc_enum, RT5640_DIG_INF_DATA,
+	RT5640_IF1_ADC_SEL_SFT, rt5640_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if2_dac_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF2_DAC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if2_dac_enum, RT5640_DIG_INF_DATA,
+	RT5640_IF2_DAC_SEL_SFT, rt5640_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if2_adc_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF2_ADC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if2_adc_enum, RT5640_DIG_INF_DATA,
+	RT5640_IF2_ADC_SEL_SFT, rt5640_data_select);
 
 /* Class D speaker gain ratio */
 static const char * const rt5640_clsd_spk_ratio[] = {"1.66x", "1.83x", "1.94x",
 	"2x", "2.11x", "2.22x", "2.33x", "2.44x", "2.55x", "2.66x", "2.77x"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_clsd_spk_ratio_enum, RT5640_CLS_D_OUT,
+static SOC_ENUM_SINGLE_DECL(rt5640_clsd_spk_ratio_enum, RT5640_CLS_D_OUT,
 	RT5640_CLSD_RATIO_SFT, rt5640_clsd_spk_ratio);
 
 static const struct snd_kcontrol_new rt5640_snd_controls[] = {
@@ -387,11 +386,13 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 		RT5640_VOL_L_SFT, RT5640_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5640_SPK_VOL,
 		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 39, 1, out_vol_tlv),
+
 	/* Headphone Output Volume */
 	SOC_DOUBLE("HP Channel Switch", RT5640_HP_VOL,
 		RT5640_VOL_L_SFT, RT5640_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("HP Playback Volume", RT5640_HP_VOL,
 		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 39, 1, out_vol_tlv),
+
 	/* OUTPUT Control */
 	SOC_DOUBLE("OUT Playback Switch", RT5640_OUTPUT,
 		RT5640_L_MUTE_SFT, RT5640_R_MUTE_SFT, 1, 1),
@@ -399,49 +400,54 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 		RT5640_VOL_L_SFT, RT5640_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("OUT Playback Volume", RT5640_OUTPUT,
 		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 39, 1, out_vol_tlv),
-	/* MONO Output Control */
-	SOC_SINGLE("Mono Playback Switch", RT5640_MONO_OUT,
-				RT5640_L_MUTE_SFT, 1, 1),
+
 	/* DAC Digital Volume */
 	SOC_DOUBLE("DAC2 Playback Switch", RT5640_DAC2_CTRL,
 		RT5640_M_DAC_L2_VOL_SFT, RT5640_M_DAC_R2_VOL_SFT, 1, 1),
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5640_DAC1_DIG_VOL,
-			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
-			175, 0, dac_vol_tlv),
-	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5640_DAC2_DIG_VOL,
-			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
-			175, 0, dac_vol_tlv),
+		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 175, 0, dac_vol_tlv),
+
 	/* IN1/IN2 Control */
-	SOC_SINGLE_TLV("IN1 Boost", RT5640_IN1_IN2,
-		RT5640_BST_SFT1, 8, 0, bst_tlv),
-	SOC_SINGLE_TLV("IN2 Boost", RT5640_IN3_IN4,
-		RT5640_BST_SFT2, 8, 0, bst_tlv),
+	SOC_SINGLE_TLV("IN1 Boost", RT5640_IN1_IN2, RT5640_BST_SFT1, 8, 0,
+		bst_tlv),
+	SOC_SINGLE_TLV("IN2 Boost", RT5640_IN3_IN4, RT5640_BST_SFT2, 8, 0,
+		bst_tlv),
+
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5640_INL_INR_VOL,
-			RT5640_INL_VOL_SFT, RT5640_INR_VOL_SFT,
-			31, 1, in_vol_tlv),
+		RT5640_INL_VOL_SFT, RT5640_INR_VOL_SFT, 31, 1, in_vol_tlv),
+
 	/* ADC Digital Volume Control */
 	SOC_DOUBLE("ADC Capture Switch", RT5640_ADC_DIG_VOL,
 		RT5640_L_MUTE_SFT, RT5640_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("ADC Capture Volume", RT5640_ADC_DIG_VOL,
-			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
-			127, 0, adc_vol_tlv),
+		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 127, 0, adc_vol_tlv),
 	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5640_ADC_DATA,
-			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
-			127, 0, adc_vol_tlv),
+		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 127, 0, adc_vol_tlv),
+
 	/* ADC Boost Volume Control */
 	SOC_DOUBLE_TLV("ADC Boost Gain", RT5640_ADC_BST_VOL,
-			RT5640_ADC_L_BST_SFT, RT5640_ADC_R_BST_SFT,
-			3, 0, adc_bst_tlv),
+		RT5640_ADC_L_BST_SFT, RT5640_ADC_R_BST_SFT, 3, 0, adc_bst_tlv),
+
 	/* Class D speaker gain ratio */
 	SOC_ENUM("Class D SPK Ratio Control", rt5640_clsd_spk_ratio_enum),
 
+	/* Data Swap */
 	SOC_ENUM("ADC IF1 Data Switch", rt5640_if1_adc_enum),
 	SOC_ENUM("DAC IF1 Data Switch", rt5640_if1_dac_enum),
 	SOC_ENUM("ADC IF2 Data Switch", rt5640_if2_adc_enum),
 	SOC_ENUM("DAC IF2 Data Switch", rt5640_if2_dac_enum),
 };
 
+static const struct snd_kcontrol_new rt5640_specific_snd_controls[] = {
+	/* MONO Output Control */
+	SOC_SINGLE("Mono Playback Switch", RT5640_MONO_OUT, RT5640_L_MUTE_SFT,
+		1, 1),
+
+	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5640_DAC2_DIG_VOL,
+		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 175, 0, dac_vol_tlv),
+};
+
 /**
  * set_dmic_clk - Set parameter of dmic.
  *
@@ -555,6 +561,20 @@ static const struct snd_kcontrol_new rt5640_sto_dac_r_mix[] = {
 			RT5640_M_ANC_DAC_R_SFT, 1, 1),
 };
 
+static const struct snd_kcontrol_new rt5639_sto_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5640_STO_DAC_MIXER,
+			RT5640_M_DAC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5640_STO_DAC_MIXER,
+			RT5640_M_DAC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_sto_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5640_STO_DAC_MIXER,
+			RT5640_M_DAC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5640_STO_DAC_MIXER,
+			RT5640_M_DAC_R2_SFT, 1, 1),
+};
+
 static const struct snd_kcontrol_new rt5640_mono_dac_l_mix[] = {
 	SOC_DAPM_SINGLE("DAC L1 Switch", RT5640_MONO_DAC_MIXER,
 			RT5640_M_DAC_L1_MONO_L_SFT, 1, 1),
@@ -677,6 +697,30 @@ static const struct snd_kcontrol_new rt5640_out_r_mix[] = {
 			RT5640_M_DAC_R1_OM_R_SFT, 1, 1),
 };
 
+static const struct snd_kcontrol_new rt5639_out_l_mix[] = {
+	SOC_DAPM_SINGLE("BST1 Switch", RT5640_OUT_L3_MIXER,
+			RT5640_M_BST1_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL Switch", RT5640_OUT_L3_MIXER,
+			RT5640_M_IN_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("REC MIXL Switch", RT5640_OUT_L3_MIXER,
+			RT5640_M_RM_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5640_OUT_L3_MIXER,
+			RT5640_M_DAC_L1_OM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_out_r_mix[] = {
+	SOC_DAPM_SINGLE("BST2 Switch", RT5640_OUT_R3_MIXER,
+			RT5640_M_BST4_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5640_OUT_R3_MIXER,
+			RT5640_M_BST1_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR Switch", RT5640_OUT_R3_MIXER,
+			RT5640_M_IN_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("REC MIXR Switch", RT5640_OUT_R3_MIXER,
+			RT5640_M_RM_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5640_OUT_R3_MIXER,
+			RT5640_M_DAC_R1_OM_R_SFT, 1, 1),
+};
+
 static const struct snd_kcontrol_new rt5640_spo_l_mix[] = {
 	SOC_DAPM_SINGLE("DAC R1 Switch", RT5640_SPO_L_MIXER,
 			RT5640_M_DAC_R1_SPM_L_SFT, 1, 1),
@@ -708,6 +752,13 @@ static const struct snd_kcontrol_new rt5640_hpo_mix[] = {
 			RT5640_M_HPVOL_HM_SFT, 1, 1),
 };
 
+static const struct snd_kcontrol_new rt5639_hpo_mix[] = {
+	SOC_DAPM_SINGLE("HPO MIX DAC1 Switch", RT5640_HPO_MIXER,
+			RT5640_M_DAC1_HM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("HPO MIX HPVOL Switch", RT5640_HPO_MIXER,
+			RT5640_M_HPVOL_HM_SFT, 1, 1),
+};
+
 static const struct snd_kcontrol_new rt5640_lout_mix[] = {
 	SOC_DAPM_SINGLE("DAC L1 Switch", RT5640_LOUT_MIXER,
 			RT5640_M_DAC_L1_LM_SFT, 1, 1),
@@ -753,8 +804,7 @@ static const char * const rt5640_stereo_adc1_src[] = {
 	"DIG MIX", "ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_stereo_adc1_enum, RT5640_STO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5640_stereo_adc1_enum, RT5640_STO_ADC_MIXER,
 	RT5640_ADC_1_SRC_SFT, rt5640_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5640_sto_adc_1_mux =
@@ -764,8 +814,7 @@ static const char * const rt5640_stereo_adc2_src[] = {
 	"DMIC1", "DMIC2", "DIG MIX"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_stereo_adc2_enum, RT5640_STO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5640_stereo_adc2_enum, RT5640_STO_ADC_MIXER,
 	RT5640_ADC_2_SRC_SFT, rt5640_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5640_sto_adc_2_mux =
@@ -776,8 +825,7 @@ static const char * const rt5640_mono_adc_l1_src[] = {
 	"Mono DAC MIXL", "ADCL"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_l1_enum, RT5640_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_l1_enum, RT5640_MONO_ADC_MIXER,
 	RT5640_MONO_ADC_L1_SRC_SFT, rt5640_mono_adc_l1_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_l1_mux =
@@ -787,8 +835,7 @@ static const char * const rt5640_mono_adc_l2_src[] = {
 	"DMIC L1", "DMIC L2", "Mono DAC MIXL"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_l2_enum, RT5640_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_l2_enum, RT5640_MONO_ADC_MIXER,
 	RT5640_MONO_ADC_L2_SRC_SFT, rt5640_mono_adc_l2_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_l2_mux =
@@ -798,8 +845,7 @@ static const char * const rt5640_mono_adc_r1_src[] = {
 	"Mono DAC MIXR", "ADCR"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_r1_enum, RT5640_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_r1_enum, RT5640_MONO_ADC_MIXER,
 	RT5640_MONO_ADC_R1_SRC_SFT, rt5640_mono_adc_r1_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_r1_mux =
@@ -809,8 +855,7 @@ static const char * const rt5640_mono_adc_r2_src[] = {
 	"DMIC R1", "DMIC R2", "Mono DAC MIXR"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_r2_enum, RT5640_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_r2_enum, RT5640_MONO_ADC_MIXER,
 	RT5640_MONO_ADC_R2_SRC_SFT, rt5640_mono_adc_r2_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_r2_mux =
@@ -1103,26 +1148,15 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("AIF2RX", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("AIF2TX", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
-	/* Audio DSP */
-	SND_SOC_DAPM_PGA("Audio DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
-	/* ANC */
-	SND_SOC_DAPM_PGA("ANC", SND_SOC_NOPM, 0, 0, NULL, 0),
+
 	/* Output Side */
 	/* DAC mixer before sound effect  */
 	SND_SOC_DAPM_MIXER("DAC MIXL", SND_SOC_NOPM, 0, 0,
 		rt5640_dac_l_mix, ARRAY_SIZE(rt5640_dac_l_mix)),
 	SND_SOC_DAPM_MIXER("DAC MIXR", SND_SOC_NOPM, 0, 0,
 		rt5640_dac_r_mix, ARRAY_SIZE(rt5640_dac_r_mix)),
-	/* DAC2 channel Mux */
-	SND_SOC_DAPM_MUX("DAC L2 Mux", SND_SOC_NOPM, 0, 0,
-				&rt5640_dac_l2_mux),
-	SND_SOC_DAPM_MUX("DAC R2 Mux", SND_SOC_NOPM, 0, 0,
-				&rt5640_dac_r2_mux),
+
 	/* DAC Mixer */
-	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
-		rt5640_sto_dac_l_mix, ARRAY_SIZE(rt5640_sto_dac_l_mix)),
-	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
-		rt5640_sto_dac_r_mix, ARRAY_SIZE(rt5640_sto_dac_r_mix)),
 	SND_SOC_DAPM_MIXER("Mono DAC MIXL", SND_SOC_NOPM, 0, 0,
 		rt5640_mono_dac_l_mix, ARRAY_SIZE(rt5640_mono_dac_l_mix)),
 	SND_SOC_DAPM_MIXER("Mono DAC MIXR", SND_SOC_NOPM, 0, 0,
@@ -1132,23 +1166,15 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("DIG MIXR", SND_SOC_NOPM, 0, 0,
 		rt5640_dig_r_mix, ARRAY_SIZE(rt5640_dig_r_mix)),
 	/* DACs */
-	SND_SOC_DAPM_DAC("DAC L1", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_L1_BIT, 0),
-	SND_SOC_DAPM_DAC("DAC L2", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_L2_BIT, 0),
-	SND_SOC_DAPM_DAC("DAC R1", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_R1_BIT, 0),
-	SND_SOC_DAPM_DAC("DAC R2", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_R2_BIT, 0),
+	SND_SOC_DAPM_DAC("DAC L1", NULL, RT5640_PWR_DIG1, RT5640_PWR_DAC_L1_BIT,
+		0),
+	SND_SOC_DAPM_DAC("DAC R1", NULL, RT5640_PWR_DIG1, RT5640_PWR_DAC_R1_BIT,
+		0),
 	/* SPK/OUT Mixer */
 	SND_SOC_DAPM_MIXER("SPK MIXL", RT5640_PWR_MIXER, RT5640_PWR_SM_L_BIT,
 		0, rt5640_spk_l_mix, ARRAY_SIZE(rt5640_spk_l_mix)),
 	SND_SOC_DAPM_MIXER("SPK MIXR", RT5640_PWR_MIXER, RT5640_PWR_SM_R_BIT,
 		0, rt5640_spk_r_mix, ARRAY_SIZE(rt5640_spk_r_mix)),
-	SND_SOC_DAPM_MIXER("OUT MIXL", RT5640_PWR_MIXER, RT5640_PWR_OM_L_BIT,
-		0, rt5640_out_l_mix, ARRAY_SIZE(rt5640_out_l_mix)),
-	SND_SOC_DAPM_MIXER("OUT MIXR", RT5640_PWR_MIXER, RT5640_PWR_OM_R_BIT,
-		0, rt5640_out_r_mix, ARRAY_SIZE(rt5640_out_r_mix)),
 	/* Ouput Volume */
 	SND_SOC_DAPM_PGA("SPKVOL L", RT5640_PWR_VOL,
 		RT5640_PWR_SV_L_BIT, 0, NULL, 0),
@@ -1167,16 +1193,8 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		0, rt5640_spo_l_mix, ARRAY_SIZE(rt5640_spo_l_mix)),
 	SND_SOC_DAPM_MIXER("SPOR MIX", SND_SOC_NOPM, 0,
 		0, rt5640_spo_r_mix, ARRAY_SIZE(rt5640_spo_r_mix)),
-	SND_SOC_DAPM_MIXER("HPO MIX L", SND_SOC_NOPM, 0, 0,
-		rt5640_hpo_mix, ARRAY_SIZE(rt5640_hpo_mix)),
-	SND_SOC_DAPM_MIXER("HPO MIX R", SND_SOC_NOPM, 0, 0,
-		rt5640_hpo_mix, ARRAY_SIZE(rt5640_hpo_mix)),
 	SND_SOC_DAPM_MIXER("LOUT MIX", RT5640_PWR_ANLG1, RT5640_PWR_LM_BIT, 0,
 		rt5640_lout_mix, ARRAY_SIZE(rt5640_lout_mix)),
-	SND_SOC_DAPM_MIXER("Mono MIX", RT5640_PWR_ANLG1, RT5640_PWR_MM_BIT, 0,
-		rt5640_mono_mix, ARRAY_SIZE(rt5640_mono_mix)),
-	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
-		RT5640_PWR_MA_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("Improve HP Amp Drv", 1, SND_SOC_NOPM,
 		0, 0, rt5640_hp_power_event, SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
@@ -1199,6 +1217,7 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("HP R Playback", SND_SOC_NOPM, 0, 0,
 			&hp_r_enable_control),
 	SND_SOC_DAPM_POST("HP Post", rt5640_hp_post_event),
+
 	/* Output Lines */
 	SND_SOC_DAPM_OUTPUT("SPOLP"),
 	SND_SOC_DAPM_OUTPUT("SPOLN"),
@@ -1208,10 +1227,69 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HPOR"),
 	SND_SOC_DAPM_OUTPUT("LOUTL"),
 	SND_SOC_DAPM_OUTPUT("LOUTR"),
+};
+
+static const struct snd_soc_dapm_widget rt5640_specific_dapm_widgets[] = {
+	/* Audio DSP */
+	SND_SOC_DAPM_PGA("Audio DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
+	/* ANC */
+	SND_SOC_DAPM_PGA("ANC", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* DAC2 channel Mux */
+	SND_SOC_DAPM_MUX("DAC L2 Mux", SND_SOC_NOPM, 0, 0, &rt5640_dac_l2_mux),
+	SND_SOC_DAPM_MUX("DAC R2 Mux", SND_SOC_NOPM, 0, 0, &rt5640_dac_r2_mux),
+
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5640_sto_dac_l_mix, ARRAY_SIZE(rt5640_sto_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5640_sto_dac_r_mix, ARRAY_SIZE(rt5640_sto_dac_r_mix)),
+
+	SND_SOC_DAPM_DAC("DAC R2", NULL, RT5640_PWR_DIG1, RT5640_PWR_DAC_R2_BIT,
+		0),
+	SND_SOC_DAPM_DAC("DAC L2", NULL, RT5640_PWR_DIG1, RT5640_PWR_DAC_L2_BIT,
+		0),
+
+	SND_SOC_DAPM_MIXER("OUT MIXL", RT5640_PWR_MIXER, RT5640_PWR_OM_L_BIT,
+		0, rt5640_out_l_mix, ARRAY_SIZE(rt5640_out_l_mix)),
+	SND_SOC_DAPM_MIXER("OUT MIXR", RT5640_PWR_MIXER, RT5640_PWR_OM_R_BIT,
+		0, rt5640_out_r_mix, ARRAY_SIZE(rt5640_out_r_mix)),
+
+	SND_SOC_DAPM_MIXER("HPO MIX L", SND_SOC_NOPM, 0, 0,
+		rt5640_hpo_mix, ARRAY_SIZE(rt5640_hpo_mix)),
+	SND_SOC_DAPM_MIXER("HPO MIX R", SND_SOC_NOPM, 0, 0,
+		rt5640_hpo_mix, ARRAY_SIZE(rt5640_hpo_mix)),
+
+	SND_SOC_DAPM_MIXER("Mono MIX", RT5640_PWR_ANLG1, RT5640_PWR_MM_BIT, 0,
+		rt5640_mono_mix, ARRAY_SIZE(rt5640_mono_mix)),
+	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
+		RT5640_PWR_MA_BIT, 0, NULL, 0),
+
 	SND_SOC_DAPM_OUTPUT("MONOP"),
 	SND_SOC_DAPM_OUTPUT("MONON"),
 };
 
+static const struct snd_soc_dapm_widget rt5639_specific_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_sto_dac_l_mix, ARRAY_SIZE(rt5639_sto_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_sto_dac_r_mix, ARRAY_SIZE(rt5639_sto_dac_r_mix)),
+
+	SND_SOC_DAPM_SUPPLY("DAC L2 Filter", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R2 Filter", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("OUT MIXL", RT5640_PWR_MIXER, RT5640_PWR_OM_L_BIT,
+		0, rt5639_out_l_mix, ARRAY_SIZE(rt5639_out_l_mix)),
+	SND_SOC_DAPM_MIXER("OUT MIXR", RT5640_PWR_MIXER, RT5640_PWR_OM_R_BIT,
+		0, rt5639_out_r_mix, ARRAY_SIZE(rt5639_out_r_mix)),
+
+	SND_SOC_DAPM_MIXER("HPO MIX L", SND_SOC_NOPM, 0, 0,
+		rt5639_hpo_mix, ARRAY_SIZE(rt5639_hpo_mix)),
+	SND_SOC_DAPM_MIXER("HPO MIX R", SND_SOC_NOPM, 0, 0,
+		rt5639_hpo_mix, ARRAY_SIZE(rt5639_hpo_mix)),
+};
+
 static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"IN1P", NULL, "LDO2"},
 	{"IN2P", NULL, "LDO2"},
@@ -1353,71 +1431,38 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"DAC MIXR", "Stereo ADC Switch", "Stereo ADC MIXR"},
 	{"DAC MIXR", "INF1 Switch", "IF1 DAC R"},
 
-	{"ANC", NULL, "Stereo ADC MIXL"},
-	{"ANC", NULL, "Stereo ADC MIXR"},
-
-	{"Audio DSP", NULL, "DAC MIXL"},
-	{"Audio DSP", NULL, "DAC MIXR"},
-
-	{"DAC L2 Mux", "IF2", "IF2 DAC L"},
-	{"DAC L2 Mux", "Base L/R", "Audio DSP"},
-
-	{"DAC R2 Mux", "IF2", "IF2 DAC R"},
-
 	{"Stereo DAC MIXL", "DAC L1 Switch", "DAC MIXL"},
-	{"Stereo DAC MIXL", "DAC L2 Switch", "DAC L2 Mux"},
-	{"Stereo DAC MIXL", "ANC Switch", "ANC"},
 	{"Stereo DAC MIXR", "DAC R1 Switch", "DAC MIXR"},
-	{"Stereo DAC MIXR", "DAC R2 Switch", "DAC R2 Mux"},
-	{"Stereo DAC MIXR", "ANC Switch", "ANC"},
 
 	{"Mono DAC MIXL", "DAC L1 Switch", "DAC MIXL"},
-	{"Mono DAC MIXL", "DAC L2 Switch", "DAC L2 Mux"},
-	{"Mono DAC MIXL", "DAC R2 Switch", "DAC R2 Mux"},
 	{"Mono DAC MIXR", "DAC R1 Switch", "DAC MIXR"},
-	{"Mono DAC MIXR", "DAC R2 Switch", "DAC R2 Mux"},
-	{"Mono DAC MIXR", "DAC L2 Switch", "DAC L2 Mux"},
 
 	{"DIG MIXL", "DAC L1 Switch", "DAC MIXL"},
-	{"DIG MIXL", "DAC L2 Switch", "DAC L2 Mux"},
 	{"DIG MIXR", "DAC R1 Switch", "DAC MIXR"},
-	{"DIG MIXR", "DAC R2 Switch", "DAC R2 Mux"},
 
 	{"DAC L1", NULL, "Stereo DAC MIXL"},
 	{"DAC L1", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC R1", NULL, "Stereo DAC MIXR"},
 	{"DAC R1", NULL, "PLL1", is_sys_clk_from_pll},
-	{"DAC L2", NULL, "Mono DAC MIXL"},
-	{"DAC L2", NULL, "PLL1", is_sys_clk_from_pll},
-	{"DAC R2", NULL, "Mono DAC MIXR"},
-	{"DAC R2", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"SPK MIXL", "REC MIXL Switch", "RECMIXL"},
 	{"SPK MIXL", "INL Switch", "INL VOL"},
 	{"SPK MIXL", "DAC L1 Switch", "DAC L1"},
-	{"SPK MIXL", "DAC L2 Switch", "DAC L2"},
 	{"SPK MIXL", "OUT MIXL Switch", "OUT MIXL"},
 	{"SPK MIXR", "REC MIXR Switch", "RECMIXR"},
 	{"SPK MIXR", "INR Switch", "INR VOL"},
 	{"SPK MIXR", "DAC R1 Switch", "DAC R1"},
-	{"SPK MIXR", "DAC R2 Switch", "DAC R2"},
 	{"SPK MIXR", "OUT MIXR Switch", "OUT MIXR"},
 
-	{"OUT MIXL", "SPK MIXL Switch", "SPK MIXL"},
 	{"OUT MIXL", "BST1 Switch", "BST1"},
 	{"OUT MIXL", "INL Switch", "INL VOL"},
 	{"OUT MIXL", "REC MIXL Switch", "RECMIXL"},
-	{"OUT MIXL", "DAC R2 Switch", "DAC R2"},
-	{"OUT MIXL", "DAC L2 Switch", "DAC L2"},
 	{"OUT MIXL", "DAC L1 Switch", "DAC L1"},
 
-	{"OUT MIXR", "SPK MIXR Switch", "SPK MIXR"},
 	{"OUT MIXR", "BST2 Switch", "BST2"},
 	{"OUT MIXR", "BST1 Switch", "BST1"},
 	{"OUT MIXR", "INR Switch", "INR VOL"},
 	{"OUT MIXR", "REC MIXR Switch", "RECMIXR"},
-	{"OUT MIXR", "DAC L2 Switch", "DAC L2"},
-	{"OUT MIXR", "DAC R2 Switch", "DAC R2"},
 	{"OUT MIXR", "DAC R1 Switch", "DAC R1"},
 
 	{"SPKVOL L", NULL, "SPK MIXL"},
@@ -1436,11 +1481,9 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"SPOR MIX", "SPKVOL R Switch", "SPKVOL R"},
 	{"SPOR MIX", "BST1 Switch", "BST1"},
 
-	{"HPO MIX L", "HPO MIX DAC2 Switch", "DAC L2"},
 	{"HPO MIX L", "HPO MIX DAC1 Switch", "DAC L1"},
 	{"HPO MIX L", "HPO MIX HPVOL Switch", "HPOVOL L"},
 	{"HPO MIX L", NULL, "HP L Amp"},
-	{"HPO MIX R", "HPO MIX DAC2 Switch", "DAC R2"},
 	{"HPO MIX R", "HPO MIX DAC1 Switch", "DAC R1"},
 	{"HPO MIX R", "HPO MIX HPVOL Switch", "HPOVOL R"},
 	{"HPO MIX R", NULL, "HP R Amp"},
@@ -1450,12 +1493,6 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"LOUT MIX", "OUTVOL L Switch", "OUTVOL L"},
 	{"LOUT MIX", "OUTVOL R Switch", "OUTVOL R"},
 
-	{"Mono MIX", "DAC R2 Switch", "DAC R2"},
-	{"Mono MIX", "DAC L2 Switch", "DAC L2"},
-	{"Mono MIX", "OUTVOL R Switch", "OUTVOL R"},
-	{"Mono MIX", "OUTVOL L Switch", "OUTVOL L"},
-	{"Mono MIX", "BST1 Switch", "BST1"},
-
 	{"HP Amp", NULL, "HPO MIX L"},
 	{"HP Amp", NULL, "HPO MIX R"},
 
@@ -1480,11 +1517,82 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"HPOR", NULL, "HP R Playback"},
 	{"LOUTL", NULL, "LOUT MIX"},
 	{"LOUTR", NULL, "LOUT MIX"},
+};
+
+static const struct snd_soc_dapm_route rt5640_specific_dapm_routes[] = {
+	{"ANC", NULL, "Stereo ADC MIXL"},
+	{"ANC", NULL, "Stereo ADC MIXR"},
+
+	{"Audio DSP", NULL, "DAC MIXL"},
+	{"Audio DSP", NULL, "DAC MIXR"},
+
+	{"DAC L2 Mux", "IF2", "IF2 DAC L"},
+	{"DAC L2 Mux", "Base L/R", "Audio DSP"},
+
+	{"DAC R2 Mux", "IF2", "IF2 DAC R"},
+
+	{"Stereo DAC MIXL", "DAC L2 Switch", "DAC L2 Mux"},
+	{"Stereo DAC MIXL", "ANC Switch", "ANC"},
+	{"Stereo DAC MIXR", "DAC R2 Switch", "DAC R2 Mux"},
+	{"Stereo DAC MIXR", "ANC Switch", "ANC"},
+
+	{"Mono DAC MIXL", "DAC L2 Switch", "DAC L2 Mux"},
+	{"Mono DAC MIXL", "DAC R2 Switch", "DAC R2 Mux"},
+
+	{"Mono DAC MIXR", "DAC R2 Switch", "DAC R2 Mux"},
+	{"Mono DAC MIXR", "DAC L2 Switch", "DAC L2 Mux"},
+
+	{"DIG MIXR", "DAC R2 Switch", "DAC R2 Mux"},
+	{"DIG MIXL", "DAC L2 Switch", "DAC L2 Mux"},
+
+	{"DAC L2", NULL, "Mono DAC MIXL"},
+	{"DAC L2", NULL, "PLL1", is_sys_clk_from_pll},
+	{"DAC R2", NULL, "Mono DAC MIXR"},
+	{"DAC R2", NULL, "PLL1", is_sys_clk_from_pll},
+
+	{"SPK MIXL", "DAC L2 Switch", "DAC L2"},
+	{"SPK MIXR", "DAC R2 Switch", "DAC R2"},
+
+	{"OUT MIXL", "SPK MIXL Switch", "SPK MIXL"},
+	{"OUT MIXR", "SPK MIXR Switch", "SPK MIXR"},
+
+	{"OUT MIXL", "DAC R2 Switch", "DAC R2"},
+	{"OUT MIXL", "DAC L2 Switch", "DAC L2"},
+
+	{"OUT MIXR", "DAC L2 Switch", "DAC L2"},
+	{"OUT MIXR", "DAC R2 Switch", "DAC R2"},
+
+	{"HPO MIX L", "HPO MIX DAC2 Switch", "DAC L2"},
+	{"HPO MIX R", "HPO MIX DAC2 Switch", "DAC R2"},
+
+	{"Mono MIX", "DAC R2 Switch", "DAC R2"},
+	{"Mono MIX", "DAC L2 Switch", "DAC L2"},
+	{"Mono MIX", "OUTVOL R Switch", "OUTVOL R"},
+	{"Mono MIX", "OUTVOL L Switch", "OUTVOL L"},
+	{"Mono MIX", "BST1 Switch", "BST1"},
+
 	{"MONOP", NULL, "Mono MIX"},
 	{"MONON", NULL, "Mono MIX"},
 	{"MONOP", NULL, "Improve MONO Amp Drv"},
 };
 
+static const struct snd_soc_dapm_route rt5639_specific_dapm_routes[] = {
+	{"Stereo DAC MIXL", "DAC L2 Switch", "IF2 DAC L"},
+	{"Stereo DAC MIXR", "DAC R2 Switch", "IF2 DAC R"},
+
+	{"Mono DAC MIXL", "DAC L2 Switch", "IF2 DAC L"},
+	{"Mono DAC MIXL", "DAC R2 Switch", "IF2 DAC R"},
+
+	{"Mono DAC MIXR", "DAC R2 Switch", "IF2 DAC R"},
+	{"Mono DAC MIXR", "DAC L2 Switch", "IF2 DAC L"},
+
+	{"DIG MIXL", "DAC L2 Switch", "IF2 DAC L"},
+	{"DIG MIXR", "DAC R2 Switch", "IF2 DAC R"},
+
+	{"IF2 DAC L", NULL, "DAC L2 Filter"},
+	{"IF2 DAC R", NULL, "DAC R2 Filter"},
+};
+
 static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
 {
 	int ret = 0, val;
@@ -1551,8 +1659,7 @@ static int get_clk_info(int sclk, int rate)
 static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val_len = 0, val_clk, mask_clk;
 	int dai_sel, pre_div, bclk_ms, frame_size;
@@ -1901,6 +2008,28 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, RT5640_MICBIAS, 0x0030, 0x0030);
 	snd_soc_update_bits(codec, RT5640_DSP_PATH2, 0xfc00, 0x0c00);
 
+	switch (snd_soc_read(codec, RT5640_RESET)) {
+	case RT5640_RESET_ID:
+		snd_soc_add_codec_controls(codec,
+			rt5640_specific_snd_controls,
+			ARRAY_SIZE(rt5640_specific_snd_controls));
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5640_specific_dapm_widgets,
+			ARRAY_SIZE(rt5640_specific_dapm_widgets));
+		snd_soc_dapm_add_routes(&codec->dapm,
+			rt5640_specific_dapm_routes,
+			ARRAY_SIZE(rt5640_specific_dapm_routes));
+		break;
+	case RT5639_RESET_ID:
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5639_specific_dapm_widgets,
+			ARRAY_SIZE(rt5639_specific_dapm_widgets));
+		snd_soc_dapm_add_routes(&codec->dapm,
+			rt5639_specific_dapm_routes,
+			ARRAY_SIZE(rt5639_specific_dapm_routes));
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index d7bd525..3b50459 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -14,6 +14,9 @@
 
 #include <sound/rt5640.h>
 
+#define RT5639_RESET_ID				0x0008
+#define RT5640_RESET_ID				0x000c
+
 /* Info */
 #define RT5640_RESET				0x00
 #define RT5640_VENDOR_ID			0xfd
-- 
1.8.1.1.439.g50a6b54
