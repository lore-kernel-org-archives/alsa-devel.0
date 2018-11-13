From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Clean up the interrupt
	handlers" to the asoc tree
Date: Tue, 13 Nov 2018 18:33:30 +0000 (GMT)
Message-ID: <20181113183330.EA84A440079@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 057D226786A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:33:33 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: Clean up the interrupt handlers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d63a7625a6dff8f75604b952de600d24b58b8b54 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 8 Nov 2018 09:29:55 +0200
Subject: [PATCH] ASoC: omap-mcbsp: Clean up the interrupt handlers

The parameter name of dev_id is leftover from the old times when we passed
numeric ID as data for the interrupt handlers.

The mcbsp_rx and mcbsp_tx is misleading as they are pointers to the mcbsp
struct.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/mcbsp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 8c3cedfcb878..fca0b0e9186b 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -110,9 +110,9 @@ static void omap_mcbsp_dump_reg(struct omap_mcbsp *mcbsp)
 	dev_dbg(mcbsp->dev, "***********************\n");
 }
 
-static irqreturn_t omap_mcbsp_irq_handler(int irq, void *dev_id)
+static irqreturn_t omap_mcbsp_irq_handler(int irq, void *data)
 {
-	struct omap_mcbsp *mcbsp = dev_id;
+	struct omap_mcbsp *mcbsp = data;
 	u16 irqst;
 
 	irqst = MCBSP_READ(mcbsp, IRQST);
@@ -151,37 +151,37 @@ static irqreturn_t omap_mcbsp_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
+static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *data)
 {
-	struct omap_mcbsp *mcbsp_tx = dev_id;
+	struct omap_mcbsp *mcbsp = data;
 	u16 irqst_spcr2;
 
-	irqst_spcr2 = MCBSP_READ(mcbsp_tx, SPCR2);
-	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
+	irqst_spcr2 = MCBSP_READ(mcbsp, SPCR2);
+	dev_dbg(mcbsp->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
 
 	if (irqst_spcr2 & XSYNC_ERR) {
-		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
+		dev_err(mcbsp->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_tx, SPCR2, MCBSP_READ_CACHE(mcbsp_tx, SPCR2));
+		MCBSP_WRITE(mcbsp, SPCR2, MCBSP_READ_CACHE(mcbsp, SPCR2));
 	}
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
+static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *data)
 {
-	struct omap_mcbsp *mcbsp_rx = dev_id;
+	struct omap_mcbsp *mcbsp = data;
 	u16 irqst_spcr1;
 
-	irqst_spcr1 = MCBSP_READ(mcbsp_rx, SPCR1);
-	dev_dbg(mcbsp_rx->dev, "RX IRQ callback : 0x%x\n", irqst_spcr1);
+	irqst_spcr1 = MCBSP_READ(mcbsp, SPCR1);
+	dev_dbg(mcbsp->dev, "RX IRQ callback : 0x%x\n", irqst_spcr1);
 
 	if (irqst_spcr1 & RSYNC_ERR) {
-		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
+		dev_err(mcbsp->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
+		MCBSP_WRITE(mcbsp, SPCR1, MCBSP_READ_CACHE(mcbsp, SPCR1));
 	}
 
 	return IRQ_HANDLED;
-- 
2.19.1
