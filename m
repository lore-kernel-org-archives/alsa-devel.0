From: Raffaele Recalcati <lamiaposta71-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Asoc Davinci Voicecodec: Added support based on
	copy_from_user instead of DMA
Date: Wed, 14 Jul 2010 16:28:10 +0200
Message-ID: <1279117691-5467-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Raffaele Recalcati <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Davide Bonfanti <davide.bonfanti-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>

    Since DM365 has the same DMA event for McBSP and Voicecodec this two
    peripherals cannot be used at the same time.
    This driver implements Voicecodec without the use of a DMA but with
    a copy_from_user.
    There's a buffer of BUF_SIZE (tested with 2KB) bytes in the driver that
    is filled with davinci_pcm_copy.
    When pcm is running, a TIMER interrupt is activated each 1.36ms in
    order to fill HW FIFO (dm_vc_irq).
    BUG: It happens sometimes that the peripheral stops working so there's a
    trap.
    This driver was tested with timer1 and timer4.
    The measures made using a GPIO and scope give a time for copy_from_user
    about 8/10us (triggered by alsa layer) while TIMER interrupt takes 1.5us.

    This patch has been developed against the
    http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
    git tree and tested on bmx board.

Signed-off-by: Davide Bonfanti <davide.bonfanti-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
Signed-off-by: Raffaele Recalcati <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
---
 sound/soc/davinci/Makefile                   |    1 +
 sound/soc/davinci/davinci-pcm-copyfromuser.c |  333 ++++++++++++++++++++++++++
 sound/soc/davinci/davinci-pcm.h              |    1 +
 sound/soc/soc-core.c                         |   31 ++-
 4 files changed, 354 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/davinci/davinci-pcm-copyfromuser.c

diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a93679d..7d6a9a1 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -1,5 +1,6 @@
 # DAVINCI Platform Support
 snd-soc-davinci-objs := davinci-pcm.o
+snd-soc-davinci-objs += davinci-pcm-copyfromuser.o
 snd-soc-davinci-i2s-objs := davinci-i2s.o
 snd-soc-davinci-mcasp-objs:= davinci-mcasp.o
 snd-soc-davinci-vcif-objs:= davinci-vcif.o
diff --git a/sound/soc/davinci/davinci-pcm-copyfromuser.c b/sound/soc/davinci/davinci-pcm-copyfromuser.c
new file mode 100644
index 0000000..df37873
--- /dev/null
+++ b/sound/soc/davinci/davinci-pcm-copyfromuser.c
@@ -0,0 +1,333 @@
+/*
+ *
+ * Copyright (C) 2010 Bticino S.p.a
+ * Author: Davide Bonfanti <davide.bonfanti-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
+ *
+ * Contributors:
+ *     Raffaele Recalcati <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <mach/gpio.h>
+
+#include "davinci-pcm.h"
+
+/* Timer register offsets */
+#define PID12                   0x00
+#define TIM12                   0x10
+#define TIM34                   0x14
+#define PRD12                   0x18
+#define PRD34                   0x1c
+#define TCR                     0x20
+#define TGCR                    0x24
+
+/* Timer register bitfields */
+#define TCR_ENAMODE_DISABLE          0x0
+#define TCR_ENAMODE_ONESHOT          0x1
+#define TCR_ENAMODE_PERIODIC         0x2
+#define TCR_ENAMODE_MASK             0x3
+
+#define TGCR_TIMMODE_SHIFT           2
+#define TGCR_TIMMODE_64BIT_GP        0x0
+#define TGCR_TIMMODE_32BIT_UNCHAINED 0x1
+#define TGCR_TIMMODE_64BIT_WDOG      0x2
+#define TGCR_TIMMODE_32BIT_CHAINED   0x3
+
+#define TGCR_TIM12RS_SHIFT           0
+#define TGCR_TIM34RS_SHIFT           1
+#define TGCR_RESET                   0x0
+#define TGCR_UNRESET                 0x1
+#define TGCR_RESET_MASK              0x3
+
+#define TIMER1_BASE		0x01C21800
+#define TIMER4_BASE		0x01C23800
+
+/* choose the timer to use */
+#define TIMER_BASE		TIMER4_BASE
+/* driver buffer dimension */
+#define BUF_SIZE		2048
+
+#if (TIMER_BASE == TIMER1_BASE)
+#define TINT			IRQ_TINT1_TINT12
+#define TIMER			"timer1"
+#elif (TIMER_BASE == TIMER4_BASE)
+#define TINT                    IRQ_PWMINT2
+#define TIMER			"timer4"
+#endif
+
+int pointer_sub;
+u16 local_buffer[BUF_SIZE/2];
+
+static struct snd_pcm_hardware pcm_hardware_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000),
+	.rate_min = 8000,
+	.rate_max = 8000,
+	.channels_min = 1,
+	.channels_max = 1,
+	.buffer_bytes_max = BUF_SIZE,
+	.period_bytes_min = 512,
+	.period_bytes_max = 512,
+	.periods_min = BUF_SIZE / 512,
+	.periods_max = BUF_SIZE / 512,
+	.fifo_size = 0,
+};
+
+/*
+ * How this driver works...
+ *
+ * Since DM365 have the same DMA event for I2S and Voicecodec this two
+ * peripheralscannot be used at the same time.
+ * This driver implements voicecodec without the use of a DMA but with
+ * a copy_from_user.
+ * There's a buffer of BUF_SIZE bytes in the driver that is filled with
+ * davinci_pcm_copy.
+ * When pcm is running, a TIMER interrupt is activated each 1.36ms in
+ * order to fill HW FIFO (dm_vc_irq).
+ * It happens that the peripheral stop working so there's a trap...
+ * Driver was proved with timer1 and timer4. if timer2 is used the device
+ * resets during power-up. Timer3 have a structure a bit different and,
+ * in fact, doesn't work.
+ * Measures using a GPIO and scope give a time for copy_from_user about
+ * 8/10us while interrupt takes 1.5us
+ */
+
+static snd_pcm_uframes_t
+davinci_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	return pointer_sub;
+}
+
+static int davinci_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct davinci_runtime_data *prtd;
+	struct snd_pcm_hardware *ppcm;
+	int ret = 0;
+	struct davinci_pcm_dma_params *pa;
+	struct davinci_pcm_dma_params *params;
+	struct clk *clk;
+
+	pointer_sub = 0;
+
+/*
+ *	ppcm = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+ *		&pcm_hardware_playback : &pcm_hardware_capture;
+ */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ppcm = &pcm_hardware_playback;
+	else
+		return -ENODEV;
+
+	snd_soc_set_runtime_hwparams(substream, ppcm);
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	__raw_writel(0x0, IO_ADDRESS(0x01D0C008));
+	__raw_writel(0x7400, IO_ADDRESS(0x01D0C004));
+	clk = clk_get(NULL, TIMER);
+	if (!IS_ERR(clk))
+		clk_enable(clk);
+	return 0;
+}
+
+static int davinci_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct clk *clk;
+
+	clk = clk_get(NULL, TIMER);
+	if (!IS_ERR(clk))
+		clk_disable(clk);
+	return 0;
+}
+
+static int davinci_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+static int davinci_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int davinci_pcm_copy(struct snd_pcm_substream *substream, int channel,
+	snd_pcm_uframes_t hwoff, void __user *buf, snd_pcm_uframes_t frames)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (copy_from_user(local_buffer + hwoff, buf,
+	    frames_to_bytes(runtime, frames))) {
+		printk(KERN_ERR "ERROR COPY_FROM_USER\n");
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static struct snd_pcm_ops davinci_pcm_ops = {
+	.open =		davinci_pcm_open,
+	.close =	davinci_pcm_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	davinci_pcm_hw_params,
+	.hw_free =	davinci_pcm_hw_free,
+	.pointer =	davinci_pcm_pointer,
+	.copy =		davinci_pcm_copy,
+};
+
+static u64 davinci_pcm_dmamask = 0xffffffff;
+
+static irqreturn_t dm_vc_irq(int irq, void *sbst)
+{
+	struct snd_pcm_substream *substream =
+			(struct snd_pcm_substream *) sbst;
+	int fifo, diff, per_size, buf_size;
+	static int last_ptr;
+
+	if (substream->runtime && substream->runtime->status &&
+	    snd_pcm_running(substream)) {
+		fifo = __raw_readl(IO_ADDRESS(0x01D0C028));
+		fifo = (fifo & 0x1f00) >> 8;
+		if (fifo == 15) {
+			/* peripheral blocked! restart */
+			__raw_writel(0, IO_ADDRESS(0x01D0C004));
+			__raw_writel(0x5400, IO_ADDRESS(0x01D0C004));
+		}
+		buf_size = substream->runtime->buffer_size;
+		per_size = substream->runtime->period_size;
+		for (; fifo < 0x10; fifo++) {
+			__raw_writew(local_buffer[pointer_sub++],
+				     IO_ADDRESS(0x01D0C024));
+			pointer_sub %= buf_size;
+			do {
+				diff = __raw_readl(IO_ADDRESS(0x01D0C00C));
+			} while (!(diff & 0x8));
+		}
+		if (last_ptr >= pointer_sub)
+			diff = buf_size + pointer_sub - last_ptr;
+		else
+			diff = pointer_sub - last_ptr;
+		if (diff >= per_size) {
+			snd_pcm_period_elapsed(substream);
+			last_ptr += per_size;
+			if (last_ptr >= buf_size)
+				last_ptr -= buf_size;
+		}
+	} else
+		last_ptr = 0;
+	return IRQ_HANDLED;
+}
+
+static int davinci_pcm_new(struct snd_card *card,
+			   struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int tcr, tgcr;
+	struct snd_dma_buffer *buf;
+	struct snd_pcm_substream *substream;
+	struct clk *clk;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &davinci_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+		buf = &substream->dma_buffer;
+		buf->dev.type = SNDRV_DMA_TYPE_DEV;
+		buf->dev.dev = pcm->card->dev;
+		buf->private_data = NULL;
+		buf->bytes = pcm_hardware_playback.buffer_bytes_max;
+	}
+	clk = clk_get(NULL, TIMER);
+	if (IS_ERR(clk))
+		printk(KERN_ERR "ERROR getting timer\n");
+
+	/* Disabled, Internal clock source */
+	__raw_writel(0, IO_ADDRESS(TIMER_BASE + TCR));
+
+	/* reset both timers, no pre-scaler for timer34 */
+	tgcr = 0;
+	__raw_writel(tgcr, IO_ADDRESS(TIMER_BASE + TGCR));
+
+	/* Set both timers to unchained 32-bit */
+	tgcr = TGCR_TIMMODE_32BIT_UNCHAINED << TGCR_TIMMODE_SHIFT;
+	__raw_writel(tgcr, IO_ADDRESS(TIMER_BASE + TGCR));
+
+	/* Unreset timers */
+	tgcr |= (TGCR_UNRESET << TGCR_TIM12RS_SHIFT);
+	__raw_writel(tgcr, IO_ADDRESS(TIMER_BASE + TGCR));
+
+	/* Init both counters to zero */
+	__raw_writel(0, IO_ADDRESS(TIMER_BASE + TIM12));
+	tcr = __raw_readl(IO_ADDRESS(TIMER_BASE + TCR));
+
+	/* disable timer */
+	tcr &= ~(TCR_ENAMODE_MASK << 6);
+	__raw_writel(tcr, IO_ADDRESS(TIMER_BASE + TCR));
+
+	/* reset counter to zero, set new period */
+	__raw_writel(0, IO_ADDRESS(TIMER_BASE + TIM12));
+	__raw_writel(0x8000, IO_ADDRESS(TIMER_BASE + PRD12));
+
+	/* Set enable mode */
+	tcr |= TCR_ENAMODE_PERIODIC << 6;
+	__raw_writel(tcr, IO_ADDRESS(TIMER_BASE + TCR));
+
+#if (TIMER_BASE == TIMER4_BASE)
+	__raw_writel(__raw_readl(IO_ADDRESS(0x01c40018)) |
+		     0x1000, IO_ADDRESS(0x01c40018));
+#endif
+	if (request_irq(TINT, dm_vc_irq, IRQF_TIMER, "VOICE-TOUT", substream))
+		printk(KERN_ERR "%s ERROR requesting Interrupt\n", __func__);
+	return 0;
+}
+
+struct snd_soc_platform davinci_soc_platform_copy = {
+	.name =		"davinci-audio-copy",
+	.pcm_ops =	&davinci_pcm_ops,
+	.pcm_new =	davinci_pcm_new,
+}; EXPORT_SYMBOL_GPL(davinci_soc_platform_copy);
+
+static int __init davinci_soc_copy_platform_init(void)
+{
+	return snd_soc_register_platform(&davinci_soc_platform_copy);
+}
+module_init(davinci_soc_copy_platform_init);
+
+static void __exit davinci_soc_copy_platform_exit(void)
+{
+	snd_soc_unregister_platform(&davinci_soc_platform_copy);
+}
+module_exit(davinci_soc_copy_platform_exit);
+
+MODULE_AUTHOR("bticino s.p.a.");
+MODULE_DESCRIPTION("TI DAVINCI PCM copy_from_user module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 0764944..cb7c2aa 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -29,5 +29,6 @@ struct davinci_pcm_dma_params {
 
 
 extern struct snd_soc_platform davinci_soc_platform;
+extern struct snd_soc_platform davinci_soc_platform_copy;
 
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad7f952..696e8b3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -801,7 +801,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 	return 0;
 }
-
+#if 0
 /* ASoC PCM operations */
 static struct snd_pcm_ops soc_pcm_ops = {
 	.open		= soc_pcm_open,
@@ -811,7 +811,7 @@ static struct snd_pcm_ops soc_pcm_ops = {
 	.prepare	= soc_pcm_prepare,
 	.trigger	= soc_pcm_trigger,
 };
-
+#endif
 #ifdef CONFIG_PM
 /* powers down audio subsystem for suspend */
 static int soc_suspend(struct device *dev)
@@ -1306,6 +1306,7 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
+	struct snd_pcm_ops *soc_pcm_ops;
 
 	rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime), GFP_KERNEL);
 	if (rtd == NULL)
@@ -1335,19 +1336,25 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 
 	dai_link->pcm = pcm;
 	pcm->private_data = rtd;
-	soc_pcm_ops.mmap = platform->pcm_ops->mmap;
-	soc_pcm_ops.pointer = platform->pcm_ops->pointer;
-	soc_pcm_ops.ioctl = platform->pcm_ops->ioctl;
-	soc_pcm_ops.copy = platform->pcm_ops->copy;
-	soc_pcm_ops.silence = platform->pcm_ops->silence;
-	soc_pcm_ops.ack = platform->pcm_ops->ack;
-	soc_pcm_ops.page = platform->pcm_ops->page;
+	soc_pcm_ops = kmalloc(sizeof(struct snd_pcm_ops), GFP_KERNEL);
+	soc_pcm_ops->open		= soc_pcm_open;
+	soc_pcm_ops->close		= soc_codec_close;
+	soc_pcm_ops->hw_params	= soc_pcm_hw_params;
+	soc_pcm_ops->hw_free	= soc_pcm_hw_free;
+	soc_pcm_ops->prepare	= soc_pcm_prepare;
+	soc_pcm_ops->trigger	= soc_pcm_trigger;
+	soc_pcm_ops->mmap = platform->pcm_ops->mmap;
+	soc_pcm_ops->pointer = platform->pcm_ops->pointer;
+	soc_pcm_ops->ioctl = platform->pcm_ops->ioctl;
+	soc_pcm_ops->copy = platform->pcm_ops->copy;
+	soc_pcm_ops->silence = platform->pcm_ops->silence;
+	soc_pcm_ops->ack = platform->pcm_ops->ack;
+	soc_pcm_ops->page = platform->pcm_ops->page;
 
 	if (playback)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
-
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);
 	if (capture)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);
 
 	ret = platform->pcm_new(codec->card, codec_dai, pcm);
 	if (ret < 0) {
-- 
1.7.0.4
