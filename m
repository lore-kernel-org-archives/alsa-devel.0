From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Use the common interrupt
	line if supported by the SoC
Date: Mon, 19 Mar 2012 17:16:23 +0200
Message-ID: <1332170183-25474-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog137.obsmtp.com [74.125.149.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 49C08104107
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 16:16:36 +0100 (CET)
Received: by lbon3 with SMTP id n3so3604491lbo.4
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 08:16:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

With the common irq the driver only needs to use one interrupt line, and
it provides better debugging possibilites compared to the legacy TX/RX
interrupt lines.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello,

with chages going via linux-omap:
http://marc.info/?l=linux-omap&m=133217004811408&w=2
http://marc.info/?l=linux-omap&m=133217006911415&w=2

the McBSP driver will use the common interrupt line where it is supported.

Regards,
Peter

 sound/soc/omap/mcbsp.c |  113 +++++++++++++++++++++++++++++++++++++----------
 sound/soc/omap/mcbsp.h |    7 +++-
 2 files changed, 95 insertions(+), 25 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index ec6832c..34835e8 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -109,6 +109,47 @@ static void omap_mcbsp_dump_reg(struct omap_mcbsp *mcbsp)
 	dev_dbg(mcbsp->dev, "***********************\n");
 }
 
+static irqreturn_t omap_mcbsp_irq_handler(int irq, void *dev_id)
+{
+	struct omap_mcbsp *mcbsp = dev_id;
+	u16 irqst;
+
+	irqst = MCBSP_READ(mcbsp, IRQST);
+	dev_dbg(mcbsp->dev, "IRQ callback : 0x%x\n", irqst);
+
+	if (irqst & RSYNCERREN)
+		dev_err(mcbsp->dev, "RX Frame Sync Error!\n");
+	if (irqst & RFSREN)
+		dev_dbg(mcbsp->dev, "RX Frame Sync\n");
+	if (irqst & REOFEN)
+		dev_dbg(mcbsp->dev, "RX End Of Frame\n");
+	if (irqst & RRDYEN)
+		dev_dbg(mcbsp->dev, "RX Buffer Threshold Reached\n");
+	if (irqst & RUNDFLEN)
+		dev_err(mcbsp->dev, "RX Buffer Underflow!\n");
+	if (irqst & ROVFLEN)
+		dev_err(mcbsp->dev, "RX Buffer Overflow!\n");
+
+	if (irqst & XSYNCERREN)
+		dev_err(mcbsp->dev, "TX Frame Sync Error!\n");
+	if (irqst & XFSXEN)
+		dev_dbg(mcbsp->dev, "TX Frame Sync\n");
+	if (irqst & XEOFEN)
+		dev_dbg(mcbsp->dev, "TX End Of Frame\n");
+	if (irqst & XRDYEN)
+		dev_dbg(mcbsp->dev, "TX Buffer threshold Reached\n");
+	if (irqst & XUNDFLEN)
+		dev_err(mcbsp->dev, "TX Buffer Underflow!\n");
+	if (irqst & XOVFLEN)
+		dev_err(mcbsp->dev, "TX Buffer Overflow!\n");
+	if (irqst & XEMPTYEOFEN)
+		dev_dbg(mcbsp->dev, "TX Buffer empty at end of frame\n");
+
+	MCBSP_WRITE(mcbsp, IRQST, irqst);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
 {
 	struct omap_mcbsp *mcbsp_tx = dev_id;
@@ -176,6 +217,10 @@ void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 	/* Enable wakeup behavior */
 	if (mcbsp->pdata->has_wakeup)
 		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
+
+	/* Enable TX/RX sync error interrupts by default */
+	if (mcbsp->irq)
+		MCBSP_WRITE(mcbsp, IRQEN, RSYNCERREN | XSYNCERREN);
 }
 
 /**
@@ -489,23 +534,25 @@ int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 	MCBSP_WRITE(mcbsp, SPCR1, 0);
 	MCBSP_WRITE(mcbsp, SPCR2, 0);
 
-	err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler,
-				0, "McBSP", (void *)mcbsp);
-	if (err != 0) {
-		dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
-				"for McBSP%d\n", mcbsp->tx_irq,
-				mcbsp->id);
-		goto err_clk_disable;
-	}
+	if (mcbsp->irq) {
+		err = request_irq(mcbsp->irq, omap_mcbsp_irq_handler, 0,
+				  "McBSP", (void *)mcbsp);
+		if (err != 0) {
+			dev_err(mcbsp->dev, "Unable to request IRQ\n");
+			goto err_clk_disable;
+		}
+	} else {
+		err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler, 0,
+				  "McBSP TX", (void *)mcbsp);
+		if (err != 0) {
+			dev_err(mcbsp->dev, "Unable to request TX IRQ\n");
+			goto err_clk_disable;
+		}
 
-	if (mcbsp->rx_irq) {
-		err = request_irq(mcbsp->rx_irq,
-				omap_mcbsp_rx_irq_handler,
-				0, "McBSP", (void *)mcbsp);
+		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler, 0,
+				  "McBSP RX", (void *)mcbsp);
 		if (err != 0) {
-			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
-					"for McBSP%d\n", mcbsp->rx_irq,
-					mcbsp->id);
+			dev_err(mcbsp->dev, "Unable to request RX IRQ\n");
 			goto err_free_irq;
 		}
 	}
@@ -542,9 +589,16 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 	if (mcbsp->pdata->has_wakeup)
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
-	if (mcbsp->rx_irq)
+	/* Disable interrupt requests */
+	if (mcbsp->irq)
+		MCBSP_WRITE(mcbsp, IRQEN, 0);
+
+	if (mcbsp->irq) {
+		free_irq(mcbsp->irq, (void *)mcbsp);
+	} else {
 		free_irq(mcbsp->rx_irq, (void *)mcbsp);
-	free_irq(mcbsp->tx_irq, (void *)mcbsp);
+		free_irq(mcbsp->tx_irq, (void *)mcbsp);
+	}
 
 	reg_cache = mcbsp->reg_cache;
 
@@ -949,13 +1003,24 @@ int __devinit omap_mcbsp_init(struct platform_device *pdev)
 	else
 		mcbsp->phys_dma_base = res->start;
 
-	mcbsp->tx_irq = platform_get_irq_byname(pdev, "tx");
-	mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
-
-	/* From OMAP4 there will be a single irq line */
-	if (mcbsp->tx_irq == -ENXIO) {
-		mcbsp->tx_irq = platform_get_irq(pdev, 0);
-		mcbsp->rx_irq = 0;
+	/*
+	 * OMAP1, 2 uses two interrupt lines: TX, RX
+	 * OMAP2430, OMAP3 SoC have combined IRQ line as well.
+	 * OMAP4 and newer SoC only have the combined IRQ line.
+	 * Use the combined IRQ if available since it gives better debugging
+	 * possibilities.
+	 */
+	mcbsp->irq = platform_get_irq_byname(pdev, "common");
+	if (mcbsp->irq == -ENXIO) {
+		mcbsp->tx_irq = platform_get_irq_byname(pdev, "tx");
+
+		if (mcbsp->tx_irq == -ENXIO) {
+			mcbsp->irq = platform_get_irq(pdev, 0);
+			mcbsp->tx_irq = 0;
+		} else {
+			mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
+			mcbsp->irq = 0;
+		}
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 179a822..262a615 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -218,15 +218,19 @@ enum {
 #define MCBSP_DMA_MODE_ELEMENT		0
 #define MCBSP_DMA_MODE_THRESHOLD	1
 
-/********************** McBSP WAKEUPEN bit definitions *********************/
+/********************** McBSP WAKEUPEN/IRQST/IRQEN bit definitions *********/
 #define RSYNCERREN		BIT(0)
 #define RFSREN			BIT(1)
 #define REOFEN			BIT(2)
 #define RRDYEN			BIT(3)
+#define RUNDFLEN		BIT(4)
+#define ROVFLEN			BIT(5)
 #define XSYNCERREN		BIT(7)
 #define XFSXEN			BIT(8)
 #define XEOFEN			BIT(9)
 #define XRDYEN			BIT(10)
+#define XUNDFLEN		BIT(11)
+#define XOVFLEN			BIT(12)
 #define XEMPTYEOFEN		BIT(14)
 
 /* Clock signal muxing options */
@@ -294,6 +298,7 @@ struct omap_mcbsp {
 	int configured;
 	u8 free;
 
+	int irq;
 	int rx_irq;
 	int tx_irq;
 
-- 
1.7.8.5
