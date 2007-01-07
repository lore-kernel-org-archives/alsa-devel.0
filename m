From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [RFC,PATCH] ep93xx: alsa pcm and ac97 support (fwd)
Date: Sun, 7 Jan 2007 22:16:14 +0100
Message-ID: <20070107211614.GA21247@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from xi.wantstofly.org (alephnull.demon.nl [83.160.184.112])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E64BA230
	for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2007 22:16:15 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Please CC on replies, not subscribed.)

I sent this to linux-arm-kernel@ some time ago, but didn't get any
complaints, so I guess it's time I send it to the alsa list.  This
driver depends on the cirrus m2p dma driver that I also sent to the
linux-arm-kernel@ list some time ago.


Index: linux-2.6.19/sound/arm/Kconfig
===================================================================
--- linux-2.6.19.orig/sound/arm/Kconfig
+++ linux-2.6.19/sound/arm/Kconfig
@@ -20,6 +20,19 @@ config SND_ARMAACI
 	select SND_PCM
 	select SND_AC97_CODEC
 
+config SND_EP93XX_PCM
+	tristate
+	select SND_PCM
+
+config SND_EP93XX_AC97
+	tristate "AC97 driver for the Cirrus EP93xx chip"
+	depends on ARCH_EP93XX && SND
+	select SND_EP93XX_PCM
+	select SND_AC97_CODEC
+	help
+	  Say Y or M if you want to support any AC97 codec attached to
+	  the EP93xx AC97 interface.
+
 config SND_PXA2XX_PCM
 	tristate
 	select SND_PCM
Index: linux-2.6.19/sound/arm/Makefile
===================================================================
--- linux-2.6.19.orig/sound/arm/Makefile
+++ linux-2.6.19/sound/arm/Makefile
@@ -8,6 +8,12 @@ snd-sa11xx-uda1341-objs		:= sa11xx-uda13
 obj-$(CONFIG_SND_ARMAACI)	+= snd-aaci.o
 snd-aaci-objs			:= aaci.o devdma.o
 
+obj-$(CONFIG_SND_EP93XX_PCM)	+= snd-ep93xx-pcm.o
+snd-ep93xx-pcm-objs		:= ep93xx-pcm.o
+
+obj-$(CONFIG_SND_EP93XX_AC97)	+= snd-ep93xx-ac97.o
+snd-ep93xx-ac97-objs		:= ep93xx-ac97.o
+
 obj-$(CONFIG_SND_PXA2XX_PCM)	+= snd-pxa2xx-pcm.o
 snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
 
Index: linux-2.6.19/sound/arm/ep93xx-ac97.c
===================================================================
--- /dev/null
+++ linux-2.6.19/sound/arm/ep93xx-ac97.c
@@ -0,0 +1,301 @@
+/*
+ * linux/sound/arm/ep93xx-ac97.c - EP93xx AC97 driver
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2006 Applied Data Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <asm/irq.h>
+#include <linux/mutex.h>
+#include <asm/hardware.h>
+#include <asm/arch/ep93xx-regs.h>
+#include <asm/arch/dma.h>
+#include "ep93xx-pcm.h"
+
+#define EP93XX_AAC_RXCR1		(EP93XX_AAC_BASE + 0x04)
+#define EP93XX_AAC_TXCR1		(EP93XX_AAC_BASE + 0x08)
+#define EP93XX_AAC_SLOT1_DATA		(EP93XX_AAC_BASE + 0x80)
+#define EP93XX_AAC_SLOT2_DATA		(EP93XX_AAC_BASE + 0x84)
+#define EP93XX_AAC_RGIS			(EP93XX_AAC_BASE + 0x8c)
+#define EP93XX_AAC_EOI			(EP93XX_AAC_BASE + 0x98)
+#define EP93XX_AAC_GCR			(EP93XX_AAC_BASE + 0x9c)
+#define EP93XX_AAC_RESET		(EP93XX_AAC_BASE + 0xa0)
+
+
+/* AC'97 bus ops ************************************************************/
+// @@@ don't busy wait, use mutex
+static unsigned short ep93xx_ac97_bus_read(struct snd_ac97 *ac97,
+					   unsigned short reg)
+{
+	writel(reg, EP93XX_AAC_SLOT1_DATA);
+
+	/* Wait for address to be transmitted.  */
+	while ((readl(EP93XX_AAC_RGIS) & 1) == 0)
+		cpu_relax();
+
+	/* Wait for data to be received.  */
+	while ((readl(EP93XX_AAC_RGIS) & 2) == 0)
+		cpu_relax();
+
+	return readl(EP93XX_AAC_SLOT2_DATA);
+}
+
+static void ep93xx_ac97_bus_write(struct snd_ac97 *ac97,
+				  unsigned short reg,
+					unsigned short val)
+{
+	writel(val, EP93XX_AAC_SLOT2_DATA);
+	writel(reg, EP93XX_AAC_SLOT1_DATA);
+
+	/* Wait for address and data to be transmitted.  */
+	while ((readl(EP93XX_AAC_RGIS) & 0x41) != 0x41)
+		cpu_relax();
+}
+
+static void ep93xx_ac97_bus_reset(struct snd_ac97 *ac97)
+{
+	int i;
+
+	printk(KERN_INFO "ep93xx-ac97: resetting bus.. ");
+
+	writel(1, EP93XX_AAC_RESET);
+	i = 0;
+	while ((readl(EP93XX_AAC_RESET) & 1) == 1) {
+		cpu_relax();
+		i++;
+	}
+
+	printk("done (%d)\n", i);
+
+
+	/*
+	 * @@@ This sequence is necessary for the CS4202 codec.
+	 */
+	printk(KERN_INFO "ep93xx-ac97: waiting for codec ready.. ");
+	i = 0;
+	writel(0x02, EP93XX_AAC_EOI);
+	while ((readl(EP93XX_AAC_RGIS) & 0x20) == 0) {
+		cpu_relax();
+		i++;
+	}
+	printk("ready (%d)\n", i);
+
+	printk(KERN_INFO "ep93xx-ac97: waiting for codec to settle.. ");
+	i = 0;
+	while ((ep93xx_ac97_bus_read(NULL, 0x26) & 0x000f) != 0x000f) {
+		cpu_relax();
+		i++;
+	}
+	printk("settled (%d)\n", i);
+}
+
+static struct snd_ac97_bus_ops ep93xx_ac97_bus_ops = {
+	.read	= ep93xx_ac97_bus_read,
+	.write	= ep93xx_ac97_bus_write,
+	.reset	= ep93xx_ac97_bus_reset,
+};
+
+
+/* AC'97 PCM handling *******************************************************/
+static struct ep93xx_pcm_dma_params ep93xx_ac97_pcm_out = {
+	.name		= "AC97 PCM out",
+	.dma_port	= EP93XX_DMA_M2P_PORT_AAC1,
+};
+
+static struct ep93xx_pcm_dma_params ep93xx_ac97_pcm_in = {
+	.name		= "AC97 PCM in",
+	.dma_port	= EP93XX_DMA_M2P_PORT_AAC1,
+};
+
+static struct snd_ac97 *ep93xx_ac97_ac97;
+static struct snd_pcm *ep93xx_ac97_pcm;
+
+static int ep93xx_ac97_pcm_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ep93xx_ac97_audio_ops *ops;
+	int r;
+
+	runtime->hw.channels_min = 2;
+	runtime->hw.channels_max = 2;
+
+	r = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		AC97_RATES_FRONT_DAC : AC97_RATES_ADC;
+	runtime->hw.rates = ep93xx_ac97_ac97->rates[r];
+	snd_pcm_limit_hw_rates(runtime);
+
+	ops = substream->pcm->card->dev->platform_data;
+	if (ops != NULL && ops->amp_power != NULL)
+		ops->amp_power(1);
+
+	return 0;
+}
+
+static void ep93xx_ac97_pcm_shutdown(struct snd_pcm_substream *substream)
+{
+	struct ep93xx_ac97_audio_ops *ops;
+
+	ops = substream->pcm->card->dev->platform_data;
+	if (ops != NULL && ops->amp_power != NULL)
+		ops->amp_power(0);
+}
+
+static int ep93xx_ac97_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int reg;
+
+	reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
+
+	return snd_ac97_set_rate(ep93xx_ac97_ac97, reg, runtime->rate);
+}
+
+static struct ep93xx_pcm_client ep93xx_ac97_pcm_client = {
+	.playback_params	= &ep93xx_ac97_pcm_out,
+	.capture_params		= &ep93xx_ac97_pcm_in,
+	.startup		= ep93xx_ac97_pcm_startup,
+	.shutdown		= ep93xx_ac97_pcm_shutdown,
+	.prepare		= ep93xx_ac97_pcm_prepare,
+};
+
+
+/* AC'97 platform driver ****************************************************/
+static int ep93xx_ac97_probe(struct platform_device *dev)
+{
+	struct ep93xx_ac97_audio_ops *ops = dev->dev.platform_data;
+	struct snd_card *card;
+	struct snd_ac97_bus *ac97_bus;
+	struct snd_ac97_template ac97_template;
+	int ret;
+
+	// @@@ register resources
+
+	printk(KERN_INFO "ep93xx-ac97: resetting ac97 controller\n");
+	writel(0, EP93XX_AAC_GCR);
+	msleep(1);
+	writel(1, EP93XX_AAC_GCR);
+
+	writel(0x8019, EP93XX_AAC_RXCR1);
+	writel(0x8019, EP93XX_AAC_TXCR1);
+
+	if (ops != NULL && ops->codec_power != NULL) {
+		ops->codec_power(1);
+		msleep(1);
+	}
+
+	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+				THIS_MODULE, 0);
+	if (card == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	card->dev = &dev->dev;
+	strncpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
+
+	ret = ep93xx_pcm_new(card, &ep93xx_ac97_pcm_client, &ep93xx_ac97_pcm);
+	if (ret)
+		goto err;
+
+	ret = snd_ac97_bus(card, 0, &ep93xx_ac97_bus_ops, NULL, &ac97_bus);
+	if (ret)
+		goto err;
+
+	memset(&ac97_template, 0, sizeof(ac97_template));
+	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &ep93xx_ac97_ac97);
+	if (ret)
+		goto err;
+
+	snprintf(card->shortname, sizeof(card->shortname),
+			"%s", snd_ac97_get_short_name(ep93xx_ac97_ac97));
+	snprintf(card->longname, sizeof(card->longname),
+			"%s (%s)", dev->dev.driver->name, card->mixername);
+
+	ret = snd_card_register(card);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(dev, card);
+
+	return 0;
+
+err:
+	/* @@@ This causes hangs..
+	 * if (card != NULL)
+	 *	snd_card_free(card);
+	 */
+
+	return ret;
+}
+
+static int ep93xx_ac97_remove(struct platform_device *dev)
+{
+	struct snd_card *card = platform_get_drvdata(dev);
+
+	if (card != NULL) {
+		snd_card_free(card);
+		platform_set_drvdata(dev, NULL);
+		writel(0, EP93XX_AAC_GCR);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ep93xx_ac97_suspend(struct platform_device *dev, pm_message_t state)
+{
+	return 0;
+}
+
+static int ep93xx_ac97_resume(struct platform_device *dev)
+{
+	return 0;
+}
+#else
+#define ep93xx_ac97_suspend     NULL
+#define ep93xx_ac97_resume      NULL
+#endif
+
+static struct platform_driver ep93xx_ac97_driver = {
+	.probe		= ep93xx_ac97_probe,
+	.remove		= ep93xx_ac97_remove,
+	.suspend	= ep93xx_ac97_suspend,
+	.resume		= ep93xx_ac97_resume,
+	.driver		= {
+		.name	= "ep93xx-ac97",
+	},
+};
+
+static int __init ep93xx_ac97_init(void)
+{
+	return platform_driver_register(&ep93xx_ac97_driver);
+}
+
+static void __exit ep93xx_ac97_exit(void)
+{
+	platform_driver_unregister(&ep93xx_ac97_driver);
+}
+
+module_init(ep93xx_ac97_init);
+module_exit(ep93xx_ac97_exit);
+
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_DESCRIPTION("EP93xx AC97 driver");
+MODULE_LICENSE("GPL");
Index: linux-2.6.19/sound/arm/ep93xx-pcm.c
===================================================================
--- /dev/null
+++ linux-2.6.19/sound/arm/ep93xx-pcm.c
@@ -0,0 +1,324 @@
+/*
+ * linux/sound/arm/ep93xx-pcm.c - EP93xx ALSA PCM interface
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2006 Applied Data Systems
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
+#include <linux/interrupt.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <asm/dma.h>
+#include <asm/hardware.h>
+#include <asm/arch/ep93xx-regs.h>
+#include "ep93xx-pcm.h"
+
+#define MAX_PERIODS	32
+
+static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+
+	.buffer_bytes_max	= 131072,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 32768,
+	.periods_min		= 1,
+	.periods_max		= MAX_PERIODS,
+	.fifo_size		= 32,
+};
+
+struct ep93xx_runtime_data
+{
+	struct ep93xx_dma_m2p_client	cl;
+	struct ep93xx_pcm_dma_params	*params;
+	int				pointer_bytes;
+	struct tasklet_struct		period_tasklet;
+	int				periods;
+	struct ep93xx_dma_buffer	buf[MAX_PERIODS];
+};
+
+static void do_period_elapsed(unsigned long data)
+{
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
+	snd_pcm_period_elapsed(substream);
+}
+
+static void ep93xx_pcm_buffer_started(void *cookie, struct ep93xx_dma_buffer *buf)
+{
+}
+
+static void ep93xx_pcm_buffer_finished(void *cookie, struct ep93xx_dma_buffer *buf, int bytes, int error)
+{
+	struct snd_pcm_substream *substream = cookie;
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+
+	if (buf == rtd->buf + rtd->periods - 1)
+		rtd->pointer_bytes = 0;
+	else
+		rtd->pointer_bytes += buf->size;
+
+	if (!error) {
+		ep93xx_dma_m2p_submit_recursive(&rtd->cl, buf);
+		tasklet_schedule(&rtd->period_tasklet);
+	} else {
+		// @@@
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	}
+}
+
+static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct ep93xx_pcm_client *client = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ep93xx_runtime_data *rtd;
+	int ret;
+
+	runtime->hw = ep93xx_pcm_hardware;
+
+	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
+	if (rtd == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			client->playback_params : client->capture_params;
+
+	memset(&rtd->period_tasklet, 0, sizeof(rtd->period_tasklet));
+	rtd->period_tasklet.func = do_period_elapsed;
+	rtd->period_tasklet.data = (unsigned long)substream;
+
+	rtd->cl.name = rtd->params->name;
+	rtd->cl.flags = rtd->params->dma_port | EP93XX_DMA_M2P_IGNORE_ERROR |
+		((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		  EP93XX_DMA_M2P_TX : EP93XX_DMA_M2P_RX);
+	rtd->cl.cookie = (void *)substream;
+	rtd->cl.buffer_started = ep93xx_pcm_buffer_started;
+	rtd->cl.buffer_finished = ep93xx_pcm_buffer_finished;
+	ret = ep93xx_dma_m2p_client_register(&rtd->cl);
+	if (ret < 0)
+		goto err;
+
+	runtime->private_data = rtd;
+
+	ret = client->startup(substream);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	ep93xx_dma_m2p_client_unregister(&rtd->cl);
+	kfree(rtd);
+
+	return ret;
+}
+
+static int ep93xx_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct ep93xx_pcm_client *client = substream->private_data;
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+
+	ep93xx_dma_m2p_client_unregister(&rtd->cl);
+	client->shutdown(substream);
+	kfree(rtd);
+
+	return 0;
+}
+
+static int ep93xx_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ep93xx_runtime_data *rtd = runtime->private_data;
+	size_t totsize = params_buffer_bytes(params);
+	size_t period = params_period_bytes(params);
+	int i;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = totsize;
+
+	rtd->periods = (totsize + period - 1) / period;
+	for (i = 0; i < rtd->periods; i++) {
+		rtd->buf[i].bus_addr = runtime->dma_addr + (i * period);
+		rtd->buf[i].size = period;
+		if ((i + 1) * period > totsize)
+			rtd->buf[i].size = totsize - (i * period);
+	}
+
+	return 0;
+}
+
+static int ep93xx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+static int ep93xx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct ep93xx_pcm_client *client = substream->private_data;
+	return client->prepare(substream);
+}
+
+static int ep93xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+	int ret;
+	int i;
+
+	ret = 0;
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		rtd->pointer_bytes = 0;
+		for (i = 0; i < rtd->periods; i++)
+			ep93xx_dma_m2p_submit(&rtd->cl, rtd->buf + i);
+
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ep93xx_dma_m2p_flush(&rtd->cl);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t ep93xx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+
+	// @@@ implement this with sub-period granularity
+	return bytes_to_frames(runtime, rtd->pointer_bytes);
+}
+
+static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
+			   struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops ep93xx_pcm_ops = {
+	.open		= ep93xx_pcm_open,
+	.close		= ep93xx_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= ep93xx_pcm_hw_params,
+	.hw_free	= ep93xx_pcm_hw_free,
+	.prepare	= ep93xx_pcm_prepare,
+	.trigger	= ep93xx_pcm_trigger,
+	.pointer	= ep93xx_pcm_pointer,
+	.mmap		= ep93xx_pcm_mmap,
+};
+
+static int ep93xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = ep93xx_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	buf->bytes = size;
+
+	return (buf->area == NULL) ? -ENOMEM : 0;
+}
+
+static void ep93xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		struct snd_pcm_substream *substream;
+
+		substream = pcm->streams[stream].substream;
+		if (substream != NULL) {
+			struct snd_dma_buffer *buf;
+
+			buf = &substream->dma_buffer;
+			if (buf->area != NULL) {
+				dma_free_writecombine(pcm->card->dev,
+						      buf->bytes, buf->area,
+						      buf->addr);
+				buf->area = NULL;
+			}
+		}
+	}
+}
+
+static u64 ep93xx_pcm_dmamask = 0xffffffff;
+
+int ep93xx_pcm_new(struct snd_card *card, struct ep93xx_pcm_client *client,
+		   struct snd_pcm **rpcm)
+{
+	struct snd_pcm *pcm;
+	int play = client->playback_params ? 1 : 0;
+	int capt = client->capture_params ? 1 : 0;
+	int ret;
+
+	ret = snd_pcm_new(card, "EP93xx-PCM", 0, play, capt, &pcm);
+	if (ret)
+		goto out;
+
+	pcm->private_data = client;
+	pcm->private_free = ep93xx_pcm_free_dma_buffers;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &ep93xx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (play) {
+		int stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_pcm_set_ops(pcm, stream, &ep93xx_pcm_ops);
+		ret = ep93xx_pcm_preallocate_dma_buffer(pcm, stream);
+		if (ret)
+			goto out;
+	}
+	if (capt) {
+		int stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_pcm_set_ops(pcm, stream, &ep93xx_pcm_ops);
+		ret = ep93xx_pcm_preallocate_dma_buffer(pcm, stream);
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
+EXPORT_SYMBOL(ep93xx_pcm_new);
+
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
+MODULE_LICENSE("GPL");
Index: linux-2.6.19/sound/arm/ep93xx-pcm.h
===================================================================
--- /dev/null
+++ linux-2.6.19/sound/arm/ep93xx-pcm.h
@@ -0,0 +1,26 @@
+/*
+ * linux/sound/arm/ep93xx-pcm.h - EP93xx ALSA PCM interface
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2006 Applied Data Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+struct ep93xx_pcm_dma_params {
+	char	*name;
+	int	dma_port;
+};
+
+struct ep93xx_pcm_client {
+	struct ep93xx_pcm_dma_params *playback_params;
+	struct ep93xx_pcm_dma_params *capture_params;
+	int (*startup)(struct snd_pcm_substream *);
+	void (*shutdown)(struct snd_pcm_substream *);
+	int (*prepare)(struct snd_pcm_substream *);
+};
+
+int ep93xx_pcm_new(struct snd_card *, struct ep93xx_pcm_client *,
+		   struct snd_pcm **);
Index: linux-2.6.19/include/asm-arm/arch-ep93xx/platform.h
===================================================================
--- linux-2.6.19.orig/include/asm-arm/arch-ep93xx/platform.h
+++ linux-2.6.19/include/asm-arm/arch-ep93xx/platform.h
@@ -10,6 +10,12 @@ void ep93xx_init_time(unsigned long);
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 
+struct ep93xx_ac97_audio_ops
+{
+	void		(*amp_power)(int on);
+	void		(*codec_power)(int on);
+};
+
 struct ep93xx_eth_data
 {
 	unsigned char	dev_addr[6];

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
