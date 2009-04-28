From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/17] ASoC: Fix S3C64xx IIS device
	registration and support both ports
Date: Tue, 28 Apr 2009 16:23:28 +0100
Message-ID: <1240932222-3718-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B0AA103882
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:45 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The S3C64xx IIS code had a number of problems with device registration.
The hardware has two IIS ports of which the driver supported only one
at once via a single exported DAI, attempting to identify the DAI to
use based on the dev->id of the ASoC platform device.  As well as
limiting the driver to only supporting one IIS port at once this also
meant that the ID of the soc-audio device (or in future the card device)
had to match the IIS ID.

Fix both problems by converting the driver to register the DAIs based on
probing of platform devices registered by the arch/arm code, using those
platform devices to interact with the clock API.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |  146 ++++++++++++++++++++++++++-------------
 sound/soc/s3c24xx/s3c64xx-i2s.h |    2 +-
 2 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 33c5de7..a84c4be 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -120,36 +120,8 @@ EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clockrate);
 static int s3c64xx_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
-	struct device *dev = &pdev->dev;
-	struct s3c_i2sv2_info *i2s;
-	int ret;
-
-	dev_dbg(dev, "%s: probing dai %d\n", __func__, pdev->id);
-
-	if (pdev->id < 0 || pdev->id > ARRAY_SIZE(s3c64xx_i2s)) {
-		dev_err(dev, "id %d out of range\n", pdev->id);
-		return -EINVAL;
-	}
-
-	i2s = &s3c64xx_i2s[pdev->id];
-
-	ret = s3c_i2sv2_probe(pdev, dai, i2s,
-			      pdev->id ? S3C64XX_PA_IIS1 : S3C64XX_PA_IIS0);
-	if (ret)
-		return ret;
-
-	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
-	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
-
-	i2s->iis_cclk = clk_get(dev, "audio-bus");
-	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(dev, "failed to get audio-bus");
-		iounmap(i2s->regs);
-		return -ENODEV;
-	}
-
 	/* configure GPIO for i2s port */
-	switch (pdev->id) {
+	switch (dai->id) {
 	case 0:
 		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
 		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
@@ -181,35 +153,114 @@ static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops = {
 	.set_sysclk	= s3c64xx_i2s_set_sysclk,	
 };
 
-struct snd_soc_dai s3c64xx_i2s_dai = {
-	.name		= "s3c64xx-i2s",
-	.id		= 0,
-	.probe		= s3c64xx_i2s_probe,
-	.playback = {
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= S3C64XX_I2S_RATES,
-		.formats	= S3C64XX_I2S_FMTS,
+struct snd_soc_dai s3c64xx_i2s_dai[] = {
+	{
+		.name		= "s3c64xx-i2s",
+		.id		= 0,
+		.probe		= s3c64xx_i2s_probe,
+		.playback = {
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= S3C64XX_I2S_RATES,
+			.formats	= S3C64XX_I2S_FMTS,
+		},
+		.capture = {
+			 .channels_min	= 2,
+			 .channels_max	= 2,
+			 .rates		= S3C64XX_I2S_RATES,
+			 .formats	= S3C64XX_I2S_FMTS,
+		 },
+		.ops = &s3c64xx_i2s_dai_ops,
 	},
-	.capture = {
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= S3C64XX_I2S_RATES,
-		.formats	= S3C64XX_I2S_FMTS,
+	{
+		.name		= "s3c64xx-i2s",
+		.id		= 1,
+		.probe		= s3c64xx_i2s_probe,
+		.playback = {
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= S3C64XX_I2S_RATES,
+			.formats	= S3C64XX_I2S_FMTS,
+		},
+		.capture = {
+			 .channels_min	= 2,
+			 .channels_max	= 2,
+			 .rates		= S3C64XX_I2S_RATES,
+			 .formats	= S3C64XX_I2S_FMTS,
+		 },
+		.ops = &s3c64xx_i2s_dai_ops,
 	},
-	.ops = &s3c64xx_i2s_dai_ops,
 };
 EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
 
+static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
+{
+	struct s3c_i2sv2_info *i2s;
+	struct snd_soc_dai *dai;
+	int ret;
+
+	if (pdev->id >= ARRAY_SIZE(s3c64xx_i2s)) {
+		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	i2s = &s3c64xx_i2s[pdev->id];
+	dai = &s3c64xx_i2s_dai[pdev->id];
+	dai->dev = &pdev->dev;
+
+	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
+	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
+
+	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
+	if (IS_ERR(i2s->iis_cclk)) {
+		dev_err(&pdev->dev, "failed to get audio-bus");
+		ret = PTR_ERR(i2s->iis_cclk);
+		goto err;
+	}
+
+	ret = s3c_i2sv2_probe(pdev, dai, i2s,
+			      dai->id ? S3C64XX_PA_IIS1 : S3C64XX_PA_IIS0);
+	if (ret)
+		goto err_clk;
+
+	ret = snd_soc_register_dai(dai);
+	if (ret != 0)
+		goto err_i2sv2;
+
+	return 0;
+
+err_i2sv2:
+	/* Not implemented for I2Sv2 core yet */
+err_clk:
+	clk_put(i2s->iis_cclk);
+err:
+	return ret;
+}
+
+static __devexit int s3c64xx_iis_dev_remove(struct platform_device *pdev)
+{
+	dev_err(&pdev->dev, "Device removal not yet supported\n");
+	return 0;
+}
+
+static struct platform_driver s3c64xx_iis_driver = {
+	.probe  = s3c64xx_iis_dev_probe,
+	.remove = s3c64xx_iis_dev_remove,
+	.driver = {
+		.name = "s3c64xx-iis",
+		.owner = THIS_MODULE,
+	},
+};
+
 static int __init s3c64xx_i2s_init(void)
 {
-	return  s3c_i2sv2_register_dai(&s3c64xx_i2s_dai);
+	return platform_driver_register(&s3c64xx_iis_driver);
 }
 module_init(s3c64xx_i2s_init);
 
 static void __exit s3c64xx_i2s_exit(void)
 {
-	snd_soc_unregister_dai(&s3c64xx_i2s_dai);
+	platform_driver_unregister(&s3c64xx_iis_driver);
 }
 module_exit(s3c64xx_i2s_exit);
 
@@ -217,6 +268,3 @@ module_exit(s3c64xx_i2s_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
 MODULE_LICENSE("GPL");
-
-
-
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index b7ffe3c..597822a 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -24,7 +24,7 @@
 #define S3C64XX_CLKSRC_PCLK	(0)
 #define S3C64XX_CLKSRC_MUX	(1)
 
-extern struct snd_soc_dai s3c64xx_i2s_dai;
+extern struct snd_soc_dai s3c64xx_i2s_dai[];
 
 extern unsigned long s3c64xx_i2s_get_clockrate(struct snd_soc_dai *cpu_dai);
 
-- 
1.6.2.4
