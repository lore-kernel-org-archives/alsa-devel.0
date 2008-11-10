From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [RFC][PATCH] pxa2xx-ac97: switch AC unit to correct
	state before	probing
Date: Mon, 10 Nov 2008 22:11:24 +0300
Message-ID: <20081110191124.GA2140@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A4632438D
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 20:12:09 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so936820eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 11:12:09 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I've stumbled upon a problem with my tosa unit. The bootloader leaves
ac97 in some partially enabled state, so when request_irq enables the
AC97 irq, I see a unending storm of irq requests. I've come with the
following patch (against 2.6.27, if the idea is OK, I'll rebase against
2.6.28-rc).

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

If AC97 unit is in partially enabled state, early request_irq can trigger
IRQ storm or even full hang up. Workaround this by forcibly switching ACLINK off
at the start of the probe.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index d94a495..259c6e1 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -315,10 +315,6 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev,
 {
 	int ret;
 
-	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, IRQF_DISABLED, "AC97", NULL);
-	if (ret < 0)
-		goto err;
-
 	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
 	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
 	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
@@ -331,28 +327,36 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev,
 	if (IS_ERR(ac97conf_clk)) {
 		ret = PTR_ERR(ac97conf_clk);
 		ac97conf_clk = NULL;
-		goto err_irq;
+		goto err_conf;
 	}
 #endif
+	GCR = GCR_ACLINK_OFF;
+
 	ac97_clk = clk_get(&pdev->dev, "AC97CLK");
 	if (IS_ERR(ac97_clk)) {
 		ret = PTR_ERR(ac97_clk);
 		ac97_clk = NULL;
-		goto err_irq;
+		goto err_clk;
 	}
 	clk_enable(ac97_clk);
+
+	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, IRQF_DISABLED, "AC97", NULL);
+	if (ret < 0)
+		goto err_irq;
+
 	return 0;
 
- err_irq:
+err_irq:
 	GCR |= GCR_ACLINK_OFF;
+	clk_disable(ac97_clk);
+	clk_put(ac97_clk);
+	ac97_clk = NULL;
+err_clk:
 #ifdef CONFIG_PXA27x
-	if (ac97conf_clk) {
-		clk_put(ac97conf_clk);
-		ac97conf_clk = NULL;
-	}
+	clk_put(ac97conf_clk);
+	ac97conf_clk = NULL;
+err_conf:
 #endif
-	free_irq(IRQ_AC97, NULL);
- err:
 	return ret;
 }
 
-- 
1.5.6.5


-- 
With best wishes
Dmitry
