From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: rt5670: Fix duplicate const warnings
Date: Fri,  1 Aug 2014 17:31:24 +0100
Message-ID: <1406910684-29708-2-git-send-email-broonie@kernel.org>
References: <1406910684-29708-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE0CA2655B3
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 19:23:15 +0200 (CEST)
In-Reply-To: <1406910684-29708-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since SOC_ENUM_SINGLE_DECL() includes a const as part of the macro adding
an explicit const in the source is duplication and causes sparse to warn.
Remove the extra consts.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/rt5670.c | 109 ++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 31f664f..ba9d9b4 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -424,10 +424,10 @@ static const char * const rt5670_data_select[] = {
 	"Normal", "Swap", "left copy to right", "right copy to left"
 };
 
-static const SOC_ENUM_SINGLE_DECL(rt5670_if2_dac_enum, RT5670_DIG_INF1_DATA,
+static SOC_ENUM_SINGLE_DECL(rt5670_if2_dac_enum, RT5670_DIG_INF1_DATA,
 				RT5670_IF2_DAC_SEL_SFT, rt5670_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_enum, RT5670_DIG_INF1_DATA,
+static SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_enum, RT5670_DIG_INF1_DATA,
 				RT5670_IF2_ADC_SEL_SFT, rt5670_data_select);
 
 static const struct snd_kcontrol_new rt5670_snd_controls[] = {
@@ -786,15 +786,13 @@ static const char * const rt5670_dac1_src[] = {
 	"IF1 DAC", "IF2 DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_dac1l_enum, RT5670_AD_DA_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_dac1l_enum, RT5670_AD_DA_MIXER,
 	RT5670_DAC1_L_SEL_SFT, rt5670_dac1_src);
 
 static const struct snd_kcontrol_new rt5670_dac1l_mux =
 	SOC_DAPM_ENUM("DAC1 L source", rt5670_dac1l_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_dac1r_enum, RT5670_AD_DA_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_dac1r_enum, RT5670_AD_DA_MIXER,
 	RT5670_DAC1_R_SEL_SFT, rt5670_dac1_src);
 
 static const struct snd_kcontrol_new rt5670_dac1r_mux =
@@ -807,8 +805,7 @@ static const char * const rt5670_dac12_src[] = {
 	"Bass", "VAD_ADC", "IF4 DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_dac2l_enum, RT5670_DAC_CTRL,
+static SOC_ENUM_SINGLE_DECL(rt5670_dac2l_enum, RT5670_DAC_CTRL,
 	RT5670_DAC2_L_SEL_SFT, rt5670_dac12_src);
 
 static const struct snd_kcontrol_new rt5670_dac_l2_mux =
@@ -818,8 +815,7 @@ static const char * const rt5670_dacr2_src[] = {
 	"IF1 DAC", "IF2 DAC", "IF3 DAC", "TxDC DAC", "TxDP ADC", "IF4 DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_dac2r_enum, RT5670_DAC_CTRL,
+static SOC_ENUM_SINGLE_DECL(rt5670_dac2r_enum, RT5670_DAC_CTRL,
 	RT5670_DAC2_R_SEL_SFT, rt5670_dacr2_src);
 
 static const struct snd_kcontrol_new rt5670_dac_r2_mux =
@@ -831,8 +827,7 @@ static const char * const rt5670_rxdp_src[] = {
 	"Mono ADC Mixer L", "Mono ADC Mixer R", "DAC1"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_rxdp_enum, RT5670_DSP_PATH1,
+static SOC_ENUM_SINGLE_DECL(rt5670_rxdp_enum, RT5670_DSP_PATH1,
 	RT5670_RXDP_SEL_SFT, rt5670_rxdp_src);
 
 static const struct snd_kcontrol_new rt5670_rxdp_mux =
@@ -843,15 +838,13 @@ static const char * const rt5670_dsp_bypass_src[] = {
 	"DSP", "Bypass"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_dsp_ul_enum, RT5670_DSP_PATH1,
+static SOC_ENUM_SINGLE_DECL(rt5670_dsp_ul_enum, RT5670_DSP_PATH1,
 	RT5670_DSP_UL_SFT, rt5670_dsp_bypass_src);
 
 static const struct snd_kcontrol_new rt5670_dsp_ul_mux =
 	SOC_DAPM_ENUM("DSP UL source", rt5670_dsp_ul_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_dsp_dl_enum, RT5670_DSP_PATH1,
+static SOC_ENUM_SINGLE_DECL(rt5670_dsp_dl_enum, RT5670_DSP_PATH1,
 	RT5670_DSP_DL_SFT, rt5670_dsp_bypass_src);
 
 static const struct snd_kcontrol_new rt5670_dsp_dl_mux =
@@ -863,8 +856,7 @@ static const char * const rt5670_stereo2_adc_lr_src[] = {
 	"L", "LR"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo2_adc_lr_enum, RT5670_STO2_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc_lr_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_STO2_ADC_SRC_SFT, rt5670_stereo2_adc_lr_src);
 
 static const struct snd_kcontrol_new rt5670_sto2_adc_lr_mux =
@@ -876,8 +868,7 @@ static const char * const rt5670_stereo_adc1_src[] = {
 	"DAC MIX", "ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo1_adc1_enum, RT5670_STO1_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc1_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5670_sto_adc_l1_mux =
@@ -886,8 +877,7 @@ static const struct snd_kcontrol_new rt5670_sto_adc_l1_mux =
 static const struct snd_kcontrol_new rt5670_sto_adc_r1_mux =
 	SOC_DAPM_ENUM("Stereo1 ADC R1 source", rt5670_stereo1_adc1_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo2_adc1_enum, RT5670_STO2_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc1_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5670_sto2_adc_l1_mux =
@@ -901,8 +891,7 @@ static const char * const rt5670_stereo_adc2_src[] = {
 	"DAC MIX", "DMIC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo1_adc2_enum, RT5670_STO1_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc2_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5670_sto_adc_l2_mux =
@@ -911,8 +900,7 @@ static const struct snd_kcontrol_new rt5670_sto_adc_l2_mux =
 static const struct snd_kcontrol_new rt5670_sto_adc_r2_mux =
 	SOC_DAPM_ENUM("Stereo1 ADC R2 source", rt5670_stereo1_adc2_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5670_sto2_adc_l2_mux =
@@ -926,15 +914,13 @@ static const char * const rt5670_stereo_adc_src[] = {
 	"ADC1L ADC2R", "ADC3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo1_adc_enum, RT5670_STO1_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
 
 static const struct snd_kcontrol_new rt5670_sto_adc_mux =
 	SOC_DAPM_ENUM("Stereo1 ADC source", rt5670_stereo1_adc_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo2_adc_enum, RT5670_STO2_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
 
 static const struct snd_kcontrol_new rt5670_sto2_adc_mux =
@@ -945,15 +931,13 @@ static const char * const rt5670_stereo_dmic_src[] = {
 	"DMIC1", "DMIC2", "DMIC3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo1_dmic_enum, RT5670_STO1_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_dmic_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_DMIC_SRC_SFT, rt5670_stereo_dmic_src);
 
 static const struct snd_kcontrol_new rt5670_sto1_dmic_mux =
 	SOC_DAPM_ENUM("Stereo1 DMIC source", rt5670_stereo1_dmic_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo2_dmic_enum, RT5670_STO2_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_dmic_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_DMIC_SRC_SFT, rt5670_stereo_dmic_src);
 
 static const struct snd_kcontrol_new rt5670_sto2_dmic_mux =
@@ -964,8 +948,7 @@ static const char * const rt5670_stereo_dmic3_src[] = {
 	"DMIC3", "PDM ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_stereo_dmic3_enum, RT5670_STO1_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_stereo_dmic3_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_DMIC3_SRC_SFT, rt5670_stereo_dmic3_src);
 
 static const struct snd_kcontrol_new rt5670_sto_dmic3_mux =
@@ -977,8 +960,7 @@ static const char * const rt5670_mono_adc_l1_src[] = {
 	"Mono DAC MIXL", "ADC1"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_mono_adc_l1_enum, RT5670_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_mono_adc_l1_enum, RT5670_MONO_ADC_MIXER,
 	RT5670_MONO_ADC_L1_SRC_SFT, rt5670_mono_adc_l1_src);
 
 static const struct snd_kcontrol_new rt5670_mono_adc_l1_mux =
@@ -988,8 +970,7 @@ static const char * const rt5670_mono_adc_l2_src[] = {
 	"Mono DAC MIXL", "DMIC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_mono_adc_l2_enum, RT5670_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_mono_adc_l2_enum, RT5670_MONO_ADC_MIXER,
 	RT5670_MONO_ADC_L2_SRC_SFT, rt5670_mono_adc_l2_src);
 
 static const struct snd_kcontrol_new rt5670_mono_adc_l2_mux =
@@ -1000,15 +981,13 @@ static const char * const rt5670_mono_dmic_src[] = {
 	"DMIC1", "DMIC2", "DMIC3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_mono_dmic_l_enum, RT5670_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_mono_dmic_l_enum, RT5670_MONO_ADC_MIXER,
 	RT5670_MONO_DMIC_L_SRC_SFT, rt5670_mono_dmic_src);
 
 static const struct snd_kcontrol_new rt5670_mono_dmic_l_mux =
 	SOC_DAPM_ENUM("Mono DMIC left source", rt5670_mono_dmic_l_enum);
 /* MX-28 [1:0] */
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_mono_dmic_r_enum, RT5670_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_mono_dmic_r_enum, RT5670_MONO_ADC_MIXER,
 	RT5670_MONO_DMIC_R_SRC_SFT, rt5670_mono_dmic_src);
 
 static const struct snd_kcontrol_new rt5670_mono_dmic_r_mux =
@@ -1018,8 +997,7 @@ static const char * const rt5670_mono_adc_r1_src[] = {
 	"Mono DAC MIXR", "ADC2"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_mono_adc_r1_enum, RT5670_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_mono_adc_r1_enum, RT5670_MONO_ADC_MIXER,
 	RT5670_MONO_ADC_R1_SRC_SFT, rt5670_mono_adc_r1_src);
 
 static const struct snd_kcontrol_new rt5670_mono_adc_r1_mux =
@@ -1029,8 +1007,7 @@ static const char * const rt5670_mono_adc_r2_src[] = {
 	"Mono DAC MIXR", "DMIC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_mono_adc_r2_enum, RT5670_MONO_ADC_MIXER,
+static SOC_ENUM_SINGLE_DECL(rt5670_mono_adc_r2_enum, RT5670_MONO_ADC_MIXER,
 	RT5670_MONO_ADC_R2_SRC_SFT, rt5670_mono_adc_r2_src);
 
 static const struct snd_kcontrol_new rt5670_mono_adc_r2_mux =
@@ -1041,8 +1018,7 @@ static const char * const rt5670_txdp_slot_src[] = {
 	"Slot 0-1", "Slot 2-3", "Slot 4-5", "Slot 6-7"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_txdp_slot_enum, RT5670_DSP_PATH1,
+static SOC_ENUM_SINGLE_DECL(rt5670_txdp_slot_enum, RT5670_DSP_PATH1,
 	RT5670_TXDP_SLOT_SEL_SFT, rt5670_txdp_slot_src);
 
 static const struct snd_kcontrol_new rt5670_txdp_slot_mux =
@@ -1053,8 +1029,7 @@ static const char * const rt5670_if1_adc2_in_src[] = {
 	"IF_ADC2", "VAD_ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_if1_adc2_in_enum, RT5670_DIG_INF1_DATA,
+static SOC_ENUM_SINGLE_DECL(rt5670_if1_adc2_in_enum, RT5670_DIG_INF1_DATA,
 	RT5670_IF1_ADC2_IN_SFT, rt5670_if1_adc2_in_src);
 
 static const struct snd_kcontrol_new rt5670_if1_adc2_in_mux =
@@ -1065,8 +1040,7 @@ static const char * const rt5670_if2_adc_in_src[] = {
 	"IF_ADC1", "IF_ADC2", "IF_ADC3", "TxDC_DAC", "TxDP_ADC", "VAD_ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_if2_adc_in_enum, RT5670_DIG_INF1_DATA,
+static SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_in_enum, RT5670_DIG_INF1_DATA,
 	RT5670_IF2_ADC_IN_SFT, rt5670_if2_adc_in_src);
 
 static const struct snd_kcontrol_new rt5670_if2_adc_in_mux =
@@ -1077,8 +1051,7 @@ static const char * const rt5670_if4_adc_in_src[] = {
 	"IF_ADC1", "IF_ADC2", "IF_ADC3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_if4_adc_in_enum, RT5670_DIG_INF2_DATA,
+static SOC_ENUM_SINGLE_DECL(rt5670_if4_adc_in_enum, RT5670_DIG_INF2_DATA,
 	RT5670_IF4_ADC_IN_SFT, rt5670_if4_adc_in_src);
 
 static const struct snd_kcontrol_new rt5670_if4_adc_in_mux =
@@ -1089,29 +1062,25 @@ static const char * const rt5670_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_pdm1_l_enum, RT5670_PDM_OUT_CTRL,
+static SOC_ENUM_SINGLE_DECL(rt5670_pdm1_l_enum, RT5670_PDM_OUT_CTRL,
 	RT5670_PDM1_L_SFT, rt5670_pdm_src);
 
 static const struct snd_kcontrol_new rt5670_pdm1_l_mux =
 	SOC_DAPM_ENUM("PDM1 L source", rt5670_pdm1_l_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_pdm1_r_enum, RT5670_PDM_OUT_CTRL,
+static SOC_ENUM_SINGLE_DECL(rt5670_pdm1_r_enum, RT5670_PDM_OUT_CTRL,
 	RT5670_PDM1_R_SFT, rt5670_pdm_src);
 
 static const struct snd_kcontrol_new rt5670_pdm1_r_mux =
 	SOC_DAPM_ENUM("PDM1 R source", rt5670_pdm1_r_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_pdm2_l_enum, RT5670_PDM_OUT_CTRL,
+static SOC_ENUM_SINGLE_DECL(rt5670_pdm2_l_enum, RT5670_PDM_OUT_CTRL,
 	RT5670_PDM2_L_SFT, rt5670_pdm_src);
 
 static const struct snd_kcontrol_new rt5670_pdm2_l_mux =
 	SOC_DAPM_ENUM("PDM2 L source", rt5670_pdm2_l_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_pdm2_r_enum, RT5670_PDM_OUT_CTRL,
+static SOC_ENUM_SINGLE_DECL(rt5670_pdm2_r_enum, RT5670_PDM_OUT_CTRL,
 	RT5670_PDM2_R_SFT, rt5670_pdm_src);
 
 static const struct snd_kcontrol_new rt5670_pdm2_r_mux =
@@ -1122,8 +1091,7 @@ static const char * const rt5670_if1_adc1_in1_src[] = {
 	"IF_ADC1", "IF1_ADC3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_if1_adc1_in1_enum, RT5670_DIG_MISC,
+static SOC_ENUM_SINGLE_DECL(rt5670_if1_adc1_in1_enum, RT5670_DIG_MISC,
 	RT5670_IF1_ADC1_IN1_SFT, rt5670_if1_adc1_in1_src);
 
 static const struct snd_kcontrol_new rt5670_if1_adc1_in1_mux =
@@ -1134,8 +1102,7 @@ static const char * const rt5670_if1_adc1_in2_src[] = {
 	"IF1_ADC1_IN1", "IF1_ADC4"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_if1_adc1_in2_enum, RT5670_DIG_MISC,
+static SOC_ENUM_SINGLE_DECL(rt5670_if1_adc1_in2_enum, RT5670_DIG_MISC,
 	RT5670_IF1_ADC1_IN2_SFT, rt5670_if1_adc1_in2_src);
 
 static const struct snd_kcontrol_new rt5670_if1_adc1_in2_mux =
@@ -1146,8 +1113,7 @@ static const char * const rt5670_if1_adc2_in1_src[] = {
 	"IF1_ADC2_IN", "IF1_ADC4"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_if1_adc2_in1_enum, RT5670_DIG_MISC,
+static SOC_ENUM_SINGLE_DECL(rt5670_if1_adc2_in1_enum, RT5670_DIG_MISC,
 	RT5670_IF1_ADC2_IN1_SFT, rt5670_if1_adc2_in1_src);
 
 static const struct snd_kcontrol_new rt5670_if1_adc2_in1_mux =
@@ -1158,8 +1124,7 @@ static const char * const rt5670_vad_adc_src[] = {
 	"Sto1 ADC L", "Mono ADC L", "Mono ADC R", "Sto2 ADC L"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5670_vad_adc_enum, RT5670_VAD_CTRL4,
+static SOC_ENUM_SINGLE_DECL(rt5670_vad_adc_enum, RT5670_VAD_CTRL4,
 	RT5670_VAD_SEL_SFT, rt5670_vad_adc_src);
 
 static const struct snd_kcontrol_new rt5670_vad_adc_mux =
-- 
2.0.0
