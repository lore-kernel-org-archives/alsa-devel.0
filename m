From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 4/9] ASoC: fsl-ssi: Add offline_config flag
Date: Mon, 25 Nov 2013 12:13:40 +0100
Message-ID: <1385378025-1262-5-git-send-email-mpa@pengutronix.de>
References: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9A041261A7F
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 12:14:29 +0100 (CET)
In-Reply-To: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

imx50-ssi and later versions of this IP support online reconfiguration
of all registers. The reference manual does not list any registers that
can only be configured while the SSI unit is disabled. This patch
introduces the flag for later use.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5e95244..abe6172 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -151,6 +151,7 @@ struct fsl_ssi_private {
 	bool ssi_on_imx;
 	bool imx_ac97;
 	bool use_dma;
+	bool offline_config;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -1030,6 +1031,24 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	/*
+	 * imx50 and later SoCs have a slightly different IP that allows the
+	 * SSI configuration while the SSI unit is running.
+	 *
+	 * More important, it is necessary on those SoCs to configure the
+	 * sperate TX/RX DMA bits just before starting the stream
+	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
+	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
+	 * how the SDMA unit handles the DMA request.
+	 *
+	 * SDMA units are present on devices starting at imx35 but the imx35
+	 * reference manual states that the DMA bits should not be changed
+	 * while the SSI unit is running (SSIEN). So we support the necessary
+	 * online configuration of fsl-ssi starting at imx50.
+	 */
+	if (hw_type != FSL_SSI_MX50)
+		ssi_private->offline_config = true;
+
 	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX50) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
-- 
1.8.4.2
