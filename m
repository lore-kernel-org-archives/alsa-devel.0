From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] pxa2xx-ac97: switch AC unit to correct state
	before probing
Date: Mon,  5 Jan 2009 12:58:06 +0300
Message-ID: <1231149486-32377-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id BD10324389
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 11:00:32 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so2690392fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 05 Jan 2009 02:00:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

If AC97 unit is in partially enabled state, early request_irq can trigger
IRQ storm or even full hang up. Workaround this by forcibly switching ACLINK off
at the start of the probe.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index ef6539e..35afd0c 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -321,10 +321,6 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 {
 	int ret;
 
-	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, 0, "AC97", NULL);
-	if (ret < 0)
-		goto err;
-
 	if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
 		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
 		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
@@ -339,7 +335,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 		if (IS_ERR(ac97conf_clk)) {
 			ret = PTR_ERR(ac97conf_clk);
 			ac97conf_clk = NULL;
-			goto err_irq;
+			goto err_conf;
 		}
 	}
 
@@ -347,19 +343,30 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 	if (IS_ERR(ac97_clk)) {
 		ret = PTR_ERR(ac97_clk);
 		ac97_clk = NULL;
-		goto err_irq;
+		goto err_clk;
 	}
 
-	return clk_enable(ac97_clk);
+	ret = clk_enable(ac97_clk);
+	if (ret)
+		goto err_clk2;
+
+	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, IRQF_DISABLED, "AC97", NULL);
+	if (ret < 0)
+		goto err_irq;
+
+	return 0;
 
 err_irq:
 	GCR |= GCR_ACLINK_OFF;
+err_clk2:
+	clk_put(ac97_clk);
+	ac97_clk = NULL;
+err_clk:
 	if (ac97conf_clk) {
 		clk_put(ac97conf_clk);
 		ac97conf_clk = NULL;
 	}
-	free_irq(IRQ_AC97, NULL);
-err:
+err_conf:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_probe);
-- 
1.5.6.5
