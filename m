From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: fsl: Set sdma peripheral type directly
Date: Thu, 25 Jul 2013 17:41:41 +0800
Message-ID: <1374745301-29508-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E3871260729
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 11:32:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shawn.guo@linaro.org, broonie@kernel.org, timur@tabi.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Let CPU DAI drivers set SDMA periperal type directly to support more
dma types(SPDIF, ESAI) other than only two for SSI.
This will easily allow some non-SSI drivers to use the imx-pcm-dma
as well.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
@Timur
Compile-passed with mpc85xx_defconfig by using gcc-4.6.3-nolibc_powerpc-linux.
---
 sound/soc/fsl/fsl_ssi.c |    4 ++--
 sound/soc/fsl/imx-pcm.h |    7 ++-----
 sound/soc/fsl/imx-ssi.c |    4 ++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 11469fe..4d78df7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -775,9 +775,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			    "fsl,spba-bus");
 
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_tx,
-			dma_events[0], shared);
+			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
-			dma_events[1], shared);
+			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 	}
 
 	/* Initialize the the device_attribute structure */
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index fd56cad..9136625 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -22,14 +22,11 @@
 
 static inline void
 imx_pcm_dma_params_init_data(struct imx_dma_data *dma_data,
-	int dma, bool shared)
+	int dma, enum sdma_peripheral_type peripheral_type)
 {
 	dma_data->dma_request = dma;
 	dma_data->priority = DMA_PRIO_HIGH;
-	if (shared)
-		dma_data->peripheral_type = IMX_DMATYPE_SSI_SP;
-	else
-		dma_data->peripheral_type = IMX_DMATYPE_SSI;
+	dma_data->peripheral_type = peripheral_type;
 }
 
 struct imx_pcm_fiq_params {
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index f029e27..f58bcd8 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -571,13 +571,13 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
 	if (res) {
 		imx_pcm_dma_params_init_data(&ssi->filter_data_tx, res->start,
-			false);
+			IMX_DMATYPE_SSI);
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx0");
 	if (res) {
 		imx_pcm_dma_params_init_data(&ssi->filter_data_rx, res->start,
-			false);
+			IMX_DMATYPE_SSI);
 	}
 
 	platform_set_drvdata(pdev, ssi);
-- 
1.7.1
