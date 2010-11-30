From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Correct event flags for WM8958 AIF
	DACs
Date: Tue, 30 Nov 2010 17:06:35 +0000
Message-ID: <1291136796-8525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 193E31037F9
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 18:06:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We need a post notification as we need to shut down the MBC after the
data stops flowing rather than before.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e4aab94..c9e5f38 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1205,10 +1205,10 @@ SND_SOC_DAPM_AIF_OUT("AIF1ADC1R", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 8, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC1L", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 9, 0, wm8958_aif_ev,
-		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC1R", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 8, 0, wm8958_aif_ev,
-		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_AIF_OUT("AIF1ADC2L", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 11, 0),
@@ -1216,10 +1216,10 @@ SND_SOC_DAPM_AIF_OUT("AIF1ADC2R", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 10, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC2L", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 11, 0, wm8958_aif_ev,
-		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC2R", NULL, 0,
 		      WM8994_POWER_MANAGEMENT_5, 10, 0, wm8958_aif_ev,
-		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_MIXER("AIF1ADC1L Mixer", SND_SOC_NOPM, 0, 0,
 		   aif1adc1l_mix, ARRAY_SIZE(aif1adc1l_mix)),
-- 
1.7.1
