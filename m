From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mfd: Remove bitrotted genirq comment from
	wm831x IRQ code
Date: Wed, 16 Feb 2011 14:58:11 -0800
Message-ID: <1297897091-6516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6376110387F
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 23:58:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm831x-irq.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index 03eb61d..2e45f60 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -26,15 +26,6 @@
 
 #include <linux/delay.h>
 
-/*
- * Since generic IRQs don't currently support interrupt controllers on
- * interrupt driven buses we don't use genirq but instead provide an
- * interface that looks very much like the standard ones.  This leads
- * to some bodges, including storing interrupt handler information in
- * the static irq_data table we use to look up the data for individual
- * interrupts, but hopefully won't last too long.
- */
-
 struct wm831x_irq_data {
 	int primary;
 	int reg;
-- 
1.7.2.3
