From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 3/5] Make pxa-ac97-lib separate module
Date: Mon,  8 Sep 2008 13:06:11 +0400
Message-ID: <1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 58D9F103842
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:08:56 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so547857nfd.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 02:08:55 -0700 (PDT)
In-Reply-To: <1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
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

Make pxa-ac97-lib separate compilation unit, thus cleaning up
all dependencies.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 include/sound/pxa2xx-lib.h  |   17 +++++++++++++
 sound/arm/Kconfig           |    6 ++++-
 sound/arm/Makefile          |    3 ++
 sound/arm/pxa2xx-ac97-lib.c |   54 ++++++++++++++++++++++++++++++++++--------
 sound/arm/pxa2xx-ac97.c     |   18 +------------
 sound/soc/pxa/Kconfig       |    2 +
 sound/soc/pxa/pxa2xx-ac97.c |   21 ++--------------
 7 files changed, 75 insertions(+), 46 deletions(-)
 create mode 100644 include/sound/pxa2xx-lib.h

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
new file mode 100644
index 0000000..a300e46
--- /dev/null
+++ b/include/sound/pxa2xx-lib.h
@@ -0,0 +1,17 @@
+#ifndef PXA2XX_LIB_H
+#define PXA2XX_LIB_H
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
index ee0de4d..6c73c49 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -1,3 +1,17 @@
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
 
 static DEFINE_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
@@ -17,7 +31,7 @@ static struct clk *ac97conf_clk;
  * 1 jiffy timeout if interrupt never comes).
  */
 
-static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
+unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
 	volatile u32 *reg_addr;
@@ -59,8 +73,9 @@ static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg
 out:	mutex_unlock(&car_mutex);
 	return val;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_read);
 
-static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
+void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 {
 	volatile u32 *reg_addr;
 
@@ -87,8 +102,9 @@ static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigne
 
 	mutex_unlock(&car_mutex);
 }
+EXPORT_SYMBOL(pxa2xx_ac97_write);
 
-static bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
+bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 {
 #ifdef CONFIG_PXA3xx
 	int timeout = 100;
@@ -113,13 +129,18 @@ static bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
 #endif
 
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
+	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
+				 __func__, gsr_bits);
+
 		return false;
+	}
 
 	return true;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_try_warm_reset);
 
-static bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
+bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 {
 #ifdef CONFIG_PXA3xx
 	int timeout = 1000;
@@ -155,18 +176,24 @@ static bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
 #endif
 
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
+	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
+				 __func__, gsr_bits);
+
 		return false;
+	}
 
 	return true;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_try_cold_reset);
 
 
-static void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97)
+void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97)
 {
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_finish_reset);
 
 static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
 {
@@ -194,14 +221,15 @@ static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_PM
-static int pxa2xx_ac97_hw_suspend(void)
+int pxa2xx_ac97_hw_suspend(void)
 {
 	GCR |= GCR_ACLINK_OFF;
 	clk_disable(ac97_clk);
 	return 0;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_hw_suspend);
 
-static int pxa2xx_ac97_hw_resume(void)
+int pxa2xx_ac97_hw_resume(void)
 {
 	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
 	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
@@ -214,9 +242,10 @@ static int pxa2xx_ac97_hw_resume(void)
 	clk_enable(ac97_clk);
 	return 0;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_hw_resume);
 #endif
 
-static int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
+int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 {
 	int ret;
 
@@ -260,8 +289,9 @@ err_irq:
 err:
 	return ret;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_hw_probe);
 
-static void pxa2xx_ac97_hw_remove(struct platform_device *dev)
+void pxa2xx_ac97_hw_remove(struct platform_device *dev)
 {
 	GCR |= GCR_ACLINK_OFF;
 	free_irq(IRQ_AC97, NULL);
@@ -273,3 +303,5 @@ static void pxa2xx_ac97_hw_remove(struct platform_device *dev)
 	clk_put(ac97_clk);
 	ac97_clk = NULL;
 }
+EXPORT_SYMBOL(pxa2xx_ac97_hw_remove);
+
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 320ac75..cba71d8 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -12,38 +12,24 @@
 
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
 
-#include "pxa2xx-ac97-lib.c"
-
 static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
 {
 	if (!pxa2xx_ac97_try_cold_reset(ac97)) {
-		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
-
-		if (!pxa2xx_ac97_try_warm_reset(ac97))
-			printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-					 __func__, gsr_bits);
+		pxa2xx_ac97_try_warm_reset(ac97);
 	}
 
 	pxa2xx_ac97_finish_reset(ac97);
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
index 99f096d..a80ae07 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -13,43 +13,28 @@
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
 
-#include "../../arm/pxa2xx-ac97-lib.c"
-
 static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-	if (!pxa2xx_ac97_try_warm_reset(ac97))
-		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
+	pxa2xx_ac97_try_warm_reset(ac97);
 
 	pxa2xx_ac97_finish_reset(ac97);
 }
 
 static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	if (!pxa2xx_ac97_try_cold_reset(ac97))
-		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
+	pxa2xx_ac97_try_cold_reset(ac97);
 
 	pxa2xx_ac97_finish_reset(ac97);
 }
-- 
1.5.6.5
