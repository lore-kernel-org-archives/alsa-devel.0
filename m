From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Wed, 10 Sep 2008 05:01:17 +0400
Message-ID: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by alsa0.perex.cz (Postfix) with ESMTP id AD4902452B
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 03:01:30 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id j67so845923rne.21
	for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2008 18:01:29 -0700 (PDT)
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

ASoC and non-ASoC drivers for ACLINK on PXA share lot's of common code.
Move all common code into separate module snd-pxa2xx-lib.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 include/sound/pxa2xx-lib.h  |   20 +++
 sound/arm/Kconfig           |    6 +-
 sound/arm/Makefile          |    3 +
 sound/arm/pxa2xx-ac97-lib.c |  323 +++++++++++++++++++++++++++++++++++++++++++
 sound/arm/pxa2xx-ac97.c     |  247 +++------------------------------
 sound/soc/pxa/Kconfig       |    2 +
 sound/soc/pxa/pxa2xx-ac97.c |  272 ++-----------------------------------
 7 files changed, 380 insertions(+), 493 deletions(-)
 create mode 100644 include/sound/pxa2xx-lib.h
 create mode 100644 sound/arm/pxa2xx-ac97-lib.c

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
new file mode 100644
index 0000000..d18dd2d
--- /dev/null
+++ b/include/sound/pxa2xx-lib.h
@@ -0,0 +1,20 @@
+#ifndef PXA2XX_LIB_H
+#define PXA2XX_LIB_H
+
+#include <linux/platform_device.h>
+#include <sound/ac97_codec.h>
+
+extern unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg);
+extern void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val);
+
+extern bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97);
+extern bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97);
+extern void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97);
+
+extern int pxa2xx_ac97_hw_suspend(void);
+extern int pxa2xx_ac97_hw_resume(void);
+
+extern int pxa2xx_ac97_hw_probe(struct platform_device *dev);
+extern void pxa2xx_ac97_hw_remove(struct platform_device *dev);
+
+#endif
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 351e19e..3fd2642 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -32,11 +32,15 @@ config SND_PXA2XX_PCM
 	tristate
 	select SND_PCM
 
+config SND_PXA2XX_LIB
+	tristate
+	select SND_AC97_CODEC
+
 config SND_PXA2XX_AC97
 	tristate "AC97 driver for the Intel PXA2xx chip"
 	depends on ARCH_PXA
 	select SND_PXA2XX_PCM
-	select SND_AC97_CODEC
+	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to support any AC97 codec attached to
 	  the PXA2xx AC97 interface.
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 4ef6dd0..bb2ed88 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -11,5 +11,8 @@ snd-aaci-objs			:= aaci.o devdma.o
 obj-$(CONFIG_SND_PXA2XX_PCM)	+= snd-pxa2xx-pcm.o
 snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
 
+obj-$(CONFIG_SND_PXA2XX_LIB)	+= snd-pxa2xx-lib.o
+snd-pxa2xx-lib-objs		:= pxa2xx-ac97-lib.o
+
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
new file mode 100644
index 0000000..61cf41f
--- /dev/null
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -0,0 +1,323 @@
+/*
+ * Based on sound/arm/pxa2xx-ac97.c and sound/soc/pxa/pxa2xx-ac97.c which contain:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Dec 02, 2004
+ * Copyright:	MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <sound/ac97_codec.h>
+#include <sound/pxa2xx-lib.h>
+
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <mach/pxa-regs.h>
+#include <mach/pxa2xx-gpio.h>
+#include <mach/audio.h>
+
+static DEFINE_MUTEX(car_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
+static volatile long gsr_bits;
+static struct clk *ac97_clk;
+#ifdef CONFIG_PXA27x
+static struct clk *ac97conf_clk;
+#endif
+
+/*
+ * Beware PXA27x bugs:
+ *
+ *   o Slot 12 read from modem space will hang controller.
+ *   o CDONE, SDONE interrupt fails after any slot 12 IO.
+ *
+ * We therefore have an hybrid approach for waiting on SDONE (interrupt or
+ * 1 jiffy timeout if interrupt never comes).
+ */
+
+unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
+{
+	unsigned short val = -1;
+	volatile u32 *reg_addr;
+
+	mutex_lock(&car_mutex);
+
+	/* set up primary or secondary codec space */
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
+#else
+	if (reg == AC97_GPIO_STATUS)
+		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
+	else
+		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+#endif
+	reg_addr += (reg >> 1);
+
+	/* start read access across the ac97 link */
+	GSR = GSR_CDONE | GSR_SDONE;
+	gsr_bits = 0;
+	val = *reg_addr;
+	if (reg == AC97_GPIO_STATUS)
+		goto out;
+	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1) <= 0 &&
+	    !((GSR | gsr_bits) & GSR_SDONE)) {
+		printk(KERN_ERR "%s: read error (ac97_reg=%d GSR=%#lx)\n",
+				__func__, reg, GSR | gsr_bits);
+		val = -1;
+		goto out;
+	}
+
+	/* valid data now */
+	GSR = GSR_CDONE | GSR_SDONE;
+	gsr_bits = 0;
+	val = *reg_addr;
+	/* but we've just started another cycle... */
+	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
+
+out:	mutex_unlock(&car_mutex);
+	return val;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_read);
+
+void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
+{
+	volatile u32 *reg_addr;
+
+	mutex_lock(&car_mutex);
+
+	/* set up primary or secondary codec space */
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
+#else
+	if (reg == AC97_GPIO_STATUS)
+		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
+	else
+		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+#endif
+	reg_addr += (reg >> 1);
+
+	GSR = GSR_CDONE | GSR_SDONE;
+	gsr_bits = 0;
+	*reg_addr = val;
+	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_CDONE, 1) <= 0 &&
+	    !((GSR | gsr_bits) & GSR_CDONE))
+		printk(KERN_ERR "%s: write error (ac97_reg=%d GSR=%#lx)\n",
+				__func__, reg, GSR | gsr_bits);
+
+	mutex_unlock(&car_mutex);
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_write);
+
+bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
+{
+#ifdef CONFIG_PXA3xx
+	int timeout = 100;
+#endif
+	gsr_bits = 0;
+
+#ifdef CONFIG_PXA27x
+	/* warm reset broken on Bulverde,
+	   so manually keep AC97 reset high */
+	pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
+	udelay(10);
+	GCR |= GCR_WARM_RST;
+	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	udelay(500);
+#elif defined(CONFIG_PXA3xx)
+	/* Can't use interrupts */
+	GCR |= GCR_WARM_RST;
+	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(1);
+#else
+	GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
+	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+#endif
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
+#ifdef CONFIG_PXA3xx
+	int timeout = 1000;
+
+	/* Hold CLKBPB for 100us */
+	GCR = 0;
+	GCR = GCR_CLKBPB;
+	udelay(100);
+	GCR = 0;
+#endif
+
+	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
+	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
+
+	gsr_bits = 0;
+#ifdef CONFIG_PXA27x
+	/* PXA27x Developers Manual section 13.5.2.2.1 */
+	clk_enable(ac97conf_clk);
+	udelay(5);
+	clk_disable(ac97conf_clk);
+	GCR = GCR_COLD_RST;
+	udelay(50);
+#elif defined(CONFIG_PXA3xx)
+	/* Can't use interrupts on PXA3xx */
+	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+
+	GCR = GCR_WARM_RST | GCR_COLD_RST;
+	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(10);
+#else
+	GCR = GCR_COLD_RST;
+	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
+	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+#endif
+
+	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
+				 __func__, gsr_bits);
+
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_cold_reset);
+
+
+void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97)
+{
+	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_finish_reset);
+
+static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
+{
+	long status;
+
+	status = GSR;
+	if (status) {
+		GSR = status;
+		gsr_bits |= status;
+		wake_up(&gsr_wq);
+
+#ifdef CONFIG_PXA27x
+		/* Although we don't use those we still need to clear them
+		   since they tend to spuriously trigger when MMC is used
+		   (hardware bug? go figure)... */
+		MISR = MISR_EOC;
+		PISR = PISR_EOC;
+		MCSR = MCSR_EOC;
+#endif
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+#ifdef CONFIG_PM
+int pxa2xx_ac97_hw_suspend(void)
+{
+	GCR |= GCR_ACLINK_OFF;
+	clk_disable(ac97_clk);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_suspend);
+
+int pxa2xx_ac97_hw_resume(void)
+{
+	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
+	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
+	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
+	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
+#ifdef CONFIG_PXA27x
+	/* Use GPIO 113 as AC97 Reset on Bulverde */
+	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+#endif
+	clk_enable(ac97_clk);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
+#endif
+
+int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
+{
+	int ret;
+
+	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, 0, "AC97", NULL);
+	if (ret < 0)
+		goto err;
+
+	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
+	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
+	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
+	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
+#ifdef CONFIG_PXA27x
+	/* Use GPIO 113 as AC97 Reset on Bulverde */
+	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
+	if (IS_ERR(ac97conf_clk)) {
+		ret = PTR_ERR(ac97conf_clk);
+		ac97conf_clk = NULL;
+		goto err_irq;
+	}
+#endif
+
+	ac97_clk = clk_get(&dev->dev, "AC97CLK");
+	if (IS_ERR(ac97_clk)) {
+		ret = PTR_ERR(ac97_clk);
+		ac97_clk = NULL;
+		goto err_irq;
+	}
+
+	return clk_enable(ac97_clk);
+
+err_irq:
+	GCR |= GCR_ACLINK_OFF;
+#ifdef CONFIG_PXA27x
+	if (ac97conf_clk) {
+		clk_put(ac97conf_clk);
+		ac97conf_clk = NULL;
+	}
+#endif
+	free_irq(IRQ_AC97, NULL);
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_probe);
+
+void pxa2xx_ac97_hw_remove(struct platform_device *dev)
+{
+	GCR |= GCR_ACLINK_OFF;
+	free_irq(IRQ_AC97, NULL);
+#ifdef CONFIG_PXA27x
+	clk_put(ac97conf_clk);
+	ac97conf_clk = NULL;
+#endif
+	clk_disable(ac97_clk);
+	clk_put(ac97_clk);
+	ac97_clk = NULL;
+}
+EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_remove);
+
+MODULE_AUTHOR("Nicolas Pitre");
+MODULE_DESCRIPTION("Intel/Marvell PXA sound library");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 199cca3..cba71d8 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -12,198 +12,27 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/wait.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
+#include <sound/pxa2xx-lib.h>
 
-#include <asm/irq.h>
-#include <linux/mutex.h>
 #include <mach/hardware.h>
 #include <mach/pxa-regs.h>
-#include <mach/pxa2xx-gpio.h>
 #include <mach/audio.h>
 
 #include "pxa2xx-pcm.h"
 
-
-static DEFINE_MUTEX(car_mutex);
-static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
-static volatile long gsr_bits;
-static struct clk *ac97_clk;
-#ifdef CONFIG_PXA27x
-static struct clk *ac97conf_clk;
-#endif
-
-/*
- * Beware PXA27x bugs:
- *
- *   o Slot 12 read from modem space will hang controller.
- *   o CDONE, SDONE interrupt fails after any slot 12 IO.
- *
- * We therefore have an hybrid approach for waiting on SDONE (interrupt or
- * 1 jiffy timeout if interrupt never comes).
- */ 
-
-static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
-{
-	unsigned short val = -1;
-	volatile u32 *reg_addr;
-
-	mutex_lock(&car_mutex);
-
-	/* set up primary or secondary codec space */
-	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
-	reg_addr += (reg >> 1);
-
-	/* start read access across the ac97 link */
-	GSR = GSR_CDONE | GSR_SDONE;
-	gsr_bits = 0;
-	val = *reg_addr;
-	if (reg == AC97_GPIO_STATUS)
-		goto out;
-	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1) <= 0 &&
-	    !((GSR | gsr_bits) & GSR_SDONE)) {
-		printk(KERN_ERR "%s: read error (ac97_reg=%d GSR=%#lx)\n",
-				__func__, reg, GSR | gsr_bits);
-		val = -1;
-		goto out;
-	}
-
-	/* valid data now */
-	GSR = GSR_CDONE | GSR_SDONE;
-	gsr_bits = 0;
-	val = *reg_addr;			
-	/* but we've just started another cycle... */
-	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
-
-out:	mutex_unlock(&car_mutex);
-	return val;
-}
-
-static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
-{
-	volatile u32 *reg_addr;
-
-	mutex_lock(&car_mutex);
-
-	/* set up primary or secondary codec space */
-	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
-	reg_addr += (reg >> 1);
-
-	GSR = GSR_CDONE | GSR_SDONE;
-	gsr_bits = 0;
-	*reg_addr = val;
-	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_CDONE, 1) <= 0 &&
-	    !((GSR | gsr_bits) & GSR_CDONE))
-		printk(KERN_ERR "%s: write error (ac97_reg=%d GSR=%#lx)\n",
-				__func__, reg, GSR | gsr_bits);
-
-	mutex_unlock(&car_mutex);
-}
-
 static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
 {
-	/* First, try cold reset */
-#ifdef CONFIG_PXA3xx
-	int timeout;
-
-	/* Hold CLKBPB for 100us */
-	GCR = 0;
-	GCR = GCR_CLKBPB;
-	udelay(100);
-	GCR = 0;
-#endif
-
-	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
-	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
-
-	gsr_bits = 0;
-#ifdef CONFIG_PXA27x
-	/* PXA27x Developers Manual section 13.5.2.2.1 */
-	clk_enable(ac97conf_clk);
-	udelay(5);
-	clk_disable(ac97conf_clk);
-	GCR = GCR_COLD_RST;
-	udelay(50);
-#elif defined(CONFIG_PXA3xx)
-	timeout = 1000;
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
-
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
-		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
-
-		/* let's try warm reset */
-		gsr_bits = 0;
-#ifdef CONFIG_PXA27x
-		/* warm reset broken on Bulverde,
-		   so manually keep AC97 reset high */
-		pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH); 
-		udelay(10);
-		GCR |= GCR_WARM_RST;
-		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-		udelay(500);
-#elif defined(CONFIG_PXA3xx)
-		timeout = 100;
-		/* Can't use interrupts */
-		GCR |= GCR_WARM_RST;
-		while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
-			mdelay(1);
-#else
-		GCR |= GCR_WARM_RST|GCR_PRIRDY_IEN|GCR_SECRDY_IEN;
-		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
-#endif			
-
-		if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
-			printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-					 __func__, gsr_bits);
-	}
-
-	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
-	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
-}
-
-static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
-{
-	long status;
-
-	status = GSR;
-	if (status) {
-		GSR = status;
-		gsr_bits |= status;
-		wake_up(&gsr_wq);
-
-#ifdef CONFIG_PXA27x
-		/* Although we don't use those we still need to clear them
-		   since they tend to spuriously trigger when MMC is used
-		   (hardware bug? go figure)... */
-		MISR = MISR_EOC;
-		PISR = PISR_EOC;
-		MCSR = MCSR_EOC;
-#endif
-
-		return IRQ_HANDLED;
+	if (!pxa2xx_ac97_try_cold_reset(ac97)) {
+		pxa2xx_ac97_try_warm_reset(ac97);
 	}
 
-	return IRQ_NONE;
+	pxa2xx_ac97_finish_reset(ac97);
 }
 
 static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
@@ -288,17 +117,19 @@ static int pxa2xx_ac97_do_suspend(struct snd_card *card, pm_message_t state)
 	snd_ac97_suspend(pxa2xx_ac97_ac97);
 	if (platform_ops && platform_ops->suspend)
 		platform_ops->suspend(platform_ops->priv);
-	GCR |= GCR_ACLINK_OFF;
-	clk_disable(ac97_clk);
 
-	return 0;
+	return pxa2xx_ac97_hw_suspend();
 }
 
 static int pxa2xx_ac97_do_resume(struct snd_card *card)
 {
 	pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
+	int rc;
+
+	rc = pxa2xx_ac97_hw_resume();
+	if (rc)
+		return rc;
 
-	clk_enable(ac97_clk);
 	if (platform_ops && platform_ops->resume)
 		platform_ops->resume(platform_ops->priv);
 	snd_ac97_resume(pxa2xx_ac97_ac97);
@@ -354,40 +185,17 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
 	if (ret)
 		goto err;
 
-	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, 0, "AC97", NULL);
-	if (ret < 0)
-		goto err;
-
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
-		goto err;
-	}
-#endif
-
-	ac97_clk = clk_get(&dev->dev, "AC97CLK");
-	if (IS_ERR(ac97_clk)) {
-		ret = PTR_ERR(ac97_clk);
-		ac97_clk = NULL;
+	ret = pxa2xx_ac97_hw_probe(dev);
+	if (ret)
 		goto err;
-	}
-	clk_enable(ac97_clk);
 
 	ret = snd_ac97_bus(card, 0, &pxa2xx_ac97_ops, NULL, &ac97_bus);
 	if (ret)
-		goto err;
+		goto err_remove;
 	memset(&ac97_template, 0, sizeof(ac97_template));
 	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &pxa2xx_ac97_ac97);
 	if (ret)
-		goto err;
+		goto err_remove;
 
 	snprintf(card->shortname, sizeof(card->shortname),
 		 "%s", snd_ac97_get_short_name(pxa2xx_ac97_ac97));
@@ -401,22 +209,11 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
 		return 0;
 	}
 
- err:
+err_remove:
+	pxa2xx_ac97_hw_remove(dev);
+err:
 	if (card)
 		snd_card_free(card);
-	if (ac97_clk) {
-		GCR |= GCR_ACLINK_OFF;
-		free_irq(IRQ_AC97, NULL);
-		clk_disable(ac97_clk);
-		clk_put(ac97_clk);
-		ac97_clk = NULL;
-	}
-#ifdef CONFIG_PXA27x
-	if (ac97conf_clk) {
-		clk_put(ac97conf_clk);
-		ac97conf_clk = NULL;
-	}
-#endif
 	return ret;
 }
 
@@ -427,15 +224,7 @@ static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
 	if (card) {
 		snd_card_free(card);
 		platform_set_drvdata(dev, NULL);
-		GCR |= GCR_ACLINK_OFF;
-		free_irq(IRQ_AC97, NULL);
-		clk_disable(ac97_clk);
-		clk_put(ac97_clk);
-		ac97_clk = NULL;
-#ifdef CONFIG_PXA27x
-		clk_put(ac97conf_clk);
-		ac97conf_clk = NULL;
-#endif
+		pxa2xx_ac97_hw_remove(dev);
 	}
 
 	return 0;
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 9212c37..d1ccbdc 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -13,6 +13,8 @@ config SND_PXA2XX_AC97
 config SND_PXA2XX_SOC_AC97
 	tristate
 	select AC97_BUS
+	select SND_ARM
+	select SND_PXA2XX_LIB
 	select SND_SOC_AC97_BUS
 
 config SND_PXA2XX_SOC_I2S
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index d94a495..a80ae07 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -13,225 +13,30 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/wait.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
 
 #include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/ac97_codec.h>
-#include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
 
-#include <asm/irq.h>
-#include <linux/mutex.h>
 #include <mach/hardware.h>
 #include <mach/pxa-regs.h>
-#include <mach/pxa2xx-gpio.h>
-#include <mach/audio.h>
 
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
 
-static DEFINE_MUTEX(car_mutex);
-static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
-static volatile long gsr_bits;
-static struct clk *ac97_clk;
-#ifdef CONFIG_PXA27x
-static struct clk *ac97conf_clk;
-#endif
-
-/*
- * Beware PXA27x bugs:
- *
- *   o Slot 12 read from modem space will hang controller.
- *   o CDONE, SDONE interrupt fails after any slot 12 IO.
- *
- * We therefore have an hybrid approach for waiting on SDONE (interrupt or
- * 1 jiffy timeout if interrupt never comes).
- */
-
-static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97,
-	unsigned short reg)
-{
-	unsigned short val = -1;
-	volatile u32 *reg_addr;
-
-	mutex_lock(&car_mutex);
-
-	/* set up primary or secondary codec/modem space */
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-	reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
-#else
-	if (reg == AC97_GPIO_STATUS)
-		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
-	else
-		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
-#endif
-	reg_addr += (reg >> 1);
-
-#ifndef CONFIG_PXA27x
-	if (reg == AC97_GPIO_STATUS) {
-		/* read from controller cache */
-		val = *reg_addr;
-		goto out;
-	}
-#endif
-
-	/* start read access across the ac97 link */
-	GSR = GSR_CDONE | GSR_SDONE;
-	gsr_bits = 0;
-	val = *reg_addr;
-
-	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
-	if (!((GSR | gsr_bits) & GSR_SDONE)) {
-		printk(KERN_ERR "%s: read error (ac97_reg=%x GSR=%#lx)\n",
-				__func__, reg, GSR | gsr_bits);
-		val = -1;
-		goto out;
-	}
-
-	/* valid data now */
-	GSR = GSR_CDONE | GSR_SDONE;
-	gsr_bits = 0;
-	val = *reg_addr;
-	/* but we've just started another cycle... */
-	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
-
-out:	mutex_unlock(&car_mutex);
-	return val;
-}
-
-static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
-	unsigned short val)
-{
-	volatile u32 *reg_addr;
-
-	mutex_lock(&car_mutex);
-
-	/* set up primary or secondary codec/modem space */
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-	reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
-#else
-	if (reg == AC97_GPIO_STATUS)
-		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
-	else
-		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
-#endif
-	reg_addr += (reg >> 1);
-
-	GSR = GSR_CDONE | GSR_SDONE;
-	gsr_bits = 0;
-	*reg_addr = val;
-	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_CDONE, 1);
-	if (!((GSR | gsr_bits) & GSR_CDONE))
-		printk(KERN_ERR "%s: write error (ac97_reg=%x GSR=%#lx)\n",
-				__func__, reg, GSR | gsr_bits);
-
-	mutex_unlock(&car_mutex);
-}
-
 static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-#ifdef CONFIG_PXA3xx
-	int timeout = 100;
-#endif
-	gsr_bits = 0;
-
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
-
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
-		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
+	pxa2xx_ac97_try_warm_reset(ac97);
 
-	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
-	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
+	pxa2xx_ac97_finish_reset(ac97);
 }
 
 static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
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
+	pxa2xx_ac97_try_cold_reset(ac97);
 
-	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
-	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
-
-	gsr_bits = 0;
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
-
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
-		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
-
-	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
-	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
-}
-
-static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
-{
-	long status;
-
-	status = GSR;
-	if (status) {
-		GSR = status;
-		gsr_bits |= status;
-		wake_up(&gsr_wq);
-
-#ifdef CONFIG_PXA27x
-		/* Although we don't use those we still need to clear them
-		   since they tend to spuriously trigger when MMC is used
-		   (hardware bug? go figure)... */
-		MISR = MISR_EOC;
-		PISR = PISR_EOC;
-		MCSR = MCSR_EOC;
-#endif
-
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
+	pxa2xx_ac97_finish_reset(ac97);
 }
 
 struct snd_ac97_bus_ops soc_ac97_ops = {
@@ -285,24 +90,13 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_mic_mono_in = {
 static int pxa2xx_ac97_suspend(struct platform_device *pdev,
 	struct snd_soc_dai *dai)
 {
-	GCR |= GCR_ACLINK_OFF;
-	clk_disable(ac97_clk);
-	return 0;
+	return pxa2xx_ac97_hw_suspend();
 }
 
 static int pxa2xx_ac97_resume(struct platform_device *pdev,
 	struct snd_soc_dai *dai)
 {
-	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
-#ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-#endif
-	clk_enable(ac97_clk);
-	return 0;
+	return pxa2xx_ac97_hw_resume();
 }
 
 #else
@@ -313,61 +107,13 @@ static int pxa2xx_ac97_resume(struct platform_device *pdev,
 static int pxa2xx_ac97_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
-	int ret;
-
-	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, IRQF_DISABLED, "AC97", NULL);
-	if (ret < 0)
-		goto err;
-
-	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-	pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
-#ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
-
-	ac97conf_clk = clk_get(&pdev->dev, "AC97CONFCLK");
-	if (IS_ERR(ac97conf_clk)) {
-		ret = PTR_ERR(ac97conf_clk);
-		ac97conf_clk = NULL;
-		goto err_irq;
-	}
-#endif
-	ac97_clk = clk_get(&pdev->dev, "AC97CLK");
-	if (IS_ERR(ac97_clk)) {
-		ret = PTR_ERR(ac97_clk);
-		ac97_clk = NULL;
-		goto err_irq;
-	}
-	clk_enable(ac97_clk);
-	return 0;
-
- err_irq:
-	GCR |= GCR_ACLINK_OFF;
-#ifdef CONFIG_PXA27x
-	if (ac97conf_clk) {
-		clk_put(ac97conf_clk);
-		ac97conf_clk = NULL;
-	}
-#endif
-	free_irq(IRQ_AC97, NULL);
- err:
-	return ret;
+	return pxa2xx_ac97_hw_probe(pdev);
 }
 
 static void pxa2xx_ac97_remove(struct platform_device *pdev,
 			       struct snd_soc_dai *dai)
 {
-	GCR |= GCR_ACLINK_OFF;
-	free_irq(IRQ_AC97, NULL);
-#ifdef CONFIG_PXA27x
-	clk_put(ac97conf_clk);
-	ac97conf_clk = NULL;
-#endif
-	clk_disable(ac97_clk);
-	clk_put(ac97_clk);
-	ac97_clk = NULL;
+	pxa2xx_ac97_hw_remove(pdev);
 }
 
 static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
-- 
1.5.6.5
