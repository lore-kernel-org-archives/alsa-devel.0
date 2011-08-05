From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: OMAP4: mcpdm: Fix IRQ handling
Date: Fri, 5 Aug 2011 12:04:54 +0300
Message-ID: <1312535094-7831-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 75094103986
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 11:04:56 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the correct variable holding the IRQ reason flags
to check the reason for the interrupt.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello Liam,

this patch as well with my previous series for McPDM can go for 3.1,
since this is fixing the interrupt handler function.

Regards,
Peter

 sound/soc/omap/mcpdm.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
index 1594fe0..9746a49 100644
--- a/sound/soc/omap/mcpdm.c
+++ b/sound/soc/omap/mcpdm.c
@@ -283,41 +283,39 @@ static irqreturn_t omap_mcpdm_irq_handler(int irq, void *dev_id)
 	/* Acknowledge irq event */
 	omap_mcpdm_write(MCPDM_IRQSTATUS, irq_status);
 
-	if (irq & MCPDM_DN_IRQ_FULL) {
+	if (irq_status & MCPDM_DN_IRQ_FULL) {
 		dev_err(mcpdm_irq->dev, "DN FIFO error %x\n", irq_status);
 		omap_mcpdm_reset_playback(1);
 		omap_mcpdm_playback_open(mcpdm_irq->downlink);
 		omap_mcpdm_reset_playback(0);
 	}
 
-	if (irq & MCPDM_DN_IRQ_EMPTY) {
+	if (irq_status & MCPDM_DN_IRQ_EMPTY) {
 		dev_err(mcpdm_irq->dev, "DN FIFO error %x\n", irq_status);
 		omap_mcpdm_reset_playback(1);
 		omap_mcpdm_playback_open(mcpdm_irq->downlink);
 		omap_mcpdm_reset_playback(0);
 	}
 
-	if (irq & MCPDM_DN_IRQ) {
+	if (irq_status & MCPDM_DN_IRQ)
 		dev_dbg(mcpdm_irq->dev, "DN write request\n");
-	}
 
-	if (irq & MCPDM_UP_IRQ_FULL) {
+	if (irq_status & MCPDM_UP_IRQ_FULL) {
 		dev_err(mcpdm_irq->dev, "UP FIFO error %x\n", irq_status);
 		omap_mcpdm_reset_capture(1);
 		omap_mcpdm_capture_open(mcpdm_irq->uplink);
 		omap_mcpdm_reset_capture(0);
 	}
 
-	if (irq & MCPDM_UP_IRQ_EMPTY) {
+	if (irq_status & MCPDM_UP_IRQ_EMPTY) {
 		dev_err(mcpdm_irq->dev, "UP FIFO error %x\n", irq_status);
 		omap_mcpdm_reset_capture(1);
 		omap_mcpdm_capture_open(mcpdm_irq->uplink);
 		omap_mcpdm_reset_capture(0);
 	}
 
-	if (irq & MCPDM_UP_IRQ) {
+	if (irq_status & MCPDM_UP_IRQ)
 		dev_dbg(mcpdm_irq->dev, "UP write request\n");
-	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.6
