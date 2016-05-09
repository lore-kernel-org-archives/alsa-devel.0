From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v3] ASoC: rt5514: add rt5514 SPI driver
Date: Mon, 9 May 2016 18:30:55 +0800
Message-ID: <1462789855-23485-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6987126062E
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:31:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The device has multiple control interfaces, I2C and SPI. The I2C interface
mainly controls the register settings of codec. The SPI interface is in
order to provide the high speed transmission of data. For example, high
bandwidth memory read/write of DSP. The patch adds the rt5514 SPI driver
for loading the firmware of DSP and retrieving the voice data from DSP
after the system is waked up by specific voice.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/Kconfig      |   3 +
 sound/soc/codecs/Makefile     |   2 +
 sound/soc/codecs/rt5514-spi.c | 457 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5514-spi.h |  38 ++++
 sound/soc/codecs/rt5514.c     | 134 ++++++++++++-
 sound/soc/codecs/rt5514.h     |   4 +
 6 files changed, 637 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/rt5514-spi.c
 create mode 100644 sound/soc/codecs/rt5514-spi.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c6f86ef..90749d2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -639,6 +639,9 @@ config SND_SOC_RT298
 config SND_SOC_RT5514
 	tristate
 
+config SND_SOC_RT5514_SPI
+	tristate
+
 config SND_SOC_RT5616
 	tristate "Realtek RT5616 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 94873ee..9ab7016 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -99,6 +99,7 @@ snd-soc-rl6347a-objs := rl6347a.o
 snd-soc-rt286-objs := rt286.o
 snd-soc-rt298-objs := rt298.o
 snd-soc-rt5514-objs := rt5514.o
+snd-soc-rt5514-spi-objs := rt5514-spi.o
 snd-soc-rt5616-objs := rt5616.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
@@ -312,6 +313,7 @@ obj-$(CONFIG_SND_SOC_RL6347A)	+= snd-soc-rl6347a.o
 obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
 obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
+obj-$(CONFIG_SND_SOC_RT5514_SPI)	+= snd-soc-rt5514-spi.o
 obj-$(CONFIG_SND_SOC_RT5616)	+= snd-soc-rt5616.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
new file mode 100644
index 0000000..32b5fb6
--- /dev/null
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -0,0 +1,457 @@
+/*
+ * rt5514-spi.c  --  RT5514 SPI driver
+ *
+ * Copyright 2015 Realtek Semiconductor Corp.
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/spi/spi.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_qos.h>
+#include <linux/sysfs.h>
+#include <linux/clk.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "rt5514-spi.h"
+
+static struct spi_device *rt5514_spi;
+
+struct rt5514_dsp {
+	struct device *dev;
+	struct delayed_work copy_work;
+	struct mutex dma_lock;
+	struct snd_pcm_substream *substream;
+	unsigned int buf_base, buf_limit, buf_rp;
+	size_t buf_size;
+	size_t dma_offset;
+	size_t dsp_offset;
+};
+
+static const struct snd_pcm_hardware rt5514_spi_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.period_bytes_min	= PAGE_SIZE,
+	.period_bytes_max	= 0x20000 / 8,
+	.periods_min		= 8,
+	.periods_max		= 8,
+	.channels_min		= 1,
+	.channels_max		= 1,
+	.buffer_bytes_max	= 0x20000,
+};
+
+static struct snd_soc_dai_driver rt5514_spi_dai = {
+	.name = "rt5514-dsp-cpu-dai",
+	.id = 0,
+	.capture = {
+		.stream_name = "DSP Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
+static void rt5514_spi_copy_work(struct work_struct *work)
+{
+	struct rt5514_dsp *rt5514_dsp =
+		container_of(work, struct rt5514_dsp, copy_work.work);
+	struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
+	size_t period_bytes, truncated_bytes = 0;
+
+	mutex_lock(&rt5514_dsp->dma_lock);
+	if (!rt5514_dsp->substream) {
+		dev_err(rt5514_dsp->dev, "No pcm substream\n");
+		goto done;
+	}
+
+	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
+
+	if (rt5514_dsp->buf_size - rt5514_dsp->dsp_offset <  period_bytes)
+		period_bytes = rt5514_dsp->buf_size - rt5514_dsp->dsp_offset;
+
+	if (rt5514_dsp->buf_rp + period_bytes <= rt5514_dsp->buf_limit) {
+		rt5514_spi_burst_read(rt5514_dsp->buf_rp,
+			runtime->dma_area + rt5514_dsp->dma_offset,
+			period_bytes);
+
+		if (rt5514_dsp->buf_rp + period_bytes == rt5514_dsp->buf_limit)
+			rt5514_dsp->buf_rp = rt5514_dsp->buf_base;
+		else
+			rt5514_dsp->buf_rp += period_bytes;
+	} else {
+		truncated_bytes = rt5514_dsp->buf_limit - rt5514_dsp->buf_rp;
+		rt5514_spi_burst_read(rt5514_dsp->buf_rp,
+			runtime->dma_area + rt5514_dsp->dma_offset,
+			truncated_bytes);
+
+		rt5514_spi_burst_read(rt5514_dsp->buf_base,
+			runtime->dma_area + rt5514_dsp->dma_offset +
+			truncated_bytes, period_bytes - truncated_bytes);
+
+			rt5514_dsp->buf_rp = rt5514_dsp->buf_base +
+				period_bytes - truncated_bytes;
+	}
+
+	rt5514_dsp->dma_offset += period_bytes;
+	if (rt5514_dsp->dma_offset >= runtime->dma_bytes)
+		rt5514_dsp->dma_offset = 0;
+
+	rt5514_dsp->dsp_offset += period_bytes;
+
+	snd_pcm_period_elapsed(rt5514_dsp->substream);
+
+	if (rt5514_dsp->dsp_offset < rt5514_dsp->buf_size)
+		schedule_delayed_work(&rt5514_dsp->copy_work, 5);
+done:
+	mutex_unlock(&rt5514_dsp->dma_lock);
+}
+
+/* PCM for streaming audio from the DSP buffer */
+static int rt5514_spi_pcm_open(struct snd_pcm_substream *substream)
+{
+	snd_soc_set_runtime_hwparams(substream, &rt5514_spi_pcm_hardware);
+
+	return 0;
+}
+
+static int rt5514_spi_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct rt5514_dsp *rt5514_dsp =
+			snd_soc_platform_get_drvdata(rtd->platform);
+	int ret;
+
+	mutex_lock(&rt5514_dsp->dma_lock);
+	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+			params_buffer_bytes(hw_params));
+	rt5514_dsp->substream = substream;
+	mutex_unlock(&rt5514_dsp->dma_lock);
+
+	return ret;
+}
+
+static int rt5514_spi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct rt5514_dsp *rt5514_dsp =
+			snd_soc_platform_get_drvdata(rtd->platform);
+
+	mutex_lock(&rt5514_dsp->dma_lock);
+	rt5514_dsp->substream = NULL;
+	mutex_unlock(&rt5514_dsp->dma_lock);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int rt5514_spi_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct rt5514_dsp *rt5514_dsp =
+			snd_soc_platform_get_drvdata(rtd->platform);
+	u8 buf[8];
+
+	rt5514_dsp->dma_offset = 0;
+	rt5514_dsp->dsp_offset = 0;
+
+	/**
+	 * The address area x1800XXXX is the register address, and it cannot
+	 * support spi burst read perfectly. So we use the spi burst read
+	 * individually to make sure the data correctly.
+	*/
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_BASE, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_base = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_LIMIT, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_limit = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_RP, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_rp = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_SIZE, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_size = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	return 0;
+}
+
+static int rt5514_spi_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct rt5514_dsp *rt5514_dsp =
+			snd_soc_platform_get_drvdata(rtd->platform);
+
+	if (cmd == SNDRV_PCM_TRIGGER_START) {
+		if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
+			rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
+			schedule_delayed_work(&rt5514_dsp->copy_work, 0);
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t rt5514_spi_pcm_pointer(
+		struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct rt5514_dsp *rt5514_dsp =
+		snd_soc_platform_get_drvdata(rtd->platform);
+
+	return bytes_to_frames(runtime, rt5514_dsp->dma_offset);
+}
+
+static struct snd_pcm_ops rt5514_spi_pcm_ops = {
+	.open		= rt5514_spi_pcm_open,
+	.hw_params	= rt5514_spi_hw_params,
+	.hw_free	= rt5514_spi_hw_free,
+	.trigger	= rt5514_spi_trigger,
+	.prepare	= rt5514_spi_prepare,
+	.pointer	= rt5514_spi_pcm_pointer,
+	.mmap		= snd_pcm_lib_mmap_vmalloc,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+};
+
+static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
+{
+	struct rt5514_dsp *rt5514_dsp;
+
+	rt5514_dsp = devm_kzalloc(platform->dev, sizeof(*rt5514_dsp),
+			GFP_KERNEL);
+
+	rt5514_dsp->dev = &rt5514_spi->dev;
+	mutex_init(&rt5514_dsp->dma_lock);
+	INIT_DELAYED_WORK(&rt5514_dsp->copy_work, rt5514_spi_copy_work);
+	snd_soc_platform_set_drvdata(platform, rt5514_dsp);
+
+	return 0;
+}
+
+static struct snd_soc_platform_driver rt5514_spi_platform = {
+	.probe = rt5514_spi_pcm_probe,
+	.ops = &rt5514_spi_pcm_ops,
+};
+
+static const struct snd_soc_component_driver rt5514_spi_dai_component = {
+	.name		= "rt5514-spi-dai",
+};
+
+/**
+ * rt5514_spi_burst_read - Read data from SPI by rt5514 address.
+ * @addr: Start address.
+ * @rxbuf: Data Buffer for reading.
+ * @len: Data length, it must be a multiple of 8.
+ *
+ *
+ * Returns true for success.
+ */
+int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len)
+{
+	u8 spi_cmd = RT5514_SPI_CMD_BURST_READ;
+	int status;
+	u8 write_buf[8];
+	unsigned int i, end, offset = 0;
+
+	struct spi_message message;
+	struct spi_transfer x[3];
+
+	while (offset < len) {
+		if (offset + RT5514_SPI_BUF_LEN <= len)
+			end = RT5514_SPI_BUF_LEN;
+		else
+			end = len % RT5514_SPI_BUF_LEN;
+
+		write_buf[0] = spi_cmd;
+		write_buf[1] = ((addr + offset) & 0xff000000) >> 24;
+		write_buf[2] = ((addr + offset) & 0x00ff0000) >> 16;
+		write_buf[3] = ((addr + offset) & 0x0000ff00) >> 8;
+		write_buf[4] = ((addr + offset) & 0x000000ff) >> 0;
+
+		spi_message_init(&message);
+		memset(x, 0, sizeof(x));
+
+		x[0].len = 5;
+		x[0].tx_buf = write_buf;
+		spi_message_add_tail(&x[0], &message);
+
+		x[1].len = 4;
+		x[1].tx_buf = write_buf;
+		spi_message_add_tail(&x[1], &message);
+
+		x[2].len = end;
+		x[2].rx_buf = rxbuf + offset;
+		spi_message_add_tail(&x[2], &message);
+
+		status = spi_sync(rt5514_spi, &message);
+
+		if (status)
+			return false;
+
+		offset += RT5514_SPI_BUF_LEN;
+	}
+
+	for (i = 0; i < len; i += 8) {
+		write_buf[0] = rxbuf[i + 0];
+		write_buf[1] = rxbuf[i + 1];
+		write_buf[2] = rxbuf[i + 2];
+		write_buf[3] = rxbuf[i + 3];
+		write_buf[4] = rxbuf[i + 4];
+		write_buf[5] = rxbuf[i + 5];
+		write_buf[6] = rxbuf[i + 6];
+		write_buf[7] = rxbuf[i + 7];
+
+		rxbuf[i + 0] = write_buf[7];
+		rxbuf[i + 1] = write_buf[6];
+		rxbuf[i + 2] = write_buf[5];
+		rxbuf[i + 3] = write_buf[4];
+		rxbuf[i + 4] = write_buf[3];
+		rxbuf[i + 5] = write_buf[2];
+		rxbuf[i + 6] = write_buf[1];
+		rxbuf[i + 7] = write_buf[0];
+	}
+
+	return true;
+}
+
+/**
+ * rt5514_spi_burst_write - Write data to SPI by rt5514 address.
+ * @addr: Start address.
+ * @txbuf: Data Buffer for writng.
+ * @len: Data length, it must be a multiple of 8.
+ *
+ *
+ * Returns true for success.
+ */
+int rt5514_spi_burst_write(u32 addr, const u8 *txbuf, size_t len)
+{
+	u8 spi_cmd = RT5514_SPI_CMD_BURST_WRITE;
+	u8 *write_buf;
+	unsigned int i, end, offset = 0;
+
+	write_buf = kmalloc(RT5514_SPI_BUF_LEN + 6, GFP_KERNEL);
+
+	if (write_buf == NULL)
+		return -ENOMEM;
+
+	while (offset < len) {
+		if (offset + RT5514_SPI_BUF_LEN <= len)
+			end = RT5514_SPI_BUF_LEN;
+		else
+			end = len % RT5514_SPI_BUF_LEN;
+
+		write_buf[0] = spi_cmd;
+		write_buf[1] = ((addr + offset) & 0xff000000) >> 24;
+		write_buf[2] = ((addr + offset) & 0x00ff0000) >> 16;
+		write_buf[3] = ((addr + offset) & 0x0000ff00) >> 8;
+		write_buf[4] = ((addr + offset) & 0x000000ff) >> 0;
+
+		for (i = 0; i < end; i += 8) {
+			write_buf[i + 12] = txbuf[offset + i + 0];
+			write_buf[i + 11] = txbuf[offset + i + 1];
+			write_buf[i + 10] = txbuf[offset + i + 2];
+			write_buf[i +  9] = txbuf[offset + i + 3];
+			write_buf[i +  8] = txbuf[offset + i + 4];
+			write_buf[i +  7] = txbuf[offset + i + 5];
+			write_buf[i +  6] = txbuf[offset + i + 6];
+			write_buf[i +  5] = txbuf[offset + i + 7];
+		}
+
+		write_buf[end + 5] = spi_cmd;
+
+		spi_write(rt5514_spi, write_buf, end + 6);
+
+		offset += RT5514_SPI_BUF_LEN;
+	}
+
+	kfree(write_buf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5514_spi_burst_write);
+
+static int rt5514_spi_probe(struct spi_device *spi)
+{
+	int ret;
+
+	rt5514_spi = spi;
+
+	ret = snd_soc_register_platform(&spi->dev, &rt5514_spi_platform);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to register platform.\n");
+		goto err_plat;
+	}
+
+	ret = snd_soc_register_component(&spi->dev, &rt5514_spi_dai_component,
+					 &rt5514_spi_dai, 1);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to register component.\n");
+		goto err_comp;
+	}
+
+	return 0;
+err_comp:
+	snd_soc_unregister_platform(&spi->dev);
+err_plat:
+
+	return 0;
+}
+
+static int rt5514_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_component(&spi->dev);
+	snd_soc_unregister_platform(&spi->dev);
+
+	return 0;
+}
+
+static const struct of_device_id rt5514_of_match[] = {
+	{ .compatible = "realtek,rt5514", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5514_of_match);
+
+static struct spi_driver rt5514_spi_driver = {
+	.driver = {
+		.name = "rt5514",
+		.of_match_table = of_match_ptr(rt5514_of_match),
+	},
+	.probe = rt5514_spi_probe,
+	.remove = rt5514_spi_remove,
+};
+module_spi_driver(rt5514_spi_driver);
+
+MODULE_DESCRIPTION("RT5514 SPI driver");
+MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rt5514-spi.h b/sound/soc/codecs/rt5514-spi.h
new file mode 100644
index 0000000..f69b1cd
--- /dev/null
+++ b/sound/soc/codecs/rt5514-spi.h
@@ -0,0 +1,38 @@
+/*
+ * rt5514-spi.h  --  RT5514 driver
+ *
+ * Copyright 2015 Realtek Semiconductor Corp.
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT5514_SPI_H__
+#define __RT5514_SPI_H__
+
+/**
+ * RT5514_SPI_BUF_LEN is the buffer size of SPI master controller.
+*/
+#define RT5514_SPI_BUF_LEN		240
+
+#define RT5514_BUFFER_VOICE_BASE	0x18001034
+#define RT5514_BUFFER_VOICE_LIMIT	0x18001038
+#define RT5514_BUFFER_VOICE_RP		0x1800103c
+#define RT5514_BUFFER_VOICE_SIZE	0x18001040
+
+/* SPI Command */
+enum {
+	RT5514_SPI_CMD_16_READ = 0,
+	RT5514_SPI_CMD_16_WRITE,
+	RT5514_SPI_CMD_32_READ,
+	RT5514_SPI_CMD_32_WRITE,
+	RT5514_SPI_CMD_BURST_READ,
+	RT5514_SPI_CMD_BURST_WRITE,
+};
+
+int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len);
+int rt5514_spi_burst_write(u32 addr, const u8 *txbuf, size_t len);
+
+#endif /* __RT5514_SPI_H__ */
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 879bf60..475b932 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -30,6 +30,9 @@
 
 #include "rl6231.h"
 #include "rt5514.h"
+#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#include "rt5514-spi.h"
+#endif
 
 static const struct reg_sequence rt5514_i2c_patch[] = {
 	{0x1800101c, 0x00000000},
@@ -110,6 +113,35 @@ static const struct reg_default rt5514_reg[] = {
 	{RT5514_VENDOR_ID2,		0x10ec5514},
 };
 
+static void rt5514_enable_dsp_prepare(struct rt5514_priv *rt5514)
+{
+	/* Reset */
+	regmap_write(rt5514->i2c_regmap, 0x18002000, 0x000010ec);
+	/* LDO_I_limit */
+	regmap_write(rt5514->i2c_regmap, 0x18002200, 0x00028604);
+	/* I2C bypass enable */
+	regmap_write(rt5514->i2c_regmap, 0xfafafafa, 0x00000001);
+	/* mini-core reset */
+	regmap_write(rt5514->i2c_regmap, 0x18002f00, 0x0005514b);
+	regmap_write(rt5514->i2c_regmap, 0x18002f00, 0x00055149);
+	/* I2C bypass disable */
+	regmap_write(rt5514->i2c_regmap, 0xfafafafa, 0x00000000);
+	/* PIN config */
+	regmap_write(rt5514->i2c_regmap, 0x18002070, 0x00000040);
+	/* PLL3(QN)=RCOSC*(10+2) */
+	regmap_write(rt5514->i2c_regmap, 0x18002240, 0x0000000a);
+	/* PLL3 source=RCOSC, fsi=rt_clk */
+	regmap_write(rt5514->i2c_regmap, 0x18002100, 0x0000000b);
+	/* Power on RCOSC, pll3 */
+	regmap_write(rt5514->i2c_regmap, 0x18002004, 0x00808b81);
+	/* DSP clk source = pll3, ENABLE DSP clk */
+	regmap_write(rt5514->i2c_regmap, 0x18002f08, 0x00000005);
+	/* Enable DSP clk auto switch */
+	regmap_write(rt5514->i2c_regmap, 0x18001114, 0x00000001);
+	/* Reduce DSP power */
+	regmap_write(rt5514->i2c_regmap, 0x18001118, 0x00000001);
+}
+
 static bool rt5514_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -248,6 +280,74 @@ static const DECLARE_TLV_DB_RANGE(bst_tlv,
 
 static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
 
+static int rt5514_dsp_voice_wake_up_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = rt5514->dsp_enabled;
+
+	return 0;
+}
+
+static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_codec *codec = rt5514->codec;
+	const struct firmware *fw = NULL;
+
+	if (ucontrol->value.integer.value[0] == rt5514->dsp_enabled)
+		return 0;
+
+	if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		rt5514->dsp_enabled = ucontrol->value.integer.value[0];
+
+		if (rt5514->dsp_enabled) {
+			rt5514_enable_dsp_prepare(rt5514);
+
+			request_firmware(&fw, RT5514_FIRMWARE1, codec->dev);
+			if (fw) {
+#if defined(CONFIG_SND_SOC_RT5514_SPI)
+				rt5514_spi_burst_write(0x4ff60000, fw->data,
+					((fw->size/8)+1)*8);
+#else
+				dev_err(codec->dev, "There is no SPI driver for"
+					" loading the firmware\n");
+#endif
+				release_firmware(fw);
+				fw = NULL;
+			}
+
+			request_firmware(&fw, RT5514_FIRMWARE2, codec->dev);
+			if (fw) {
+#if defined(CONFIG_SND_SOC_RT5514_SPI)
+				rt5514_spi_burst_write(0x4ffc0000, fw->data,
+					((fw->size/8)+1)*8);
+#else
+				dev_err(codec->dev, "There is no SPI driver for"
+					" loading the firmware\n");
+#endif
+				release_firmware(fw);
+				fw = NULL;
+			}
+
+			/* DSP run */
+			regmap_write(rt5514->i2c_regmap, 0x18002f00,
+				0x00055148);
+		} else {
+			regcache_mark_dirty(rt5514->i2c_regmap);
+			regcache_mark_dirty(rt5514->regmap);
+			regcache_sync(rt5514->i2c_regmap);
+			regcache_sync(rt5514->regmap);
+		}
+	}
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 	SOC_DOUBLE_TLV("MIC Boost Volume", RT5514_ANA_CTRL_MICBST,
 		RT5514_SEL_BSTL_SFT, RT5514_SEL_BSTR_SFT, 8, 0, bst_tlv),
@@ -257,6 +357,8 @@ static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("ADC2 Capture Volume", RT5514_DOWNFILTER1_CTRL1,
 		RT5514_DOWNFILTER1_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
 		adc_vol_tlv),
+	SOC_SINGLE_EXT("DSP Voice Wake Up", SND_SOC_NOPM, 0, 1, 0,
+		rt5514_dsp_voice_wake_up_get, rt5514_dsp_voice_wake_up_put),
 };
 
 /* ADC Mixer*/
@@ -365,6 +467,35 @@ static int rt5514_is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 		return 0;
 }
 
+static int rt5514_pre_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/**
+		 * If the DSP is enabled in start of recording, the DSP
+		 * should be disabled, and sync back to normal recording
+		 * settings to make sure recording properly.
+		*/
+		if (rt5514->dsp_enabled) {
+			rt5514->dsp_enabled = 0;
+			regcache_mark_dirty(rt5514->i2c_regmap);
+			regcache_mark_dirty(rt5514->regmap);
+			regcache_sync(rt5514->i2c_regmap);
+			regcache_sync(rt5514->regmap);
+		}
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC1L"),
@@ -472,6 +603,8 @@ static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 
 	/* Audio Interface */
 	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_PRE("DAPM Pre", rt5514_pre_event),
 };
 
 static const struct snd_soc_dapm_route rt5514_dapm_routes[] = {
@@ -871,7 +1004,6 @@ static const struct regmap_config rt5514_i2c_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
 
-	.max_register = RT5514_DSP_MAPPING | RT5514_VENDOR_ID2,
 	.readable_reg = rt5514_i2c_readable_register,
 
 	.cache_type = REGCACHE_NONE,
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 6ad8a61..6e89e7d 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -225,6 +225,9 @@
 #define RT5514_PLL_INP_MAX			40000000
 #define RT5514_PLL_INP_MIN			256000
 
+#define RT5514_FIRMWARE1	"rt5514_dsp_fw1.bin"
+#define RT5514_FIRMWARE2	"rt5514_dsp_fw2.bin"
+
 /* System Clock Source */
 enum {
 	RT5514_SCLK_S_MCLK,
@@ -247,6 +250,7 @@ struct rt5514_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+	int dsp_enabled;
 };
 
 #endif /* __RT5514_H__ */
-- 
1.8.1.1.439.g50a6b54
