From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: add rt5639 support
Date: Tue, 8 Apr 2014 19:40:00 +0800
Message-ID: <1396957200-13647-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D6E265900
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 13:40:08 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch adds the rt5639 support

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 286 ++++++++++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5640.h |   3 +
 2 files changed, 213 insertions(+), 76 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6b8778f..d672f44 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -399,18 +399,13 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
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
 			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
-	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5640_DAC2_DIG_VOL,
-			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
-			175, 0, dac_vol_tlv),
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5640_IN1_IN2,
 		RT5640_BST_SFT1, 8, 0, bst_tlv),
@@ -442,6 +437,15 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
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
@@ -555,6 +559,20 @@ static const struct snd_kcontrol_new rt5640_sto_dac_r_mix[] = {
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
@@ -677,6 +695,30 @@ static const struct snd_kcontrol_new rt5640_out_r_mix[] = {
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
@@ -708,6 +750,13 @@ static const struct snd_kcontrol_new rt5640_hpo_mix[] = {
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
@@ -1103,26 +1152,15 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
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
@@ -1134,21 +1172,14 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	/* DACs */
 	SND_SOC_DAPM_DAC("DAC L1", NULL, RT5640_PWR_DIG1,
 			RT5640_PWR_DAC_L1_BIT, 0),
-	SND_SOC_DAPM_DAC("DAC L2", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_L2_BIT, 0),
 	SND_SOC_DAPM_DAC("DAC R1", NULL, RT5640_PWR_DIG1,
 			RT5640_PWR_DAC_R1_BIT, 0),
-	SND_SOC_DAPM_DAC("DAC R2", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_R2_BIT, 0),
+
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
@@ -1167,16 +1198,8 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
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
@@ -1208,10 +1231,69 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
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
@@ -1353,71 +1435,38 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
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
@@ -1436,11 +1485,9 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
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
@@ -1450,12 +1497,6 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
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
 
@@ -1480,11 +1521,82 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
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
@@ -1901,6 +2013,28 @@ static int rt5640_probe(struct snd_soc_codec *codec)
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
