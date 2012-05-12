From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: littlemill: Use a widget to keep track
	of AIF2 clocking
Date: Sat, 12 May 2012 12:37:07 +0100
Message-ID: <1336822627-23604-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3F51244F7
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 13:46:06 +0200 (CEST)
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

Since we only need to clock AIF2 when it's actively in use start up the
FLL for it using a supply widget which supplies AIF2CLK. This both makes
the sequencing more robust and ensures we minimise power consumption.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/littlemill.c |   86 +++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index fd5ac47..c82c646 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -67,7 +67,6 @@ static int littlemill_set_bias_level_post(struct snd_soc_card *card,
 					       enum snd_soc_bias_level level)
 {
 	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
 	int ret;
 
 	if (dapm->dev != aif1_dai->dev)
@@ -75,20 +74,6 @@ static int littlemill_set_bias_level_post(struct snd_soc_card *card,
 
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
-		ret = snd_soc_dai_set_sysclk(aif2_dai, WM8994_SYSCLK_MCLK2,
-					     32768, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			pr_err("Failed to switch away from FLL2: %d\n", ret);
-			return ret;
-		}
-
-		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
-					  0, 0, 0);
-		if (ret < 0) {
-			pr_err("Failed to stop FLL2: %d\n", ret);
-			return ret;
-		}
-
 		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
 					     32768, SND_SOC_CLOCK_IN);
 		if (ret < 0) {
@@ -104,24 +89,6 @@ static int littlemill_set_bias_level_post(struct snd_soc_card *card,
 		}
 		break;
 
-	case SND_SOC_BIAS_PREPARE:
-		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
-					  WM8994_FLL_SRC_BCLK, 64 * 8000,
-					  8000 * 256);
-		if (ret < 0) {
-			pr_err("Failed to start FLL: %d\n", ret);
-			return ret;
-		}
-
-		ret = snd_soc_dai_set_sysclk(aif2_dai, WM8994_SYSCLK_FLL2,
-					     8000 * 256,
-					     SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			pr_err("Failed to set SYSCLK: %d\n", ret);
-			return ret;
-		}
-		break;
-
 	default:
 		break;
 	}
@@ -197,11 +164,62 @@ static struct snd_soc_dai_link littlemill_dai[] = {
 	},
 };
 
+static int bbclk_ev(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_card *card = w->dapm->card;
+	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
+					  WM8994_FLL_SRC_BCLK, 64 * 8000,
+					  8000 * 256);
+		if (ret < 0) {
+			pr_err("Failed to start FLL: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(aif2_dai, WM8994_SYSCLK_FLL2,
+					     8000 * 256,
+					     SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to set SYSCLK: %d\n", ret);
+			return ret;
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = snd_soc_dai_set_sysclk(aif2_dai, WM8994_SYSCLK_MCLK2,
+					     32768, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to switch away from FLL2: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
+					  0, 0, 0);
+		if (ret < 0) {
+			pr_err("Failed to stop FLL2: %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
 	SND_SOC_DAPM_MIC("AMIC", NULL),
 	SND_SOC_DAPM_MIC("DMIC", NULL),
+
+	SND_SOC_DAPM_SUPPLY_S("Baseband Clock", -1, SND_SOC_NOPM, 0, 0,
+			      bbclk_ev,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
 static struct snd_soc_dapm_route audio_paths[] = {
@@ -214,6 +232,8 @@ static struct snd_soc_dapm_route audio_paths[] = {
 	{ "DMIC", NULL, "MICBIAS2" },   /* Default for DMICBIAS jumper */
 	{ "DMIC1DAT", NULL, "DMIC" },
 	{ "DMIC2DAT", NULL, "DMIC" },
+
+	{ "AIF2CLK", NULL, "Baseband Clock" },
 };
 
 static struct snd_soc_jack littlemill_headset;
-- 
1.7.10
