From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 3/9] ASoC: fsl-ssi: Add imx51-ssi and
	of_device_id matching
Date: Fri, 20 Dec 2013 14:11:30 +0100
Message-ID: <1387545096-2334-4-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 3EBD92655E4
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 14:12:15 +0100 (CET)
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

There is a small but significant difference between imx21-ssi and
imx51-ssi and above. imx21-ssi does not allow online reconfiguration of
some registers. They have to be configured at the beginning.

imx51-ssi has to reconfigure the SSI unit while it is running. Otherwise
it would not be possible to have two streams in parallel. The new SDMA
unit in imx51 and above has to be configured before the first DMA
request arrives. Therefor we need to setup TDMAE/RDMAE just before
starting the stream.

This patch introduces distinct imx51-ssi as compatible and adds
of_device_id matching in the probe function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 702c63d..39ad516 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -123,6 +123,13 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TFRC_EN)
 #define FSLSSI_SISR_MASK (FSLSSI_SIER_DBG_RX_FLAGS | FSLSSI_SIER_DBG_TX_FLAGS)
 
+
+enum fsl_ssi_type {
+	FSL_SSI_MCP8610,
+	FSL_SSI_MX21,
+	FSL_SSI_MX51,
+};
+
 /**
  * fsl_ssi_private: per-SSI private data
  *
@@ -189,6 +196,14 @@ struct fsl_ssi_private {
 	char name[1];
 };
 
+static const struct of_device_id fsl_ssi_ids[] = {
+	{ .compatible = "fsl,mpc8610-ssi", .data = (void *) FSL_SSI_MCP8610},
+	{ .compatible = "fsl,imx51-ssi", .data = (void *) FSL_SSI_MX51},
+	{ .compatible = "fsl,imx21-ssi", .data = (void *) FSL_SSI_MX21},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -1118,6 +1133,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct device_attribute *dev_attr = NULL;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	enum fsl_ssi_type hw_type;
 	const char *p, *sprop;
 	const uint32_t *iprop;
 	struct resource res;
@@ -1132,6 +1149,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
+	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+	hw_type = (enum fsl_ssi_type) of_id->data;
+
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop) {
@@ -1211,7 +1233,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi_private->baudclk_locked = false;
 	spin_lock_init(&ssi_private->baudclk_lock);
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
+	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX51 ||
+			hw_type == FSL_SSI_MX35) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
@@ -1413,13 +1436,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id fsl_ssi_ids[] = {
-	{ .compatible = "fsl,mpc8610-ssi", },
-	{ .compatible = "fsl,imx21-ssi", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
-
 static struct platform_driver fsl_ssi_driver = {
 	.driver = {
 		.name = "fsl-ssi-dai",
-- 
1.8.5.1
