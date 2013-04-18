From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 05/10] ASoC: fsl-ssi: Use generic DMA bindings if possible
Date: Thu, 18 Apr 2013 14:33:39 +0200
Message-ID: <1366288424-7660-6-git-send-email-mpa@pengutronix.de>
References: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

There may be some platforms using fsl-ssi that do not have a DMA driver
with generic DMA bindings. So this patch adds support for the generic
DMA bindings, while still using the old "fsl,dma-events" property if
"dmas" is not found.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v4:
     - Change TODO comment to a FIXME, to remove the old dma-events property as soon
       as all dma drivers support the generic DMA bindings.

 sound/soc/fsl/fsl_ssi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5165d41..d2afda1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -796,15 +796,19 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			&ssi_private->filter_data_tx;
 		ssi_private->dma_params_rx.filter_data =
 			&ssi_private->filter_data_rx;
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helplers get in.
-		 */
-		ret = of_property_read_u32_array(pdev->dev.of_node,
+		if (!of_property_read_bool(pdev->dev.of_node, "dmas") &&
+				ssi_private->use_dma) {
+			/*
+			 * FIXME: This is a temporary solution until all
+			 * necessary dma drivers support the generic dma
+			 * bindings.
+			 */
+			ret = of_property_read_u32_array(pdev->dev.of_node,
 					"fsl,ssi-dma-events", dma_events, 2);
-		if (ret && !ssi_private->use_dma) {
-			dev_err(&pdev->dev, "could not get dma events\n");
-			goto error_clk;
+			if (ret && ssi_private->use_dma) {
+				dev_err(&pdev->dev, "could not get dma events but fsl-ssi is configured to use DMA\n");
+				goto error_clk;
+			}
 		}
 
 		shared = of_device_is_compatible(of_get_parent(np),
@@ -875,8 +879,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			}
 		} else {
 			ssi_private->imx_pcm_pdev =
-				platform_device_register_simple("imx-pcm-audio",
-							-1, NULL, 0);
+				platform_device_register_data(&pdev->dev,
+						"imx-pcm-audio", -1,
+						pdev->dev.of_node,
+						sizeof(*pdev->dev.of_node));
 			if (IS_ERR(ssi_private->imx_pcm_pdev)) {
 				ret = PTR_ERR(ssi_private->imx_pcm_pdev);
 				goto error_dev;
-- 
1.8.1.5
