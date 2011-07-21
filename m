From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mfd: Acknowledge WM8994 IRQs before reporting
Date: Thu, 21 Jul 2011 10:09:24 +0100
Message-ID: <1311239364-29552-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 749A0103915
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 11:10:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This ensures we never have a window where we've handled an interrupt but
not told the hardware about it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm8994-irq.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index 71c6e8f..d682f7b 100644
--- a/drivers/mfd/wm8994-irq.c
+++ b/drivers/mfd/wm8994-irq.c
@@ -231,12 +231,6 @@ static irqreturn_t wm8994_irq_thread(int irq, void *data)
 		status[i] &= ~wm8994->irq_masks_cur[i];
 	}
 
-	/* Report */
-	for (i = 0; i < ARRAY_SIZE(wm8994_irqs); i++) {
-		if (status[wm8994_irqs[i].reg - 1] & wm8994_irqs[i].mask)
-			handle_nested_irq(wm8994->irq_base + i);
-	}
-
 	/* Ack any unmasked IRQs */
 	for (i = 0; i < ARRAY_SIZE(status); i++) {
 		if (status[i])
@@ -244,6 +238,12 @@ static irqreturn_t wm8994_irq_thread(int irq, void *data)
 					 status[i]);
 	}
 
+	/* Report */
+	for (i = 0; i < ARRAY_SIZE(wm8994_irqs); i++) {
+		if (status[wm8994_irqs[i].reg - 1] & wm8994_irqs[i].mask)
+			handle_nested_irq(wm8994->irq_base + i);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.5.4
