From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Rename WM8962 DMIC widget to DMIC_ENA
Date: Fri, 23 Sep 2011 16:45:51 +0100
Message-ID: <1316792751-369-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2323F103871
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 17:45:56 +0200 (CEST)
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

Matches the register name and avoids confusion with board widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 431b976..59b2ad6 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2690,7 +2690,7 @@ SND_SOC_DAPM_MIXER("MIXINL", WM8962_PWR_MGMT_1, 5, 0,
 SND_SOC_DAPM_MIXER("MIXINR", WM8962_PWR_MGMT_1, 4, 0,
 		   mixinr, ARRAY_SIZE(mixinr)),
 
-SND_SOC_DAPM_AIF_IN("DMIC", NULL, 0, WM8962_PWR_MGMT_1, 10, 0),
+SND_SOC_DAPM_AIF_IN("DMIC_ENA", NULL, 0, WM8962_PWR_MGMT_1, 10, 0),
 
 SND_SOC_DAPM_ADC("ADCL", "Capture", WM8962_PWR_MGMT_1, 3, 0),
 SND_SOC_DAPM_ADC("ADCR", "Capture", WM8962_PWR_MGMT_1, 2, 0),
@@ -2769,18 +2769,18 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
 
 	{ "MICBIAS", NULL, "SYSCLK" },
 
-	{ "DMIC", NULL, "DMICDAT" },
+	{ "DMIC_ENA", NULL, "DMICDAT" },
 
 	{ "ADCL", NULL, "SYSCLK" },
 	{ "ADCL", NULL, "TOCLK" },
 	{ "ADCL", NULL, "MIXINL" },
-	{ "ADCL", NULL, "DMIC" },
+	{ "ADCL", NULL, "DMIC_ENA" },
 	{ "ADCL", NULL, "DSP2" },
 
 	{ "ADCR", NULL, "SYSCLK" },
 	{ "ADCR", NULL, "TOCLK" },
 	{ "ADCR", NULL, "MIXINR" },
-	{ "ADCR", NULL, "DMIC" },
+	{ "ADCR", NULL, "DMIC_ENA" },
 	{ "ADCR", NULL, "DSP2" },
 
 	{ "STL", "Left", "ADCL" },
-- 
1.7.6.3
