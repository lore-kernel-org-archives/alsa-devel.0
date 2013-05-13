From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: mxs: move to use generic DMA helper
Date: Mon, 13 May 2013 13:10:35 +0800
Message-ID: <1368421836-7261-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B787261AC4
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 07:10:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

With mxs-dma converted to generic DMA bindings, let's move mxs-pcm to
use it by removing flages SND_DMAENGINE_PCM_FLAG_NO_DT and
SND_DMAENGINE_PCM_FLAG_COMPAT.  As the result, those mxs custom dma
params code can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/sound/mxs-saif.txt         |   17 ++++++++----
 sound/soc/mxs/mxs-pcm.c                            |   18 ------------
 sound/soc/mxs/mxs-pcm.h                            |    7 -----
 sound/soc/mxs/mxs-saif.c                           |   29 +-------------------
 sound/soc/mxs/mxs-saif.h                           |    1 -
 5 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mxs-saif.txt b/Documentation/devicetree/bindings/sound/mxs-saif.txt
index c37ba61..7ba07a1 100644
--- a/Documentation/devicetree/bindings/sound/mxs-saif.txt
+++ b/Documentation/devicetree/bindings/sound/mxs-saif.txt
@@ -3,8 +3,11 @@
 Required properties:
 - compatible: Should be "fsl,<chip>-saif"
 - reg: Should contain registers location and length
-- interrupts: Should contain ERROR and DMA interrupts
-- fsl,saif-dma-channel: APBX DMA channel for the SAIF
+- interrupts: Should contain ERROR interrupt number
+- dmas: DMA specifier, consisting of a phandle to DMA controller node
+  and SAIF DMA channel ID.
+  Refer to dma.txt and fsl-mxs-dma.txt for details.
+- dma-names: Must be "rx-tx".
 
 Optional properties:
 - fsl,saif-master: phandle to the master SAIF.  It's only required for
@@ -23,14 +26,16 @@ aliases {
 saif0: saif@80042000 {
 	compatible = "fsl,imx28-saif";
 	reg = <0x80042000 2000>;
-	interrupts = <59 80>;
-	fsl,saif-dma-channel = <4>;
+	interrupts = <59>;
+	dmas = <&dma_apbx 4>;
+	dma-names = "rx-tx";
 };
 
 saif1: saif@80046000 {
 	compatible = "fsl,imx28-saif";
 	reg = <0x80046000 2000>;
-	interrupts = <58 81>;
-	fsl,saif-dma-channel = <5>;
+	interrupts = <58>;
+	dmas = <&dma_apbx 5>;
+	dma-names = "rx-tx";
 	fsl,saif-master = <&saif0>;
 };
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index b41fffc..b16abbb 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -49,24 +49,8 @@ static const struct snd_pcm_hardware snd_mxs_hardware = {
 	.fifo_size		= 32,
 };
 
-static bool filter(struct dma_chan *chan, void *param)
-{
-	struct mxs_pcm_dma_params *dma_params = param;
-
-	if (!mxs_dma_is_apbx(chan))
-		return false;
-
-	if (chan->chan_id != dma_params->chan_num)
-		return false;
-
-	chan->private = &dma_params->dma_data;
-
-	return true;
-}
-
 static const struct snd_dmaengine_pcm_config mxs_dmaengine_pcm_config = {
 	.pcm_hardware = &snd_mxs_hardware,
-	.compat_filter_fn = filter,
 	.prealloc_buffer_size = 64 * 1024,
 };
 
@@ -74,8 +58,6 @@ int mxs_pcm_platform_register(struct device *dev)
 {
 	return snd_dmaengine_pcm_register(dev, &mxs_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-		SND_DMAENGINE_PCM_FLAG_NO_DT |
-		SND_DMAENGINE_PCM_FLAG_COMPAT |
 		SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX);
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_register);
diff --git a/sound/soc/mxs/mxs-pcm.h b/sound/soc/mxs/mxs-pcm.h
index 3aa918f..bc685b6 100644
--- a/sound/soc/mxs/mxs-pcm.h
+++ b/sound/soc/mxs/mxs-pcm.h
@@ -19,13 +19,6 @@
 #ifndef _MXS_PCM_H
 #define _MXS_PCM_H
 
-#include <linux/fsl/mxs-dma.h>
-
-struct mxs_pcm_dma_params {
-	struct mxs_dma_data dma_data;
-	int chan_num;
-};
-
 int mxs_pcm_platform_register(struct device *dev);
 void mxs_pcm_platform_unregister(struct device *dev);
 
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index d31dc52..d8c9a19 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -26,7 +26,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/time.h>
-#include <linux/fsl/mxs-dma.h>
 #include <linux/pinctrl/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -605,8 +604,6 @@ static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
 	struct mxs_saif *saif = dev_get_drvdata(dai->dev);
 
 	snd_soc_dai_set_drvdata(dai, saif);
-	dai->playback_dma_data = &saif->dma_param;
-	dai->capture_dma_data = &saif->dma_param;
 
 	return 0;
 }
@@ -665,7 +662,7 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *iores, *dmares;
+	struct resource *iores;
 	struct mxs_saif *saif;
 	struct pinctrl *pinctrl;
 	int ret = 0;
@@ -727,22 +724,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (IS_ERR(saif->base))
 		return PTR_ERR(saif->base);
 
-	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmares) {
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helplers get in.
-		 */
-		ret = of_property_read_u32(np, "fsl,saif-dma-channel",
-					   &saif->dma_param.chan_num);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get dma channel\n");
-			return ret;
-		}
-	} else {
-		saif->dma_param.chan_num = dmares->start;
-	}
-
 	saif->irq = platform_get_irq(pdev, 0);
 	if (saif->irq < 0) {
 		ret = saif->irq;
@@ -759,14 +740,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	saif->dma_param.dma_data.chan_irq = platform_get_irq(pdev, 1);
-	if (saif->dma_param.dma_data.chan_irq < 0) {
-		ret = saif->dma_param.dma_data.chan_irq;
-		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
-			ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, saif);
 
 	ret = snd_soc_register_component(&pdev->dev, &mxs_saif_component,
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 3cb342e..53eaa4b 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -117,7 +117,6 @@ struct mxs_saif {
 	unsigned int mclk_in_use;
 	void __iomem *base;
 	int irq;
-	struct mxs_pcm_dma_params dma_param;
 	unsigned int id;
 	unsigned int master_id;
 	unsigned int cur_rate;
-- 
1.7.9.5
