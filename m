From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: wm8994: Convert to use DAI widget
	routing rather than streams
Date: Thu, 16 Feb 2012 21:56:10 -0800
Message-ID: <1329458170-22119-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B9C43103A5A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b137ac9..45b8ab9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1473,17 +1473,17 @@ SND_SOC_DAPM_AIF_IN_E("AIF2DACR", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 12, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
-SND_SOC_DAPM_AIF_IN("AIF1DACDAT", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
-SND_SOC_DAPM_AIF_IN("AIF2DACDAT", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
-SND_SOC_DAPM_AIF_OUT("AIF1ADCDAT", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
-SND_SOC_DAPM_AIF_OUT("AIF2ADCDAT", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_IN("AIF1DACDAT", NULL, 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_IN("AIF2DACDAT", NULL, 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1ADCDAT", NULL, 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIF2ADCDAT",  NULL, 0, SND_SOC_NOPM, 0, 0),
 
 SND_SOC_DAPM_MUX("AIF1DAC Mux", SND_SOC_NOPM, 0, 0, &aif1dac_mux),
 SND_SOC_DAPM_MUX("AIF2DAC Mux", SND_SOC_NOPM, 0, 0, &aif2dac_mux),
 SND_SOC_DAPM_MUX("AIF2ADC Mux", SND_SOC_NOPM, 0, 0, &aif2adc_mux),
 
-SND_SOC_DAPM_AIF_IN("AIF3DACDAT", "AIF3 Playback", 0, SND_SOC_NOPM, 0, 0),
-SND_SOC_DAPM_AIF_OUT("AIF3ADCDAT", "AIF3 Capture", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_IN("AIF3DACDAT", NULL, 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIF3ADCDAT", NULL, 0, SND_SOC_NOPM, 0, 0),
 
 SND_SOC_DAPM_SUPPLY("TOCLK", WM8994_CLOCKING_1, 4, 0, NULL, 0),
 
@@ -1598,6 +1598,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 	{ "TOCLK", NULL, "CLK_SYS" },
 
+	{ "AIF1DACDAT", NULL, "AIF1 Playback" },
+	{ "AIF2DACDAT", NULL, "AIF2 Playback" },
+	{ "AIF3DACDAT", NULL, "AIF3 Playback" },
+
+	{ "AIF1 Capture", NULL, "AIF1ADCDAT" },
+	{ "AIF2 Capture", NULL, "AIF2ADCDAT" },
+	{ "AIF3 Capture", NULL, "AIF3ADCDAT" },
+
 	/* AIF1 outputs */
 	{ "AIF1ADC1L", NULL, "AIF1ADC1L Mixer" },
 	{ "AIF1ADC1L Mixer", "ADC/DMIC Switch", "ADCL Mux" },
-- 
1.7.9.rc1
