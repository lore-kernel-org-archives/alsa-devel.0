From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: blackfin: Use dai_fmt
Date: Wed, 1 Feb 2012 19:24:21 +0100
Message-ID: <1328120661-28586-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id D1F932457A
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 19:23:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use the dai_link's dai_fmt attribute to setup the DAI format instead of doing
this manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ad1836.c       |   17 +++++------------
 sound/soc/blackfin/bf5xx-ad193x.c       |   17 +++++------------
 sound/soc/blackfin/bf5xx-ad73311.c      |   29 ++++-------------------------
 sound/soc/blackfin/bf5xx-ssm2602.c      |   20 ++++----------------
 sound/soc/blackfin/bfin-eval-adau1373.c |   13 ++-----------
 sound/soc/blackfin/bfin-eval-adau1701.c |   16 +++++-----------
 sound/soc/blackfin/bfin-eval-adav80x.c  |   13 ++-----------
 7 files changed, 27 insertions(+), 98 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 60962ce..d542d40 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -40,20 +40,8 @@ static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int channel_map[] = {0, 4, 1, 5, 2, 6, 3, 7};
 	int ret = 0;
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
 
 	/* set cpu DAI channel mapping */
 	ret = snd_soc_dai_set_channel_map(cpu_dai, ARRAY_SIZE(channel_map),
@@ -68,6 +56,9 @@ static struct snd_soc_ops bf5xx_ad1836_ops = {
 	.hw_params = bf5xx_ad1836_hw_params,
 };
 
+#define BF5XX_AD1836_DAIFMT (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_IF | \
+				SND_SOC_DAIFMT_CBM_CFM)
+
 static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
 	{
 		.name = "ad1836",
@@ -77,6 +68,7 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
 		.platform_name = "bfin-tdm-pcm-audio",
 		.codec_name = "spi0.4",
 		.ops = &bf5xx_ad1836_ops,
+		.dai_fmt = BF5XX_AD1836_DAIFMT,
 	},
 	{
 		.name = "ad1836",
@@ -86,6 +78,7 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
 		.platform_name = "bfin-tdm-pcm-audio",
 		.codec_name = "spi0.4",
 		.ops = &bf5xx_ad1836_ops,
+		.dai_fmt = BF5XX_AD1836_DAIFMT,
 	},
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index 2d8d82d..0e55e9f 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -60,18 +60,6 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
 		SND_SOC_CLOCK_IN);
@@ -92,6 +80,9 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+#define BF5XX_AD193X_DAIFMT (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_IF | \
+				SND_SOC_DAIFMT_CBM_CFM)
+
 static struct snd_soc_ops bf5xx_ad193x_ops = {
 	.hw_params = bf5xx_ad193x_hw_params,
 };
@@ -105,6 +96,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
 		.platform_name = "bfin-tdm-pcm-audio",
 		.codec_name = "spi0.5",
 		.ops = &bf5xx_ad193x_ops,
+		.dai_fmt = BF5XX_AD193X_DAIFMT,
 	},
 	{
 		.name = "ad193x",
@@ -114,6 +106,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
 		.platform_name = "bfin-tdm-pcm-audio",
 		.codec_name = "spi0.5",
 		.ops = &bf5xx_ad193x_ops,
+		.dai_fmt = BF5XX_AD193X_DAIFMT,
 	},
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 8e49508..61cc91d 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -145,29 +145,8 @@ static int bf5xx_probe(struct snd_soc_card *card)
 	return 0;
 }
 
-static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0;
-
-	pr_debug("%s rate %d format %x\n", __func__, params_rate(params),
-		params_format(params));
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-
-static struct snd_soc_ops bf5xx_ad73311_ops = {
-	.hw_params = bf5xx_ad73311_hw_params,
-};
+#define BF5XX_AD7311_DAI_FMT (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | \
+				SND_SOC_DAIFMT_CBM_CFM)
 
 static struct snd_soc_dai_link bf5xx_ad73311_dai[] = {
 	{
@@ -177,7 +156,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai[] = {
 		.codec_dai_name = "ad73311-hifi",
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "ad73311",
-		.ops = &bf5xx_ad73311_ops,
+		.dai_fmt = BF5XX_AD7311_DAI_FMT,
 	},
 	{
 		.name = "ad73311",
@@ -186,7 +165,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai[] = {
 		.codec_dai_name = "ad73311-hifi",
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "ad73311",
-		.ops = &bf5xx_ad73311_ops,
+		.dai_fmt = BF5XX_AD7311_DAI_FMT,
 	},
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 0303032..df3ac73 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -49,7 +49,6 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 
@@ -75,21 +74,6 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/*
-	 * CODEC is master for BCLK and LRC in this configuration.
-	 */
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, SSM2602_SYSCLK, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
@@ -102,6 +86,10 @@ static struct snd_soc_ops bf5xx_ssm2602_ops = {
 	.hw_params = bf5xx_ssm2602_hw_params,
 };
 
+/* CODEC is master for BCLK and LRC in this configuration. */
+#define BF5XX_SSM2602_DAIFMT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
+				SND_SOC_DAIFMT_CBM_CFM)
+
 static struct snd_soc_dai_link bf5xx_ssm2602_dai[] = {
 	{
 		.name = "ssm2602",
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index 26b271c..f3adbdb 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -67,21 +67,10 @@ static int bfin_eval_adau1373_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 	int pll_rate;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret)
-		return ret;
-
 	switch (params_rate(params)) {
 	case 48000:
 	case 8000:
@@ -143,6 +132,8 @@ static struct snd_soc_dai_link bfin_eval_adau1373_dai = {
 	.codec_name = "adau1373.0-001a",
 	.ops = &bfin_eval_adau1373_ops,
 	.init = bfin_eval_adau1373_codec_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBM_CFM,
 };
 
 static struct snd_soc_card bfin_eval_adau1373 = {
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
index c0064fa..b0531fc 100644
--- a/sound/soc/blackfin/bfin-eval-adau1701.c
+++ b/sound/soc/blackfin/bfin-eval-adau1701.c
@@ -37,20 +37,9 @@ static int bfin_eval_adau1701_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret)
-		return ret;
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, ADAU1701_CLK_SRC_OSC, 12288000,
 			SND_SOC_CLOCK_IN);
 
@@ -61,6 +50,9 @@ static struct snd_soc_ops bfin_eval_adau1701_ops = {
 	.hw_params = bfin_eval_adau1701_hw_params,
 };
 
+#define BFIN_EVAL_ADAU1701_DAI_FMT (SND_SOC_DAIFMT_I2S | \
+				SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM)
+
 static struct snd_soc_dai_link bfin_eval_adau1701_dai[] = {
 	{
 		.name = "adau1701",
@@ -70,6 +62,7 @@ static struct snd_soc_dai_link bfin_eval_adau1701_dai[] = {
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "adau1701.0-0034",
 		.ops = &bfin_eval_adau1701_ops,
+		.dai_fmt = BFIN_EVAL_ADAU1701_DAI_FMT,
 	},
 	{
 		.name = "adau1701",
@@ -79,6 +72,7 @@ static struct snd_soc_dai_link bfin_eval_adau1701_dai[] = {
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "adau1701.0-0034",
 		.ops = &bfin_eval_adau1701_ops,
+		.dai_fmt = BFIN_EVAL_ADAU1701_DAI_FMT,
 	},
 };
 
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 4ef079f..84b0998 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -34,20 +34,9 @@ static int bfin_eval_adav80x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret)
-		return ret;
-
 	ret = snd_soc_dai_set_pll(codec_dai, ADAV80X_PLL1, ADAV80X_PLL_SRC_XTAL,
 			27000000, params_rate(params) * 256);
 	if (ret)
@@ -88,6 +77,8 @@ static struct snd_soc_dai_link bfin_eval_adav80x_dais[] = {
 		.platform_name = "bfin-i2s-pcm-audio",
 		.init = bfin_eval_adav80x_codec_init,
 		.ops = &bfin_eval_adav80x_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM,
 	},
 };
 
-- 
1.7.8.3
