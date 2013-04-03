From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] ASoC: fsl: Use common DAI DMA data struct
Date: Wed,  3 Apr 2013 11:06:04 +0200
Message-ID: <1364979965-15776-3-git-send-email-lars@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-217.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A04226533E
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:06:56 +0200 (CEST)
In-Reply-To: <1364979965-15776-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the common DAI DMA data struct for fsl/imx, this allows us to use the common
helper function to configure the DMA slave config based on the DAI DMA data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/fsl_ssi.c     | 23 +++++++++++++++--------
 sound/soc/fsl/imx-pcm-dma.c | 23 ++++++++---------------
 sound/soc/fsl/imx-pcm-fiq.c |  4 ++--
 sound/soc/fsl/imx-pcm.h     | 16 +++++-----------
 sound/soc/fsl/imx-ssi.c     | 21 ++++++++++++---------
 sound/soc/fsl/imx-ssi.h     |  7 +++++--
 6 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d02450e..42366d7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -27,6 +27,7 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
@@ -122,8 +123,10 @@ struct fsl_ssi_private {
 	bool ssi_on_imx;
 	struct clk *clk;
 	struct platform_device *imx_pcm_pdev;
-	struct imx_pcm_dma_params dma_params_tx;
-	struct imx_pcm_dma_params dma_params_rx;
+	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	struct imx_dma_data filter_data_tx;
+	struct imx_dma_data filter_data_rx;
 
 	struct {
 		unsigned int rfrc;
@@ -742,14 +745,18 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 * We have burstsize be "fifo_depth - 2" to match the SSI
 		 * watermark setting in fsl_ssi_startup().
 		 */
-		ssi_private->dma_params_tx.burstsize =
+		ssi_private->dma_params_tx.maxburst =
 			ssi_private->fifo_depth - 2;
-		ssi_private->dma_params_rx.burstsize =
+		ssi_private->dma_params_rx.maxburst =
 			ssi_private->fifo_depth - 2;
-		ssi_private->dma_params_tx.dma_addr =
+		ssi_private->dma_params_tx.addr =
 			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
-		ssi_private->dma_params_rx.dma_addr =
+		ssi_private->dma_params_rx.addr =
 			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
+		ssi_private->dma_params_tx.filter_data =
+			&ssi_private->filter_data_tx;
+		ssi_private->dma_params_rx.filter_data =
+			&ssi_private->filter_data_rx;
 		/*
 		 * TODO: This is a temporary solution and should be changed
 		 * to use generic DMA binding later when the helplers get in.
@@ -764,9 +771,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		shared = of_device_is_compatible(of_get_parent(np),
 			    "fsl,spba-bus");
 
-		imx_pcm_dma_params_init_data(&ssi_private->dma_params_tx,
+		imx_pcm_dma_params_init_data(&ssi_private->filter_data_tx,
 			dma_events[0], shared);
-		imx_pcm_dma_params_init_data(&ssi_private->dma_params_rx,
+		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared);
 	}
 
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 64af573..ee838c8 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -34,10 +34,12 @@
 
 static bool filter(struct dma_chan *chan, void *param)
 {
+	struct snd_dmaengine_dai_dma_data *dma_data = param;
+
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
-	chan->private = param;
+	chan->private = dma_data->filter_data;
 
 	return true;
 }
@@ -47,23 +49,16 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
-	struct imx_pcm_dma_params *dma_params;
 	struct dma_slave_config slave_config;
 	int ret;
 
-	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
 	ret = snd_hwparams_to_dma_slave_config(substream, params, &slave_config);
 	if (ret)
 		return ret;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config.dst_addr = dma_params->dma_addr;
-		slave_config.dst_maxburst = dma_params->burstsize;
-	} else {
-		slave_config.src_addr = dma_params->dma_addr;
-		slave_config.src_maxburst = dma_params->burstsize;
-	}
+	snd_dmaengine_pcm_set_config_from_dai_data(substream,
+			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
+			&slave_config);
 
 	ret = dmaengine_slave_config(chan, &slave_config);
 	if (ret)
@@ -96,13 +91,11 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 static int snd_imx_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params;
 
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 
-	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	return snd_dmaengine_pcm_open(substream, filter, &dma_params->dma_data);
+	return snd_dmaengine_pcm_open(substream, filter,
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
 static struct snd_pcm_ops imx_pcm_ops = {
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 47228c0..670b96b 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -299,8 +299,8 @@ int imx_pcm_fiq_init(struct platform_device *pdev)
 
 	imx_ssi_fiq_base = (unsigned long)ssi->base;
 
-	ssi->dma_params_tx.burstsize = 4;
-	ssi->dma_params_rx.burstsize = 6;
+	ssi->dma_params_tx.maxburst = 4;
+	ssi->dma_params_rx.maxburst = 6;
 
 	ret = snd_soc_register_platform(&pdev->dev, &imx_soc_platform_fiq);
 	if (ret)
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 16eaf5a..be9cc64 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -20,22 +20,16 @@
  */
 #define IMX_SSI_DMABUF_SIZE	(64 * 1024)
 
-struct imx_pcm_dma_params {
-	unsigned long dma_addr;
-	int burstsize;
-	struct imx_dma_data dma_data;
-};
-
 static inline void
-imx_pcm_dma_params_init_data(struct imx_pcm_dma_params *params,
+imx_pcm_dma_params_init_data(struct imx_dma_data *dma_data,
 	int dma, bool shared)
 {
-	params->dma_data.dma_request = dma;
-	params->dma_data.priority = DMA_PRIO_HIGH;
+	dma_data->dma_request = dma;
+	dma_data->priority = DMA_PRIO_HIGH;
 	if (shared)
-		params->dma_data.peripheral_type = IMX_DMATYPE_SSI_SP;
+		dma_data->peripheral_type = IMX_DMATYPE_SSI_SP;
 	else
-		params->dma_data.peripheral_type = IMX_DMATYPE_SSI;
+		dma_data->peripheral_type = IMX_DMATYPE_SSI;
 }
 
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 706097f..4ce2d60 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -236,7 +236,7 @@ static int imx_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *cpu_dai)
 {
 	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
-	struct imx_pcm_dma_params *dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 
 	/* Tx/Rx config */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -369,8 +369,8 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 
 	snd_soc_dai_set_drvdata(dai, ssi);
 
-	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.burstsize) |
-		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
+	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.maxburst) |
+		SSI_SFCSR_RFWM0(ssi->dma_params_rx.maxburst);
 	writel(val, ssi->base + SSI_SFCSR);
 
 	return 0;
@@ -579,21 +579,24 @@ static int imx_ssi_probe(struct platform_device *pdev)
 
 	writel(0x0, ssi->base + SSI_SIER);
 
-	ssi->dma_params_rx.dma_addr = res->start + SSI_SRX0;
-	ssi->dma_params_tx.dma_addr = res->start + SSI_STX0;
+	ssi->dma_params_rx.addr = res->start + SSI_SRX0;
+	ssi->dma_params_tx.addr = res->start + SSI_STX0;
 
-	ssi->dma_params_tx.burstsize = 6;
-	ssi->dma_params_rx.burstsize = 4;
+	ssi->dma_params_tx.maxburst = 6;
+	ssi->dma_params_rx.maxburst = 4;
+
+	ssi->dma_params_tx.filter_data = &ssi->filter_data_tx;
+	ssi->dma_params_rx.filter_data = &ssi->filter_data_rx;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
 	if (res) {
-		imx_pcm_dma_params_init_data(&ssi->dma_params_tx, res->start,
+		imx_pcm_dma_params_init_data(&ssi->filter_data_tx, res->start,
 			false);
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx0");
 	if (res) {
-		imx_pcm_dma_params_init_data(&ssi->dma_params_rx, res->start,
+		imx_pcm_dma_params_init_data(&ssi->filter_data_rx, res->start,
 			false);
 	}
 
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index dc114bd..bb6b3db 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -187,6 +187,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-imx.h>
+#include <sound/dmaengine_pcm.h>
 #include "imx-pcm.h"
 
 struct imx_ssi {
@@ -204,8 +205,10 @@ struct imx_ssi {
 	void (*ac97_reset) (struct snd_ac97 *ac97);
 	void (*ac97_warm_reset)(struct snd_ac97 *ac97);
 
-	struct imx_pcm_dma_params	dma_params_rx;
-	struct imx_pcm_dma_params	dma_params_tx;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	struct imx_dma_data filter_data_tx;
+	struct imx_dma_data filter_data_rx;
 
 	int enabled;
 
-- 
1.8.0
