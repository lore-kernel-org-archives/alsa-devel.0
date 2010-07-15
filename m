From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 2/3] ASoC: multi-component - Modify to use
	common S3C I2S features
Date: Thu, 15 Jul 2010 17:58:47 +0900
Message-ID: <1279184328-31746-2-git-send-email-sw.youn@samsung.com>
References: <git send-email --to alsa-devel@alsa-project.org --cc "Liam
	Girdwood <lrg@slimlogic.co.uk>" --cc "Mark Brown
	<broonie@opensource.wolfsonmicro.com>" --cc "Jassi Brar
	<jassisinghbrar@gmail.com>" --cc "Seungwhan Youn
	<claude.youn@gmail.com>" 000*>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 388341038EB
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 11:09:47 +0200 (CEST)
In-Reply-To: <1279184328-31746-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

In Samsung SoC's I2S was improved gradually from I2Sv2 to I2Sv4.
So, S3C I2S platform codes are designed to use privious feature
hierarchy. This patch modify that s3c64xx-i2s use common features
of s3c-i2s-v2 and remove duplicated function on s3c64xx-i2s.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.h     |    2 +
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c |   13 +++++++-
 sound/soc/s3c24xx/s3c64xx-i2s.c    |   55 ++++++++++++------------------------
 3 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
index c2a4bad..d458301 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.h
@@ -66,6 +66,8 @@ struct s3c_i2sv2_info {
 	u32		 suspend_iismod;
 	u32		 suspend_iiscon;
 	u32		 suspend_iispsr;
+
+	unsigned long	base;
 };
 
 extern struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai);
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 72708af..e17bc92 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -41,6 +41,9 @@ static struct s3c_i2sv2_info s3c64xx_i2sv4;
 
 static int s3c64xx_i2sv4_probe(struct snd_soc_dai *dai)
 {
+	struct s3c_i2sv2_info *i2s = &s3c64xx_i2sv4;
+	int ret = 0;
+
 	/* configure GPIO for i2s port */
 	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
 	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
@@ -50,7 +53,11 @@ static int s3c64xx_i2sv4_probe(struct snd_soc_dai *dai)
 	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
 	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
 
-	return 0;
+	snd_soc_dai_set_drvdata(dai, i2s);
+
+	ret = s3c_i2sv2_probe(dai, i2s, i2s->base);
+
+	return ret;
 }
 
 static int s3c_i2sv4_hw_params(struct snd_pcm_substream *substream,
@@ -137,6 +144,8 @@ static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 	i2s->dma_playback->client = &s3c64xx_dma_client_out;
 	i2s->dma_playback->dma_size = 4;
 
+	i2s->base = S3C64XX_PA_IISV4;
+
 	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
 		dev_err(&pdev->dev, "failed to get audio-bus\n");
@@ -146,7 +155,7 @@ static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 
 	clk_enable(i2s->iis_cclk);
 
-	ret = snd_soc_register_dai(&pdev->dev, pdev->id, &s3c64xx_i2s_v4_dai);
+	ret = s3c_i2sv2_register_dai(&pdev->dev, pdev->id, &s3c64xx_i2s_v4_dai);
 	if (ret != 0)
 		goto err_i2sv2;
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 5017e31..e712204 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -48,43 +48,6 @@ static struct s3c2410_dma_client s3c64xx_dma_client_in = {
 static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
 static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
 
-static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(cpu_dai);
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	switch (clk_id) {
-	case S3C64XX_CLKSRC_PCLK:
-		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-
-	case S3C64XX_CLKSRC_MUX:
-		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-
-	case S3C64XX_CLKSRC_CDCLK:
-		switch (dir) {
-		case SND_SOC_CLOCK_IN:
-			iismod |= S3C64XX_IISMOD_CDCLKCON;
-			break;
-		case SND_SOC_CLOCK_OUT:
-			iismod &= ~S3C64XX_IISMOD_CDCLKCON;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-
-	return 0;
-}
-
 struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
 {
 	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(dai);
@@ -112,12 +75,14 @@ static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
 
 	switch (dai->id) {
 	case 0:
+		i2s->base = S3C64XX_PA_IIS0;
 		i2s->dma_capture->channel = DMACH_I2S0_IN;
 		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
 		i2s->dma_playback->channel = DMACH_I2S0_OUT;
 		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
 		break;
 	case 1:
+		i2s->base = S3C64XX_PA_IIS1;
 		i2s->dma_capture->channel = DMACH_I2S1_IN;
 		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
 		i2s->dma_playback->channel = DMACH_I2S1_OUT;
@@ -156,8 +121,15 @@ static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
 	}
 
+	ret = s3c_i2sv2_probe(dai, i2s, i2s->base);
+	if (ret)
+		goto err_clk;
+
 	return 0;
 
+err_clk:
+	clk_disable(i2s->i2s_cclk);
+	clk_put(i2s->i2s_cclk);
 err:
 	kfree(i2s);
 	return ret;
@@ -213,6 +185,7 @@ EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
 
 static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
+	int i, ret;
 
 	if (pdev->id >= MAX_I2SV3) {
 		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
@@ -221,6 +194,14 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 
 	return snd_soc_register_dais(&pdev->dev, s3c64xx_i2s_dai,
 			ARRAY_SIZE(s3c64xx_i2s_dai));
+	for (i = 0; i < ARRAY_SIZE(s3c64xx_i2s_dai); i++) {
+		ret = s3c_i2sv2_register_dai(&pdev->dev, i,
+						&s3c4xx_i2s_dai[i]);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static __devexit int s3c64xx_iis_dev_remove(struct platform_device *pdev)
-- 
1.6.2.5
