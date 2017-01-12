From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: rt5659: drop double const
Date: Thu, 12 Jan 2017 14:15:03 +0100
Message-ID: <1484226903-5722-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

Drop the const qualifier as it is being added by SOC_ENUM_DOUBLE_DECL()
already which is called by SOC_ENUM_SINGLE_DECL() as well as the
double const by calls to SOC_VALUE_ENUM_SINGLE_DECL() via
SOC_VALUE_ENUM_DOUBLE_DECL).

Fixes: commit d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem found by sparse:
sound/soc/codecs/rt5659.c:1153:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1156:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1159:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1162:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1165:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1168:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1171:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1174:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1210:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1214:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1218:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1222:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1226:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1230:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1234:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1933:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1940:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1954:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1967:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1980:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:1993:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2007:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2021:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2034:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2041:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2054:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2067:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2080:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2093:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2107:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2114:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2127:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2134:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2147:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2154:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2167:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2174:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2187:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2200:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2213:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2220:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2233:14: warning: duplicate const 
sound/soc/codecs/rt5659.c:2253:14: warning: duplicate const 

which is due to:
static const SOC_ENUM_SINGLE_DECL(...

which via:
#define SOC_ENUM_SINGLE_DECL(name, xreg, xshift, xtexts) \
        SOC_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xtexts)

expands to:
#define SOC_ENUM_DOUBLE_DECL(name, xreg, xshift_l, xshift_r, xtexts) \
        const struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, \
                                                ARRAY_SIZE(xtexts), xtexts)
and that already carries the const qualifier so that results in the
"duplicate const" from sparse. 

Likewise
static const SOC_VALUE_ENUM_SINGLE_DECL(...

via:
#define SOC_VALUE_ENUM_SINGLE_DECL(name, xreg, xshift, xmask, xtexts, xvalues) \
        SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)

which expands to:
#define SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift_l, xshift_r, xmask, xtexts, xvalues) \
        const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
                                                        ARRAY_SIZE(xtexts), xtexts, xvalues)
results in a double const qualifier. The fix is simply to drop the first
const.

 sound/soc/codecs/rt5659.c | 86 ++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index db54550..80672d5 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1150,28 +1150,28 @@ static const char * const rt5659_data_select[] = {
 	"L/R", "R/L", "L/L", "R/R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if1_01_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if1_01_adc_enum,
 	RT5659_TDM_CTRL_2, RT5659_DS_ADC_SLOT01_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if1_23_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if1_23_adc_enum,
 	RT5659_TDM_CTRL_2, RT5659_DS_ADC_SLOT23_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if1_45_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if1_45_adc_enum,
 	RT5659_TDM_CTRL_2, RT5659_DS_ADC_SLOT45_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if1_67_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if1_67_adc_enum,
 	RT5659_TDM_CTRL_2, RT5659_DS_ADC_SLOT67_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if2_dac_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if2_dac_enum,
 	RT5659_DIG_INF23_DATA, RT5659_IF2_DAC_SEL_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if2_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if2_adc_enum,
 	RT5659_DIG_INF23_DATA, RT5659_IF2_ADC_SEL_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if3_dac_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if3_dac_enum,
 	RT5659_DIG_INF23_DATA, RT5659_IF3_DAC_SEL_SFT, rt5659_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5659_if3_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5659_if3_adc_enum,
 	RT5659_DIG_INF23_DATA, RT5659_IF3_ADC_SEL_SFT, rt5659_data_select);
 
 static const struct snd_kcontrol_new rt5659_if1_01_adc_swap_mux =
@@ -1207,31 +1207,31 @@ static unsigned int rt5659_asrc_clk_map_values[] = {
 	0, 1, 2, 3, 5, 6,
 };
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(
+static SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
@@ -1930,14 +1930,14 @@ static const char * const rt5659_dac2_src[] = {
 	"IF1 DAC2", "IF2 DAC", "IF3 DAC", "Mono ADC MIX"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_dac_l2_enum, RT5659_DAC_CTRL,
 	RT5659_DAC_L2_SEL_SFT, rt5659_dac2_src);
 
 static const struct snd_kcontrol_new rt5659_dac_l2_mux =
 	SOC_DAPM_ENUM("DAC L2 Source", rt5659_dac_l2_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_dac_r2_enum, RT5659_DAC_CTRL,
 	RT5659_DAC_R2_SEL_SFT, rt5659_dac2_src);
 
@@ -1951,7 +1951,7 @@ static const char * const rt5659_sto1_adc1_src[] = {
 	"DAC MIX", "ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_sto1_adc1_enum, RT5659_STO1_ADC_MIXER,
 	RT5659_STO1_ADC1_SRC_SFT, rt5659_sto1_adc1_src);
 
@@ -1964,7 +1964,7 @@ static const char * const rt5659_sto1_adc_src[] = {
 	"ADC1", "ADC2"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_sto1_adc_enum, RT5659_STO1_ADC_MIXER,
 	RT5659_STO1_ADC_SRC_SFT, rt5659_sto1_adc_src);
 
@@ -1977,7 +1977,7 @@ static const char * const rt5659_sto1_adc2_src[] = {
 	"DAC MIX", "DMIC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_sto1_adc2_enum, RT5659_STO1_ADC_MIXER,
 	RT5659_STO1_ADC2_SRC_SFT, rt5659_sto1_adc2_src);
 
@@ -1990,7 +1990,7 @@ static const char * const rt5659_sto1_dmic_src[] = {
 	"DMIC1", "DMIC2"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_sto1_dmic_enum, RT5659_STO1_ADC_MIXER,
 	RT5659_STO1_DMIC_SRC_SFT, rt5659_sto1_dmic_src);
 
@@ -2004,7 +2004,7 @@ static const char * const rt5659_mono_adc_l2_src[] = {
 	"Mono DAC MIXL", "DMIC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_adc_l2_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_ADC_L2_SRC_SFT, rt5659_mono_adc_l2_src);
 
@@ -2018,7 +2018,7 @@ static const char * const rt5659_mono_adc_l1_src[] = {
 	"Mono DAC MIXL", "ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_adc_l1_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_ADC_L1_SRC_SFT, rt5659_mono_adc_l1_src);
 
@@ -2031,14 +2031,14 @@ static const char * const rt5659_mono_adc_src[] = {
 	"ADC1 L", "ADC1 R", "ADC2 L", "ADC2 R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_adc_l_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_ADC_L_SRC_SFT, rt5659_mono_adc_src);
 
 static const struct snd_kcontrol_new rt5659_mono_adc_l_mux =
 	SOC_DAPM_ENUM("Mono ADC L Source", rt5659_mono_adc_l_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_adcr_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_ADC_R_SRC_SFT, rt5659_mono_adc_src);
 
@@ -2051,7 +2051,7 @@ static const char * const rt5659_mono_dmic_l_src[] = {
 	"DMIC1 L", "DMIC2 L"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_dmic_l_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_DMIC_L_SRC_SFT, rt5659_mono_dmic_l_src);
 
@@ -2064,7 +2064,7 @@ static const char * const rt5659_mono_adc_r2_src[] = {
 	"Mono DAC MIXR", "DMIC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_adc_r2_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_ADC_R2_SRC_SFT, rt5659_mono_adc_r2_src);
 
@@ -2077,7 +2077,7 @@ static const char * const rt5659_mono_adc_r1_src[] = {
 	"Mono DAC MIXR", "ADC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_adc_r1_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_ADC_R1_SRC_SFT, rt5659_mono_adc_r1_src);
 
@@ -2090,7 +2090,7 @@ static const char * const rt5659_mono_dmic_r_src[] = {
 	"DMIC1 R", "DMIC2 R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_mono_dmic_r_enum, RT5659_MONO_ADC_MIXER,
 	RT5659_MONO_DMIC_R_SRC_SFT, rt5659_mono_dmic_r_src);
 
@@ -2104,14 +2104,14 @@ static const char * const rt5659_dac1_src[] = {
 	"IF1 DAC1", "IF2 DAC", "IF3 DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_dac_r1_enum, RT5659_AD_DA_MIXER,
 	RT5659_DAC1_R_SEL_SFT, rt5659_dac1_src);
 
 static const struct snd_kcontrol_new rt5659_dac_r1_mux =
 	SOC_DAPM_ENUM("DAC R1 Source", rt5659_dac_r1_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_dac_l1_enum, RT5659_AD_DA_MIXER,
 	RT5659_DAC1_L_SEL_SFT, rt5659_dac1_src);
 
@@ -2124,14 +2124,14 @@ static const char * const rt5659_dig_dac_mix_src[] = {
 	"Stereo DAC Mixer", "Mono DAC Mixer"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_dig_dac_mixl_enum, RT5659_DIG_MIXER,
 	RT5659_DAC_MIX_L_SFT, rt5659_dig_dac_mix_src);
 
 static const struct snd_kcontrol_new rt5659_dig_dac_mixl_mux =
 	SOC_DAPM_ENUM("DAC Digital Mixer L Source", rt5659_dig_dac_mixl_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_dig_dac_mixr_enum, RT5659_DIG_MIXER,
 	RT5659_DAC_MIX_R_SFT, rt5659_dig_dac_mix_src);
 
@@ -2144,14 +2144,14 @@ static const char * const rt5659_alg_dac1_src[] = {
 	"DAC", "Stereo DAC Mixer"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_alg_dac_l1_enum, RT5659_A_DAC_MUX,
 	RT5659_A_DACL1_SFT, rt5659_alg_dac1_src);
 
 static const struct snd_kcontrol_new rt5659_alg_dac_l1_mux =
 	SOC_DAPM_ENUM("Analog DACL1 Source", rt5659_alg_dac_l1_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_alg_dac_r1_enum, RT5659_A_DAC_MUX,
 	RT5659_A_DACR1_SFT, rt5659_alg_dac1_src);
 
@@ -2164,14 +2164,14 @@ static const char * const rt5659_alg_dac2_src[] = {
 	"Stereo DAC Mixer", "Mono DAC Mixer"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_alg_dac_l2_enum, RT5659_A_DAC_MUX,
 	RT5659_A_DACL2_SFT, rt5659_alg_dac2_src);
 
 static const struct snd_kcontrol_new rt5659_alg_dac_l2_mux =
 	SOC_DAPM_ENUM("Analog DAC L2 Source", rt5659_alg_dac_l2_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_alg_dac_r2_enum, RT5659_A_DAC_MUX,
 	RT5659_A_DACR2_SFT, rt5659_alg_dac2_src);
 
@@ -2184,7 +2184,7 @@ static const char * const rt5659_if2_adc_in_src[] = {
 	"IF_ADC1", "IF_ADC2", "DAC_REF", "IF_ADC3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_if2_adc_in_enum, RT5659_DIG_INF23_DATA,
 	RT5659_IF2_ADC_IN_SFT, rt5659_if2_adc_in_src);
 
@@ -2197,7 +2197,7 @@ static const char * const rt5659_if3_adc_in_src[] = {
 	"IF_ADC1", "IF_ADC2", "DAC_REF", "Stereo2_ADC_L/R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_if3_adc_in_enum, RT5659_DIG_INF23_DATA,
 	RT5659_IF3_ADC_IN_SFT, rt5659_if3_adc_in_src);
 
@@ -2210,14 +2210,14 @@ static const char * const rt5659_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_pdm_l_enum, RT5659_PDM_OUT_CTRL,
 	RT5659_PDM1_L_SFT, rt5659_pdm_src);
 
 static const struct snd_kcontrol_new rt5659_pdm_l_mux =
 	SOC_DAPM_ENUM("PDM L Source", rt5659_pdm_l_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_pdm_r_enum, RT5659_PDM_OUT_CTRL,
 	RT5659_PDM1_R_SFT, rt5659_pdm_src);
 
@@ -2230,7 +2230,7 @@ static const char * const rt5659_spdif_src[] = {
 	"IF1_DAC1", "IF1_DAC2", "IF2_DAC", "IF3_DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_spdif_enum, RT5659_SPDIF_CTRL,
 	RT5659_SPDIF_SEL_SFT, rt5659_spdif_src);
 
@@ -2250,7 +2250,7 @@ static const char * const rt5659_rx_adc_data_src[] = {
 	"NUL:AD2:DAC:AD1", "NUL:DAC:DAC:AD2", "NUL:DAC:AD2:DAC"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5659_rx_adc_data_enum, RT5659_TDM_CTRL_2,
 	RT5659_ADCDAT_SRC_SFT, rt5659_rx_adc_data_src);
 
-- 
2.1.4
