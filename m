From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/21] ASoC: rt5645: remove unused mux define
Date: Fri,  4 Jan 2019 20:02:33 -0600
Message-ID: <20190105020249.8639-6-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

rt5645_if3_adc_in_mux, rt5645_inr_mux, and rt5645_inl_mux are not used.
Remove them from the driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index be674688dc40..52ce380c8f3a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1288,30 +1288,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_dac_r2_mux =
 	SOC_DAPM_ENUM("DAC2 R source", rt5645_dac2r_enum);
 
-
-/* INL/R source */
-static const char * const rt5645_inl_src[] = {
-	"IN2P", "MonoP"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inl_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INL_SEL_SFT, rt5645_inl_src);
-
-static const struct snd_kcontrol_new rt5645_inl_mux =
-	SOC_DAPM_ENUM("INL source", rt5645_inl_enum);
-
-static const char * const rt5645_inr_src[] = {
-	"IN2N", "MonoN"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inr_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INR_SEL_SFT, rt5645_inr_src);
-
-static const struct snd_kcontrol_new rt5645_inr_mux =
-	SOC_DAPM_ENUM("INR source", rt5645_inr_enum);
-
 /* Stereo1 ADC source */
 /* MX-27 [12] */
 static const char * const rt5645_stereo_adc1_src[] = {
@@ -1611,18 +1587,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_if2_adc_in_mux =
 	SOC_DAPM_ENUM("IF2 ADC IN source", rt5645_if2_adc_in_enum);
 
-/* MX-2F [1:0] */
-static const char * const rt5645_if3_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "VAD_ADC"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_if3_adc_in_enum, RT5645_DIG_INF1_DATA,
-	RT5645_IF3_ADC_IN_SFT, rt5645_if3_adc_in_src);
-
-static const struct snd_kcontrol_new rt5645_if3_adc_in_mux =
-	SOC_DAPM_ENUM("IF3 ADC IN source", rt5645_if3_adc_in_enum);
-
 /* MX-31 [15] [13] [11] [9] */
 static const char * const rt5645_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
-- 
2.17.1
