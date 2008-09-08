From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 4/5] pxa2xx-lib: support building for several
	pxa's
Date: Mon,  8 Sep 2008 13:06:12 +0400
Message-ID: <1220864773-31745-4-git-send-email-dbaryshkov@gmail.com>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 219F910384A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:08:57 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so590031eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 02:08:57 -0700 (PDT)
In-Reply-To: <1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
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
Cc: Russ Dill <russ.dill@gmail.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Russ Dill <russ.dill@gmail.com>

Here's a version of the third patch in the series without all the
cpu_is_pxa3xx())'s around the pxa_gpio_mode's? Also, there was a build
error when just building the sound/arm pxa2xx-ac97.

Support building pxa2xx-lib for several pxa chip versions by making code
run-time selected, not only compile-time

Signed-off-by: Russ Dill <russ.dill@gmail.com>
Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/include/mach/pxa-regs.h |    4 +-
 sound/arm/pxa2xx-ac97-lib.c               |  174 ++++++++++++++---------------
 sound/soc/pxa/pxa2xx-i2s.c                |   16 ++-
 3 files changed, 94 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxa-regs.h b/arch/arm/mach-pxa/include/mach/pxa-regs.h
index 12288ca..c978dfe 100644
--- a/arch/arm/mach-pxa/include/mach/pxa-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa-regs.h
@@ -520,9 +520,7 @@
 #define MCCR_FSRIE	(1 << 1)	/* FIFO Service Request Interrupt Enable */
 
 #define GCR		__REG(0x4050000C)  /* Global Control Register */
-#ifdef CONFIG_PXA3xx
-#define GCR_CLKBPB	(1 << 31)	/* Internal clock enable */
-#endif
+#define GCR_CLKBPB	(1 << 31)	/* Internal clock enable, PXA3XX only */
 #define GCR_nDMAEN	(1 << 24)	/* non DMA Enable */
 #define GCR_CDONE_IE	(1 << 19)	/* Command Done Interrupt Enable */
 #define GCR_SDONE_IE	(1 << 18)	/* Status Done Interrupt Enable */
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 6c73c49..3802d68 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -17,9 +17,7 @@ static DEFINE_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
 static struct clk *ac97_clk;
-#ifdef CONFIG_PXA27x
 static struct clk *ac97conf_clk;
-#endif
 
 /*
  * Beware PXA27x bugs:
@@ -39,14 +37,10 @@ unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
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
@@ -82,14 +76,10 @@ void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short
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
@@ -106,28 +96,26 @@ EXPORT_SYMBOL(pxa2xx_ac97_write);
 
 bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 {
-#ifdef CONFIG_PXA3xx
-	int timeout = 100;
-#endif
 	gsr_bits = 0;
 
-#ifdef CONFIG_PXA27x
-	/* warm reset broken on Bulverde,
-	   so manually keep AC97 reset high */
-	pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
-	udelay(10);
-	GCR |= GCR_WARM_RST;
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-	udelay(500);
-#elif defined(CONFIG_PXA3xx)
-	/* Can't use interrupts */
-	GCR |= GCR_WARM_RST;
-	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(1);
-#else
-	GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
-#endif
+	if (cpu_is_pxa27x()) {
+		/* warm reset broken on Bulverde,
+		   so manually keep AC97 reset high */
+		pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
+		udelay(10);
+		GCR |= GCR_WARM_RST;
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		udelay(500);
+	} else  if (cpu_is_pxa3xx()) {
+		/* Can't use interrupts */
+		int timeout = 100;
+		GCR |= GCR_WARM_RST;
+		while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+			mdelay(1);
+	} else {
+		GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
+		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+	}
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
@@ -142,39 +130,38 @@ EXPORT_SYMBOL(pxa2xx_ac97_try_warm_reset);
 
 bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 {
-#ifdef CONFIG_PXA3xx
-	int timeout = 1000;
-
-	/* Hold CLKBPB for 100us */
-	GCR = 0;
-	GCR = GCR_CLKBPB;
-	udelay(100);
-	GCR = 0;
-#endif
+	if (cpu_is_pxa3xx()) {
+		/* Hold CLKBPB for 100us */
+		GCR = 0;
+		GCR = GCR_CLKBPB;
+		udelay(100);
+		GCR = 0;
+	}
 
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
-	/* Can't use interrupts on PXA3xx */
-	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
-
-	GCR = GCR_WARM_RST | GCR_COLD_RST;
-	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(10);
-#else
-	GCR = GCR_COLD_RST;
-	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
-#endif
+	if (cpu_is_pxa27x()) {
+		/* PXA27x Developers Manual section 13.5.2.2.1 */
+		clk_enable(ac97conf_clk);
+		udelay(5);
+		clk_disable(ac97conf_clk);
+		GCR = GCR_COLD_RST;
+		udelay(50);
+	} else if (cpu_is_pxa3xx()) {
+		/* Can't use interrupts on PXA3xx */
+		int timeout = 1000;
+		GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+
+		GCR = GCR_WARM_RST | GCR_COLD_RST;
+		while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
+			mdelay(10);
+	} else {
+		GCR = GCR_COLD_RST;
+		GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
+		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+	}
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
@@ -205,14 +192,14 @@ static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
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
@@ -231,14 +218,16 @@ EXPORT_SYMBOL(pxa2xx_ac97_hw_suspend);
 
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
+	if (!cpu_is_pxa3xx()) {
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
@@ -253,20 +242,23 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
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
+	if (!cpu_is_pxa3xx()) {
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
@@ -279,12 +271,10 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 
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
@@ -295,10 +285,10 @@ void pxa2xx_ac97_hw_remove(struct platform_device *dev)
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
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 8548818..533e1f5 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -64,11 +64,6 @@ static struct pxa2xx_gpio gpio_bus[] = {
 		.frm = GPIO31_SYNC_I2S_MD,
 	},
 	{ /* I2S SoC Master */
-#ifdef CONFIG_PXA27x
-		.sys = GPIO113_I2S_SYSCLK_MD,
-#else
-		.sys = GPIO32_SYSCLK_I2S_MD,
-#endif
 		.rx = GPIO29_SDATA_IN_I2S_MD,
 		.tx = GPIO30_SDATA_OUT_I2S_MD,
 		.clk = GPIO28_BITCLK_OUT_I2S_MD,
@@ -317,6 +312,17 @@ struct snd_soc_dai pxa_i2s_dai = {
 
 EXPORT_SYMBOL_GPL(pxa_i2s_dai);
 
+static int __init pxa_i2s_init(void)
+{
+	if (cpu_is_pxa27x())
+		gpio_bus[1].sys = GPIO113_I2S_SYSCLK_MD;
+	else
+		gpio_bus[1].sys = GPIO32_SYSCLK_I2S_MD;
+        return 0;
+}
+
+module_init(pxa_i2s_init);
+
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood, liam.girdwood@wolfsonmicro.com, www.wolfsonmicro.com");
 MODULE_DESCRIPTION("pxa2xx I2S SoC Interface");
-- 
1.5.6.5
