From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [RESEND][PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0
	internal dma driver
Date: Wed, 13 Jul 2011 13:59:51 +0900
Message-ID: <1310533191-31645-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id C830F1038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 07:11:28 +0200 (CEST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, jassisinghbrar@gmail.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

I2S in Exynos4 and S5PC110(S5PV210) has a internal dma.
It can be used low power audio mode and 2nd channel transfer.
This patch can support idma.

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
V2: change idma_new by new pcm_new api
    add handling different idma address
    as jassi comments, Modify the idma driver

V3: merge idma_reg_int and idma_addr_init

V4: move idma setting in i2s.c to idma_hw_params in idma.c
    move idma_reg_addr_init calling
    modify idma address handling error
    modify module information
    delete useless dev_dbg

V5: delete redundant error print and check routine
    modify irq handler as jassi comment
    fix the indent error
    modify period_bytes_max value to set half size of max buffer

 sound/soc/samsung/Makefile |    2 +
 sound/soc/samsung/idma.c   |  453 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/samsung/idma.h   |   26 +++
 3 files changed, 481 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/samsung/idma.c
 create mode 100644 sound/soc/samsung/idma.h

diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 00ba557..41becdd 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -1,5 +1,6 @@
 # S3c24XX Platform Support
 snd-soc-s3c24xx-objs := dma.o
+snd-soc-idma-objs := idma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-ac97-objs := ac97.o
@@ -16,6 +17,7 @@ obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_SAMSUNG_SPDIF) += snd-soc-samsung-spdif.o
 obj-$(CONFIG_SND_SAMSUNG_PCM) += snd-soc-pcm.o
 obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-idma.o
 
 # S3C24XX Machine Support
 snd-soc-jive-wm8750-objs := jive_wm8750.o
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
new file mode 100644
index 0000000..ebde074
--- /dev/null
+++ b/sound/soc/samsung/idma.c
@@ -0,0 +1,453 @@
+/*
+ * sound/soc/samsung/idma.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * I2S0's Internal DMA driver
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "i2s.h"
+#include "idma.h"
+#include "dma.h"
+#include "i2s-regs.h"
+
+#define ST_RUNNING		(1<<0)
+#define ST_OPENED		(1<<1)
+
+static const struct snd_pcm_hardware idma_hardware = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		    SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		    SNDRV_PCM_INFO_MMAP |
+		    SNDRV_PCM_INFO_MMAP_VALID |
+		    SNDRV_PCM_INFO_PAUSE |
+		    SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		    SNDRV_PCM_FMTBIT_U16_LE |
+		    SNDRV_PCM_FMTBIT_S24_LE |
+		    SNDRV_PCM_FMTBIT_U24_LE |
+		    SNDRV_PCM_FMTBIT_U8 |
+		    SNDRV_PCM_FMTBIT_S8,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = MAX_IDMA_BUFFER,
+	.period_bytes_min = 128,
+	.period_bytes_max = MAX_IDMA_BUFFER/2,
+	.periods_min = 1,
+	.periods_max = 2,
+};
+
+struct idma_ctrl {
+	spinlock_t	lock;
+	int		state;
+	dma_addr_t	start;
+	dma_addr_t	pos;
+	dma_addr_t	end;
+	dma_addr_t	period;
+	dma_addr_t	periodsz;
+	void		*token;
+	void		(*cb)(void *dt, int bytes_xfer);
+};
+
+static struct idma_info {
+	spinlock_t	lock;
+	void		 __iomem  *regs;
+	dma_addr_t	lp_tx_addr;
+} idma;
+
+static void idma_getpos(dma_addr_t *src)
+{
+	*src = idma.lp_tx_addr +
+		(readl(idma.regs + I2STRNCNT) & 0xffffff) * 4;
+}
+
+static int idma_enqueue(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct idma_ctrl *prtd = substream->runtime->private_data;
+	u32 val;
+
+	spin_lock(&prtd->lock);
+	prtd->token = (void *) substream;
+	spin_unlock(&prtd->lock);
+
+	/* Internal DMA Level0 Interrupt Address */
+	val = idma.lp_tx_addr + prtd->periodsz;
+	writel(val, idma.regs + I2SLVL0ADDR);
+
+	/* Start address0 of I2S internal DMA operation. */
+	val = idma.lp_tx_addr;
+	writel(val, idma.regs + I2SSTR0);
+
+	/*
+	 * Transfer block size for I2S internal DMA.
+	 * Should decide transfer size before start dma operation
+	 */
+	val = readl(idma.regs + I2SSIZE);
+	val &= ~(I2SSIZE_TRNMSK << I2SSIZE_SHIFT);
+	val |= (((runtime->dma_bytes >> 2) &
+			I2SSIZE_TRNMSK) << I2SSIZE_SHIFT);
+	writel(val, idma.regs + I2SSIZE);
+
+	val = readl(idma.regs + I2SAHB);
+	val |= AHB_INTENLVL0;
+	writel(val, idma.regs + I2SAHB);
+
+	return 0;
+}
+
+static void idma_setcallbk(struct snd_pcm_substream *substream,
+				void (*cb)(void *, int))
+{
+	struct idma_ctrl *prtd = substream->runtime->private_data;
+
+	spin_lock(&prtd->lock);
+	prtd->cb = cb;
+	spin_unlock(&prtd->lock);
+}
+
+static void idma_control(int op)
+{
+	u32 val = readl(idma.regs + I2SAHB);
+
+	spin_lock(&idma.lock);
+
+	switch (op) {
+	case LPAM_DMA_START:
+		val |= (AHB_INTENLVL0 | AHB_DMAEN);
+		break;
+	case LPAM_DMA_STOP:
+		val &= ~(AHB_INTENLVL0 | AHB_DMAEN);
+		break;
+	default:
+		spin_unlock(&idma.lock);
+		return;
+	}
+
+	writel(val, idma.regs + I2SAHB);
+	spin_unlock(&idma.lock);
+}
+
+static void idma_done(void *id, int bytes_xfer)
+{
+	struct snd_pcm_substream *substream = id;
+	struct idma_ctrl *prtd = substream->runtime->private_data;
+
+	if (prtd && (prtd->state & ST_RUNNING))
+		snd_pcm_period_elapsed(substream);
+}
+
+static int idma_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct idma_ctrl *prtd = substream->runtime->private_data;
+	u32 mod = readl(idma.regs + I2SMOD);
+	u32 ahb = readl(idma.regs + I2SAHB);
+
+	ahb |= (AHB_DMARLD | AHB_INTMASK);
+	mod |= MOD_TXS_IDMA;
+	writel(ahb, idma.regs + I2SAHB);
+	writel(mod, idma.regs + I2SMOD);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	prtd->start = prtd->pos = runtime->dma_addr;
+	prtd->period = params_periods(params);
+	prtd->periodsz = params_period_bytes(params);
+	prtd->end = runtime->dma_addr + runtime->dma_bytes;
+
+	idma_setcallbk(substream, idma_done);
+
+	return 0;
+}
+
+static int idma_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+
+	return 0;
+}
+
+static int idma_prepare(struct snd_pcm_substream *substream)
+{
+	struct idma_ctrl *prtd = substream->runtime->private_data;
+
+	prtd->pos = prtd->start;
+
+	/* flush the DMA channel */
+	idma_control(LPAM_DMA_STOP);
+	idma_enqueue(substream);
+
+	return 0;
+}
+
+static int idma_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct idma_ctrl *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	spin_lock(&prtd->lock);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		prtd->state |= ST_RUNNING;
+		idma_control(LPAM_DMA_START);
+		break;
+
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		prtd->state &= ~ST_RUNNING;
+		idma_control(LPAM_DMA_STOP);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	spin_unlock(&prtd->lock);
+
+	return ret;
+}
+
+static snd_pcm_uframes_t
+	idma_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct idma_ctrl *prtd = runtime->private_data;
+	dma_addr_t src;
+	unsigned long res;
+
+	spin_lock(&prtd->lock);
+
+	idma_getpos(&src);
+	res = src - prtd->start;
+
+	spin_unlock(&prtd->lock);
+
+	return bytes_to_frames(substream->runtime, res);
+}
+
+static int idma_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long size, offset;
+	int ret;
+
+	/* From snd_pcm_lib_mmap_iomem */
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_flags |= VM_IO;
+	size = vma->vm_end - vma->vm_start;
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+	ret = io_remap_pfn_range(vma, vma->vm_start,
+			(runtime->dma_addr + offset) >> PAGE_SHIFT,
+			size, vma->vm_page_prot);
+
+	return ret;
+}
+
+static irqreturn_t iis_irq(int irqno, void *dev_id)
+{
+	struct idma_ctrl *prtd = (struct idma_ctrl *)dev_id;
+	u32 iiscon, iisahb, val, addr;
+
+	iisahb  = readl(idma.regs + I2SAHB);
+	iiscon  = readl(idma.regs + I2SCON);
+
+	val = (iisahb & AHB_LVL0INT) ? AHB_CLRLVL0INT : 0;
+
+	if (val) {
+		iisahb |= val;
+		writel(iisahb, idma.regs + I2SAHB);
+
+		addr = readl(idma.regs + I2SLVL0ADDR) - idma.lp_tx_addr;
+		addr += prtd->periodsz;
+		addr %= (prtd->end - prtd->start);
+		addr += idma.lp_tx_addr;
+
+		writel(addr, idma.regs + I2SLVL0ADDR);
+
+		if (prtd->cb)
+			prtd->cb(prtd->token, prtd->period);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int idma_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct idma_ctrl *prtd;
+	int ret;
+
+	snd_soc_set_runtime_hwparams(substream, &idma_hardware);
+
+	prtd = kzalloc(sizeof(struct idma_ctrl), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	ret = request_irq(IRQ_I2S0, iis_irq, 0, "i2s", prtd);
+	if (ret < 0) {
+		pr_err("fail to claim i2s irq , ret = %d\n", ret);
+		kfree(prtd);
+		return ret;
+	}
+
+	spin_lock_init(&prtd->lock);
+
+	runtime->private_data = prtd;
+
+	return 0;
+}
+
+static int idma_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct idma_ctrl *prtd = runtime->private_data;
+
+	free_irq(IRQ_I2S0, prtd);
+
+	if (!prtd)
+		pr_err("idma_close called with prtd == NULL\n");
+
+	kfree(prtd);
+
+	return 0;
+}
+
+static struct snd_pcm_ops idma_ops = {
+	.open		= idma_open,
+	.close		= idma_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.trigger	= idma_trigger,
+	.pointer	= idma_pointer,
+	.mmap		= idma_mmap,
+	.hw_params	= idma_hw_params,
+	.hw_free	= idma_hw_free,
+	.prepare	= idma_prepare,
+};
+
+static void idma_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+
+	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (!substream)
+		return;
+
+	buf = &substream->dma_buffer;
+	if (!buf->area)
+		return;
+
+	iounmap(buf->area);
+
+	buf->area = NULL;
+	buf->addr = 0;
+}
+
+static int preallocate_idma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	/* Assign PCM buffer pointers */
+	buf->dev.type = SNDRV_DMA_TYPE_CONTINUOUS;
+	buf->addr = idma.lp_tx_addr;
+	buf->bytes = idma_hardware.buffer_bytes_max;
+	buf->area = (unsigned char *)ioremap(buf->addr, buf->bytes);
+
+	return 0;
+}
+
+static u64 idma_mask = DMA_BIT_MASK(32);
+
+static int idma_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &idma_mask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (dai->driver->playback.channels_min)
+		ret = preallocate_idma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+
+	return ret;
+}
+
+void idma_reg_addr_init(void *regs, dma_addr_t addr)
+{
+	spin_lock_init(&idma.lock);
+	idma.regs = regs;
+	idma.lp_tx_addr = addr;
+}
+
+struct snd_soc_platform_driver asoc_idma_platform = {
+	.ops = &idma_ops,
+	.pcm_new = idma_new,
+	.pcm_free = idma_free,
+};
+
+static int __devinit asoc_idma_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &asoc_idma_platform);
+}
+
+static int __devexit asoc_idma_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver asoc_idma_driver = {
+	.driver = {
+		.name = "samsung-idma",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = asoc_idma_platform_probe,
+	.remove = __devexit_p(asoc_idma_platform_remove),
+};
+
+static int __init asoc_idma_init(void)
+{
+	return platform_driver_register(&asoc_idma_driver);
+}
+module_init(asoc_idma_init);
+
+static void __exit asoc_idma_exit(void)
+{
+	platform_driver_unregister(&asoc_idma_driver);
+}
+module_exit(asoc_idma_exit);
+
+MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
+MODULE_DESCRIPTION("Samsung ASoC IDMA Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/idma.h b/sound/soc/samsung/idma.h
new file mode 100644
index 0000000..4827321
--- /dev/null
+++ b/sound/soc/samsung/idma.h
@@ -0,0 +1,26 @@
+/*
+ * sound/soc/samsung/idma.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *		http://www.samsung.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __SND_SOC_SAMSUNG_IDMA_H_
+#define __SND_SOC_SAMSUNG_IDMA_H_
+
+extern void idma_reg_addr_init(void *regs, dma_addr_t addr);
+
+/* dma_state */
+#define LPAM_DMA_STOP	0
+#define LPAM_DMA_START	1
+
+
+#define MAX_IDMA_BUFFER (128 * 1024)
+
+#endif /* __SND_SOC_SAMSUNG_IDMA_H_ */
-- 
1.7.1
