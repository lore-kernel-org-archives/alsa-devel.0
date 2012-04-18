From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: samsung: Hook up AIF2 to the CODEC on
	Littlemill
Date: Wed, 18 Apr 2012 18:17:37 +0100
Message-ID: <1334769457-20256-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BE542447F
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 19:17:40 +0200 (CEST)
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

Connect the WM1250-EV1 baseband simulator on Littlemill systems up to
the CODEC AIF2 using the new CODEC<->CODEC link support, allowing a wider
range of use cases to be represented.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/littlemill.c |   82 ++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index e741685..71bff63 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -23,10 +23,10 @@ static int littlemill_set_bias_level(struct snd_soc_card *card,
 					  struct snd_soc_dapm_context *dapm,
 					  enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
 	int ret;
 
-	if (dapm->dev != codec_dai->dev)
+	if (dapm->dev != aif1_dai->dev)
 		return 0;
 
 	switch (level) {
@@ -36,7 +36,7 @@ static int littlemill_set_bias_level(struct snd_soc_card *card,
 		 * then do so now, otherwise these are noops.
 		 */
 		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
-			ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1,
+			ret = snd_soc_dai_set_pll(aif1_dai, WM8994_FLL1,
 						  WM8994_FLL_SRC_MCLK2, 32768,
 						  sample_rate * 512);
 			if (ret < 0) {
@@ -44,7 +44,7 @@ static int littlemill_set_bias_level(struct snd_soc_card *card,
 				return ret;
 			}
 
-			ret = snd_soc_dai_set_sysclk(codec_dai,
+			ret = snd_soc_dai_set_sysclk(aif1_dai,
 						     WM8994_SYSCLK_FLL1,
 						     sample_rate * 512,
 						     SND_SOC_CLOCK_IN);
@@ -66,25 +66,58 @@ static int littlemill_set_bias_level_post(struct snd_soc_card *card,
 					       struct snd_soc_dapm_context *dapm,
 					       enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
+	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
 	int ret;
 
-	if (dapm->dev != codec_dai->dev)
+	if (dapm->dev != aif1_dai->dev)
 		return 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
-		ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_MCLK2,
+		ret = snd_soc_dai_set_sysclk(aif2_dai, WM8994_SYSCLK_MCLK2,
 					     32768, SND_SOC_CLOCK_IN);
 		if (ret < 0) {
-			pr_err("Failed to switch away from FLL: %d\n", ret);
+			pr_err("Failed to switch away from FLL2: %d\n", ret);
 			return ret;
 		}
 
-		ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1,
+		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
 					  0, 0, 0);
 		if (ret < 0) {
-			pr_err("Failed to stop FLL: %d\n", ret);
+			pr_err("Failed to stop FLL2: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
+					     32768, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to switch away from FLL1: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_pll(aif1_dai, WM8994_FLL1,
+					  0, 0, 0);
+		if (ret < 0) {
+			pr_err("Failed to stop FLL1: %d\n", ret);
+			return ret;
+		}
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
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
 			return ret;
 		}
 		break;
@@ -131,6 +164,14 @@ static struct snd_soc_ops littlemill_ops = {
 	.hw_params = littlemill_hw_params,
 };
 
+static const struct snd_soc_pcm_stream baseband_params = {
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.rate_min = 8000,
+	.rate_max = 8000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
 static struct snd_soc_dai_link littlemill_dai[] = {
 	{
 		.name = "CPU",
@@ -143,6 +184,17 @@ static struct snd_soc_dai_link littlemill_dai[] = {
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.ops = &littlemill_ops,
 	},
+	{
+		.name = "Baseband",
+		.stream_name = "Baseband",
+		.cpu_dai_name = "wm8994-aif2",
+		.codec_dai_name = "wm1250-ev1",
+		.codec_name = "wm1250-ev1.1-0027",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.ignore_suspend = 1,
+		.params = &baseband_params,
+	},
 };
 
 static struct snd_soc_dapm_widget widgets[] = {
@@ -169,10 +221,16 @@ static struct snd_soc_jack littlemill_headset;
 static int littlemill_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec = card->rtd[0].codec;
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
+	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_MCLK2,
+	ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
+				     32768, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(aif2_dai, WM8994_SYSCLK_MCLK2,
 				     32768, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
-- 
1.7.10
