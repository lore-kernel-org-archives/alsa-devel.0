From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/14] ASoC: mmp-pcm: Allocate dma filter
	parameters on the stack
Date: Fri, 22 Mar 2013 14:12:11 +0100
Message-ID: <1363957934-20059-12-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A91B9266557
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:14 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Zhangfei Gao <zhangfei.gao@marvell.com>
List-Id: alsa-devel@alsa-project.org

The dma filter parameters are only used within filter callback, so there is no
need to allocate them on the heap and keep them around until the PCM has been
closed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 sound/soc/pxa/mmp-pcm.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 190eb0b..6c39802 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -118,9 +118,8 @@ static int mmp_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct mmp_dma_data *dma_data;
+	struct mmp_dma_data dma_data;
 	struct resource *r;
-	int ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, substream->stream);
 	if (!r)
@@ -128,33 +127,11 @@ static int mmp_pcm_open(struct snd_pcm_substream *substream)
 
 	snd_soc_set_runtime_hwparams(substream,
 				&mmp_pcm_hardware[substream->stream]);
-	dma_data = devm_kzalloc(&pdev->dev,
-			sizeof(struct mmp_dma_data), GFP_KERNEL);
-	if (dma_data == NULL)
-		return -ENOMEM;
 
-	dma_data->dma_res = r;
-	dma_data->ssp_id = cpu_dai->id;
+	dma_data.dma_res = r;
+	dma_data.ssp_id = cpu_dai->id;
 
-	ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
-	if (ret) {
-		devm_kfree(&pdev->dev, dma_data);
-		return ret;
-	}
-
-	snd_dmaengine_pcm_set_data(substream, dma_data);
-	return 0;
-}
-
-static int mmp_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct mmp_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
-
-	snd_dmaengine_pcm_close(substream);
-	devm_kfree(&pdev->dev, dma_data);
-	return 0;
+	return snd_dmaengine_pcm_open(substream, filter, &dma_data);
 }
 
 static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
@@ -171,7 +148,7 @@ static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
 
 struct snd_pcm_ops mmp_pcm_ops = {
 	.open		= mmp_pcm_open,
-	.close		= mmp_pcm_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= mmp_pcm_hw_params,
 	.trigger	= snd_dmaengine_pcm_trigger,
-- 
1.8.0
