From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/4] ASoC: rt5677: Replace the string "source"
	to "Source"
Date: Tue, 10 Jun 2014 14:35:24 +0800
Message-ID: <1402382126-704-2-git-send-email-oder_chiou@realtek.com>
References: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E9812652C3
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 08:35:39 +0200 (CEST)
In-Reply-To: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
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

The patch replaces the string "source" to "Source".

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 122 +++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 75268a7..c0b4384 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -951,7 +951,7 @@ static const struct snd_kcontrol_new rt5677_ob_7_mix[] = {
 
 
 /* Mux */
-/* DAC1 L/R source */ /* MX-29 [10:8] */
+/* DAC1 L/R Source */ /* MX-29 [10:8] */
 static const char * const rt5677_dac1_src[] = {
 	"IF1 DAC 01", "IF2 DAC 01", "IF3 DAC LR", "IF4 DAC LR", "SLB DAC 01",
 	"OB 01"
@@ -962,9 +962,9 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_DAC1_L_SEL_SFT, rt5677_dac1_src);
 
 static const struct snd_kcontrol_new rt5677_dac1_mux =
-	SOC_DAPM_ENUM("DAC1 source", rt5677_dac1_enum);
+	SOC_DAPM_ENUM("DAC1 Source", rt5677_dac1_enum);
 
-/* ADDA1 L/R source */ /* MX-29 [1:0] */
+/* ADDA1 L/R Source */ /* MX-29 [1:0] */
 static const char * const rt5677_adda1_src[] = {
 	"STO1 ADC MIX", "STO2 ADC MIX", "OB 67",
 };
@@ -974,10 +974,10 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_ADDA1_SEL_SFT, rt5677_adda1_src);
 
 static const struct snd_kcontrol_new rt5677_adda1_mux =
-	SOC_DAPM_ENUM("ADDA1 source", rt5677_adda1_enum);
+	SOC_DAPM_ENUM("ADDA1 Source", rt5677_adda1_enum);
 
 
-/*DAC2 L/R source*/ /* MX-1B [6:4] [2:0] */
+/*DAC2 L/R Source*/ /* MX-1B [6:4] [2:0] */
 static const char * const rt5677_dac2l_src[] = {
 	"IF1 DAC 2", "IF2 DAC 2", "IF3 DAC L", "IF4 DAC L", "SLB DAC 2",
 	"OB 2",
@@ -988,7 +988,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_DAC2_L_SRC_SFT, rt5677_dac2l_src);
 
 static const struct snd_kcontrol_new rt5677_dac2_l_mux =
-	SOC_DAPM_ENUM("DAC2 L source", rt5677_dac2l_enum);
+	SOC_DAPM_ENUM("DAC2 L Source", rt5677_dac2l_enum);
 
 static const char * const rt5677_dac2r_src[] = {
 	"IF1 DAC 3", "IF2 DAC 3", "IF3 DAC R", "IF4 DAC R", "SLB DAC 3",
@@ -1000,9 +1000,9 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_DAC2_R_SRC_SFT, rt5677_dac2r_src);
 
 static const struct snd_kcontrol_new rt5677_dac2_r_mux =
-	SOC_DAPM_ENUM("DAC2 R source", rt5677_dac2r_enum);
+	SOC_DAPM_ENUM("DAC2 R Source", rt5677_dac2r_enum);
 
-/*DAC3 L/R source*/ /* MX-16 [6:4] [2:0] */
+/*DAC3 L/R Source*/ /* MX-16 [6:4] [2:0] */
 static const char * const rt5677_dac3l_src[] = {
 	"IF1 DAC 4", "IF2 DAC 4", "IF3 DAC L", "IF4 DAC L",
 	"SLB DAC 4", "OB 4"
@@ -1013,7 +1013,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_DAC3_L_SRC_SFT, rt5677_dac3l_src);
 
 static const struct snd_kcontrol_new rt5677_dac3_l_mux =
-	SOC_DAPM_ENUM("DAC3 L source", rt5677_dac3l_enum);
+	SOC_DAPM_ENUM("DAC3 L Source", rt5677_dac3l_enum);
 
 static const char * const rt5677_dac3r_src[] = {
 	"IF1 DAC 5", "IF2 DAC 5", "IF3 DAC R", "IF4 DAC R",
@@ -1025,9 +1025,9 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_DAC3_R_SRC_SFT, rt5677_dac3r_src);
 
 static const struct snd_kcontrol_new rt5677_dac3_r_mux =
-	SOC_DAPM_ENUM("DAC3 R source", rt5677_dac3r_enum);
+	SOC_DAPM_ENUM("DAC3 R Source", rt5677_dac3r_enum);
 
-/*DAC4 L/R source*/ /* MX-16 [14:12] [10:8] */
+/*DAC4 L/R Source*/ /* MX-16 [14:12] [10:8] */
 static const char * const rt5677_dac4l_src[] = {
 	"IF1 DAC 6", "IF2 DAC 6", "IF3 DAC L", "IF4 DAC L",
 	"SLB DAC 6", "OB 6"
@@ -1038,7 +1038,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_DAC4_L_SRC_SFT, rt5677_dac4l_src);
 
 static const struct snd_kcontrol_new rt5677_dac4_l_mux =
-	SOC_DAPM_ENUM("DAC4 L source", rt5677_dac4l_enum);
+	SOC_DAPM_ENUM("DAC4 L Source", rt5677_dac4l_enum);
 
 static const char * const rt5677_dac4r_src[] = {
 	"IF1 DAC 7", "IF2 DAC 7", "IF3 DAC R", "IF4 DAC R",
@@ -1050,7 +1050,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_DAC4_R_SRC_SFT, rt5677_dac4r_src);
 
 static const struct snd_kcontrol_new rt5677_dac4_r_mux =
-	SOC_DAPM_ENUM("DAC4 R source", rt5677_dac4r_enum);
+	SOC_DAPM_ENUM("DAC4 R Source", rt5677_dac4r_enum);
 
 /* In/OutBound Source Pass SRC */ /* MX-A5 [3] [4] [0] [1] [2] */
 static const char * const rt5677_iob_bypass_src[] = {
@@ -1062,35 +1062,35 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_SRC_OB01_SFT, rt5677_iob_bypass_src);
 
 static const struct snd_kcontrol_new rt5677_ob01_bypass_src_mux =
-	SOC_DAPM_ENUM("OB01 Bypass source", rt5677_ob01_bypass_src_enum);
+	SOC_DAPM_ENUM("OB01 Bypass Source", rt5677_ob01_bypass_src_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_ob23_bypass_src_enum, RT5677_DSP_IN_OUTB_CTRL,
 	RT5677_SEL_SRC_OB23_SFT, rt5677_iob_bypass_src);
 
 static const struct snd_kcontrol_new rt5677_ob23_bypass_src_mux =
-	SOC_DAPM_ENUM("OB23 Bypass source", rt5677_ob23_bypass_src_enum);
+	SOC_DAPM_ENUM("OB23 Bypass Source", rt5677_ob23_bypass_src_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_ib01_bypass_src_enum, RT5677_DSP_IN_OUTB_CTRL,
 	RT5677_SEL_SRC_IB01_SFT, rt5677_iob_bypass_src);
 
 static const struct snd_kcontrol_new rt5677_ib01_bypass_src_mux =
-	SOC_DAPM_ENUM("IB01 Bypass source", rt5677_ib01_bypass_src_enum);
+	SOC_DAPM_ENUM("IB01 Bypass Source", rt5677_ib01_bypass_src_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_ib23_bypass_src_enum, RT5677_DSP_IN_OUTB_CTRL,
 	RT5677_SEL_SRC_IB23_SFT, rt5677_iob_bypass_src);
 
 static const struct snd_kcontrol_new rt5677_ib23_bypass_src_mux =
-	SOC_DAPM_ENUM("IB23 Bypass source", rt5677_ib23_bypass_src_enum);
+	SOC_DAPM_ENUM("IB23 Bypass Source", rt5677_ib23_bypass_src_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_ib45_bypass_src_enum, RT5677_DSP_IN_OUTB_CTRL,
 	RT5677_SEL_SRC_IB45_SFT, rt5677_iob_bypass_src);
 
 static const struct snd_kcontrol_new rt5677_ib45_bypass_src_mux =
-	SOC_DAPM_ENUM("IB45 Bypass source", rt5677_ib45_bypass_src_enum);
+	SOC_DAPM_ENUM("IB45 Bypass Source", rt5677_ib45_bypass_src_enum);
 
 /* Stereo ADC Source 2 */ /* MX-27 MX26  MX25 [11:10] */
 static const char * const rt5677_stereo_adc2_src[] = {
@@ -1102,21 +1102,21 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_STO1_ADC2_SFT, rt5677_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_sto1_adc2_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC2 source", rt5677_stereo1_adc2_enum);
+	SOC_DAPM_ENUM("Stereo1 ADC2 Source", rt5677_stereo1_adc2_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo2_adc2_enum, RT5677_STO2_ADC_MIXER,
 	RT5677_SEL_STO2_ADC2_SFT, rt5677_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_sto2_adc2_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC2 source", rt5677_stereo2_adc2_enum);
+	SOC_DAPM_ENUM("Stereo2 ADC2 Source", rt5677_stereo2_adc2_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo3_adc2_enum, RT5677_STO3_ADC_MIXER,
 	RT5677_SEL_STO3_ADC2_SFT, rt5677_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_sto3_adc2_mux =
-	SOC_DAPM_ENUM("Stereo3 ADC2 source", rt5677_stereo3_adc2_enum);
+	SOC_DAPM_ENUM("Stereo3 ADC2 Source", rt5677_stereo3_adc2_enum);
 
 /* DMIC Source */ /* MX-28 [9:8][1:0] MX-27 MX-26 MX-25 MX-24 [9:8] */
 static const char * const rt5677_dmic_src[] = {
@@ -1128,44 +1128,44 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_MONO_DMIC_L_SFT, rt5677_dmic_src);
 
 static const struct snd_kcontrol_new rt5677_mono_dmic_l_mux =
-	SOC_DAPM_ENUM("Mono DMIC L source", rt5677_mono_dmic_l_enum);
+	SOC_DAPM_ENUM("Mono DMIC L Source", rt5677_mono_dmic_l_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_mono_dmic_r_enum, RT5677_MONO_ADC_MIXER,
 	RT5677_SEL_MONO_DMIC_R_SFT, rt5677_dmic_src);
 
 static const struct snd_kcontrol_new rt5677_mono_dmic_r_mux =
-	SOC_DAPM_ENUM("Mono DMIC R source", rt5677_mono_dmic_r_enum);
+	SOC_DAPM_ENUM("Mono DMIC R Source", rt5677_mono_dmic_r_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo1_dmic_enum, RT5677_STO1_ADC_MIXER,
 	RT5677_SEL_STO1_DMIC_SFT, rt5677_dmic_src);
 
 static const struct snd_kcontrol_new rt5677_sto1_dmic_mux =
-	SOC_DAPM_ENUM("Stereo1 DMIC source", rt5677_stereo1_dmic_enum);
+	SOC_DAPM_ENUM("Stereo1 DMIC Source", rt5677_stereo1_dmic_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo2_dmic_enum, RT5677_STO2_ADC_MIXER,
 	RT5677_SEL_STO2_DMIC_SFT, rt5677_dmic_src);
 
 static const struct snd_kcontrol_new rt5677_sto2_dmic_mux =
-	SOC_DAPM_ENUM("Stereo2 DMIC source", rt5677_stereo2_dmic_enum);
+	SOC_DAPM_ENUM("Stereo2 DMIC Source", rt5677_stereo2_dmic_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo3_dmic_enum, RT5677_STO3_ADC_MIXER,
 	RT5677_SEL_STO3_DMIC_SFT, rt5677_dmic_src);
 
 static const struct snd_kcontrol_new rt5677_sto3_dmic_mux =
-	SOC_DAPM_ENUM("Stereo3 DMIC source", rt5677_stereo3_dmic_enum);
+	SOC_DAPM_ENUM("Stereo3 DMIC Source", rt5677_stereo3_dmic_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo4_dmic_enum, RT5677_STO4_ADC_MIXER,
 	RT5677_SEL_STO4_DMIC_SFT, rt5677_dmic_src);
 
 static const struct snd_kcontrol_new rt5677_sto4_dmic_mux =
-	SOC_DAPM_ENUM("Stereo4 DMIC source", rt5677_stereo4_dmic_enum);
+	SOC_DAPM_ENUM("Stereo4 DMIC Source", rt5677_stereo4_dmic_enum);
 
-/* Stereo2 ADC source */ /* MX-26 [0] */
+/* Stereo2 ADC Source */ /* MX-26 [0] */
 static const char * const rt5677_stereo2_adc_lr_src[] = {
 	"L", "LR"
 };
@@ -1175,7 +1175,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_STO2_LR_MIX_SFT, rt5677_stereo2_adc_lr_src);
 
 static const struct snd_kcontrol_new rt5677_sto2_adc_lr_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC LR source", rt5677_stereo2_adc_lr_enum);
+	SOC_DAPM_ENUM("Stereo2 ADC LR Source", rt5677_stereo2_adc_lr_enum);
 
 /* Stereo1 ADC Source 1 */ /* MX-27 MX26  MX25 [13:12] */
 static const char * const rt5677_stereo_adc1_src[] = {
@@ -1187,23 +1187,23 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_STO1_ADC1_SFT, rt5677_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_sto1_adc1_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC1 source", rt5677_stereo1_adc1_enum);
+	SOC_DAPM_ENUM("Stereo1 ADC1 Source", rt5677_stereo1_adc1_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo2_adc1_enum, RT5677_STO2_ADC_MIXER,
 	RT5677_SEL_STO2_ADC1_SFT, rt5677_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_sto2_adc1_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC1 source", rt5677_stereo2_adc1_enum);
+	SOC_DAPM_ENUM("Stereo2 ADC1 Source", rt5677_stereo2_adc1_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_stereo3_adc1_enum, RT5677_STO3_ADC_MIXER,
 	RT5677_SEL_STO3_ADC1_SFT, rt5677_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_sto3_adc1_mux =
-	SOC_DAPM_ENUM("Stereo3 ADC1 source", rt5677_stereo3_adc1_enum);
+	SOC_DAPM_ENUM("Stereo3 ADC1 Source", rt5677_stereo3_adc1_enum);
 
-/* Mono ADC Left source 2 */ /* MX-28 [11:10] */
+/* Mono ADC Left Source 2 */ /* MX-28 [11:10] */
 static const char * const rt5677_mono_adc2_l_src[] = {
 	"DD MIX1L", "DMIC", "MONO DAC MIXL"
 };
@@ -1213,9 +1213,9 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_MONO_ADC_L2_SFT, rt5677_mono_adc2_l_src);
 
 static const struct snd_kcontrol_new rt5677_mono_adc2_l_mux =
-	SOC_DAPM_ENUM("Mono ADC2 L source", rt5677_mono_adc2_l_enum);
+	SOC_DAPM_ENUM("Mono ADC2 L Source", rt5677_mono_adc2_l_enum);
 
-/* Mono ADC Left source 1 */ /* MX-28 [13:12] */
+/* Mono ADC Left Source 1 */ /* MX-28 [13:12] */
 static const char * const rt5677_mono_adc1_l_src[] = {
 	"DD MIX1L", "ADC1", "MONO DAC MIXL"
 };
@@ -1225,9 +1225,9 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_MONO_ADC_L1_SFT, rt5677_mono_adc1_l_src);
 
 static const struct snd_kcontrol_new rt5677_mono_adc1_l_mux =
-	SOC_DAPM_ENUM("Mono ADC1 L source", rt5677_mono_adc1_l_enum);
+	SOC_DAPM_ENUM("Mono ADC1 L Source", rt5677_mono_adc1_l_enum);
 
-/* Mono ADC Right source 2 */ /* MX-28 [3:2] */
+/* Mono ADC Right Source 2 */ /* MX-28 [3:2] */
 static const char * const rt5677_mono_adc2_r_src[] = {
 	"DD MIX1R", "DMIC", "MONO DAC MIXR"
 };
@@ -1237,9 +1237,9 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_MONO_ADC_R2_SFT, rt5677_mono_adc2_r_src);
 
 static const struct snd_kcontrol_new rt5677_mono_adc2_r_mux =
-	SOC_DAPM_ENUM("Mono ADC2 R source", rt5677_mono_adc2_r_enum);
+	SOC_DAPM_ENUM("Mono ADC2 R Source", rt5677_mono_adc2_r_enum);
 
-/* Mono ADC Right source 1 */ /* MX-28 [5:4] */
+/* Mono ADC Right Source 1 */ /* MX-28 [5:4] */
 static const char * const rt5677_mono_adc1_r_src[] = {
 	"DD MIX1R", "ADC2", "MONO DAC MIXR"
 };
@@ -1249,7 +1249,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_MONO_ADC_R1_SFT, rt5677_mono_adc1_r_src);
 
 static const struct snd_kcontrol_new rt5677_mono_adc1_r_mux =
-	SOC_DAPM_ENUM("Mono ADC1 R source", rt5677_mono_adc1_r_enum);
+	SOC_DAPM_ENUM("Mono ADC1 R Source", rt5677_mono_adc1_r_enum);
 
 /* Stereo4 ADC Source 2 */ /* MX-24 [11:10] */
 static const char * const rt5677_stereo4_adc2_src[] = {
@@ -1261,7 +1261,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_STO4_ADC2_SFT, rt5677_stereo4_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_sto4_adc2_mux =
-	SOC_DAPM_ENUM("Stereo4 ADC2 source", rt5677_stereo4_adc2_enum);
+	SOC_DAPM_ENUM("Stereo4 ADC2 Source", rt5677_stereo4_adc2_enum);
 
 
 /* Stereo4 ADC Source 1 */ /* MX-24 [13:12] */
@@ -1274,7 +1274,7 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_STO4_ADC1_SFT, rt5677_stereo4_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_sto4_adc1_mux =
-	SOC_DAPM_ENUM("Stereo4 ADC1 source", rt5677_stereo4_adc1_enum);
+	SOC_DAPM_ENUM("Stereo4 ADC1 Source", rt5677_stereo4_adc1_enum);
 
 /* InBound0/1 Source */ /* MX-A3 [14:12] */
 static const char * const rt5677_inbound01_src[] = {
@@ -1416,7 +1416,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_dac3_mux =
 	SOC_DAPM_ENUM("Analog DAC3 Source", rt5677_dac3_enum);
 
-/* PDM channel source */ /* MX-31 [13:12][9:8][5:4][1:0] */
+/* PDM channel Source */ /* MX-31 [13:12][9:8][5:4][1:0] */
 static const char * const rt5677_pdm_src[] = {
 	"STO1 DAC MIX", "MONO DAC MIX", "DD MIX1", "DD MIX2"
 };
@@ -1426,28 +1426,28 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_SEL_PDM1_L_SFT, rt5677_pdm_src);
 
 static const struct snd_kcontrol_new rt5677_pdm1_l_mux =
-	SOC_DAPM_ENUM("PDM1 source", rt5677_pdm1_l_enum);
+	SOC_DAPM_ENUM("PDM1 Source", rt5677_pdm1_l_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_pdm2_l_enum, RT5677_PDM_OUT_CTRL,
 	RT5677_SEL_PDM2_L_SFT, rt5677_pdm_src);
 
 static const struct snd_kcontrol_new rt5677_pdm2_l_mux =
-	SOC_DAPM_ENUM("PDM2 source", rt5677_pdm2_l_enum);
+	SOC_DAPM_ENUM("PDM2 Source", rt5677_pdm2_l_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_pdm1_r_enum, RT5677_PDM_OUT_CTRL,
 	RT5677_SEL_PDM1_R_SFT, rt5677_pdm_src);
 
 static const struct snd_kcontrol_new rt5677_pdm1_r_mux =
-	SOC_DAPM_ENUM("PDM1 source", rt5677_pdm1_r_enum);
+	SOC_DAPM_ENUM("PDM1 Source", rt5677_pdm1_r_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_pdm2_r_enum, RT5677_PDM_OUT_CTRL,
 	RT5677_SEL_PDM2_R_SFT, rt5677_pdm_src);
 
 static const struct snd_kcontrol_new rt5677_pdm2_r_mux =
-	SOC_DAPM_ENUM("PDM2 source", rt5677_pdm2_r_enum);
+	SOC_DAPM_ENUM("PDM2 Source", rt5677_pdm2_r_enum);
 
 /* TDM IF1/2 SLB ADC1 Data Selection */ /* MX-3C MX-41 [5:4] MX-08 [1:0]*/
 static const char * const rt5677_if12_adc1_src[] = {
@@ -1459,21 +1459,21 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_IF1_ADC1_SFT, rt5677_if12_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_if1_adc1_mux =
-	SOC_DAPM_ENUM("IF1 ADC1 source", rt5677_if1_adc1_enum);
+	SOC_DAPM_ENUM("IF1 ADC1 Source", rt5677_if1_adc1_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_if2_adc1_enum, RT5677_TDM2_CTRL2,
 	RT5677_IF2_ADC1_SFT, rt5677_if12_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_if2_adc1_mux =
-	SOC_DAPM_ENUM("IF2 ADC1 source", rt5677_if2_adc1_enum);
+	SOC_DAPM_ENUM("IF2 ADC1 Source", rt5677_if2_adc1_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_slb_adc1_enum, RT5677_SLIMBUS_RX,
 	RT5677_SLB_ADC1_SFT, rt5677_if12_adc1_src);
 
 static const struct snd_kcontrol_new rt5677_slb_adc1_mux =
-	SOC_DAPM_ENUM("SLB ADC1 source", rt5677_slb_adc1_enum);
+	SOC_DAPM_ENUM("SLB ADC1 Source", rt5677_slb_adc1_enum);
 
 /* TDM IF1/2 SLB ADC2 Data Selection */ /* MX-3C MX-41 [7:6] MX-08 [3:2] */
 static const char * const rt5677_if12_adc2_src[] = {
@@ -1485,21 +1485,21 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_IF1_ADC2_SFT, rt5677_if12_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_if1_adc2_mux =
-	SOC_DAPM_ENUM("IF1 ADC2 source", rt5677_if1_adc2_enum);
+	SOC_DAPM_ENUM("IF1 ADC2 Source", rt5677_if1_adc2_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_if2_adc2_enum, RT5677_TDM2_CTRL2,
 	RT5677_IF2_ADC2_SFT, rt5677_if12_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_if2_adc2_mux =
-	SOC_DAPM_ENUM("IF2 ADC2 source", rt5677_if2_adc2_enum);
+	SOC_DAPM_ENUM("IF2 ADC2 Source", rt5677_if2_adc2_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_slb_adc2_enum, RT5677_SLIMBUS_RX,
 	RT5677_SLB_ADC2_SFT, rt5677_if12_adc2_src);
 
 static const struct snd_kcontrol_new rt5677_slb_adc2_mux =
-	SOC_DAPM_ENUM("SLB ADC2 source", rt5677_slb_adc2_enum);
+	SOC_DAPM_ENUM("SLB ADC2 Source", rt5677_slb_adc2_enum);
 
 /* TDM IF1/2 SLB ADC3 Data Selection */ /* MX-3C MX-41 [9:8] MX-08 [5:4] */
 static const char * const rt5677_if12_adc3_src[] = {
@@ -1511,21 +1511,21 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_IF1_ADC3_SFT, rt5677_if12_adc3_src);
 
 static const struct snd_kcontrol_new rt5677_if1_adc3_mux =
-	SOC_DAPM_ENUM("IF1 ADC3 source", rt5677_if1_adc3_enum);
+	SOC_DAPM_ENUM("IF1 ADC3 Source", rt5677_if1_adc3_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_if2_adc3_enum, RT5677_TDM2_CTRL2,
 	RT5677_IF2_ADC3_SFT, rt5677_if12_adc3_src);
 
 static const struct snd_kcontrol_new rt5677_if2_adc3_mux =
-	SOC_DAPM_ENUM("IF2 ADC3 source", rt5677_if2_adc3_enum);
+	SOC_DAPM_ENUM("IF2 ADC3 Source", rt5677_if2_adc3_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_slb_adc3_enum, RT5677_SLIMBUS_RX,
 	RT5677_SLB_ADC3_SFT, rt5677_if12_adc3_src);
 
 static const struct snd_kcontrol_new rt5677_slb_adc3_mux =
-	SOC_DAPM_ENUM("SLB ADC3 source", rt5677_slb_adc3_enum);
+	SOC_DAPM_ENUM("SLB ADC3 Source", rt5677_slb_adc3_enum);
 
 /* TDM IF1/2 SLB ADC4 Data Selection */ /* MX-3C MX-41 [11:10]  MX-08 [7:6] */
 static const char * const rt5677_if12_adc4_src[] = {
@@ -1537,21 +1537,21 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_IF1_ADC4_SFT, rt5677_if12_adc4_src);
 
 static const struct snd_kcontrol_new rt5677_if1_adc4_mux =
-	SOC_DAPM_ENUM("IF1 ADC4 source", rt5677_if1_adc4_enum);
+	SOC_DAPM_ENUM("IF1 ADC4 Source", rt5677_if1_adc4_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_if2_adc4_enum, RT5677_TDM2_CTRL2,
 	RT5677_IF2_ADC4_SFT, rt5677_if12_adc4_src);
 
 static const struct snd_kcontrol_new rt5677_if2_adc4_mux =
-	SOC_DAPM_ENUM("IF2 ADC4 source", rt5677_if2_adc4_enum);
+	SOC_DAPM_ENUM("IF2 ADC4 Source", rt5677_if2_adc4_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_slb_adc4_enum, RT5677_SLIMBUS_RX,
 	RT5677_SLB_ADC4_SFT, rt5677_if12_adc4_src);
 
 static const struct snd_kcontrol_new rt5677_slb_adc4_mux =
-	SOC_DAPM_ENUM("SLB ADC4 source", rt5677_slb_adc4_enum);
+	SOC_DAPM_ENUM("SLB ADC4 Source", rt5677_slb_adc4_enum);
 
 /* Interface3/4 ADC Data Input */ /* MX-2F [3:0] MX-30 [7:4]*/
 static const char * const rt5677_if34_adc_src[] = {
@@ -1564,14 +1564,14 @@ static SOC_ENUM_SINGLE_DECL(
 	RT5677_IF3_ADC_IN_SFT, rt5677_if34_adc_src);
 
 static const struct snd_kcontrol_new rt5677_if3_adc_mux =
-	SOC_DAPM_ENUM("IF3 ADC source", rt5677_if3_adc_enum);
+	SOC_DAPM_ENUM("IF3 ADC Source", rt5677_if3_adc_enum);
 
 static SOC_ENUM_SINGLE_DECL(
 	rt5677_if4_adc_enum, RT5677_IF4_DATA,
 	RT5677_IF4_ADC_IN_SFT, rt5677_if34_adc_src);
 
 static const struct snd_kcontrol_new rt5677_if4_adc_mux =
-	SOC_DAPM_ENUM("IF4 ADC source", rt5677_if4_adc_enum);
+	SOC_DAPM_ENUM("IF4 ADC Source", rt5677_if4_adc_enum);
 
 static int rt5677_bst1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
-- 
1.8.1.1.439.g50a6b54
