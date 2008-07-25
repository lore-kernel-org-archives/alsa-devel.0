From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] pxa2xx-lib: support building for several pxa's
Date: Sat, 26 Jul 2008 01:51:54 +0400
Message-ID: <1217022714-2521-4-git-send-email-dbaryshkov@gmail.com>
References: <1217022714-2521-1-git-send-email-dbaryshkov@gmail.com>
	<1217022714-2521-2-git-send-email-dbaryshkov@gmail.com>
	<1217022714-2521-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id F220A2446E
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 23:52:09 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1235413nfd.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 14:52:10 -0700 (PDT)
In-Reply-To: <1217022714-2521-3-git-send-email-dbaryshkov@gmail.com>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, broonie@opensource.wolfsonmicro.com, eric.miao@marvell.com, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Support building pxa2xx-lib for several pxa chip versions by making code
run-time selected, not only compile-time

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c |  183 ++++++++++++++++++++++++++-----------------
 1 files changed, 111 insertions(+), 72 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 87c75b9..9576d24 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -35,18 +35,22 @@ static struct clk *ac97conf_clk;
 unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
-	volatile u32 *reg_addr;
+	volatile u32 *reg_addr = NULL;
 
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
-#else
-	if (reg == AC97_GPIO_STATUS)
-		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
-	else
-		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx())
+		reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
+#endif
+#ifdef CONFIG_PXA25x
+	if (cpu_is_pxa21x() || cpu_is_pxa25x()) {
+		if (reg == AC97_GPIO_STATUS)
+			reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
+		else
+			reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+	}
 #endif
 	reg_addr += (reg >> 1);
 
@@ -78,18 +82,22 @@ EXPORT_SYMBOL(pxa2xx_ac97_read);
 
 void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 {
-	volatile u32 *reg_addr;
+	volatile u32 *reg_addr = NULL;
 
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
-#else
-	if (reg == AC97_GPIO_STATUS)
-		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
-	else
-		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx())
+		reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
+#endif
+#ifdef CONFIG_PXA25x
+	if (cpu_is_pxa21x() || cpu_is_pxa25x()) {
+		if (reg == AC97_GPIO_STATUS)
+			reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
+		else
+			reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+	}
 #endif
 	reg_addr += (reg >> 1);
 
@@ -113,21 +121,29 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 	gsr_bits = 0;
 
 #ifdef CONFIG_PXA27x
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
+	if (cpu_is_pxa27x()) {
+		/* warm reset broken on Bulverde,
+		   so manually keep AC97 reset high */
+		pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
+		udelay(10);
+		GCR |= GCR_WARM_RST;
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		udelay(500);
+	}
+#endif
+#ifdef CONFIG_PXA3xx
+	if (cpu_is_pxa3xx()) {
+		/* Can't use interrupts */
+		GCR |= GCR_WARM_RST;
+		while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+			mdelay(1);
+	}
+#endif
+#ifdef CONFIG_PXA25x
+	if (cpu_is_pxa21x() || cpu_is_pxa25x()) {
+		GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
+		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+	}
 #endif
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
@@ -146,11 +162,13 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 #ifdef CONFIG_PXA3xx
 	int timeout = 1000;
 
-	/* Hold CLKBPB for 100us */
-	GCR = 0;
-	GCR = GCR_CLKBPB;
-	udelay(100);
-	GCR = 0;
+	if (cpu_is_pxa3xx()) {
+		/* Hold CLKBPB for 100us */
+		GCR = 0;
+		GCR = GCR_CLKBPB;
+		udelay(100);
+		GCR = 0;
+	}
 #endif
 
 	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
@@ -158,23 +176,31 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 
 	gsr_bits = 0;
 #ifdef CONFIG_PXA27x
-	/* PXA27x Developers Manual section 13.5.2.2.1 */
-	clk_enable(ac97conf_clk);
-	udelay(5);
-	clk_disable(ac97conf_clk);
-	GCR = GCR_COLD_RST;
-	udelay(50);
-#elif defined(CONFIG_PXA3xx)
-	/* Can't use interrupts on PXA3xx */
-	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+	if (cpu_is_pxa27x()) {
+		/* PXA27x Developers Manual section 13.5.2.2.1 */
+		clk_enable(ac97conf_clk);
+		udelay(5);
+		clk_disable(ac97conf_clk);
+		GCR = GCR_COLD_RST;
+		udelay(50);
+	}
+#endif
+#ifdef CONFIG_PXA3xx
+	if (cpu_is_pxa3xx()) {
+		/* Can't use interrupts on PXA3xx */
+		GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 
-	GCR = GCR_WARM_RST | GCR_COLD_RST;
-	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(10);
-#else
-	GCR = GCR_COLD_RST;
-	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+		GCR = GCR_WARM_RST | GCR_COLD_RST;
+		while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
+			mdelay(10);
+	}
+#endif
+#ifdef CONFIG_PXA25x
+	if (cpu_is_pxa21x() || cpu_is_pxa25x()) {
+		GCR = GCR_COLD_RST;
+		GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
+		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+	}
 #endif
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
@@ -210,9 +236,11 @@ static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
 		/* Although we don't use those we still need to clear them
 		   since they tend to spuriously trigger when MMC is used
 		   (hardware bug? go figure)... */
-		MISR = MISR_EOC;
-		PISR = PISR_EOC;
-		MCSR = MCSR_EOC;
+		if (cpu_is_pxa27x()) {
+			MISR = MISR_EOC;
+			PISR = PISR_EOC;
+			MCSR = MCSR_EOC;
+		}
 #endif
 
 		return IRQ_HANDLED;
@@ -232,14 +260,16 @@ EXPORT_SYMBOL(pxa2xx_ac97_hw_suspend);
 
 int pxa2xx_ac97_hw_resume(void)
 {
-	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
+	if (!cpu_is_pxa3xx()) {
+		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
+		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
+		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
+		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
 #ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		/* Use GPIO 113 as AC97 Reset on Bulverde */
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
 #endif
+	}
 	clk_enable(ac97_clk);
 	return 0;
 }
@@ -254,18 +284,25 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 	if (ret < 0)
 		goto err;
 
-	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
+	if (!cpu_is_pxa3xx()) {
+		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
+		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
+		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
+		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
 #ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-	ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
-	if (IS_ERR(ac97conf_clk)) {
-		ret = PTR_ERR(ac97conf_clk);
-		ac97conf_clk = NULL;
-		goto err_irq;
+		/* Use GPIO 113 as AC97 Reset on Bulverde */
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+#endif
+	}
+
+#ifdef CONFIG_PXA27x
+	if (cpu_is_pxa27x()) {
+		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
+		if (IS_ERR(ac97conf_clk)) {
+			ret = PTR_ERR(ac97conf_clk);
+			ac97conf_clk = NULL;
+			goto err_irq;
+		}
 	}
 #endif
 
@@ -297,8 +334,10 @@ void pxa2xx_ac97_hw_remove(struct platform_device *dev)
 	GCR |= GCR_ACLINK_OFF;
 	free_irq(IRQ_AC97, NULL);
 #ifdef CONFIG_PXA27x
-	clk_put(ac97conf_clk);
-	ac97conf_clk = NULL;
+	if (ac97conf_clk) {
+		clk_put(ac97conf_clk);
+		ac97conf_clk = NULL;
+	}
 #endif
 	clk_disable(ac97_clk);
 	clk_put(ac97_clk);
-- 
1.5.6.2
