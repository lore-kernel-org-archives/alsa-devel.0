From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH] ASoC: Davinci: Replace use of IO_ADDRESS with
	ioremap()
Date: Thu, 16 Dec 2010 14:46:58 +0530
Message-ID: <1292491018-24491-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 738C32432C
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 10:17:09 +0100 (CET)
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch modifies the Davinci i2s and mcasp drivers to use ioremap()
instead of IO_ADDRESS

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 sound/soc/davinci/davinci-i2s.c   |   15 +++++++++++----
 sound/soc/davinci/davinci-mcasp.c |   16 ++++++++++++----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 9e0e565..5395fad 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -694,7 +694,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	}
 	clk_enable(dev->clk);
 
-	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
+	dev->base = ioremap(mem->start, resource_size(mem));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
 
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].dma_addr =
 	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DXR_REG);
@@ -707,7 +712,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENXIO;
-		goto err_free_mem;
+		goto err_ioremap;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].channel = res->start;
 
@@ -715,7 +720,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENXIO;
-		goto err_free_mem;
+		goto err_ioremap;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 	dev->dev = &pdev->dev;
@@ -724,10 +729,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_i2s_dai);
 	if (ret != 0)
-		goto err_free_mem;
+		goto err_ioremap;
 
 	return 0;
 
+err_ioremap:
+	iounmap(dev->base);
 err_free_mem:
 	kfree(dev);
 err_release_region:
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index fb55d2c..de61b41 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -885,7 +885,13 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	clk_enable(dev->clk);
 	dev->clk_active = 1;
 
-	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
+	dev->base = ioremap(mem->start, resource_size(mem));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
+
 	dev->op_mode = pdata->op_mode;
 	dev->tdm_slots = pdata->tdm_slots;
 	dev->num_serializer = pdata->num_serializer;
@@ -906,7 +912,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENODEV;
-		goto err_release_region;
+		goto err_ioremap;
 	}
 
 	dma_data->channel = res->start;
@@ -921,7 +927,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENODEV;
-		goto err_release_region;
+		goto err_ioremap;
 	}
 
 	dma_data->channel = res->start;
@@ -929,9 +935,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_mcasp_dai[pdata->op_mode]);
 
 	if (ret != 0)
-		goto err_release_region;
+		goto err_ioremap;
 	return 0;
 
+err_ioremap:
+	iounmap(dev->base);
 err_release_region:
 	release_mem_region(mem->start, (mem->end - mem->start) + 1);
 err_release_data:
-- 
1.6.2.4
