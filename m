From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Convert ASoC pxa2xx-ac97 driver to use the
	clock API
Date: Thu, 21 Feb 2008 15:59:04 +0000
Message-ID: <1203609544-23586-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080221154351.GA9341@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1089C24396
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 16:59:06 +0100 (CET)
In-Reply-To: <20080221154351.GA9341@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux@arm.linux.org.uk, eric miao <eric.miao@marvell.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/pxa/pxa2xx-ac97.c |   49 +++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 815c153..711b916 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 
 #include <sound/core.h>
@@ -35,6 +36,10 @@
 static DEFINE_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
+static struct clk *ac97_clk;
+#ifdef CONFIG_PXA27x
+static struct clk *ac97conf_clk;
+#endif
 
 /*
  * Beware PXA27x bugs:
@@ -159,9 +164,9 @@ static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 	gsr_bits = 0;
 #ifdef CONFIG_PXA27x
 	/* PXA27x Developers Manual section 13.5.2.2.1 */
-	pxa_set_cken(CKEN_AC97CONF, 1);
+	clk_enable(ac97conf_clk);
 	udelay(5);
-	pxa_set_cken(CKEN_AC97CONF, 0);
+	clk_disable(ac97conf_clk);
 	GCR = GCR_COLD_RST;
 	udelay(50);
 #else
@@ -255,7 +260,7 @@ static int pxa2xx_ac97_suspend(struct platform_device *pdev,
 	struct snd_soc_cpu_dai *dai)
 {
 	GCR |= GCR_ACLINK_OFF;
-	pxa_set_cken(CKEN_AC97, 0);
+	clk_disable(ac97_clk);
 	return 0;
 }
 
@@ -270,7 +275,7 @@ static int pxa2xx_ac97_resume(struct platform_device *pdev,
 	/* Use GPIO 113 as AC97 Reset on Bulverde */
 	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
 #endif
-	pxa_set_cken(CKEN_AC97, 1);
+	clk_enable(ac97_clk);
 	return 0;
 }
 
@@ -294,16 +299,32 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev)
 #ifdef CONFIG_PXA27x
 	/* Use GPIO 113 as AC97 Reset on Bulverde */
 	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+
+	ac97conf_clk = clk_get(&pdev->dev, "AC97CONFCLK");
+	if (IS_ERR(ac97conf_clk)) {
+		ret = PTR_ERR(ac97conf_clk);
+		ac97conf_clk = NULL;
+		goto err_irq;
+	}
 #endif
-	pxa_set_cken(CKEN_AC97, 1);
+	ac97_clk = clk_get(&pdev->dev, "AC97CLK");
+	if (IS_ERR(ac97_clk)) {
+		ret = PTR_ERR(ac97_clk);
+		ac97_clk = NULL;
+		goto err_irq;
+	}
 	return 0;
 
- err:
-	if (CKEN & (1 << CKEN_AC97)) {
-		GCR |= GCR_ACLINK_OFF;
-		free_irq(IRQ_AC97, NULL);
-		pxa_set_cken(CKEN_AC97, 0);
+ err_irq:
+	GCR |= GCR_ACLINK_OFF;
+#ifdef CONFIG_PXA27x
+	if (ac97conf_clk) {
+		clk_put(ac97conf_clk);
+		ac97conf_clk = NULL;
 	}
+#endif
+	free_irq(IRQ_AC97, NULL);
+ err:
 	return ret;
 }
 
@@ -311,7 +332,13 @@ static void pxa2xx_ac97_remove(struct platform_device *pdev)
 {
 	GCR |= GCR_ACLINK_OFF;
 	free_irq(IRQ_AC97, NULL);
-	pxa_set_cken(CKEN_AC97, 0);
+#ifdef CONFIG_PXA27x
+	clk_put(ac97conf_clk);
+	ac97conf_clk = NULL;
+#endif
+	clk_disable(ac97_clk);
+	clk_put(ac97_clk);
+	ac97_clk = NULL;
 }
 
 static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
-- 
1.5.4.2
