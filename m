From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] sound: soc: pxa2xx-ac97: prepare and unprepare
	the clocks
Date: Mon,  9 Jun 2014 21:59:12 +0200
Message-ID: <1402343952-1287-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 570452652B0
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 21:59:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Add the clock prepare and unprepare call to the driver initialization
phase. This will remove a warning once the PXA architecture is migrated
to the clock infrastructure.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/arm/pxa2xx-ac97-lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 66de90e..39c3969 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -152,9 +152,9 @@ static inline void pxa_ac97_cold_pxa27x(void)
 	gsr_bits = 0;
 
 	/* PXA27x Developers Manual section 13.5.2.2.1 */
-	clk_enable(ac97conf_clk);
+	clk_prepare_enable(ac97conf_clk);
 	udelay(5);
-	clk_disable(ac97conf_clk);
+	clk_disable_unprepare(ac97conf_clk);
 	GCR = GCR_COLD_RST | GCR_WARM_RST;
 }
 #endif
@@ -299,14 +299,14 @@ static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
 int pxa2xx_ac97_hw_suspend(void)
 {
 	GCR |= GCR_ACLINK_OFF;
-	clk_disable(ac97_clk);
+	clk_disable_unprepare(ac97_clk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_suspend);
 
 int pxa2xx_ac97_hw_resume(void)
 {
-	clk_enable(ac97_clk);
+	clk_prepare_enable(ac97_clk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
@@ -368,7 +368,7 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 		goto err_clk;
 	}
 
-	ret = clk_enable(ac97_clk);
+	ret = clk_prepare_enable(ac97_clk);
 	if (ret)
 		goto err_clk2;
 
@@ -403,7 +403,7 @@ void pxa2xx_ac97_hw_remove(struct platform_device *dev)
 		clk_put(ac97conf_clk);
 		ac97conf_clk = NULL;
 	}
-	clk_disable(ac97_clk);
+	clk_disable_unprepare(ac97_clk);
 	clk_put(ac97_clk);
 	ac97_clk = NULL;
 }
-- 
2.0.0.rc2
