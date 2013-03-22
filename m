From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/14] ASoC: imx-pcm: Embed the imx_dma_data
	struct in the dma_params struct
Date: Fri, 22 Mar 2013 14:12:12 +0100
Message-ID: <1363957934-20059-13-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A5DAF266562
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:18 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Currently the imx_dma_data struct, which gets passed to the dmaengine driver, is
allocated and constructed in the pcm driver from the data stored in the
dma_params struct. The dma_params struct gets passed to the pcm driver from the
dai driver. Instead of going this route of indirection embed the dma_data struct
directly into the dma_params struct and let the dai driver fill it in. This
allows us to simplify the imx-pcm-dma driver quite a bit, since it doesn't have
care about memory managing the imx_dma_data struct anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c     | 17 +++++++++--------
 sound/soc/fsl/imx-pcm-dma.c | 35 ++---------------------------------
 sound/soc/fsl/imx-pcm.h     | 17 +++++++++++++++--
 sound/soc/fsl/imx-ssi.c     | 12 ++++++++----
 4 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7decbd9..2cce1ce 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -649,6 +649,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const uint32_t *iprop;
 	struct resource res;
 	char name[64];
+	bool shared;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -755,14 +756,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not get dma events\n");
 			goto error_clk;
 		}
-		ssi_private->dma_params_tx.dma = dma_events[0];
-		ssi_private->dma_params_rx.dma = dma_events[1];
-
-		ssi_private->dma_params_tx.shared_peripheral =
-				of_device_is_compatible(of_get_parent(np),
-							"fsl,spba-bus");
-		ssi_private->dma_params_rx.shared_peripheral =
-				ssi_private->dma_params_tx.shared_peripheral;
+
+		shared = of_device_is_compatible(of_get_parent(np),
+			    "fsl,spba-bus");
+
+		imx_pcm_dma_params_init_data(&ssi_private->dma_params_tx,
+			dma_events[0], shared);
+		imx_pcm_dma_params_init_data(&ssi_private->dma_params_rx,
+			dma_events[1], shared);
 	}
 
 	/* Initialize the the device_attribute structure */
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 500f8ce..6832c49 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -30,8 +30,6 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <linux/platform_data/dma-imx.h>
-
 #include "imx-pcm.h"
 
 static bool filter(struct dma_chan *chan, void *param)
@@ -101,46 +99,17 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_pcm_dma_params *dma_params;
-	struct imx_dma_data *dma_data;
-	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
-	if (!dma_data)
-		return -ENOMEM;
-
-	dma_data->peripheral_type = dma_params->shared_peripheral ?
-					IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI;
-	dma_data->priority = DMA_PRIO_HIGH;
-	dma_data->dma_request = dma_params->dma;
-
-	ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
-	if (ret) {
-		kfree(dma_data);
-		return ret;
-	}
-
-	snd_dmaengine_pcm_set_data(substream, dma_data);
-
-	return 0;
-}
-
-static int snd_imx_close(struct snd_pcm_substream *substream)
-{
-	struct imx_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
-
-	snd_dmaengine_pcm_close(substream);
-	kfree(dma_data);
-
-	return 0;
+	return snd_dmaengine_pcm_open(substream, filter, &dma_params->dma_data);
 }
 
 static struct snd_pcm_ops imx_pcm_ops = {
 	.open		= snd_imx_open,
-	.close		= snd_imx_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
 	.trigger	= snd_dmaengine_pcm_trigger,
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 5ae13a1..16eaf5a 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -13,18 +13,31 @@
 #ifndef _IMX_PCM_H
 #define _IMX_PCM_H
 
+#include <linux/platform_data/dma-imx.h>
+
 /*
  * Do not change this as the FIQ handler depends on this size
  */
 #define IMX_SSI_DMABUF_SIZE	(64 * 1024)
 
 struct imx_pcm_dma_params {
-	int dma;
 	unsigned long dma_addr;
 	int burstsize;
-	bool shared_peripheral;	/* The peripheral is on SPBA bus */
+	struct imx_dma_data dma_data;
 };
 
+static inline void
+imx_pcm_dma_params_init_data(struct imx_pcm_dma_params *params,
+	int dma, bool shared)
+{
+	params->dma_data.dma_request = dma;
+	params->dma_data.priority = DMA_PRIO_HIGH;
+	if (shared)
+		params->dma_data.peripheral_type = IMX_DMATYPE_SSI_SP;
+	else
+		params->dma_data.peripheral_type = IMX_DMATYPE_SSI;
+}
+
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 		     struct vm_area_struct *vma);
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 0e3fc8d..ffc518b 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -582,12 +582,16 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->dma_params_rx.burstsize = 4;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
-	if (res)
-		ssi->dma_params_tx.dma = res->start;
+	if (res) {
+		imx_pcm_dma_params_init_data(&ssi->dma_params_tx, res->start,
+			false);
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx0");
-	if (res)
-		ssi->dma_params_rx.dma = res->start;
+	if (res) {
+		imx_pcm_dma_params_init_data(&ssi->dma_params_rx, res->start,
+			false);
+	}
 
 	platform_set_drvdata(pdev, ssi);
 
-- 
1.8.0
