From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ALSA: pxa2xx-ac97-lib: support building
	for several CPUs
Date: Mon, 15 Sep 2008 14:25:05 +0100
Message-ID: <1221485106-23881-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080915132418.GA23825@rakim.wolfsonmicro.main>
	<1221485106-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1221485106-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1221485106-23881-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1221485106-23881-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 742ED24652
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 15:25:08 +0200 (CEST)
In-Reply-To: <1221485106-23881-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Support building of pxa2xx-ac97-lib for several CPUs by making code
run-time selected, not only compile-time.

[Fixed 3XX->3xx typos in ifdef checks -- broonie.]

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/arm/pxa2xx-ac97-lib.c |  215 +++++++++++++++++++++++++++----------------
 1 files changed, 137 insertions(+), 78 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 95f8ead..99026df 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -30,9 +30,7 @@ static DEFINE_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
 static struct clk *ac97_clk;
-#ifdef CONFIG_PXA27x
 static struct clk *ac97conf_clk;
-#endif
 
 /*
  * Beware PXA27x bugs:
@@ -52,14 +50,10 @@ unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
-#else
-	if (reg == AC97_GPIO_STATUS)
+	if ((cpu_is_pxa21x() || cpu_is_pxa25x()) && reg == AC97_GPIO_STATUS)
 		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
 	else
 		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
-#endif
 	reg_addr += (reg >> 1);
 
 	/* start read access across the ac97 link */
@@ -96,14 +90,10 @@ void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
-#else
-	if (reg == AC97_GPIO_STATUS)
+	if ((cpu_is_pxa21x() || cpu_is_pxa25x()) && reg == AC97_GPIO_STATUS)
 		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
 	else
 		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
-#endif
 	reg_addr += (reg >> 1);
 
 	GSR = GSR_CDONE | GSR_SDONE;
@@ -118,14 +108,33 @@ void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_write);
 
-bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
+#ifdef CONFIG_PXA25x
+static inline void pxa_ac97_warm_pxa25x(void)
 {
-#ifdef CONFIG_PXA3xx
-	int timeout = 100;
-#endif
 	gsr_bits = 0;
 
+	GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
+	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+}
+
+static inline void pxa_ac97_cold_pxa25x(void)
+{
+	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
+	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
+
+	gsr_bits = 0;
+
+	GCR = GCR_COLD_RST;
+	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
+	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+}
+#endif
+
 #ifdef CONFIG_PXA27x
+static inline void pxa_ac97_warm_pxa27x(void)
+{
+	gsr_bits = 0;
+
 	/* warm reset broken on Bulverde,
 	   so manually keep AC97 reset high */
 	pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
@@ -133,30 +142,39 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 	GCR |= GCR_WARM_RST;
 	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
 	udelay(500);
-#elif defined(CONFIG_PXA3xx)
-	/* Can't use interrupts */
-	GCR |= GCR_WARM_RST;
-	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(1);
-#else
-	GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+}
+
+static inline void pxa_ac97_cold_pxa27x(void)
+{
+	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
+	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
+
+	gsr_bits = 0;
+
+	/* PXA27x Developers Manual section 13.5.2.2.1 */
+	clk_enable(ac97conf_clk);
+	udelay(5);
+	clk_disable(ac97conf_clk);
+	GCR = GCR_COLD_RST;
+	udelay(50);
+}
 #endif
 
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
-		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
+#ifdef CONFIG_PXA3xx
+static inline void pxa_ac97_warm_pxa3xx(void)
+{
+	int timeout = 100;
 
-		return false;
-	}
+	gsr_bits = 0;
 
-	return true;
+	/* Can't use interrupts */
+	GCR |= GCR_WARM_RST;
+	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(1);
 }
-EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
 
-bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
+static inline void pxa_ac97_cold_pxa3xx(void)
 {
-#ifdef CONFIG_PXA3xx
 	int timeout = 1000;
 
 	/* Hold CLKBPB for 100us */
@@ -164,31 +182,69 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 	GCR = GCR_CLKBPB;
 	udelay(100);
 	GCR = 0;
-#endif
 
 	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
 	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
 
 	gsr_bits = 0;
-#ifdef CONFIG_PXA27x
-	/* PXA27x Developers Manual section 13.5.2.2.1 */
-	clk_enable(ac97conf_clk);
-	udelay(5);
-	clk_disable(ac97conf_clk);
-	GCR = GCR_COLD_RST;
-	udelay(50);
-#elif defined(CONFIG_PXA3xx)
+
 	/* Can't use interrupts on PXA3xx */
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 
 	GCR = GCR_WARM_RST | GCR_COLD_RST;
 	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
 		mdelay(10);
-#else
-	GCR = GCR_COLD_RST;
-	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+}
+#endif
+
+bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
+{
+#ifdef CONFIG_PXA25x
+	if (cpu_is_pxa21x() || cpu_is_pxa25x())
+		pxa_ac97_warm_pxa25x();
+	else
 #endif
+#ifdef CONFIG_PXA27x
+	if (cpu_is_pxa27x())
+		pxa_ac97_warm_pxa27x();
+	else
+#endif
+#ifdef CONFIG_PXA3xx
+	if (cpu_is_pxa3xx())
+		pxa_ac97_warm_pxa3xx();
+	else
+#endif
+		BUG();
+
+	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
+				 __func__, gsr_bits);
+
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
+
+bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
+{
+#ifdef CONFIG_PXA25x
+	if (cpu_is_pxa21x() || cpu_is_pxa25x())
+		pxa_ac97_cold_pxa25x();
+	else
+#endif
+#ifdef CONFIG_PXA27x
+	if (cpu_is_pxa27x())
+		pxa_ac97_cold_pxa27x();
+	else
+#endif
+#ifdef CONFIG_PXA3xx
+	if (cpu_is_pxa3xx())
+		pxa_ac97_cold_pxa3xx();
+	else
+#endif
+		BUG();
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
@@ -219,14 +275,14 @@ static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
 		gsr_bits |= status;
 		wake_up(&gsr_wq);
 
-#ifdef CONFIG_PXA27x
 		/* Although we don't use those we still need to clear them
 		   since they tend to spuriously trigger when MMC is used
 		   (hardware bug? go figure)... */
-		MISR = MISR_EOC;
-		PISR = PISR_EOC;
-		MCSR = MCSR_EOC;
-#endif
+		if (cpu_is_pxa27x()) {
+			MISR = MISR_EOC;
+			PISR = PISR_EOC;
+			MCSR = MCSR_EOC;
+		}
 
 		return IRQ_HANDLED;
 	}
@@ -245,14 +301,16 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_suspend);
 
 int pxa2xx_ac97_hw_resume(void)
 {
-	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
-#ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-#endif
+	if (cpu_is_pxa21x() || cpu_is_pxa25x() || cpu_is_pxa27x()) {
+		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
+		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
+		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
+		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
+	}
+	if (cpu_is_pxa27x()) {
+		/* Use GPIO 113 as AC97 Reset on Bulverde */
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	}
 	clk_enable(ac97_clk);
 	return 0;
 }
@@ -267,20 +325,23 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 	if (ret < 0)
 		goto err;
 
-	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
-#ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-	ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
-	if (IS_ERR(ac97conf_clk)) {
-		ret = PTR_ERR(ac97conf_clk);
-		ac97conf_clk = NULL;
-		goto err_irq;
+	if (cpu_is_pxa21x() || cpu_is_pxa25x() || cpu_is_pxa27x()) {
+		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
+		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
+		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
+		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
+	}
+
+	if (cpu_is_pxa27x()) {
+		/* Use GPIO 113 as AC97 Reset on Bulverde */
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
+		if (IS_ERR(ac97conf_clk)) {
+			ret = PTR_ERR(ac97conf_clk);
+			ac97conf_clk = NULL;
+			goto err_irq;
+		}
 	}
-#endif
 
 	ac97_clk = clk_get(&dev->dev, "AC97CLK");
 	if (IS_ERR(ac97_clk)) {
@@ -293,12 +354,10 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 
 err_irq:
 	GCR |= GCR_ACLINK_OFF;
-#ifdef CONFIG_PXA27x
 	if (ac97conf_clk) {
 		clk_put(ac97conf_clk);
 		ac97conf_clk = NULL;
 	}
-#endif
 	free_irq(IRQ_AC97, NULL);
 err:
 	return ret;
@@ -309,10 +368,10 @@ void pxa2xx_ac97_hw_remove(struct platform_device *dev)
 {
 	GCR |= GCR_ACLINK_OFF;
 	free_irq(IRQ_AC97, NULL);
-#ifdef CONFIG_PXA27x
-	clk_put(ac97conf_clk);
-	ac97conf_clk = NULL;
-#endif
+	if (ac97conf_clk) {
+		clk_put(ac97conf_clk);
+		ac97conf_clk = NULL;
+	}
 	clk_disable(ac97_clk);
 	clk_put(ac97_clk);
 	ac97_clk = NULL;
-- 
1.5.6.5
