From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 009/102] ASoC: rt5640: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:21 +0100
Message-ID: <1392723148-12597-7-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CAEA265498
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/rt5640.c | 75 +++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 886924934aa5..1a1e1150237d 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -361,25 +361,24 @@ static unsigned int bst_tlv[] = {
 static const char * const rt5640_data_select[] = {
 	"Normal", "left copy to right", "right copy to left", "Swap"};
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
+			    RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if1_adc_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF1_ADC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if1_adc_enum, RT5640_DIG_INF_DATA,
+			    RT5640_IF1_ADC_SEL_SFT, rt5640_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if2_dac_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF2_DAC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if2_dac_enum, RT5640_DIG_INF_DATA,
+			    RT5640_IF2_DAC_SEL_SFT, rt5640_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5640_if2_adc_enum, RT5640_DIG_INF_DATA,
-				RT5640_IF2_ADC_SEL_SFT, rt5640_data_select);
+static SOC_ENUM_SINGLE_DECL(rt5640_if2_adc_enum, RT5640_DIG_INF_DATA,
+			    RT5640_IF2_ADC_SEL_SFT, rt5640_data_select);
 
 /* Class D speaker gain ratio */
 static const char * const rt5640_clsd_spk_ratio[] = {"1.66x", "1.83x", "1.94x",
 	"2x", "2.11x", "2.22x", "2.33x", "2.44x", "2.55x", "2.66x", "2.77x"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_clsd_spk_ratio_enum, RT5640_CLS_D_OUT,
-	RT5640_CLSD_RATIO_SFT, rt5640_clsd_spk_ratio);
+static SOC_ENUM_SINGLE_DECL(rt5640_clsd_spk_ratio_enum, RT5640_CLS_D_OUT,
+			    RT5640_CLSD_RATIO_SFT, rt5640_clsd_spk_ratio);
 
 static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	/* Speaker Output Volume */
@@ -753,9 +752,8 @@ static const char * const rt5640_stereo_adc1_src[] = {
 	"DIG MIX", "ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_stereo_adc1_enum, RT5640_STO_ADC_MIXER,
-	RT5640_ADC_1_SRC_SFT, rt5640_stereo_adc1_src);
+static SOC_ENUM_SINGLE_DECL(rt5640_stereo_adc1_enum, RT5640_STO_ADC_MIXER,
+			    RT5640_ADC_1_SRC_SFT, rt5640_stereo_adc1_src);
 
 static const struct snd_kcontrol_new rt5640_sto_adc_1_mux =
 	SOC_DAPM_ENUM("Stereo ADC1 Mux", rt5640_stereo_adc1_enum);
@@ -764,9 +762,8 @@ static const char * const rt5640_stereo_adc2_src[] = {
 	"DMIC1", "DMIC2", "DIG MIX"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_stereo_adc2_enum, RT5640_STO_ADC_MIXER,
-	RT5640_ADC_2_SRC_SFT, rt5640_stereo_adc2_src);
+static SOC_ENUM_SINGLE_DECL(rt5640_stereo_adc2_enum, RT5640_STO_ADC_MIXER,
+			    RT5640_ADC_2_SRC_SFT, rt5640_stereo_adc2_src);
 
 static const struct snd_kcontrol_new rt5640_sto_adc_2_mux =
 	SOC_DAPM_ENUM("Stereo ADC2 Mux", rt5640_stereo_adc2_enum);
@@ -776,9 +773,8 @@ static const char * const rt5640_mono_adc_l1_src[] = {
 	"Mono DAC MIXL", "ADCL"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_l1_enum, RT5640_MONO_ADC_MIXER,
-	RT5640_MONO_ADC_L1_SRC_SFT, rt5640_mono_adc_l1_src);
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_l1_enum, RT5640_MONO_ADC_MIXER,
+			    RT5640_MONO_ADC_L1_SRC_SFT, rt5640_mono_adc_l1_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_l1_mux =
 	SOC_DAPM_ENUM("Mono ADC1 left source", rt5640_mono_adc_l1_enum);
@@ -787,9 +783,8 @@ static const char * const rt5640_mono_adc_l2_src[] = {
 	"DMIC L1", "DMIC L2", "Mono DAC MIXL"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_l2_enum, RT5640_MONO_ADC_MIXER,
-	RT5640_MONO_ADC_L2_SRC_SFT, rt5640_mono_adc_l2_src);
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_l2_enum, RT5640_MONO_ADC_MIXER,
+			    RT5640_MONO_ADC_L2_SRC_SFT, rt5640_mono_adc_l2_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_l2_mux =
 	SOC_DAPM_ENUM("Mono ADC2 left source", rt5640_mono_adc_l2_enum);
@@ -798,9 +793,8 @@ static const char * const rt5640_mono_adc_r1_src[] = {
 	"Mono DAC MIXR", "ADCR"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_r1_enum, RT5640_MONO_ADC_MIXER,
-	RT5640_MONO_ADC_R1_SRC_SFT, rt5640_mono_adc_r1_src);
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_r1_enum, RT5640_MONO_ADC_MIXER,
+			    RT5640_MONO_ADC_R1_SRC_SFT, rt5640_mono_adc_r1_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_r1_mux =
 	SOC_DAPM_ENUM("Mono ADC1 right source", rt5640_mono_adc_r1_enum);
@@ -809,9 +803,8 @@ static const char * const rt5640_mono_adc_r2_src[] = {
 	"DMIC R1", "DMIC R2", "Mono DAC MIXR"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_mono_adc_r2_enum, RT5640_MONO_ADC_MIXER,
-	RT5640_MONO_ADC_R2_SRC_SFT, rt5640_mono_adc_r2_src);
+static SOC_ENUM_SINGLE_DECL(rt5640_mono_adc_r2_enum, RT5640_MONO_ADC_MIXER,
+			    RT5640_MONO_ADC_R2_SRC_SFT, rt5640_mono_adc_r2_src);
 
 static const struct snd_kcontrol_new rt5640_mono_adc_r2_mux =
 	SOC_DAPM_ENUM("Mono ADC2 right source", rt5640_mono_adc_r2_enum);
@@ -826,9 +819,9 @@ static int rt5640_dac_l2_values[] = {
 	3,
 };
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5640_dac_l2_enum, RT5640_DSP_PATH2, RT5640_DAC_L2_SEL_SFT,
-	0x3, rt5640_dac_l2_src, rt5640_dac_l2_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(rt5640_dac_l2_enum,
+				  RT5640_DSP_PATH2, RT5640_DAC_L2_SEL_SFT,
+				  0x3, rt5640_dac_l2_src, rt5640_dac_l2_values);
 
 static const struct snd_kcontrol_new rt5640_dac_l2_mux =
 	SOC_DAPM_VALUE_ENUM("DAC2 left channel source", rt5640_dac_l2_enum);
@@ -841,9 +834,9 @@ static int rt5640_dac_r2_values[] = {
 	0,
 };
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5640_dac_r2_enum, RT5640_DSP_PATH2, RT5640_DAC_R2_SEL_SFT,
-	0x3, rt5640_dac_r2_src, rt5640_dac_r2_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(rt5640_dac_r2_enum,
+				  RT5640_DSP_PATH2, RT5640_DAC_R2_SEL_SFT,
+				  0x3, rt5640_dac_r2_src, rt5640_dac_r2_values);
 
 static const struct snd_kcontrol_new rt5640_dac_r2_mux =
 	SOC_DAPM_ENUM("DAC2 right channel source", rt5640_dac_r2_enum);
@@ -860,9 +853,10 @@ static int rt5640_dai_iis_map_values[] = {
 	7,
 };
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5640_dai_iis_map_enum, RT5640_I2S1_SDP, RT5640_I2S_IF_SFT,
-	0x7, rt5640_dai_iis_map, rt5640_dai_iis_map_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(rt5640_dai_iis_map_enum,
+				  RT5640_I2S1_SDP, RT5640_I2S_IF_SFT,
+				  0x7, rt5640_dai_iis_map,
+				  rt5640_dai_iis_map_values);
 
 static const struct snd_kcontrol_new rt5640_dai_mux =
 	SOC_DAPM_VALUE_ENUM("DAI select", rt5640_dai_iis_map_enum);
@@ -872,9 +866,8 @@ static const char * const rt5640_sdi_sel[] = {
 	"IF1", "IF2"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_sdi_sel_enum, RT5640_I2S2_SDP,
-	RT5640_I2S2_SDI_SFT, rt5640_sdi_sel);
+static SOC_ENUM_SINGLE_DECL(rt5640_sdi_sel_enum, RT5640_I2S2_SDP,
+			    RT5640_I2S2_SDI_SFT, rt5640_sdi_sel);
 
 static const struct snd_kcontrol_new rt5640_sdi_mux =
 	SOC_DAPM_ENUM("SDI select", rt5640_sdi_sel_enum);
-- 
1.8.5.2
