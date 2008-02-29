From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] Convert non-SoC PXA2xx AC97 driver to
	clock API
Date: Fri, 29 Feb 2008 16:56:41 +0000
Message-ID: <1204304201-18414-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 79D99103848
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 17:56:43 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.miao@marvell.com>, Russell King <rmk@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/arm/pxa2xx-ac97.c |   48 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 5d86e68..fd7bc86 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -16,6 +16,7 @@
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
@@ -112,9 +117,9 @@ static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
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
@@ -259,7 +264,7 @@ static int pxa2xx_ac97_do_suspend(struct snd_card *card, pm_message_t state)
 	if (platform_ops && platform_ops->suspend)
 		platform_ops->suspend(platform_ops->priv);
 	GCR |= GCR_ACLINK_OFF;
-	pxa_set_cken(CKEN_AC97, 0);
+	clk_disable(ac97_clk);
 
 	return 0;
 }
@@ -268,7 +273,7 @@ static int pxa2xx_ac97_do_resume(struct snd_card *card)
 {
 	pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
 
-	pxa_set_cken(CKEN_AC97, 1);
+	clk_enable(ac97_clk);
 	if (platform_ops && platform_ops->resume)
 		platform_ops->resume(platform_ops->priv);
 	snd_ac97_resume(pxa2xx_ac97_ac97);
@@ -335,8 +340,21 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
 #ifdef CONFIG_PXA27x
 	/* Use GPIO 113 as AC97 Reset on Bulverde */
 	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
+	if (IS_ERR(ac97conf_clk)) {
+		ret = PTR_ERR(ac97conf_clk);
+		ac97conf_clk = NULL;
+		goto err;
+	}
 #endif
-	pxa_set_cken(CKEN_AC97, 1);
+
+	ac97_clk = clk_get(&dev->dev, "AC97CLK");
+	if (IS_ERR(ac97_clk)) {
+		ret = PTR_ERR(ac97_clk);
+		ac97_clk = NULL;
+		goto err;
+	}
+	clk_enable(ac97_clk);
 
 	ret = snd_ac97_bus(card, 0, &pxa2xx_ac97_ops, NULL, &ac97_bus);
 	if (ret)
@@ -361,11 +379,19 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
  err:
 	if (card)
 		snd_card_free(card);
-	if (CKEN & (1 << CKEN_AC97)) {
+	if (ac97_clk) {
 		GCR |= GCR_ACLINK_OFF;
 		free_irq(IRQ_AC97, NULL);
-		pxa_set_cken(CKEN_AC97, 0);
+		clk_disable(ac97_clk);
+		clk_put(ac97_clk);
+		ac97_clk = NULL;
+	}
+#ifdef CONFIG_PXA27x
+	if (ac97conf_clk) {
+		clk_put(ac97conf_clk);
+		ac97conf_clk = NULL;
 	}
+#endif
 	return ret;
 }
 
@@ -378,7 +404,13 @@ static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
 		platform_set_drvdata(dev, NULL);
 		GCR |= GCR_ACLINK_OFF;
 		free_irq(IRQ_AC97, NULL);
-		pxa_set_cken(CKEN_AC97, 0);
+		clk_disable(ac97_clk);
+		clk_put(ac97_clk);
+		ac97_clk = NULL;
+#ifdef CONFIG_PXA27x
+		clk_put(ac97conf_clk);
+		ac97conf_clk = NULL;
+#endif
 	}
 
 	return 0;
-- 
1.5.4.3
