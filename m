From: Nicolas Pitre <nico@cam.org>
Subject: new ALSA driver for audio on the ARM PXA2xx platform
Date: Tue, 25 Jan 2005 16:33:40 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0501251624470.16341@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This patch adds two modules: one for generic PCM support on PXA2xx and 
another to interface with the AC97 link on the PXA2xx.  Eventually 
additional modules could be written to use the PCM module with SSP or 
I2S audio ports.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/sound/arm/Kconfig
===================================================================
--- linux-2.6.orig/sound/arm/Kconfig
+++ linux-2.6/sound/arm/Kconfig
@@ -14,5 +14,20 @@
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sa11xx-uda1341.
 
+config SND_PXA2xx_AC97
+	tristate "AC97 driver for the Intel PXA2xx chip"
+	depends on ARCH_PXA && SND
+	select SND_PXA2xx_PCM
+	select SND_AC97_CODEC
+	help
+	  Say Y or M if you want to support any AC97 codec attached to
+	  the PXA2xx AC97 interface.
+
+config SND_PXA2xx_PCM
+	tristate
+	select SND_PCM
+	help
+	  Generic PCM module for PXA2xx
+
 endmenu
 
Index: linux-2.6/sound/arm/pxa2xx-ac97.c
===================================================================
--- /dev/null
+++ linux-2.6/sound/arm/pxa2xx-ac97.c
@@ -0,0 +1,412 @@
+/*
+ * linux/sound/pxa2xx-ac97.c -- AC97 support for the Intel PXA2xx chip.
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/audio.h>
+
+#include "pxa2xx-pcm.h"
+
+
+static DECLARE_MUTEX(car_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
+static volatile long gsr_bits;
+
+static unsigned short pxa2xx_ac97_read(ac97_t *ac97, unsigned short reg)
+{
+	unsigned short val = -1;
+	volatile u32 *reg_addr;
+
+	down(&car_mutex);
+	if (CAR & CAR_CAIP) {
+		printk(KERN_CRIT"%s: CAR_CAIP already set\n", __FUNCTION__);
+		goto out;
+	}
+
+	/* set up primary or secondary codec space */
+	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
+	reg_addr += (reg >> 1);
+
+	/* start read access across the ac97 link */
+	gsr_bits = 0;
+	val = *reg_addr;
+	if (reg == AC97_GPIO_STATUS)
+		goto out;
+	wait_event_timeout(gsr_wq, gsr_bits & GSR_SDONE, 1);
+	if (!gsr_bits & GSR_SDONE) {
+		printk(KERN_ERR "%s: read error (ac97_reg=%d GSR=%#lx)\n",
+				__FUNCTION__, reg, gsr_bits);
+		val = -1;
+		goto out;
+	}
+
+	/* valid data now */
+	gsr_bits = 0;
+	val = *reg_addr;			
+	/* but we've just started another cycle... */
+	wait_event_timeout(gsr_wq, gsr_bits & GSR_SDONE, 1);
+
+out:	up(&car_mutex);
+	return val;
+}
+
+static void pxa2xx_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short val)
+{
+	volatile u32 *reg_addr;
+
+	down(&car_mutex);
+
+	if (CAR & CAR_CAIP) {
+		printk(KERN_CRIT "%s: CAR_CAIP already set\n", __FUNCTION__);
+		goto out;
+	}
+
+	/* set up primary or secondary codec space */
+	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
+	reg_addr += (reg >> 1);
+	gsr_bits = 0;
+	*reg_addr = val;
+	wait_event_timeout(gsr_wq, gsr_bits & GSR_CDONE, 1);
+	if (!gsr_bits & GSR_SDONE)
+		printk(KERN_ERR "%s: write error (ac97_reg=%d GSR=%#lx)\n",
+				__FUNCTION__, reg, gsr_bits);
+
+out:	up(&car_mutex);
+}
+
+static void pxa2xx_ac97_reset(ac97_t *ac97)
+{
+	/* First, try cold reset */
+	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
+	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
+
+	gsr_bits = 0;
+#ifdef CONFIG_PXA27x
+	/* PXA27x Developers Manual section 13.5.2.2.1 */
+	pxa_set_cken(1 << 31, 1);
+	udelay(5);
+	pxa_set_cken(1 << 31, 0);
+	GCR = GCR_COLD_RST;
+	udelay(50);
+#else
+	GCR = GCR_COLD_RST;
+	GCR |= GCR_PRIRDY_IEN|GCR_SECRDY_IEN;*/
+	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+#endif
+
+	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
+				 __FUNCTION__, gsr_bits);
+
+		/* let's try warm reset */
+		gsr_bits = 0;
+#ifdef CONFIG_PXA27x
+		/* warm reset broken on Bulverde,
+		   so manually keep AC97 reset high */
+		pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH); 
+		udelay(10);
+		GCR |= GCR_WARM_RST;
+		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		udelay(50);
+#else
+		GCR |= GCR_WARM_RST|GCR_PRIRDY_IEN|GCR_SECRDY_IEN;;
+		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+#endif			
+
+		if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
+			printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
+					 __FUNCTION__, gsr_bits);
+	}
+
+	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
+}
+
+static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	long status;
+
+	status = GSR;
+	if (status) {
+		GSR = status;
+		gsr_bits |= status;
+		wake_up(&gsr_wq);
+
+		/* Although we don't use those we still need to clear them
+		   since they tend to spuriously trigger when MMC is used
+		   (hardware bug? go figure)... */
+		MISR = MISR_EOC;
+		PISR = PISR_EOC;
+		MCSR = MCSR_EOC;
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static ac97_bus_ops_t pxa2xx_ac97_ops = {
+	.read	= pxa2xx_ac97_read,
+	.write	= pxa2xx_ac97_write,
+	.reset	= pxa2xx_ac97_reset,
+};
+
+static pxa2xx_pcm_dma_params_t pxa2xx_ac97_pcm_out = {
+	.name			= "AC97 PCM out",
+	.dev_addr		= __PREG(PCDR),
+	.drcmr			= &DRCMRTXPCDR,
+	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
+				  DCMD_BURST32 | DCMD_WIDTH4,
+};
+
+static pxa2xx_pcm_dma_params_t pxa2xx_ac97_pcm_in = {
+	.name			= "AC97 PCM in",
+	.dev_addr		= __PREG(PCDR),
+	.drcmr			= &DRCMRRXPCDR,
+	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
+				  DCMD_BURST32 | DCMD_WIDTH4,
+};
+
+static snd_pcm_t *pxa2xx_ac97_pcm;
+static ac97_t *pxa2xx_ac97_ac97;
+
+static int pxa2xx_ac97_pcm_startup(snd_pcm_substream_t *substream)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	pxa2xx_audio_ops_t *platform_ops;
+	int vra_mask;
+
+	runtime->hw.channels_min = 2;
+	runtime->hw.channels_max = 2;
+
+	vra_mask = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		   AC97_EA_VRA : AC97_EA_VRM;
+	if (pxa2xx_ac97_ac97->regs[AC97_EXTENDED_STATUS] & vra_mask) {
+		runtime->hw.rates = SNDRV_PCM_RATE_8000_48000;
+		runtime->hw.rate_min = 8000;
+		runtime->hw.rate_max = 48000;
+	} else {
+		runtime->hw.rates = SNDRV_PCM_RATE_48000;
+		runtime->hw.rate_min = 48000;
+		runtime->hw.rate_max = 48000;
+	}
+
+       	platform_ops = substream->pcm->card->dev->platform_data;
+	if (platform_ops && platform_ops->startup)
+		return platform_ops->startup(substream, platform_ops->priv);
+	else
+		return 0;
+}
+
+static void pxa2xx_ac97_pcm_shutdown(snd_pcm_substream_t *substream)
+{
+	pxa2xx_audio_ops_t *platform_ops;
+
+       	platform_ops = substream->pcm->card->dev->platform_data;
+	if (platform_ops && platform_ops->shutdown)
+		platform_ops->shutdown(substream, platform_ops->priv);
+}
+
+static int pxa2xx_ac97_pcm_prepare(snd_pcm_substream_t *substream)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_MIC_ADC_RATE;
+	return snd_ac97_set_rate(pxa2xx_ac97_ac97, reg, runtime->rate);
+}
+
+static pxa2xx_pcm_client_t pxa2xx_ac97_pcm_client = {
+	.playback_params	= &pxa2xx_ac97_pcm_out,
+	.capture_params		= &pxa2xx_ac97_pcm_in,
+	.startup		= pxa2xx_ac97_pcm_startup,
+	.shutdown		= pxa2xx_ac97_pcm_shutdown,
+	.prepare		= pxa2xx_ac97_pcm_prepare,
+};
+
+#ifdef CONFIG_PM
+
+static int pxa2xx_ac97_do_suspend(snd_card_t *card, unsigned int state)
+{
+	if (card->power_state != SNDRV_CTL_POWER_D3cold) {
+		pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
+		snd_pcm_suspend_all(pxa2xx_ac97_pcm);
+		snd_ac97_suspend(pxa2xx_ac97_ac97);
+		snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
+		if (platform_ops && platform_ops->suspend)
+			platform_ops->suspend(platform_ops->priv);
+		GCR |= GCR_ACLINK_OFF;
+		pxa_set_cken(CKEN2_AC97, 0);
+	}
+
+	return 0;
+}
+
+static int pxa2xx_ac97_do_resume(snd_card_t *card, unsigned int state)
+{
+	if (card->power_state != SNDRV_CTL_POWER_D0) {
+		pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
+		pxa_set_cken(CKEN2_AC97, 1);
+		if (platform_ops && platform_ops->resume)
+			platform_ops->resume(platform_ops->priv);
+		snd_ac97_resume(pxa2xx_ac97_ac97);
+		snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	}
+
+	return 0;
+}
+
+static int pxa2xx_ac97_suspend(struct device *_dev, u32 state, u32 level)
+{
+	snd_card_t *card = dev_get_drvdata(_dev);
+	int ret = 0;
+
+	if (card && level == SUSPEND_DISABLE)
+		ret = pxa2xx_ac97_do_suspend(card, SNDRV_CTL_POWER_D3cold);
+
+	return ret;
+}
+
+static int pxa2xx_ac97_resume(struct device *_dev, u32 level)
+{
+	snd_card_t *card = dev_get_drvdata(_dev);
+	int ret = 0;
+
+	if (card && level == RESUME_ENABLE)
+		ret = pxa2xx_ac97_do_resume(card, SNDRV_CTL_POWER_D0);
+
+	return ret;
+}
+
+#else
+#define pxa2xx_ac97_suspend	NULL
+#define pxa2xx_ac97_resume	NULL
+#endif
+
+static int pxa2xx_ac97_probe(struct device *dev)
+{
+	snd_card_t *card;
+	ac97_bus_t *ac97_bus;
+	ac97_template_t ac97_template;
+	int ret;
+
+	ret = -ENOMEM;
+	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			    THIS_MODULE, 0);
+	if (!card)
+		goto err;
+
+	card->dev = dev;
+	strncpy(card->driver, "pxa2xx-ac97", sizeof(card->driver));
+
+	ret = pxa2xx_pcm_new(card, &pxa2xx_ac97_pcm_client, &pxa2xx_ac97_pcm);
+	if (ret)
+		goto err;
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
+#endif
+	pxa_set_cken(CKEN2_AC97, 1);
+
+	ret = snd_ac97_bus(card, 0, &pxa2xx_ac97_ops, NULL, &ac97_bus);
+	if (ret)
+		goto err;
+	memset(&ac97_template, 0, sizeof(ac97_template));
+	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &pxa2xx_ac97_ac97);
+	if (ret)
+		goto err;
+	snprintf(card->shortname, sizeof(card->shortname), "%s",
+		 snd_ac97_get_short_name(pxa2xx_ac97_ac97));
+
+	snd_card_set_pm_callback(card, pxa2xx_ac97_do_suspend,
+				 pxa2xx_ac97_do_resume, NULL);
+	ret = snd_card_register(card);
+	if (ret == 0) {
+		dev_set_drvdata(dev, card);
+		return 0;
+	}
+
+ err:
+	if (card)
+		snd_card_free(card);
+	if (CKEN & CKEN2_AC97) {
+		GCR |= GCR_ACLINK_OFF;
+		free_irq(IRQ_AC97, NULL);
+		pxa_set_cken(CKEN2_AC97, 0);
+	}
+	return ret;
+}
+
+static int pxa2xx_ac97_remove(struct device *dev)
+{
+	snd_card_t *card = dev_get_drvdata(dev);
+
+	if (card) {
+		snd_card_free(card);
+		dev_set_drvdata(dev, NULL);
+		GCR |= GCR_ACLINK_OFF;
+		free_irq(IRQ_AC97, NULL);
+		pxa_set_cken(CKEN2_AC97, 0);
+	}
+
+	return 0;
+}
+
+static struct device_driver pxa2xx_ac97_driver = {
+	.name		= "pxa2xx-ac97",
+	.bus		= &platform_bus_type,
+	.probe		= pxa2xx_ac97_probe,
+	.remove		= pxa2xx_ac97_remove,
+	.suspend	= pxa2xx_ac97_suspend,
+	.resume		= pxa2xx_ac97_resume,
+};
+
+static int __init pxa2xx_ac97_init(void)
+{
+	return driver_register(&pxa2xx_ac97_driver);
+}
+
+static void __exit pxa2xx_ac97_exit(void)
+{
+	driver_unregister(&pxa2xx_ac97_driver);
+}
+
+module_init(pxa2xx_ac97_init);
+module_exit(pxa2xx_ac97_exit);
+
+MODULE_AUTHOR("Nicolas Pitre");
+MODULE_DESCRIPTION("AC97 driver for the Intel PXA2xx chip");
+MODULE_LICENSE("GPL");
Index: linux-2.6/sound/arm/Makefile
===================================================================
--- linux-2.6.orig/sound/arm/Makefile
+++ linux-2.6/sound/arm/Makefile
@@ -3,6 +3,10 @@
 #
 
 snd-sa11xx-uda1341-objs := sa11xx-uda1341.o
+snd-pxa2xx-pcm-objs := pxa2xx-pcm.o
+snd-pxa2xx-ac97-objs := pxa2xx-ac97.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-sa11xx-uda1341.o 
+obj-$(CONFIG_SND_PXA2xx_PCM) += snd-pxa2xx-pcm.o
+obj-$(CONFIG_SND_PXA2xx_AC97) += snd-pxa2xx-ac97.o
Index: linux-2.6/sound/arm/pxa2xx-pcm.h
===================================================================
--- /dev/null
+++ linux-2.6/sound/arm/pxa2xx-pcm.h
@@ -0,0 +1,29 @@
+/*
+ * linux/sound/arm/pxa2xx-pcm.h -- ALSA PCM interface for the Intel PXA2xx chip
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+typedef struct {
+	char *name;			/* stream identifier */
+	u32 dcmd;			/* DMA descriptor dcmd field */
+	volatile u32 *drcmr;		/* the DMA request channel to use */
+	u32 dev_addr;			/* device physical address for DMA */
+} pxa2xx_pcm_dma_params_t;
+	
+typedef struct {
+	pxa2xx_pcm_dma_params_t *playback_params;
+	pxa2xx_pcm_dma_params_t *capture_params;
+	int (*startup)(snd_pcm_substream_t *);
+	void (*shutdown)(snd_pcm_substream_t *);
+	int (*prepare)(snd_pcm_substream_t *);
+} pxa2xx_pcm_client_t;
+
+extern int pxa2xx_pcm_new(snd_card_t *, pxa2xx_pcm_client_t *, snd_pcm_t **);
+
Index: linux-2.6/sound/arm/pxa2xx-pcm.c
===================================================================
--- /dev/null
+++ linux-2.6/sound/arm/pxa2xx-pcm.c
@@ -0,0 +1,366 @@
+/*
+ * linux/sound/arm/pxa2xx-pcm.c -- ALSA PCM interface for the Intel PXA2xx chip
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include <asm/dma.h>
+#include <asm/hardware.h>
+#include <asm/arch/pxa-regs.h>
+
+#include "pxa2xx-pcm.h"
+
+
+static const snd_pcm_hardware_t pxa2xx_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192 - 32,
+	.periods_min		= 1,
+	.periods_max		= PAGE_SIZE/sizeof(pxa_dma_desc),
+	.buffer_bytes_max	= 128 * 1024,
+	.fifo_size		= 32,
+};
+
+struct pxa2xx_runtime_data {
+	int dma_ch;
+	pxa2xx_pcm_dma_params_t *params;
+	pxa_dma_desc *dma_desc_array;
+	dma_addr_t dma_desc_array_phys;
+};
+
+static int pxa2xx_pcm_hw_params(snd_pcm_substream_t *substream,
+				snd_pcm_hw_params_t *params)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct pxa2xx_runtime_data *rtd = runtime->private_data;
+	size_t totsize = params_buffer_bytes(params);
+	size_t period = params_period_bytes(params);
+	pxa_dma_desc *dma_desc;
+	dma_addr_t dma_buff_phys, next_desc_phys;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = totsize;
+
+	dma_desc = rtd->dma_desc_array;
+	next_desc_phys = rtd->dma_desc_array_phys;
+	dma_buff_phys = runtime->dma_addr;
+	do {
+		next_desc_phys += sizeof(pxa_dma_desc);
+		dma_desc->ddadr = next_desc_phys;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			dma_desc->dsadr = dma_buff_phys;
+			dma_desc->dtadr = rtd->params->dev_addr;
+		} else {
+			dma_desc->dsadr = rtd->params->dev_addr;
+			dma_desc->dtadr = dma_buff_phys;
+		}
+		if (period > totsize)
+			period = totsize;
+		dma_desc->dcmd = rtd->params->dcmd | period | DCMD_ENDIRQEN;
+		dma_desc++;
+		dma_buff_phys += period;
+	} while (totsize -= period);
+	dma_desc[-1].ddadr = rtd->dma_desc_array_phys;
+
+	return 0;
+}
+
+static int pxa2xx_pcm_hw_free(snd_pcm_substream_t *substream)
+{
+	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
+
+	*rtd->params->drcmr = 0;
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+static int pxa2xx_pcm_prepare(snd_pcm_substream_t *substream)
+{
+	pxa2xx_pcm_client_t *client = substream->private_data;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct pxa2xx_runtime_data *rtd = runtime->private_data;
+
+	DCSR(rtd->dma_ch) &= ~DCSR_RUN;
+	DCSR(rtd->dma_ch) = 0;
+	DCMD(rtd->dma_ch) = 0;
+	*rtd->params->drcmr = rtd->dma_ch | DRCMR_MAPVLD;
+
+	return client->prepare(substream);
+}
+
+static int pxa2xx_pcm_trigger(snd_pcm_substream_t *substream, int cmd)
+{
+	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		DDADR(rtd->dma_ch) = rtd->dma_desc_array_phys;
+		DCSR(rtd->dma_ch) = DCSR_RUN;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		DCSR(rtd->dma_ch) &= ~DCSR_RUN;
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		DCSR(rtd->dma_ch) |= DCSR_RUN;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id, struct pt_regs *regs)
+{
+	snd_pcm_substream_t *substream = dev_id;
+	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
+	int dcsr;
+
+	dcsr = DCSR(dma_ch);
+	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
+
+	if (dcsr & DCSR_ENDINTR) {
+		snd_pcm_period_elapsed(substream);
+	} else {
+		printk( KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
+			rtd->params->name, dma_ch, dcsr );
+	}
+}
+
+static snd_pcm_uframes_t pxa2xx_pcm_pointer(snd_pcm_substream_t *substream)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct pxa2xx_runtime_data *rtd = runtime->private_data;
+	dma_addr_t ptr = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			 DSADR(rtd->dma_ch) : DTADR(rtd->dma_ch);
+	snd_pcm_uframes_t x = bytes_to_frames(runtime, ptr - runtime->dma_addr);
+	if (x == runtime->buffer_size)
+		x = 0;
+	return x;
+}
+
+static int
+pxa2xx_pcm_hw_rule_mult32(snd_pcm_hw_params_t *params, snd_pcm_hw_rule_t *rule)
+{
+	snd_interval_t *i = hw_param_interval(params, rule->var);
+	int changed = 0;
+
+	if (i->min & 31) {
+		i->min = (i->min & ~31) + 32;
+		i->openmin = 0;
+		changed = 1;
+	}
+
+	if (i->max & 31) {
+		i->max &= ~31;
+		i->openmax = 0;
+		changed = 1;
+	}
+
+	return changed;
+}
+
+static int pxa2xx_pcm_open(snd_pcm_substream_t *substream)
+{
+	pxa2xx_pcm_client_t *client = substream->private_data;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct pxa2xx_runtime_data *rtd;
+	int ret;
+
+	runtime->hw = pxa2xx_pcm_hardware;
+
+	/*
+	 * For mysterious reasons (and despite what the manual says)
+	 * playback samples are lost if the DMA count is not a multiple
+	 * of the DMA burst size.  Let's add a rule to enforce that.
+	 */
+	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				  pxa2xx_pcm_hw_rule_mult32, NULL,
+				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, -1);
+	if (ret)
+		goto out;
+	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				  pxa2xx_pcm_hw_rule_mult32, NULL,
+				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
+	if (ret)
+		goto out;
+
+	ret = -ENOMEM;
+	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
+	if (!rtd)
+		goto out;
+	rtd->dma_desc_array =
+		dma_alloc_writecombine(substream->pcm->card->dev, PAGE_SIZE,
+				       &rtd->dma_desc_array_phys, GFP_KERNEL);
+	if (!rtd->dma_desc_array)
+		goto err1;
+
+	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		      client->playback_params : client->capture_params;
+	ret = pxa_request_dma(rtd->params->name, DMA_PRIO_LOW,
+			      pxa2xx_pcm_dma_irq, substream);
+	if (ret < 0)
+		goto err2;
+	rtd->dma_ch = ret;
+
+	runtime->private_data = rtd;
+	ret = client->startup(substream);
+	if (!ret)
+		goto out;
+
+	pxa_free_dma(rtd->dma_ch);
+ err2:
+	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
+			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
+ err1:
+	kfree(rtd);
+ out:
+	return ret;
+}
+
+static int pxa2xx_pcm_close(snd_pcm_substream_t *substream)
+{
+	pxa2xx_pcm_client_t *client = substream->private_data;
+	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
+
+	pxa_free_dma(rtd->dma_ch);
+	client->shutdown(substream);
+	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
+			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
+	kfree(rtd);
+	return 0;
+}
+
+static int
+pxa2xx_pcm_mmap(snd_pcm_substream_t *substream, struct vm_area_struct *vma)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+static snd_pcm_ops_t pxa2xx_pcm_ops = {
+	.open		= pxa2xx_pcm_open,
+	.close		= pxa2xx_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pxa2xx_pcm_hw_params,
+	.hw_free	= pxa2xx_pcm_hw_free,
+	.prepare	= pxa2xx_pcm_prepare,
+	.trigger	= pxa2xx_pcm_trigger,
+	.pointer	= pxa2xx_pcm_pointer,
+	.mmap		= pxa2xx_pcm_mmap,
+};
+
+static int pxa2xx_pcm_preallocate_dma_buffer(snd_pcm_t *pcm, int stream)
+{
+	snd_pcm_substream_t *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = pxa2xx_pcm_hardware.buffer_bytes_max;
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+	return 0;
+}
+
+static void pxa2xx_pcm_free_dma_buffers(snd_pcm_t *pcm)
+{
+	snd_pcm_substream_t *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+		dma_free_writecombine(pcm->card->dev, buf->bytes,
+				      buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static u64 pxa2xx_pcm_dmamask = 0xffffffff;
+
+int pxa2xx_pcm_new(snd_card_t *card, pxa2xx_pcm_client_t *client, snd_pcm_t **rpcm)
+{
+	snd_pcm_t *pcm;
+	int play = client->playback_params ? 1 : 0;
+	int capt = client->capture_params ? 1 : 0;
+	int ret;
+
+	ret = snd_pcm_new(card, "PXA2xx-PCM", 0, play, capt, &pcm);
+	if (ret)
+		goto out;
+
+	pcm->private_data = client;
+	pcm->private_free = pxa2xx_pcm_free_dma_buffers;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &pxa2xx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (play) {
+		int stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
+		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
+		if (ret)
+			goto out;
+	}
+	if (capt) {
+		int stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
+		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
+		if (ret)
+			goto out;
+	}
+
+	if (rpcm)
+		*rpcm = pcm;
+	ret = 0;
+
+ out:
+	return ret;
+}
+
+EXPORT_SYMBOL(pxa2xx_pcm_new);
+
+MODULE_AUTHOR("Nicolas Pitre");
+MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
+MODULE_LICENSE("GPL");


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
