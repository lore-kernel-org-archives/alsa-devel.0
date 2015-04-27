From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE
	internal
Date: Mon, 27 Apr 2015 12:44:25 +0200
Message-ID: <1430131465-17991-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id B11662605EF
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 12:44:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Whether residue can be reported or not is not a property of the audio
controller but of the DMA controller. The FLAG_NO_RESIDUE was initially
added when the DMAengine framework had no support for describing the residue
reporting capabilities of the controller. Support for this was added quite a
while ago and recently the DMAengine framework started to complain if a
driver does not describe its capabilities and a lot of patches have been
merged that add support for this where it was missing. So it should be safe
to assume that driver on actively used platforms properly implement the DMA
capabilities API.

This patch makes the FLAG_NO_RESIDUE internal and no longer allows audio
controller drivers to manually set the flag. If a DMA driver against
expectations does not support reporting its capabilities for now the generic
DMAengine PCM driver will now emit a warning and simply assume that residue
reporting is not supported. In the future this might be changed to aborting
with an error.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h         |  5 -----
 sound/soc/atmel/atmel-pcm-dma.c       |  3 +--
 sound/soc/cirrus/ep93xx-pcm.c         |  1 -
 sound/soc/fsl/fsl_sai.c               |  3 +--
 sound/soc/soc-generic-dmaengine-pcm.c | 25 ++++++++++++++-----------
 sound/soc/ux500/ux500_pcm.c           |  1 -
 6 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index eb73a3a..f86ef5e 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -91,11 +91,6 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_DT BIT(1)
 /*
- * The platforms dmaengine driver does not support reporting the amount of
- * bytes that are still left to transfer.
- */
-#define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(2)
-/*
  * The PCM is half duplex and the DMA channel is shared between capture and
  * playback.
  */
diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index b6625c8..dd57a9e 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -124,8 +124,7 @@ static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
 
 int atmel_pcm_dma_platform_register(struct device *dev)
 {
-	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
 
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 5f66447..67a7333 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -60,7 +60,6 @@ int devm_ep93xx_pcm_platform_register(struct device *dev)
 {
 	return devm_snd_dmaengine_pcm_register(dev,
 		&ep93xx_dmaengine_pcm_config,
-		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ec79c3d..ee2671b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -664,8 +664,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (sai->sai_on_imx)
 		return imx_pcm_dma_init(pdev);
 	else
-		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
-				SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index c9917ca..6fd1906 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -24,6 +24,12 @@
 
 #include <sound/dmaengine_pcm.h>
 
+/*
+ * The platforms dmaengine driver does not support reporting the amount of
+ * bytes that are still left to transfer.
+ */
+#define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(31)
+
 struct dmaengine_pcm {
 	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
 	const struct snd_dmaengine_pcm_config *config;
@@ -222,14 +228,18 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	return snd_dmaengine_pcm_request_channel(fn, dma_data->filter_data);
 }
 
-static bool dmaengine_pcm_can_report_residue(struct dma_chan *chan)
+static bool dmaengine_pcm_can_report_residue(struct device *dev,
+	struct dma_chan *chan)
 {
 	struct dma_slave_caps dma_caps;
 	int ret;
 
 	ret = dma_get_slave_caps(chan, &dma_caps);
-	if (ret != 0)
-		return true;
+	if (ret != 0) {
+		dev_warn(dev, "Failed to get DMA channel capabilities, falling back to period counting: %d\n",
+			 ret);
+		return false;
+	}
 
 	if (dma_caps.residue_granularity == DMA_RESIDUE_GRANULARITY_DESCRIPTOR)
 		return false;
@@ -289,14 +299,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (ret)
 			return ret;
 
-		/*
-		 * This will only return false if we know for sure that at least
-		 * one channel does not support residue reporting. If the DMA
-		 * driver does not implement the slave_caps API we rely having
-		 * the NO_RESIDUE flag set manually in case residue reporting is
-		 * not supported.
-		 */
-		if (!dmaengine_pcm_can_report_residue(pcm->chan[i]))
+		if (!dmaengine_pcm_can_report_residue(dev, pcm->chan[i]))
 			pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
 	}
 
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 51a66a8..f12c01d 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -147,7 +147,6 @@ int ux500_pcm_register_platform(struct platform_device *pdev)
 		pcm_config = &ux500_dmaengine_pcm_config;
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config,
-					 SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 					 SND_DMAENGINE_PCM_FLAG_COMPAT);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
-- 
1.8.0
