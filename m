From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 4/5] ASoC: SPEAr: remove custom DMA alloc
	compat function
Date: Mon,  9 Dec 2013 13:24:15 -0700
Message-ID: <1386620656-18391-5-git-send-email-swarren@wwwdotorg.org>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9D5261A1D
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:24:36 +0100 (CET)
In-Reply-To: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

spear_pcm_request_chan() is almost identical to
dmaengine_pcm_compat_request_channel(), with the exception that the
latter:

a) Assumes that the DAI DMA data is a struct snd_dmaengine_dai_dma_data
   pointer rather than some custom type.

b) dma_data->filter_data rather than dma_data should be passed to
   snd_dmaengine_pcm_request_channel() as the filter data.

Make minor changes to the SPEAr DAI drivers so that those two conditions
are met. This allows removal of the custom .compat_request_channel().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/spear_dma.h   |  1 -
 sound/soc/spear/spdif_in.c  | 10 +++++++---
 sound/soc/spear/spdif_out.c | 10 +++++++---
 sound/soc/spear/spear_pcm.c | 21 +++++++--------------
 sound/soc/spear/spear_pcm.h |  4 +++-
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/sound/spear_dma.h b/include/sound/spear_dma.h
index 1b365bfdfb37..65aca51fe255 100644
--- a/include/sound/spear_dma.h
+++ b/include/sound/spear_dma.h
@@ -29,7 +29,6 @@ struct spear_dma_data {
 	dma_addr_t addr;
 	u32 max_burst;
 	enum dma_slave_buswidth addr_width;
-	bool (*filter)(struct dma_chan *chan, void *slave);
 };
 
 #endif /* SPEAR_DMA_H */
diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index c1cfd333d81c..8c003b769bf1 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -18,6 +18,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <sound/dmaengine_pcm.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -38,6 +39,8 @@ struct spdif_in_dev {
 	struct device *dev;
 	void (*reset_perip)(void);
 	int irq;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	struct snd_dmaengine_pcm_config config;
 };
 
 static void spdif_in_configure(struct spdif_in_dev *host)
@@ -54,7 +57,8 @@ static int spdif_in_dai_probe(struct snd_soc_dai *dai)
 {
 	struct spdif_in_dev *host = snd_soc_dai_get_drvdata(dai);
 
-	dai->capture_dma_data = &host->dma_params;
+	host->dma_params_rx.filter_data = &host->dma_params;
+	dai->capture_dma_data = &host->dma_params_rx;
 
 	return 0;
 }
@@ -245,7 +249,6 @@ static int spdif_in_probe(struct platform_device *pdev)
 	host->dma_params.addr = res_fifo->start;
 	host->dma_params.max_burst = 16;
 	host->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	host->dma_params.filter = pdata->filter;
 	host->reset_perip = pdata->reset_perip;
 
 	host->dev = &pdev->dev;
@@ -263,7 +266,8 @@ static int spdif_in_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return spear_pcm_platform_register(&pdev->dev);
+	return spear_pcm_platform_register(&pdev->dev, &host->config,
+					   pdata->filter);
 }
 
 static int spdif_in_remove(struct platform_device *pdev)
diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index ad3d5d684f0c..e8aed8902141 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -18,6 +18,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <sound/dmaengine_pcm.h>
 #include <sound/soc.h>
 #include <sound/spear_dma.h>
 #include <sound/spear_spdif.h>
@@ -36,6 +37,8 @@ struct spdif_out_dev {
 	struct spdif_out_params saved_params;
 	u32 running;
 	void __iomem *io_base;
+	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	struct snd_dmaengine_pcm_config config;
 };
 
 static void spdif_out_configure(struct spdif_out_dev *host)
@@ -245,7 +248,8 @@ static int spdif_soc_dai_probe(struct snd_soc_dai *dai)
 {
 	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
 
-	dai->playback_dma_data = &host->dma_params;
+	host->dma_params_tx.filter_data = &host->dma_params;
+	dai->playback_dma_data = &host->dma_params_tx;
 
 	return snd_soc_add_dai_controls(dai, spdif_out_controls,
 				ARRAY_SIZE(spdif_out_controls));
@@ -304,7 +308,6 @@ static int spdif_out_probe(struct platform_device *pdev)
 	host->dma_params.addr = res->start + SPDIF_OUT_FIFO_DATA;
 	host->dma_params.max_burst = 16;
 	host->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	host->dma_params.filter = pdata->filter;
 
 	dev_set_drvdata(&pdev->dev, host);
 
@@ -313,7 +316,8 @@ static int spdif_out_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return spear_pcm_platform_register(&pdev->dev);
+	return spear_pcm_platform_register(&pdev->dev, &host->config,
+					   pdata->filter);
 }
 
 static int spdif_out_remove(struct platform_device *pdev)
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index e849f28e10c2..c7a9718d04c1 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -32,26 +32,19 @@ static const struct snd_pcm_hardware spear_pcm_hardware = {
 	.fifo_size = 0, /* fifo size in bytes */
 };
 
-static struct dma_chan *spear_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
-	struct snd_pcm_substream *substream)
-{
-	struct spear_dma_data *dma_data;
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	return snd_dmaengine_pcm_request_channel(dma_data->filter, dma_data);
-}
-
 static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
 	.pcm_hardware = &spear_pcm_hardware,
-	.compat_request_channel = spear_pcm_request_chan,
 	.prealloc_buffer_size = 16 * 1024,
 };
 
-int spear_pcm_platform_register(struct device *dev)
+int spear_pcm_platform_register(struct device *dev,
+			struct snd_dmaengine_pcm_config *config,
+			bool (*filter)(struct dma_chan *chan, void *slave))
 {
-	return snd_dmaengine_pcm_register(dev,
-		&spear_dmaengine_pcm_config,
+	*config = spear_dmaengine_pcm_config;
+	config->compat_filter_fn = filter;
+
+	return snd_dmaengine_pcm_register(dev, config,
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
diff --git a/sound/soc/spear/spear_pcm.h b/sound/soc/spear/spear_pcm.h
index 0ece110eb3d6..5fdce092090d 100644
--- a/sound/soc/spear/spear_pcm.h
+++ b/sound/soc/spear/spear_pcm.h
@@ -17,7 +17,9 @@
 #ifndef __SPEAR_PCM_H__
 #define __SPEAR_PCM_H__
 
-int spear_pcm_platform_register(struct device *dev);
+int spear_pcm_platform_register(struct device *dev,
+			struct snd_dmaengine_pcm_config *config,
+			bool (*filter)(struct dma_chan *chan, void *slave));
 void spear_pcm_platform_unregister(struct device *dev);
 
 #endif
-- 
1.8.1.5
