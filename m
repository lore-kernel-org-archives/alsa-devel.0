From: Michael Zoran <mzoran@crowfest.net>
Subject: [RESEND RFC PATCH] sound: bcm2835-analog-audio: Add
	driver for bcm2835(Raspberry PI) headphone jack.
Date: Tue,  7 Mar 2017 17:19:45 -0800
Message-ID: <20170308011945.31394-1-mzoran@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw.crowfest.net (gw.crowfest.net [52.42.241.221])
 by alsa0.perex.cz (Postfix) with ESMTP id C88CA2666C5
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 02:19:58 +0100 (CET)
Received: from mail.crowfest.net (unknown [192.168.1.2])
 by gw.crowfest.net (Postfix) with ESMTP id 902B06013B
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 17:19:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Michael Zoran <mzoran@crowfest.net>
List-Id: alsa-devel@alsa-project.org

I tried sending this a few times, but I'm not sure it made it through to the 
e-mail list.

Someone on the internet mentioned that if we have a HDMI Audio driver, why not
have a driver for the headphone/analog jack on the Raspberry PI that doesn't
use the firmware.  So I quickly make up a prototype that isn't submit quality 
yet, but is very functional.  The idea is to like the firmware, just use the
PWM of the bcm2835 to generate the audio.

Questions:

1. Is this something that people would want in the upstream kernel and
would be seriously considered for submission?

2. Is it a complete deal breaker that the driver is a regular ALSA driver 
instead of a ASoC driver?

TODO(Things I will do before submitting for real):

1. I found several people on the Internet that have written bare metal applications
to do the same thing as this driver.  One thing they all typically have is more
signal conditioning(higher hardware bitrates, noise shaping filters, support For
multiple software formats).

2. The DMA engine doesn't have support for bus priorities even though the hardware
supports it.  It might be good to put support for this in the DMA engine driver
since it might be required for HDMI audio as well.

3. Checkpatch.pl/Formatting issues.


---
 arch/arm/boot/dts/bcm283x.dtsi   |  19 ++
 drivers/dma/bcm2835-dma.c        |  33 ++-
 sound/arm/Kconfig                |  10 +-
 sound/arm/Makefile               |   3 +
 sound/arm/bcm2835-analog-audio.c | 585 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 641 insertions(+), 9 deletions(-)
 create mode 100644 sound/arm/bcm2835-analog-audio.c

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9798bc9293d8..0810931addd8 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -338,6 +338,12 @@
 				brcm,pins = <42 43>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
+
+			analog_audio_pins: analog_audio_pins {
+				brcm,pins = <40 45>;
+				brcm,function = <4 4>; /* Alt0 */
+			};
+
 		};
 
 		uart0: serial@7e201000 {
@@ -464,6 +470,19 @@
 			status = "disabled";
 		};
 
+		analogaudio: analogaudio@7e20c000 {
+			compatible = "brcm,bcm2835-analog-audio";
+			reg = <0x7e20c000 0x28>;
+			clocks = <&clocks BCM2835_CLOCK_PWM>;
+			assigned-clocks = <&clocks BCM2835_CLOCK_PWM>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&analog_audio_pins>;
+			assigned-clock-rates = <250000000>;
+
+			dmas = <&dma 5>;
+			dma-names = "tx";
+		};
+
 		sdhci: sdhci@7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6204cc32d09c..73b50009ea4b 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -179,6 +179,17 @@ struct bcm2835_desc {
 #define MAX_DMA_LEN SZ_1G
 #define MAX_LITE_DMA_LEN (SZ_64K - 4)
 
+static inline u32 bcm2835_get_priority(struct bcm2835_chan *c)
+{
+	if (c->dreq != 5)
+		return BCM2835_DMA_PRIORITY(0) | BCM2835_DMA_PANIC_PRIORITY(0);
+
+	else  {
+//		printk( KERN_ERR "Setting priority to 15 for DRAQ 5");
+		return BCM2835_DMA_PRIORITY(15) | BCM2835_DMA_PANIC_PRIORITY(15);
+	}
+}
+
 static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
 {
 	/* lite and normal channels have different max frame length */
@@ -465,7 +476,7 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
 
 	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
-	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
+	writel(BCM2835_DMA_ACTIVE | bcm2835_get_priority(c), c->chan_base + BCM2835_DMA_CS);
 }
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
@@ -485,24 +496,30 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 
-	/* Acknowledge interrupt */
-	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
-
 	d = c->desc;
 
 	if (d) {
 		if (d->cyclic) {
+
+			/* Acknowledge interrupt */
+			writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE | bcm2835_get_priority(c), c->chan_base + BCM2835_DMA_CS);
+
 			/* call the cyclic callback */
 			vchan_cyclic_callback(&d->vd);
-
-			/* Keep the DMA engine running */
-			writel(BCM2835_DMA_ACTIVE,
-			       c->chan_base + BCM2835_DMA_CS);
 		} else {
+
+			/* Acknowledge interrupt */
+			writel(BCM2835_DMA_INT | bcm2835_get_priority(c), c->chan_base + BCM2835_DMA_CS);
+
 			vchan_cookie_complete(&c->desc->vd);
 			bcm2835_dma_start_desc(c);
 		}
 	}
+ 	else
+	{
+		/* Acknowledge interrupt */
+		writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
+	}
 
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 65171f6657a2..71aef1dae6b8 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -2,7 +2,7 @@
 
 menuconfig SND_ARM
 	bool "ARM sound devices"
-	depends on ARM
+	depends on ARM || ARM64
 	default y
 	help
 	  Support for sound devices specific to ARM architectures.
@@ -11,6 +11,14 @@ menuconfig SND_ARM
 
 if SND_ARM
 
+config SND_BCM2835_ANALOG_AUDIO
+	tristate "Analog/Headphone jack support for BCM2835"
+	depends on ARCH_BCM2835 && HAS_DMA
+	select SND_PCM
+	help
+	    Say y or m to support the analog/headphone jack
+	    for the BCM2835 as used by the Raspberry PI.
+
 config SND_ARMAACI
 	tristate "ARM PrimeCell PL041 AC Link support"
 	depends on ARM_AMBA
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 8c0c851d4641..744ff77e580a 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -14,3 +14,6 @@ snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o
 
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
+
+obj-$(CONFIG_SND_BCM2835_ANALOG_AUDIO) += bcm2835-analog-audio.o
+
diff --git a/sound/arm/bcm2835-analog-audio.c b/sound/arm/bcm2835-analog-audio.c
new file mode 100644
index 000000000000..b04dbe068ecd
--- /dev/null
+++ b/sound/arm/bcm2835-analog-audio.c
@@ -0,0 +1,585 @@
+/*
+ * Michael Zoran <mzoran@crowfest.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <sound/dmaengine_pcm.h>
+#include <linux/of_address.h>
+#include <linux/dma-mapping.h>
+
+/*
+ * The channel order that needs to be passed to the PWM FIFO is opposite the
+ * order that is passed by the application.  So the order needs to be flipped
+ * in software.
+ */
+
+
+struct bcm2835_hardware_frame
+{
+	u32 right;
+	u32 left;
+};
+
+struct bcm2835_software_frame
+{
+	s16 left;
+	s16 right;
+};
+
+#define HARDWARE_BUFFER_FRAMES_PER_PERIOD 720
+#define HARDWARE_BUFFER_PERIODS_PER_BUFFER 2
+#define HARDWARE_BUFFER_PERIOD_BYTES (sizeof(struct bcm2835_hardware_frame) * \
+				      HARDWARE_BUFFER_FRAMES_PER_PERIOD)
+#define HARDWARE_BUFFER_BYTES (HARDWARE_BUFFER_PERIOD_BYTES * \
+			       HARDWARE_BUFFER_PERIODS_PER_BUFFER )
+
+struct bcm2835_chip;
+
+struct bcm2835_chip_runtime {
+	struct bcm2835_chip *chip;
+	struct snd_pcm_substream *substream;
+	struct dma_slave_config dma_slave_config;
+	struct dma_async_tx_descriptor *dma_desc;
+	dma_cookie_t dma_cookie;
+	struct bcm2835_hardware_frame *hardware_buffer;
+	dma_addr_t hardware_buffer_dma;
+	int hardware_period_number;
+	struct bcm2835_software_frame *playback_src_buffer;
+	snd_pcm_uframes_t playback_src_pos;
+	snd_pcm_uframes_t playback_src_frames_this_period;
+};
+
+struct bcm2835_chip {
+	struct platform_device *pdev;
+	struct device *dev;
+	spinlock_t spinlock;
+	void __iomem *base;
+	struct clk *clk;
+	int clk_enabled;
+	struct dma_chan *dma_channel;
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	struct bcm2835_chip_runtime *runtime;
+};
+
+static u32 convert_audio_data(s16 input)
+{
+	s32 output;
+	output = ((s32) input * (s32) (5120 / 2)) / (s32) 32762;
+
+	return(u32) (output + (5120 / 2));
+}
+
+static void convert_dma_buffer(struct bcm2835_chip_runtime *chip_runtime)
+{
+	snd_pcm_uframes_t i;
+	snd_pcm_uframes_t hardware_start_pos =
+		chip_runtime->hardware_period_number *
+		HARDWARE_BUFFER_FRAMES_PER_PERIOD;
+	snd_pcm_uframes_t buffer_size =
+		chip_runtime->substream->runtime->buffer_size;
+
+	for (i = 0; i < HARDWARE_BUFFER_FRAMES_PER_PERIOD; i++) {
+		volatile struct bcm2835_software_frame *soft_frame;
+		volatile struct bcm2835_hardware_frame *hard_frame;
+
+		hard_frame = chip_runtime->hardware_buffer + hardware_start_pos + i;
+		soft_frame = chip_runtime->playback_src_buffer +
+			chip_runtime->playback_src_pos;
+
+		hard_frame->left = convert_audio_data(soft_frame->left);
+		hard_frame->right = convert_audio_data(soft_frame->right);
+
+		if (chip_runtime->playback_src_pos >= buffer_size - 1)
+			chip_runtime->playback_src_pos = 0;
+		else
+			chip_runtime->playback_src_pos++;
+	}
+}
+
+static void dma_complete(void *arg)
+{
+	struct bcm2835_chip_runtime *chip_runtime = arg;
+	struct bcm2835_chip *chip = chip_runtime->chip;
+	unsigned long flags;
+	bool period_elapsed = false;
+
+	spin_lock_irqsave(&chip->spinlock, flags);
+
+	chip_runtime->hardware_period_number++;
+	if (chip_runtime->hardware_period_number >=
+		HARDWARE_BUFFER_PERIODS_PER_BUFFER)
+		chip_runtime->hardware_period_number = 0;
+
+	chip_runtime->playback_src_frames_this_period +=
+		HARDWARE_BUFFER_FRAMES_PER_PERIOD;
+	if (chip_runtime->playback_src_frames_this_period >=
+		chip_runtime->substream->runtime->period_size) {
+		chip_runtime->playback_src_frames_this_period = 0;
+		period_elapsed = true;
+	}
+
+	convert_dma_buffer(chip_runtime);
+
+	spin_unlock_irqrestore(&chip->spinlock, flags);
+
+	if (period_elapsed)
+		snd_pcm_period_elapsed(chip_runtime->substream);
+}
+
+static struct snd_pcm_hardware snd_bcm2835_playback_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.rates = SNDRV_PCM_RATE_48000,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 4 * 1024,
+	.period_bytes_max = 128 * 1024,
+	.periods_min = 1,
+	.periods_max = 128 / 4,
+	.fifo_size = 0,
+
+};
+
+static void snd_bcm2835_playback_free(struct snd_pcm_runtime *runtime)
+{
+	kfree(runtime->private_data);
+	runtime->private_data = NULL;
+}
+
+static int snd_bcm2835_playback_open(struct snd_pcm_substream *substream)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct bcm2835_chip_runtime *chip_runtime;
+	int err;
+
+	chip_runtime = kzalloc(sizeof(*chip_runtime), GFP_KERNEL);
+
+	runtime->hw = snd_bcm2835_playback_hw;
+	runtime->private_data = chip_runtime;
+	runtime->private_free = snd_bcm2835_playback_free;
+
+	chip->runtime = chip_runtime;
+
+	chip_runtime->chip = chip;
+	chip_runtime->substream = substream;
+
+	if (!chip->clk_enabled) {
+
+		clk_set_rate(chip->clk, 250000000);
+		err = clk_prepare_enable(chip->clk);
+		if (err) {
+			kfree(chip_runtime);
+			return err;
+		}
+	}
+
+	chip->clk_enabled++;
+	return 0;
+}
+
+static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+
+	writel(0x00, chip->base + 0x00);
+	writel(0x00, chip->base + 0x08);
+
+	chip->runtime = NULL;
+
+	if (chip->clk_enabled) {
+		clk_disable_unprepare(chip->clk);
+		chip->clk_enabled--;
+	}
+
+	return 0;
+}
+
+static int snd_bcm2835_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+	struct bcm2835_chip_runtime *chip_runtime = chip->runtime;
+	int ret;
+
+	if (chip_runtime->dma_cookie) {
+		dmaengine_terminate_async(chip->dma_channel);
+		chip_runtime->dma_cookie = 0;
+	}
+
+	writel(0x00, chip->base + 0x00);
+	writel(0x00, chip->base + 0x08);
+
+	if (chip_runtime->hardware_buffer) {
+		dma_free_coherent(chip->dma_channel->device->dev,
+			HARDWARE_BUFFER_BYTES,
+			chip_runtime->hardware_buffer,
+			chip_runtime->hardware_buffer_dma);
+	}
+
+	memset(chip_runtime, 0, sizeof(*chip_runtime));
+
+	chip_runtime->chip = chip;
+	chip_runtime->substream = substream;
+
+	ret = snd_pcm_lib_free_pages(substream);
+	return ret;
+}
+
+static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+	struct bcm2835_chip_runtime *chip_runtime = chip->runtime;
+	snd_pcm_uframes_t playback_src_buffer_frames;
+	snd_pcm_uframes_t playback_src_period_frames;
+	int err = 0;
+
+	snd_bcm2835_pcm_hw_free(substream);
+
+	playback_src_buffer_frames = params_buffer_bytes(params) / 4;
+	playback_src_period_frames = params_period_bytes(params) / 4;
+
+	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	if (err < 0) {
+		snd_bcm2835_pcm_hw_free(substream);
+		return err;
+	}
+
+	chip_runtime->playback_src_buffer =
+		(struct bcm2835_software_frame *) (substream->runtime->dma_area);
+	chip_runtime->playback_src_pos = 0;
+	chip_runtime->playback_src_frames_this_period = 0;
+
+	chip_runtime->hardware_buffer =
+		dma_alloc_coherent(chip->dma_channel->device->dev,
+		HARDWARE_BUFFER_BYTES,
+		&chip_runtime->hardware_buffer_dma,
+		GFP_KERNEL);
+
+	if (!chip_runtime->hardware_buffer) {
+		snd_bcm2835_pcm_hw_free(substream);
+		return -ENOMEM;
+	}
+
+	memset(chip_runtime->hardware_buffer, 0, HARDWARE_BUFFER_BYTES);
+	chip_runtime->hardware_period_number = 0;
+
+	chip_runtime->dma_slave_config.direction = DMA_MEM_TO_DEV;
+	chip_runtime->dma_slave_config.dst_addr = 0x7e20c000 + 0x18;
+	chip_runtime->dma_slave_config.dst_maxburst = 2;
+	chip_runtime->dma_slave_config.dst_addr_width = 4;
+	chip_runtime->dma_slave_config.src_addr =
+		chip_runtime->hardware_buffer_dma;
+	chip_runtime->dma_slave_config.src_maxburst = 2;
+	chip_runtime->dma_slave_config.src_addr_width = 4;
+
+	err = dmaengine_slave_config(chip->dma_channel,
+		&chip_runtime->dma_slave_config);
+
+	if (err < 0) {
+		snd_bcm2835_pcm_hw_free(substream);
+		return err;
+	}
+
+	chip_runtime->dma_desc =
+		dmaengine_prep_dma_cyclic(chip->dma_channel,
+		chip_runtime->hardware_buffer_dma,
+		HARDWARE_BUFFER_BYTES,
+		HARDWARE_BUFFER_PERIOD_BYTES,
+		DMA_MEM_TO_DEV,
+		DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+
+	if (!chip_runtime->dma_desc) {
+		snd_bcm2835_pcm_hw_free(substream);
+		return -ENOMEM;
+	}
+
+	chip_runtime->dma_desc->callback = dma_complete;
+	chip_runtime->dma_desc->callback_param = chip_runtime;
+
+	return 0;
+}
+
+static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+	struct bcm2835_chip_runtime *chip_runtime = chip->runtime;
+
+	memset(chip_runtime->hardware_buffer, 0x8000, HARDWARE_BUFFER_BYTES);
+	chip_runtime->hardware_period_number =
+		(HARDWARE_BUFFER_PERIODS_PER_BUFFER - 1);
+
+	chip_runtime->playback_src_buffer =
+		(struct bcm2835_software_frame *) (substream->runtime->dma_area);
+	chip_runtime->playback_src_pos = 0;
+	chip_runtime->playback_src_frames_this_period = 0;
+
+	memset(chip_runtime->playback_src_buffer, 0,
+		substream->runtime->buffer_size *
+		sizeof(*(chip_runtime->playback_src_buffer)));
+
+	return 0;
+}
+
+static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+	struct bcm2835_chip_runtime *chip_runtime = chip->runtime;
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->spinlock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (!chip_runtime->dma_cookie) {
+			convert_dma_buffer(chip_runtime);
+			chip_runtime->playback_src_frames_this_period =
+				HARDWARE_BUFFER_FRAMES_PER_PERIOD;
+
+			writel(5120, chip->base + 0x10);
+			writel(5120, chip->base + 0x20);
+			writel(0xa1e1, chip->base + 0x00);
+			writel(0x80000606, chip->base + 0x08);
+
+			chip_runtime->dma_cookie =
+				dmaengine_submit(chip_runtime->dma_desc);
+			dma_async_issue_pending(chip->dma_channel);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (chip_runtime->dma_cookie) {
+			dmaengine_terminate_async(chip->dma_channel);
+			chip_runtime->dma_cookie = 0;
+
+			writel(0x00, chip->base + 0x00);
+			writel(0x00, chip->base + 0x08);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&chip->spinlock, flags);
+
+	return ret;
+}
+
+static snd_pcm_uframes_t
+snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
+	struct bcm2835_chip_runtime *chip_runtime = chip->runtime;
+	snd_pcm_uframes_t ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->spinlock, flags);
+	ret = chip_runtime->playback_src_pos;
+	spin_unlock_irqrestore(&chip->spinlock, flags);
+
+	return ret;
+}
+
+static struct snd_pcm_ops snd_bcm2835_playback_ops = {
+	.open = snd_bcm2835_playback_open,
+	.close = snd_bcm2835_playback_close,
+	.ioctl =  snd_pcm_lib_ioctl,
+	.hw_params = snd_bcm2835_pcm_hw_params,
+	.hw_free = snd_bcm2835_pcm_hw_free,
+	.prepare = snd_bcm2835_pcm_prepare,
+	.trigger = snd_bcm2835_pcm_trigger,
+	.pointer = snd_bcm2835_pcm_pointer,
+};
+
+static int snd_bcm2835_new_pcm(struct bcm2835_chip * chip)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(chip->card, "BCM2835 Analog", 0, 1, 0, &pcm);
+
+	if (err < 0)
+		return err;
+
+	pcm->private_data = chip;
+	strcpy(pcm->name, "BCM2835 Analog");
+	chip->pcm = pcm;
+
+	/* set operators */
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+		&snd_bcm2835_playback_ops);
+
+	/* pre-allocation of buffers */
+	/* NOTE: this may fail */
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+		snd_dma_continuous_data(GFP_KERNEL),
+		snd_bcm2835_playback_hw.buffer_bytes_max,
+		snd_bcm2835_playback_hw.buffer_bytes_max);
+
+	return 0;
+}
+
+static int snd_bcm2835_free(struct bcm2835_chip * chip)
+{
+	if (chip->dma_channel)
+		dma_release_channel(chip->dma_channel);
+
+	return 0;
+}
+
+static int snd_bcm2835_dev_free(struct snd_device *device)
+{
+	return snd_bcm2835_free(device->device_data);
+}
+
+static struct snd_device_ops snd_bcm2835_dev_ops = {
+	.dev_free = snd_bcm2835_dev_free,
+};
+
+static int snd_bcm2835_create(struct snd_card *card,
+	struct platform_device *pdev,
+	struct bcm2835_chip ** rchip)
+{
+	struct bcm2835_chip *chip;
+	struct resource *res;
+	int err;
+
+	*rchip = NULL;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->pdev = pdev;
+	chip->dev = &pdev->dev;
+	chip->card = card;
+
+	spin_lock_init(&chip->spinlock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	chip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(chip->base))
+		return PTR_ERR(chip->base);
+
+	chip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(chip->clk)) {
+		dev_err(&pdev->dev, "clock not found: %ld\n",
+			PTR_ERR(chip->clk));
+		return PTR_ERR(chip->clk);
+	}
+
+	chip->dma_channel = dma_request_slave_channel(&pdev->dev, "tx");
+
+	if (!chip->dma_channel)
+		return -ENOMEM;
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip,
+		&snd_bcm2835_dev_ops);
+
+	if (err < 0) {
+		snd_bcm2835_free(chip);
+		return err;
+	}
+
+	*rchip = chip;
+	return 0;
+}
+
+static int bcm2835_analog_audio_probe(struct platform_device *pdev)
+{
+	struct snd_card *card;
+
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct bcm2835_chip * chip;
+
+	ret = snd_card_new(&pdev->dev, -1, NULL, THIS_MODULE, 0, &card);
+	if (ret) {
+		dev_err(dev, "Failed to create sound card structure\n");
+		return ret;
+	}
+
+	ret = snd_bcm2835_create(card, pdev, &chip);
+	if (ret < 0) {
+		dev_err(dev, "Failed to create bcm2835 chip\n");
+		return ret;
+	}
+
+	snd_card_set_dev(card, dev);
+	strcpy(card->driver, "BCM2835 Analog");
+	strcpy(card->shortname, "BCM2835 Analog");
+	sprintf(card->longname, "%s", card->shortname);
+
+	ret = snd_bcm2835_new_pcm(chip);
+	if (ret < 0) {
+		snd_card_free(card);
+		return ret;
+	}
+
+	ret = snd_card_register(card);
+	if (ret < 0) {
+		snd_card_free(card);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, card);
+
+	dev_info(dev, "BCM2835 Analog Audio Initialized\n");
+
+	return 0;
+}
+
+static int bcm2835_analog_audio_remove(struct platform_device *pdev)
+{
+	struct snd_card *card;
+
+	card = platform_get_drvdata(pdev);
+
+	if (card)
+		snd_card_free(card);
+
+	return 0;
+}
+
+static const struct of_device_id bcm2835_analog_audio_of_match[] = {
+	{ .compatible = "brcm,bcm2835-analog-audio",},
+	{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, bcm2835_analog_audio_of_match);
+
+static struct platform_driver bcm2835_analog_audio_driver = {
+	.driver =
+	{
+		.owner = THIS_MODULE,
+		.name = "bcm2835-analog-audio",
+		.of_match_table = bcm2835_analog_audio_of_match,
+	},
+	.probe = bcm2835_analog_audio_probe,
+	.remove = bcm2835_analog_audio_remove,
+};
+module_platform_driver(bcm2835_analog_audio_driver);
+
+MODULE_AUTHOR("Michael Zoran");
+MODULE_DESCRIPTION("Audio driver for analog output on the BCM2835 chip");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bcm2835-analog-audio");
-- 
2.11.0
