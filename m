From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 2/3] ASoC: Davinci: Call clk_disable() and
	clk_put() in case of error
Date: Wed,  9 Feb 2011 18:39:53 +0530
Message-ID: <1297256994-17137-2-git-send-email-vaibhav.bedia@ti.com>
References: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id B18B124414
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 14:10:07 +0100 (CET)
In-Reply-To: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, sshtylyov@mvista.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

In case of any error in probe() function, clk_disable() and clk_put()
should be called if clk_enable() and clk_get() went through.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 sound/soc/davinci/davinci-i2s.c   |    9 ++++++---
 sound/soc/davinci/davinci-mcasp.c |    9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index f8c8487..e763d58 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -707,7 +707,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENXIO;
-		goto err_free_mem;
+		goto err_release_clk;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].channel = res->start;
 
@@ -715,7 +715,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENXIO;
-		goto err_free_mem;
+		goto err_release_clk;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 	dev->dev = &pdev->dev;
@@ -724,10 +724,13 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_i2s_dai);
 	if (ret != 0)
-		goto err_free_mem;
+		goto err_release_clk;
 
 	return 0;
 
+err_release_clk:
+	clk_disable(dev->clk);
+	clk_put(dev->clk);
 err_free_mem:
 	kfree(dev);
 err_release_region:
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 9b5d5ca..e7ae621 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -906,7 +906,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENODEV;
-		goto err_release_region;
+		goto err_release_clk;
 	}
 
 	dma_data->channel = res->start;
@@ -921,7 +921,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENODEV;
-		goto err_release_region;
+		goto err_release_clk;
 	}
 
 	dma_data->channel = res->start;
@@ -929,9 +929,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_mcasp_dai[pdata->op_mode]);
 
 	if (ret != 0)
-		goto err_release_region;
+		goto err_release_clk;
 	return 0;
 
+err_release_clk:
+	clk_disable(dev->clk);
+	clk_put(dev->clk);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 err_release_data:
-- 
1.6.2.4
