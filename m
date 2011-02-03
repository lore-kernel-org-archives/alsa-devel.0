From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Create an AIF1ADCDAT signal widget
	to match AIF2
Date: Thu,  3 Feb 2011 16:27:34 +0000
Message-ID: <1296750455-8175-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9A55103828
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 17:27:37 +0100 (CET)
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

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Due to the different routing for AIF1 and AIF2 we weren't using a
single widget to represent the ADCDAT signal. For consistency add
one.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 0ca81d3..f53b5a9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1287,9 +1287,9 @@ SND_SOC_DAPM_SUPPLY("DSPINTCLK", WM8994_CLOCKING_1, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0),
 
-SND_SOC_DAPM_AIF_OUT("AIF1ADC1L", "AIF1 Capture",
+SND_SOC_DAPM_AIF_OUT("AIF1ADC1L", NULL,
 		     0, WM8994_POWER_MANAGEMENT_4, 9, 0),
-SND_SOC_DAPM_AIF_OUT("AIF1ADC1R", "AIF1 Capture",
+SND_SOC_DAPM_AIF_OUT("AIF1ADC1R", NULL,
 		     0, WM8994_POWER_MANAGEMENT_4, 8, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC1L", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 9, 0, wm8958_aif_ev,
@@ -1298,9 +1298,9 @@ SND_SOC_DAPM_AIF_IN_E("AIF1DAC1R", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 8, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
-SND_SOC_DAPM_AIF_OUT("AIF1ADC2L", "AIF1 Capture",
+SND_SOC_DAPM_AIF_OUT("AIF1ADC2L", NULL,
 		     0, WM8994_POWER_MANAGEMENT_4, 11, 0),
-SND_SOC_DAPM_AIF_OUT("AIF1ADC2R", "AIF1 Capture",
+SND_SOC_DAPM_AIF_OUT("AIF1ADC2R", NULL,
 		     0, WM8994_POWER_MANAGEMENT_4, 10, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC2L", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 11, 0, wm8958_aif_ev,
@@ -1345,6 +1345,7 @@ SND_SOC_DAPM_AIF_IN_E("AIF2DACR", NULL, 0,
 
 SND_SOC_DAPM_AIF_IN("AIF1DACDAT", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_IN("AIF2DACDAT", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1ADCDAT", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_OUT("AIF2ADCDAT", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
 
 SND_SOC_DAPM_MUX("AIF1DAC Mux", SND_SOC_NOPM, 0, 0, &aif1dac_mux),
@@ -1546,6 +1547,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF2DAC2R Mixer", "Left Sidetone Switch", "Left Sidetone" },
 	{ "AIF2DAC2R Mixer", "Right Sidetone Switch", "Right Sidetone" },
 
+	{ "AIF1ADCDAT", NULL, "AIF1ADC1L" },
+	{ "AIF1ADCDAT", NULL, "AIF1ADC1R" },
+	{ "AIF1ADCDAT", NULL, "AIF1ADC2L" },
+	{ "AIF1ADCDAT", NULL, "AIF1ADC2R" },
+
 	{ "AIF2ADCDAT", NULL, "AIF2ADC Mux" },
 
 	/* AIF3 output */
-- 
1.7.3.5
