From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/2 2.6.38] ASoC: WM8994: Improve playback
	robustness
Date: Fri, 11 Feb 2011 16:32:12 +0000
Message-ID: <1297441932-13350-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1297441932-13350-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33F7D245E9
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 17:32:16 +0100 (CET)
In-Reply-To: <1297441932-13350-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On WM8994 revision D and earlier ensure proper playback robustness
as some rare use cases can trigger issues.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   59 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index bd0cfdd..a60b5db 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1083,6 +1083,17 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int dac_ev(struct snd_soc_dapm_widget *w,
+		  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	unsigned int mask = 1 << w->shift;
+
+	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+			    mask, mask);
+	return 0;
+}
+
 static const char *hp_mux_text[] = {
 	"Mixer",
 	"DAC",
@@ -1374,6 +1385,24 @@ SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0)
 };
 
+static const struct snd_soc_dapm_widget wm8994_dac_revd_widgets[] = {
+SND_SOC_DAPM_DAC_E("DAC2L", NULL, SND_SOC_NOPM, 3, 0,
+	dac_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC_E("DAC2R", NULL, SND_SOC_NOPM, 2, 0,
+	dac_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC_E("DAC1L", NULL, SND_SOC_NOPM, 1, 0,
+	dac_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC_E("DAC1R", NULL, SND_SOC_NOPM, 0, 0,
+	dac_ev, SND_SOC_DAPM_PRE_PMU),
+};
+
+static const struct snd_soc_dapm_widget wm8994_dac_widgets[] = {
+SND_SOC_DAPM_DAC("DAC2L", NULL, WM8994_POWER_MANAGEMENT_5, 3, 0),
+SND_SOC_DAPM_DAC("DAC1R", NULL, WM8994_POWER_MANAGEMENT_5, 2, 0),
+SND_SOC_DAPM_DAC("DAC1L", NULL, WM8994_POWER_MANAGEMENT_5, 1, 0),
+SND_SOC_DAPM_DAC("DAC1R", NULL, WM8994_POWER_MANAGEMENT_5, 0, 0),
+};
+
 static const struct snd_soc_dapm_widget wm8994_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("DMIC1DAT"),
 SND_SOC_DAPM_INPUT("DMIC2DAT"),
@@ -1471,11 +1500,6 @@ SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_MUX("ADCL Mux", WM8994_POWER_MANAGEMENT_4, 1, 0, &adcl_mux),
 SND_SOC_DAPM_MUX("ADCR Mux", WM8994_POWER_MANAGEMENT_4, 0, 0, &adcr_mux),
 
-SND_SOC_DAPM_DAC("DAC2L", NULL, WM8994_POWER_MANAGEMENT_5, 3, 0),
-SND_SOC_DAPM_DAC("DAC2R", NULL, WM8994_POWER_MANAGEMENT_5, 2, 0),
-SND_SOC_DAPM_DAC("DAC1L", NULL, WM8994_POWER_MANAGEMENT_5, 1, 0),
-SND_SOC_DAPM_DAC("DAC1R", NULL, WM8994_POWER_MANAGEMENT_5, 0, 0),
-
 SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
 SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
 
@@ -2627,6 +2651,22 @@ static int wm8994_resume(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
+	unsigned int val, mask;
+
+	if (wm8994->revision < 4) {
+		/* force a HW read */
+		val = wm8994_reg_read(codec->control_data,
+				      WM8994_POWER_MANAGEMENT_5);
+
+		/* modify the cache only */
+		codec->cache_only = 1;
+		mask =  WM8994_DAC1R_ENA | WM8994_DAC1L_ENA |
+			WM8994_DAC2R_ENA | WM8994_DAC2L_ENA;
+		val &= mask;
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    mask, val);
+		codec->cache_only = 0;
+	}
 
 	/* Restore the registers */
 	ret = snd_soc_cache_sync(codec);
@@ -3238,12 +3278,17 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	case WM8994:
 		snd_soc_dapm_new_controls(dapm, wm8994_specific_dapm_widgets,
 					  ARRAY_SIZE(wm8994_specific_dapm_widgets));
-		if (wm8994->revision < 4)
+		if (wm8994->revision < 4) {
 			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_revd_widgets,
 						  ARRAY_SIZE(wm8994_lateclk_revd_widgets));
-		else
+			snd_soc_dapm_new_controls(dapm, wm8994_dac_revd_widgets,
+						  ARRAY_SIZE(wm8994_dac_revd_widgets));
+		} else {
 			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_widgets,
 						  ARRAY_SIZE(wm8994_lateclk_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_dac_widgets,
+						  ARRAY_SIZE(wm8994_dac_widgets));
+		}
 		break;
 	case WM8958:
 		snd_soc_add_controls(codec, wm8958_snd_controls,
-- 
1.7.4
