From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH v2 6/6] ARM: DaVinci: ASoC: Introduce platform
	driver model for dm644x, dm355
Date: Thu, 16 Apr 2009 18:45:33 -0400
Message-ID: <1239921933-27045-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 17ACC10398C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:38:26 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3GBcLU0026467
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:38:26 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, "Naresh.Medisetty" <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh.Medisetty <naresh@ti.com>

Introduce the platform driver model to get platform data for dm355 and dm644x.
Register platform driver and acquire the resources in the probe function Since
the platform specific code had been moved from machine driver to dm<soc>.c

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/davinci/davinci-i2s.c |   97 +++++++++++++++++++++------------------
 1 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index ffdb943..f5cea59 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -416,16 +416,40 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static int davinci_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
+
+static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
+	.startup 	= davinci_i2s_startup,
+	.trigger	= davinci_i2s_trigger,
+	.hw_params	= davinci_i2s_hw_params,
+	.set_fmt	= davinci_i2s_set_dai_fmt,
+
+};
+
+struct snd_soc_dai davinci_i2s_dai = {
+	.name = "davinci-i2s",
+	.id = 0,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = DAVINCI_I2S_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = DAVINCI_I2S_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = &davinci_i2s_dai_ops,
+
+};
+EXPORT_SYMBOL_GPL(davinci_i2s_dai);
+
+static int davinci_i2s_probe(struct platform_device *pdev)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_dai *cpu_dai = card->dai_link[pdev->id].cpu_dai;
+	int ret;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *ioarea;
-	struct evm_snd_platform_data *pdata;
-	int ret;
+	struct evm_snd_platform_data *pdata = pdev->dev.platform_data;;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -446,9 +470,7 @@ static int davinci_i2s_probe(struct platform_device *pdev,
 		goto err_release_region;
 	}
 
-	cpu_dai->private_data = dev;
-
-	dev->clk = clk_get(&pdev->dev, "McBSPCLK");
+	dev->clk = clk_get(&pdev->dev, pdata->clk_name);
 	if (IS_ERR(dev->clk)) {
 		ret = -ENODEV;
 		goto err_free_mem;
@@ -456,7 +478,6 @@ static int davinci_i2s_probe(struct platform_device *pdev,
 	clk_enable(dev->clk);
 
 	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
-	pdata = pdev->dev.platform_data;
 
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &davinci_i2s_pcm_out;
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = pdata->tx_dma_ch;
@@ -467,7 +488,10 @@ static int davinci_i2s_probe(struct platform_device *pdev,
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel = pdata->rx_dma_ch;
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->dma_addr =
 	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DRR_REG);
-
+	davinci_i2s_dai.private_data = dev;
+	ret = snd_soc_register_dai(&davinci_i2s_dai);
+	if (ret != 0)
+		goto err_free_mem;
 	return 0;
 
 err_free_mem:
@@ -478,15 +502,13 @@ err_release_region:
 	return ret;
 }
 
-static void davinci_i2s_remove(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
+static int davinci_i2s_remove(struct platform_device *pdev)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_dai *cpu_dai = card->dai_link[pdev->id].cpu_dai;
-	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = davinci_i2s_dai.private_data;
 	struct resource *mem;
 
+	snd_soc_unregister_dai(&davinci_i2s_dai);
+
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
@@ -495,45 +517,30 @@ static void davinci_i2s_remove(struct platform_device *pdev,
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	return 0;
 }
 
-#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 
-static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
-	.startup	= davinci_i2s_startup,
-	.trigger	= davinci_i2s_trigger,
-	.hw_params	= davinci_i2s_hw_params,
-	.set_fmt	= davinci_i2s_set_dai_fmt,
+static struct platform_driver davinci_asoc_driver = {
+	.probe		= davinci_i2s_probe,
+	.remove		= davinci_i2s_remove,
+	.driver		= {
+		.name	= "davinci-asoc",
+		.owner	= THIS_MODULE,
+	},
 };
 
-struct snd_soc_dai davinci_i2s_dai = {
-	.name = "davinci-i2s",
-	.id = 0,
-	.probe = davinci_i2s_probe,
-	.remove = davinci_i2s_remove,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = DAVINCI_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = DAVINCI_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = &davinci_i2s_dai_ops,
-};
-EXPORT_SYMBOL_GPL(davinci_i2s_dai);
-
 static int __init davinci_i2s_init(void)
 {
-	return snd_soc_register_dai(&davinci_i2s_dai);
+	return platform_driver_register(&davinci_asoc_driver);
+
 }
 module_init(davinci_i2s_init);
 
 static void __exit davinci_i2s_exit(void)
 {
-	snd_soc_unregister_dai(&davinci_i2s_dai);
+	platform_driver_unregister(&davinci_asoc_driver);
+
 }
 module_exit(davinci_i2s_exit);
 
-- 
1.5.6
