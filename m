From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v11 8/8] ASoC: fsl: disable ssi irq for imx
Date: Mon, 19 Aug 2013 17:06:01 +0200
Message-ID: <1376924761-4054-9-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DF7FC264ED5
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 17:07:24 +0200 (CEST)
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

We have to disable the ssi irq, as it is not safe for all platforms to
write back into the status register. It also runs into non-linefetch
aborts.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8407d59..653ad6b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -941,18 +941,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (ssi_private->use_dma) {
-		/* The 'name' should not have any slashes in it. */
-		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
-					fsl_ssi_isr, 0, ssi_private->name,
-					ssi_private);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not claim irq %u\n",
-					ssi_private->irq);
-			goto error_irqmap;
-		}
-	}
-
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
 		ssi_private->cpu_dai_drv.symmetric_rates = 1;
@@ -1020,6 +1008,16 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
+	} else if (ssi_private->use_dma) {
+		/* The 'name' should not have any slashes in it. */
+		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
+					fsl_ssi_isr, 0, ssi_private->name,
+					ssi_private);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "could not claim irq %u\n",
+					ssi_private->irq);
+			goto error_irqmap;
+		}
 	}
 
 	/* Initialize the the device_attribute structure */
-- 
1.8.4.rc3
