From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/6] ASoC: rt5645: add TDM slot control into
	dapm route
Date: Thu, 30 Apr 2015 18:18:44 +0800
Message-ID: <1430389127-24609-3-git-send-email-bardliao@realtek.com>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6893F265D1C
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:19:14 +0200 (CEST)
In-Reply-To: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch adds TDM slot control into dapm route. The control bits
are different between rt5645 and rt5650, so we have separate dapm
routes for each codec.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 355 ++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/rt5645.h |   1 +
 2 files changed, 299 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 33ebe88..2ba761b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -434,30 +434,6 @@ static unsigned int bst_tlv[] = {
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
 };
 
-static const char * const rt5645_tdm_data_swap_select[] = {
-	"L/R", "R/L", "L/L", "R/R"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot0_1_enum,
-	RT5645_TDM_CTRL_1, 6, rt5645_tdm_data_swap_select);
-
-static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot2_3_enum,
-	RT5645_TDM_CTRL_1, 4, rt5645_tdm_data_swap_select);
-
-static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot4_5_enum,
-	RT5645_TDM_CTRL_1, 2, rt5645_tdm_data_swap_select);
-
-static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot6_7_enum,
-	RT5645_TDM_CTRL_1, 0, rt5645_tdm_data_swap_select);
-
-static const char * const rt5645_tdm_adc_data_select[] = {
-	"1/2/R", "2/1/R", "R/1/2", "R/2/1"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_sel_enum,
-				RT5645_TDM_CTRL_1, 8,
-				rt5645_tdm_adc_data_select);
-
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -518,17 +494,6 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* I2S2 function select */
 	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
 		1, 1),
-
-	/* TDM */
-	SOC_ENUM("TDM Adc Slot0 1 Data", rt5645_tdm_adc_slot0_1_enum),
-	SOC_ENUM("TDM Adc Slot2 3 Data", rt5645_tdm_adc_slot2_3_enum),
-	SOC_ENUM("TDM Adc Slot4 5 Data", rt5645_tdm_adc_slot4_5_enum),
-	SOC_ENUM("TDM Adc Slot6 7 Data", rt5645_tdm_adc_slot6_7_enum),
-	SOC_ENUM("TDM IF1 ADC DATA Sel", rt5645_tdm_adc_sel_enum),
-	SOC_SINGLE("TDM IF1_DAC1_L Sel", RT5645_TDM_CTRL_3, 12, 7, 0),
-	SOC_SINGLE("TDM IF1_DAC1_R Sel", RT5645_TDM_CTRL_3, 8, 7, 0),
-	SOC_SINGLE("TDM IF1_DAC2_L Sel", RT5645_TDM_CTRL_3, 4, 7, 0),
-	SOC_SINGLE("TDM IF1_DAC2_R Sel", RT5645_TDM_CTRL_3, 0, 7, 0),
 };
 
 /**
@@ -1095,7 +1060,8 @@ static const struct snd_kcontrol_new rt5645_mono_adc_r2_mux =
 
 /* MX-77 [9:8] */
 static const char * const rt5645_if1_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "VAD_ADC"
+	"IF_ADC1/IF_ADC2/VAD_ADC", "IF_ADC2/IF_ADC1/VAD_ADC",
+	"VAD_ADC/IF_ADC1/IF_ADC2", "VAD_ADC/IF_ADC2/IF_ADC1"
 };
 
 static SOC_ENUM_SINGLE_DECL(
@@ -1105,6 +1071,140 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_if1_adc_in_mux =
 	SOC_DAPM_ENUM("IF1 ADC IN source", rt5645_if1_adc_in_enum);
 
+/* MX-78 [4:0] */
+static const char * const rt5650_if1_adc_in_src[] = {
+	"IF_ADC1/IF_ADC2/DAC_REF/Null",
+	"IF_ADC1/IF_ADC2/Null/DAC_REF",
+	"IF_ADC1/DAC_REF/IF_ADC2/Null",
+	"IF_ADC1/DAC_REF/Null/IF_ADC2",
+	"IF_ADC1/Null/DAC_REF/IF_ADC2",
+	"IF_ADC1/Null/IF_ADC2/DAC_REF",
+
+	"IF_ADC2/IF_ADC1/DAC_REF/Null",
+	"IF_ADC2/IF_ADC1/Null/DAC_REF",
+	"IF_ADC2/DAC_REF/IF_ADC1/Null",
+	"IF_ADC2/DAC_REF/Null/IF_ADC1",
+	"IF_ADC2/Null/DAC_REF/IF_ADC1",
+	"IF_ADC2/Null/IF_ADC1/DAC_REF",
+
+	"DAC_REF/IF_ADC1/IF_ADC2/Null",
+	"DAC_REF/IF_ADC1/Null/IF_ADC2",
+	"DAC_REF/IF_ADC2/IF_ADC1/Null",
+	"DAC_REF/IF_ADC2/Null/IF_ADC1",
+	"DAC_REF/Null/IF_ADC1/IF_ADC2",
+	"DAC_REF/Null/IF_ADC2/IF_ADC1",
+
+	"Null/IF_ADC1/IF_ADC2/DAC_REF",
+	"Null/IF_ADC1/DAC_REF/IF_ADC2",
+	"Null/IF_ADC2/IF_ADC1/DAC_REF",
+	"Null/IF_ADC2/DAC_REF/IF_ADC1",
+	"Null/DAC_REF/IF_ADC1/IF_ADC2",
+	"Null/DAC_REF/IF_ADC2/IF_ADC1",
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5650_if1_adc_in_enum, RT5645_TDM_CTRL_2,
+	0, rt5650_if1_adc_in_src);
+
+static const struct snd_kcontrol_new rt5650_if1_adc_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC IN source", rt5650_if1_adc_in_enum);
+
+/* MX-78 [15:14][13:12][11:10] */
+static const char * const rt5645_tdm_adc_swap_select[] = {
+	"L/R", "R/L", "L/L", "R/R"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_adc_slot0_1_enum,
+	RT5645_TDM_CTRL_2, 14, rt5645_tdm_adc_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_adc1_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC1 IN source", rt5650_tdm_adc_slot0_1_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_adc_slot2_3_enum,
+	RT5645_TDM_CTRL_2, 12, rt5645_tdm_adc_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_adc2_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC2 IN source", rt5650_tdm_adc_slot2_3_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_adc_slot4_5_enum,
+	RT5645_TDM_CTRL_2, 10, rt5645_tdm_adc_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_adc3_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC3 IN source", rt5650_tdm_adc_slot4_5_enum);
+
+/* MX-77 [7:6][5:4][3:2] */
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot0_1_enum,
+	RT5645_TDM_CTRL_1, 6, rt5645_tdm_adc_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_adc1_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC1 IN source", rt5645_tdm_adc_slot0_1_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot2_3_enum,
+	RT5645_TDM_CTRL_1, 4, rt5645_tdm_adc_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_adc2_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC2 IN source", rt5645_tdm_adc_slot2_3_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_slot4_5_enum,
+	RT5645_TDM_CTRL_1, 2, rt5645_tdm_adc_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_adc3_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC3 IN source", rt5645_tdm_adc_slot4_5_enum);
+
+/* MX-79 [14:12][10:8][6:4][2:0] */
+static const char * const rt5645_tdm_dac_swap_select[] = {
+	"Slot0", "Slot1", "Slot2", "Slot3"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_dac0_enum,
+	RT5645_TDM_CTRL_3, 12, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_dac0_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC0 source", rt5645_tdm_dac0_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_dac1_enum,
+	RT5645_TDM_CTRL_3, 8, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_dac1_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC1 source", rt5645_tdm_dac1_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_dac2_enum,
+	RT5645_TDM_CTRL_3, 4, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_dac2_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC2 source", rt5645_tdm_dac2_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5645_tdm_dac3_enum,
+	RT5645_TDM_CTRL_3, 0, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5645_if1_dac3_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC3 source", rt5645_tdm_dac3_enum);
+
+/* MX-7a [14:12][10:8][6:4][2:0] */
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_dac0_enum,
+	RT5650_TDM_CTRL_4, 12, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_dac0_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC0 source", rt5650_tdm_dac0_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_dac1_enum,
+	RT5650_TDM_CTRL_4, 8, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_dac1_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC1 source", rt5650_tdm_dac1_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_dac2_enum,
+	RT5650_TDM_CTRL_4, 4, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_dac2_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC2 source", rt5650_tdm_dac2_enum);
+
+static SOC_ENUM_SINGLE_DECL(rt5650_tdm_dac3_enum,
+	RT5650_TDM_CTRL_4, 0, rt5645_tdm_dac_swap_select);
+
+static const struct snd_kcontrol_new rt5650_if1_dac3_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC3 source", rt5650_tdm_dac3_enum);
+
 /* MX-2d [3] [2] */
 static const char * const rt5650_a_dac1_src[] = {
 	"DAC1", "Stereo DAC Mixer"
@@ -1573,8 +1673,24 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* IF1 2 Mux */
-	SND_SOC_DAPM_MUX("IF1 ADC Mux", SND_SOC_NOPM,
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc1_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc2_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc3_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC Mux", SND_SOC_NOPM,
 		0, 0, &rt5645_if1_adc_in_mux),
+
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc1_in_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc2_in_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc3_in_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc_in_mux),
+
 	SND_SOC_DAPM_MUX("IF2 ADC Mux", SND_SOC_NOPM,
 		0, 0, &rt5645_if2_adc_in_mux),
 
@@ -1583,10 +1699,22 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 		RT5645_PWR_I2S1_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC2", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1 DAC1 L", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1 DAC1 R", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1 DAC2 L", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1 DAC2 R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac3_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac3_tdm_sel_mux),
 	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1850,42 +1978,32 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "IF_ADC2", NULL, "Mono ADC MIXR" },
 	{ "VAD_ADC", NULL, "VAD ADC Mux" },
 
-	{ "IF1 ADC Mux", "IF_ADC1", "IF_ADC1" },
-	{ "IF1 ADC Mux", "IF_ADC2", "IF_ADC2" },
-	{ "IF1 ADC Mux", "VAD_ADC", "VAD_ADC" },
-
 	{ "IF2 ADC Mux", "IF_ADC1", "IF_ADC1" },
 	{ "IF2 ADC Mux", "IF_ADC2", "IF_ADC2" },
 	{ "IF2 ADC Mux", "VAD_ADC", "VAD_ADC" },
 
 	{ "IF1 ADC", NULL, "I2S1" },
-	{ "IF1 ADC", NULL, "IF1 ADC Mux" },
 	{ "IF2 ADC", NULL, "I2S2" },
 	{ "IF2 ADC", NULL, "IF2 ADC Mux" },
 
-	{ "AIF1TX", NULL, "IF1 ADC" },
-	{ "AIF1TX", NULL, "IF2 ADC" },
 	{ "AIF2TX", NULL, "IF2 ADC" },
 
+	{ "IF1 DAC0", NULL, "AIF1RX" },
 	{ "IF1 DAC1", NULL, "AIF1RX" },
 	{ "IF1 DAC2", NULL, "AIF1RX" },
+	{ "IF1 DAC3", NULL, "AIF1RX" },
 	{ "IF2 DAC", NULL, "AIF2RX" },
 
+	{ "IF1 DAC0", NULL, "I2S1" },
 	{ "IF1 DAC1", NULL, "I2S1" },
 	{ "IF1 DAC2", NULL, "I2S1" },
+	{ "IF1 DAC3", NULL, "I2S1" },
 	{ "IF2 DAC", NULL, "I2S2" },
 
-	{ "IF1 DAC2 L", NULL, "IF1 DAC2" },
-	{ "IF1 DAC2 R", NULL, "IF1 DAC2" },
-	{ "IF1 DAC1 L", NULL, "IF1 DAC1" },
-	{ "IF1 DAC1 R", NULL, "IF1 DAC1" },
 	{ "IF2 DAC L", NULL, "IF2 DAC" },
 	{ "IF2 DAC R", NULL, "IF2 DAC" },
 
-	{ "DAC1 L Mux", "IF1 DAC", "IF1 DAC1 L" },
 	{ "DAC1 L Mux", "IF2 DAC", "IF2 DAC L" },
-
-	{ "DAC1 R Mux", "IF1 DAC", "IF1 DAC1 R" },
 	{ "DAC1 R Mux", "IF2 DAC", "IF2 DAC R" },
 
 	{ "DAC1 MIXL", "Stereo ADC Switch", "Stereo1 ADC MIXL" },
@@ -1895,14 +2013,12 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "DAC1 MIXR", "DAC1 Switch", "DAC1 R Mux" },
 	{ "DAC1 MIXR", NULL, "dac stereo1 filter" },
 
-	{ "DAC L2 Mux", "IF1 DAC", "IF1 DAC2 L" },
 	{ "DAC L2 Mux", "IF2 DAC", "IF2 DAC L" },
 	{ "DAC L2 Mux", "Mono ADC", "Mono ADC MIXL" },
 	{ "DAC L2 Mux", "VAD_ADC", "VAD_ADC" },
 	{ "DAC L2 Volume", NULL, "DAC L2 Mux" },
 	{ "DAC L2 Volume", NULL, "dac mono left filter" },
 
-	{ "DAC R2 Mux", "IF1 DAC", "IF1 DAC2 R" },
 	{ "DAC R2 Mux", "IF2 DAC", "IF2 DAC R" },
 	{ "DAC R2 Mux", "Mono ADC", "Mono ADC MIXR" },
 	{ "DAC R2 Mux", "Haptic", "Haptic Generator" },
@@ -2040,6 +2156,80 @@ static const struct snd_soc_dapm_route rt5650_specific_dapm_routes[] = {
 	{ "DAC R1", NULL, "A DAC1 R Mux" },
 	{ "DAC L2", NULL, "A DAC2 L Mux" },
 	{ "DAC R2", NULL, "A DAC2 R Mux" },
+
+	{ "RT5650 IF1 ADC1 Swap Mux", "L/R", "IF_ADC1" },
+	{ "RT5650 IF1 ADC1 Swap Mux", "R/L", "IF_ADC1" },
+	{ "RT5650 IF1 ADC1 Swap Mux", "L/L", "IF_ADC1" },
+	{ "RT5650 IF1 ADC1 Swap Mux", "R/R", "IF_ADC1" },
+
+	{ "RT5650 IF1 ADC2 Swap Mux", "L/R", "IF_ADC2" },
+	{ "RT5650 IF1 ADC2 Swap Mux", "R/L", "IF_ADC2" },
+	{ "RT5650 IF1 ADC2 Swap Mux", "L/L", "IF_ADC2" },
+	{ "RT5650 IF1 ADC2 Swap Mux", "R/R", "IF_ADC2" },
+
+	{ "RT5650 IF1 ADC3 Swap Mux", "L/R", "VAD_ADC" },
+	{ "RT5650 IF1 ADC3 Swap Mux", "R/L", "VAD_ADC" },
+	{ "RT5650 IF1 ADC3 Swap Mux", "L/L", "VAD_ADC" },
+	{ "RT5650 IF1 ADC3 Swap Mux", "R/R", "VAD_ADC" },
+
+	{ "IF1 ADC", NULL, "RT5650 IF1 ADC1 Swap Mux" },
+	{ "IF1 ADC", NULL, "RT5650 IF1 ADC2 Swap Mux" },
+	{ "IF1 ADC", NULL, "RT5650 IF1 ADC3 Swap Mux" },
+
+	{ "RT5650 IF1 ADC Mux", "IF_ADC1/IF_ADC2/DAC_REF/Null", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC1/IF_ADC2/Null/DAC_REF", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC1/DAC_REF/IF_ADC2/Null", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC1/DAC_REF/Null/IF_ADC2", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC1/Null/DAC_REF/IF_ADC2", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC1/Null/IF_ADC2/DAC_REF", "IF1 ADC" },
+
+	{ "RT5650 IF1 ADC Mux", "IF_ADC2/IF_ADC1/DAC_REF/Null", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC2/IF_ADC1/Null/DAC_REF", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC2/DAC_REF/IF_ADC1/Null", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC2/DAC_REF/Null/IF_ADC1", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC2/Null/DAC_REF/IF_ADC1", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "IF_ADC2/Null/IF_ADC1/DAC_REF", "IF1 ADC" },
+
+	{ "RT5650 IF1 ADC Mux", "DAC_REF/IF_ADC1/IF_ADC2/Null", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "DAC_REF/IF_ADC1/Null/IF_ADC2", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "DAC_REF/IF_ADC2/IF_ADC1/Null", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "DAC_REF/IF_ADC2/Null/IF_ADC1", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "DAC_REF/Null/IF_ADC1/IF_ADC2", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "DAC_REF/Null/IF_ADC2/IF_ADC1", "IF1 ADC" },
+
+	{ "RT5650 IF1 ADC Mux", "Null/IF_ADC1/IF_ADC2/DAC_REF", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "Null/IF_ADC1/DAC_REF/IF_ADC2", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "Null/IF_ADC2/IF_ADC1/DAC_REF", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "Null/IF_ADC2/DAC_REF/IF_ADC1", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "Null/DAC_REF/IF_ADC1/IF_ADC2", "IF1 ADC" },
+	{ "RT5650 IF1 ADC Mux", "Null/DAC_REF/IF_ADC2/IF_ADC1", "IF1 ADC" },
+	{ "AIF1TX", NULL, "RT5650 IF1 ADC Mux" },
+
+	{ "RT5650 IF1 DAC1 L Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5650 IF1 DAC1 L Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5650 IF1 DAC1 L Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5650 IF1 DAC1 L Mux", "Slot3", "IF1 DAC3" },
+
+	{ "RT5650 IF1 DAC1 R Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5650 IF1 DAC1 R Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5650 IF1 DAC1 R Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5650 IF1 DAC1 R Mux", "Slot3", "IF1 DAC3" },
+
+	{ "RT5650 IF1 DAC2 L Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5650 IF1 DAC2 L Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5650 IF1 DAC2 L Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5650 IF1 DAC2 L Mux", "Slot3", "IF1 DAC3" },
+
+	{ "RT5650 IF1 DAC2 R Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5650 IF1 DAC2 R Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5650 IF1 DAC2 R Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5650 IF1 DAC2 R Mux", "Slot3", "IF1 DAC3" },
+
+	{ "DAC1 L Mux", "IF1 DAC", "RT5650 IF1 DAC1 L Mux" },
+	{ "DAC1 R Mux", "IF1 DAC", "RT5650 IF1 DAC1 R Mux" },
+
+	{ "DAC L2 Mux", "IF1 DAC", "RT5650 IF1 DAC2 L Mux" },
+	{ "DAC R2 Mux", "IF1 DAC", "RT5650 IF1 DAC2 R Mux" },
 };
 
 static const struct snd_soc_dapm_route rt5645_specific_dapm_routes[] = {
@@ -2047,6 +2237,57 @@ static const struct snd_soc_dapm_route rt5645_specific_dapm_routes[] = {
 	{ "DAC R1", NULL, "Stereo DAC MIXR" },
 	{ "DAC L2", NULL, "Mono DAC MIXL" },
 	{ "DAC R2", NULL, "Mono DAC MIXR" },
+
+	{ "RT5645 IF1 ADC1 Swap Mux", "L/R", "IF_ADC1" },
+	{ "RT5645 IF1 ADC1 Swap Mux", "R/L", "IF_ADC1" },
+	{ "RT5645 IF1 ADC1 Swap Mux", "L/L", "IF_ADC1" },
+	{ "RT5645 IF1 ADC1 Swap Mux", "R/R", "IF_ADC1" },
+
+	{ "RT5645 IF1 ADC2 Swap Mux", "L/R", "IF_ADC2" },
+	{ "RT5645 IF1 ADC2 Swap Mux", "R/L", "IF_ADC2" },
+	{ "RT5645 IF1 ADC2 Swap Mux", "L/L", "IF_ADC2" },
+	{ "RT5645 IF1 ADC2 Swap Mux", "R/R", "IF_ADC2" },
+
+	{ "RT5645 IF1 ADC3 Swap Mux", "L/R", "VAD_ADC" },
+	{ "RT5645 IF1 ADC3 Swap Mux", "R/L", "VAD_ADC" },
+	{ "RT5645 IF1 ADC3 Swap Mux", "L/L", "VAD_ADC" },
+	{ "RT5645 IF1 ADC3 Swap Mux", "R/R", "VAD_ADC" },
+
+	{ "IF1 ADC", NULL, "RT5645 IF1 ADC1 Swap Mux" },
+	{ "IF1 ADC", NULL, "RT5645 IF1 ADC2 Swap Mux" },
+	{ "IF1 ADC", NULL, "RT5645 IF1 ADC3 Swap Mux" },
+
+	{ "RT5645 IF1 ADC Mux", "IF_ADC1/IF_ADC2/VAD_ADC", "IF1 ADC" },
+	{ "RT5645 IF1 ADC Mux", "IF_ADC2/IF_ADC1/VAD_ADC", "IF1 ADC" },
+	{ "RT5645 IF1 ADC Mux", "VAD_ADC/IF_ADC1/IF_ADC2", "IF1 ADC" },
+	{ "RT5645 IF1 ADC Mux", "VAD_ADC/IF_ADC2/IF_ADC1", "IF1 ADC" },
+	{ "AIF1TX", NULL, "RT5645 IF1 ADC Mux" },
+
+	{ "RT5645 IF1 DAC1 L Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5645 IF1 DAC1 L Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5645 IF1 DAC1 L Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5645 IF1 DAC1 L Mux", "Slot3", "IF1 DAC3" },
+
+	{ "RT5645 IF1 DAC1 R Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5645 IF1 DAC1 R Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5645 IF1 DAC1 R Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5645 IF1 DAC1 R Mux", "Slot3", "IF1 DAC3" },
+
+	{ "RT5645 IF1 DAC2 L Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5645 IF1 DAC2 L Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5645 IF1 DAC2 L Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5645 IF1 DAC2 L Mux", "Slot3", "IF1 DAC3" },
+
+	{ "RT5645 IF1 DAC2 R Mux", "Slot0", "IF1 DAC0" },
+	{ "RT5645 IF1 DAC2 R Mux", "Slot1", "IF1 DAC1" },
+	{ "RT5645 IF1 DAC2 R Mux", "Slot2", "IF1 DAC2" },
+	{ "RT5645 IF1 DAC2 R Mux", "Slot3", "IF1 DAC3" },
+
+	{ "DAC1 L Mux", "IF1 DAC", "RT5645 IF1 DAC1 L Mux" },
+	{ "DAC1 R Mux", "IF1 DAC", "RT5645 IF1 DAC1 R Mux" },
+
+	{ "DAC L2 Mux", "IF1 DAC", "RT5645 IF1 DAC2 L Mux" },
+	{ "DAC R2 Mux", "IF1 DAC", "RT5645 IF1 DAC2 R Mux" },
 };
 
 static int rt5645_hw_params(struct snd_pcm_substream *substream,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 1897889..c204861 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -105,6 +105,7 @@
 #define RT5645_TDM_CTRL_1			0x77
 #define RT5645_TDM_CTRL_2			0x78
 #define RT5645_TDM_CTRL_3			0x79
+#define RT5650_TDM_CTRL_4			0x7a
 
 /* Function - Analog */
 #define RT5645_GLB_CLK				0x80
-- 
1.8.1.1.439.g50a6b54
