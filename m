From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2.6.38] ASoC: WM8994: Ensure late enable
	events are processed for the ADCs
Date: Tue,  1 Mar 2011 11:47:10 +0000
Message-ID: <1298980030-6831-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C69010380A
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 12:47:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Ensure that the ADCs are provided with a clock as the previous patch
"ASoC: WM8994: Improve playback robustness" did not handle this case
properly.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9e91525..4afbe3b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1096,6 +1096,13 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int adc_mux_ev(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	late_enable_ev(w, kcontrol, event);
+	return 0;
+}
+
 static int dac_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
@@ -1416,6 +1423,18 @@ SND_SOC_DAPM_DAC("DAC1L", NULL, WM8994_POWER_MANAGEMENT_5, 1, 0),
 SND_SOC_DAPM_DAC("DAC1R", NULL, WM8994_POWER_MANAGEMENT_5, 0, 0),
 };
 
+static const struct snd_soc_dapm_widget wm8994_adc_revd_widgets[] = {
+SND_SOC_DAPM_MUX_E("ADCL Mux", WM8994_POWER_MANAGEMENT_4, 1, 0, &adcl_mux,
+		   adc_mux_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_MUX_E("ADCR Mux", WM8994_POWER_MANAGEMENT_4, 0, 0, &adcr_mux,
+		   adc_mux_ev, SND_SOC_DAPM_PRE_PMU),
+};
+
+static const struct snd_soc_dapm_widget wm8994_adc_widgets[] = {
+SND_SOC_DAPM_MUX("ADCL Mux", WM8994_POWER_MANAGEMENT_4, 1, 0, &adcl_mux),
+SND_SOC_DAPM_MUX("ADCR Mux", WM8994_POWER_MANAGEMENT_4, 0, 0, &adcr_mux),
+};
+
 static const struct snd_soc_dapm_widget wm8994_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("DMIC1DAT"),
 SND_SOC_DAPM_INPUT("DMIC2DAT"),
@@ -1510,9 +1529,6 @@ SND_SOC_DAPM_ADC("DMIC1R", NULL, WM8994_POWER_MANAGEMENT_4, 2, 0),
 SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 
-SND_SOC_DAPM_MUX("ADCL Mux", WM8994_POWER_MANAGEMENT_4, 1, 0, &adcl_mux),
-SND_SOC_DAPM_MUX("ADCR Mux", WM8994_POWER_MANAGEMENT_4, 0, 0, &adcr_mux),
-
 SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
 SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
 
@@ -3293,11 +3309,15 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		if (wm8994->revision < 4) {
 			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_revd_widgets,
 						  ARRAY_SIZE(wm8994_lateclk_revd_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_adc_revd_widgets,
+						  ARRAY_SIZE(wm8994_adc_revd_widgets));
 			snd_soc_dapm_new_controls(dapm, wm8994_dac_revd_widgets,
 						  ARRAY_SIZE(wm8994_dac_revd_widgets));
 		} else {
 			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_widgets,
 						  ARRAY_SIZE(wm8994_lateclk_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_adc_widgets,
+						  ARRAY_SIZE(wm8994_adc_widgets));
 			snd_soc_dapm_new_controls(dapm, wm8994_dac_widgets,
 						  ARRAY_SIZE(wm8994_dac_widgets));
 		}
-- 
1.7.4.1
