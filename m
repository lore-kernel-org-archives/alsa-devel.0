From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Subject: [PATCH] alsa: Add support for timberdale I2S block
Date: Mon, 26 Oct 2009 14:02:57 +0100
Message-ID: <4AE59E01.9000802@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from av12-1-sn2.hy.skanova.net (av12-1-sn2.hy.skanova.net
	[81.228.8.185]) by alsa0.perex.cz (Postfix) with ESMTP id AF715244ED
	for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2009 14:03:00 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This driver adds support for the I2S block of the timberdale FPGA.

The timberdale is a FPGA found on intel development boards for
In-Vehicle Infotainment.

The block has support for up to 8 I2S channels, can be clocked
from either the FPGA or the device side.

This driver introduces support for this block, by exposing each
I2S channel as an ALSA PCM channel.

Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
---
diff --git a/include/sound/timbi2s.h b/include/sound/timbi2s.h
new file mode 100644
index 0000000..4ab810c
--- /dev/null
+++ b/include/sound/timbi2s.h
@@ -0,0 +1,32 @@
+/*
+ * timbi2s.h timberdale FPGA I2S platform data
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __INCLUDE_SOUND_TIMBI2S_H
+#define __INCLUDE_SOUND_TIMBI2S_H
+
+struct timbi2s_bus_data {
+	u8	rx;
+	u16	sample_rate;
+};
+
+struct timbi2s_platform_data {
+	const struct timbi2s_bus_data	*busses;
+	int				num_busses;
+	u32				main_clk;
+};
+
+#endif
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 84714a6..54ad4e7 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -182,4 +182,17 @@ config SND_AC97_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for AC97 automatic
 	  power-save mode.  0 means to disable the power-save mode.

+config SND_TIMBERDALE_I2S
+	tristate "The timberdale FPGA I2S driver"
+	depends on MFD_TIMBERDALE && HAS_IOMEM
+	default y
+	help
+	  Say Y here to enable driver for the I2S block found within the
+	  Timberdale FPGA.
+	  There is support for up to 8 I2S channels, in either transmitter
+	  or receiver mode.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-timbi2s.
+
 endif	# SND_DRIVERS
diff --git a/sound/drivers/Makefile b/sound/drivers/Makefile
index d4a07f9..dea2eed 100644
--- a/sound/drivers/Makefile
+++ b/sound/drivers/Makefile
@@ -10,6 +10,7 @@ snd-portman2x4-objs :=3D portman2x4.o
 snd-serial-u16550-objs :=3D serial-u16550.o
 snd-virmidi-objs :=3D virmidi.o
 snd-ml403-ac97cr-objs :=3D ml403-ac97cr.o pcm-indirect2.o
+snd-timbi2s-objs :=3D timbi2s.o

 # Toplevel Module Dependency
 obj-$(CONFIG_SND_DUMMY) +=3D snd-dummy.o
@@ -19,5 +20,6 @@ obj-$(CONFIG_SND_MTPAV) +=3D snd-mtpav.o
 obj-$(CONFIG_SND_MTS64) +=3D snd-mts64.o
 obj-$(CONFIG_SND_PORTMAN2X4) +=3D snd-portman2x4.o
 obj-$(CONFIG_SND_ML403_AC97CR) +=3D snd-ml403-ac97cr.o
+obj-$(CONFIG_SND_TIMBERDALE_I2S) +=3D snd-timbi2s.o

 obj-$(CONFIG_SND) +=3D opl3/ opl4/ mpu401/ vx/ pcsp/
diff --git a/sound/drivers/timbi2s.c b/sound/drivers/timbi2s.c
new file mode 100644
index 0000000..a9c34c2
--- /dev/null
+++ b/sound/drivers/timbi2s.c
@@ -0,0 +1,755 @@
+/*
+ * timbi2s.c timberdale FPGA I2S driver
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Timberdale FPGA I2S
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/timbi2s.h>
+
+#define DRIVER_NAME "timb-i2s"
+
+#define MAX_BUSSES	8
+
+#define TIMBI2S_REG_VER	0x00
+#define TIMBI2S_REG_UIR	0x04
+
+#define TIMBI2S_BUS_PRESCALE	0x00
+#define TIMBI2S_BUS_ICLR	0x04
+#define TIMBI2S_BUS_IPR		0x08
+#define TIMBI2S_BUS_ISR		0x0c
+#define TIMBI2S_BUS_IER		0x10
+
+
+#define TIMBI2S_IRQ_TX_FULL		0x01
+#define TIMBI2S_IRQ_TX_ALMOST_FULL	0x02
+#define TIMBI2S_IRQ_TX_ALMOST_EMPTY	0x04
+#define TIMBI2S_IRQ_TX_EMPTY		0x08
+
+#define TIMBI2S_IRQ_RX_FULL		0x10
+#define TIMBI2S_IRQ_RX_ALMOST_FULL	0x20
+#define TIMBI2S_IRQ_RX_ALMOST_EMPTY	0x40
+#define TIMBI2S_IRQ_RX_NOT_EMPTY	0x80
+
+#define TIMBI2S_BUS_ICOR	0x14
+#define TIMBI2S_ICOR_TX_ENABLE	0x00000001
+#define TIMBI2S_ICOR_RX_ENABLE	0x00000002
+#define TIMBI2S_ICOR_LFIFO_RST	0x00000004
+#define TIMBI2S_ICOR_RFIFO_RST	0x00000008
+#define TIMBI2S_ICOR_FIFO_RST (TIMBI2S_ICOR_LFIFO_RST | TIMBI2S_ICOR_RFIFO=
_RST)
+#define TIMBI2S_ICOR_SOFT_RST	0x00000010
+#define TIMBI2S_ICOR_WORD_SEL_LEFT_SHIFT	8
+#define TIMBI2S_ICOR_WORD_SEL_LEFT_MASK		(0xff << 8)
+#define TIMBI2S_ICOR_WORD_SEL_RIGHT_SHIFT	16
+#define TIMBI2S_ICOR_WORD_SEL_RIGHT_MASK	(0xff << 16)
+#define TIMBI2S_ICOR_CLK_MASTER	0x10000000
+#define TIMBI2S_ICOR_RX_ID	0x20000000
+#define TIMBI2S_ICOR_TX_ID	0x40000000
+#define TIMBI2S_ICOR_WORD_SEL	0x80000000
+#define TIMBI2S_BUS_FIFO	0x18
+
+#define TIMBI2S_BUS_REG_AREA_SIZE	(TIMBI2S_BUS_FIFO - \
+	TIMBI2S_BUS_PRESCALE + 4)
+#define TIMBI2S_FIRST_BUS_AREA_OFS	0x08
+
+struct timbi2s_bus {
+	u32 flags;
+	u32 prescale;
+	struct snd_pcm 	*pcm;
+	struct snd_card *card;
+	struct snd_pcm_substream *substream;
+	unsigned	buf_pos;
+	spinlock_t	lock; /* mutual exclusion */
+	u16		sample_rate;
+};
+
+#define BUS_RX		0x200
+#define BUS_MASTER	0x100
+#define BUS_INDEX_MASK	0xff
+#define BUS_INDEX(b) ((b)->flags & BUS_INDEX_MASK)
+#define BUS_IS_MASTER(b) ((b)->flags & BUS_MASTER)
+#define BUS_IS_RX(b) ((b)->flags & BUS_RX)
+
+#define SET_BUS_INDEX(b, id) ((b)->flags =3D ((b)->flags & ~BUS_INDEX_MASK=
) | id)
+#define SET_BUS_MASTER(b) ((b)->flags |=3D BUS_MASTER)
+#define SET_BUS_RX(b) ((b)->flags |=3D BUS_RX)
+
+#define TIMBI2S_BUS_OFFSET(bus) (TIMBI2S_FIRST_BUS_AREA_OFS + \
+	TIMBI2S_BUS_REG_AREA_SIZE * BUS_INDEX(bus))
+
+struct timbi2s {
+	void __iomem *membase;
+	int irq;
+	struct tasklet_struct	tasklet;
+	u32 main_clk;
+	unsigned num_busses;
+	struct timbi2s_bus busses[0];
+};
+
+#define BITS_PER_CHANNEL	16
+#define NUM_CHANNELS		2
+
+#define SAMPLE_SIZE	((NUM_CHANNELS * BITS_PER_CHANNEL) / 8)
+#define NUM_PERIODS	32
+#define NUM_SAMPLES	256
+
+static struct snd_pcm_hardware timbi2s_rx_hw =3D {
+	.info			=3D (SNDRV_PCM_INFO_MMAP
+				  | SNDRV_PCM_INFO_MMAP_VALID
+				  | SNDRV_PCM_INFO_INTERLEAVED),
+	.formats		=3D SNDRV_PCM_FMTBIT_S16_LE,
+	.rates			=3D SNDRV_PCM_RATE_44100,
+	.rate_min		=3D 44100,
+	.rate_max		=3D 44100,
+	.channels_min		=3D 2, /* only stereo */
+	.channels_max		=3D 2,
+	.buffer_bytes_max	=3D NUM_PERIODS * SAMPLE_SIZE * NUM_SAMPLES,
+	.period_bytes_min	=3D SAMPLE_SIZE * NUM_SAMPLES,
+	.period_bytes_max	=3D SAMPLE_SIZE * NUM_SAMPLES,
+	.periods_min		=3D NUM_PERIODS,
+	.periods_max		=3D NUM_PERIODS,
+};
+
+static struct snd_pcm_hardware timbi2s_tx_hw =3D {
+	.info			=3D (SNDRV_PCM_INFO_MMAP
+				  | SNDRV_PCM_INFO_MMAP_VALID
+				  | SNDRV_PCM_INFO_INTERLEAVED),
+	.formats		=3D SNDRV_PCM_FMTBIT_S16_LE,
+	.rates			=3D SNDRV_PCM_RATE_8000,
+	.rate_min		=3D 8000,
+	.rate_max		=3D 8000,
+	.channels_min		=3D 2, /* only stereo */
+	.channels_max		=3D 2,
+	.buffer_bytes_max	=3D NUM_PERIODS * SAMPLE_SIZE * NUM_SAMPLES,
+	.period_bytes_min	=3D SAMPLE_SIZE * NUM_SAMPLES,
+	.period_bytes_max	=3D SAMPLE_SIZE * NUM_SAMPLES,
+	.periods_min		=3D NUM_PERIODS,
+	.periods_max		=3D NUM_PERIODS,
+};
+
+static inline void timbi2s_bus_write(struct timbi2s_bus *bus, u32 val, u32=
 reg)
+{
+	struct timbi2s *i2s =3D snd_pcm_chip(bus->card);
+
+	iowrite32(val, i2s->membase + TIMBI2S_BUS_OFFSET(bus) + reg);
+}
+
+static inline u32 timbi2s_bus_read(struct timbi2s_bus *bus, u32 reg)
+{
+	struct timbi2s *i2s =3D snd_pcm_chip(bus->card);
+
+	return ioread32(i2s->membase + TIMBI2S_BUS_OFFSET(bus) + reg);
+}
+
+static u32 timbi2s_calc_prescale(u32 main_clk, u32 sample_rate)
+{
+	u32 halfbit_rate =3D sample_rate * BITS_PER_CHANNEL * NUM_CHANNELS * 2;
+	return main_clk / halfbit_rate;
+}
+
+static int timbi2s_open(struct snd_pcm_substream *substream)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p, bus: %d\n", __func__, substream,
+		BUS_INDEX(bus));
+
+	if (BUS_IS_RX(bus)) {
+		runtime->hw =3D timbi2s_rx_hw;
+		if (bus->sample_rate =3D=3D 8000) {
+			runtime->hw.rates =3D SNDRV_PCM_RATE_8000;
+			runtime->hw.rate_min =3D 8000;
+			runtime->hw.rate_max =3D 8000;
+		}
+	} else
+		runtime->hw =3D timbi2s_tx_hw;
+
+	bus->substream =3D substream;
+
+	return 0;
+}
+
+static int timbi2s_close(struct snd_pcm_substream *substream)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p, bus: %d\n", __func__, substream,
+		BUS_INDEX(bus));
+
+	bus->substream =3D NULL;
+
+	return 0;
+}
+
+static int timbi2s_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	struct timbi2s *i2s =3D snd_pcm_chip(card);
+	int err;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p, bus: %d\n", __func__,
+		substream, BUS_INDEX(bus));
+
+	bus->prescale =3D timbi2s_calc_prescale(i2s->main_clk,
+			params_rate(hw_params));
+
+	err =3D snd_pcm_lib_malloc_pages(substream,
+		params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Rate: %d, format: %d\n", __func__, params_rate(hw_params),
+		params_format(hw_params));
+
+	return 0;
+}
+
+static int timbi2s_hw_free(struct snd_pcm_substream *substream)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	unsigned long flags;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p\n", __func__, substream);
+
+	spin_lock_irqsave(&bus->lock, flags);
+	/* disable interrupts */
+	timbi2s_bus_write(bus, 0, TIMBI2S_BUS_IER);
+	spin_unlock_irqrestore(&bus->lock, flags);
+
+	/* disable TX and RX */
+	timbi2s_bus_write(bus, TIMBI2S_ICOR_FIFO_RST | TIMBI2S_ICOR_SOFT_RST,
+		TIMBI2S_BUS_ICOR);
+
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int timbi2s_prepare(struct snd_pcm_substream *substream)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	u32 data;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p, bus: %d, buffer: %d, period: %d\n",
+		__func__, substream,
+		BUS_INDEX(bus), (int)snd_pcm_lib_buffer_bytes(substream),
+		(int)snd_pcm_lib_period_bytes(substream));
+
+	if (runtime->dma_addr & 3 || runtime->buffer_size & 3) {
+		dev_err(snd_card_get_device_link(card),
+			"%s: Only word aligned data allowed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (runtime->channels !=3D NUM_CHANNELS) {
+		dev_err(snd_card_get_device_link(card),
+			"%s: Number of channels unsupported %d\n", __func__,
+			runtime->channels);
+		return -EINVAL;
+	}
+
+	/* reset */
+	timbi2s_bus_write(bus, TIMBI2S_ICOR_FIFO_RST | TIMBI2S_ICOR_SOFT_RST,
+		TIMBI2S_BUS_ICOR);
+
+	/* only masters have prescaling, don't write if not needed */
+	if (BUS_IS_MASTER(bus))
+		timbi2s_bus_write(bus, bus->prescale, TIMBI2S_BUS_PRESCALE);
+
+	/* write word select */
+	data =3D ((BITS_PER_CHANNEL << TIMBI2S_ICOR_WORD_SEL_LEFT_SHIFT) &
+		TIMBI2S_ICOR_WORD_SEL_LEFT_MASK) |
+		((BITS_PER_CHANNEL << TIMBI2S_ICOR_WORD_SEL_RIGHT_SHIFT) &
+		TIMBI2S_ICOR_WORD_SEL_RIGHT_MASK);
+	timbi2s_bus_write(bus, data, TIMBI2S_BUS_ICOR);
+
+	bus->buf_pos =3D 0;
+
+	return 0;
+}
+
+static int
+timbi2s_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	unsigned long flags;
+	u32 data;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p, bus: %d, cmd: %d\n", __func__,
+		substream, BUS_INDEX(bus), cmd);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: Got TRIGGER_START command\n", __func__);
+
+		/* start */
+		data =3D timbi2s_bus_read(bus, TIMBI2S_BUS_ICOR);
+		data |=3D TIMBI2S_ICOR_TX_ENABLE;
+		timbi2s_bus_write(bus, data, TIMBI2S_BUS_ICOR);
+
+		/* enable interrupts */
+		timbi2s_bus_write(bus, TIMBI2S_IRQ_TX_ALMOST_EMPTY,
+			TIMBI2S_BUS_IER);
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: ISR: %x, ICOR: %x\n", __func__,
+			timbi2s_bus_read(bus, TIMBI2S_BUS_ISR),
+			timbi2s_bus_read(bus, TIMBI2S_BUS_ICOR));
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: Got TRIGGER_STOP command\n", __func__);
+
+		spin_lock_irqsave(&bus->lock, flags);
+		/* disable interrupts */
+		timbi2s_bus_write(bus, 0, TIMBI2S_BUS_IER);
+		spin_unlock_irqrestore(&bus->lock, flags);
+
+		/* reset */
+		data =3D timbi2s_bus_read(bus, TIMBI2S_BUS_ICOR);
+		data &=3D ~TIMBI2S_ICOR_TX_ENABLE;
+
+		timbi2s_bus_write(bus, data, TIMBI2S_BUS_ICOR);
+		break;
+	default:
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: Got unsupported command\n", __func__);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+timbi2s_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	unsigned long flags;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p, bus: %d, cmd: %d\n", __func__,
+		substream, BUS_INDEX(bus), cmd);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: Got TRIGGER_START command\n", __func__);
+
+		timbi2s_bus_write(bus, TIMBI2S_ICOR_RX_ENABLE |
+			TIMBI2S_ICOR_FIFO_RST, TIMBI2S_BUS_ICOR);
+
+		timbi2s_bus_write(bus, TIMBI2S_IRQ_RX_ALMOST_FULL,
+			TIMBI2S_BUS_IER);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: Got TRIGGER_STOP command\n", __func__);
+		/* disable interrupts */
+		spin_lock_irqsave(&bus->lock, flags);
+		timbi2s_bus_write(bus, 0, TIMBI2S_BUS_IER);
+		spin_unlock_irqrestore(&bus->lock, flags);
+		/* Stop RX */
+		timbi2s_bus_write(bus, 0, TIMBI2S_BUS_ICOR);
+		break;
+	default:
+		dev_dbg(snd_card_get_device_link(card),
+			"%s: Got unsupported command\n", __func__);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t
+timbi2s_pointer(struct snd_pcm_substream *substream)
+{
+	struct timbi2s_bus *bus =3D snd_pcm_substream_chip(substream);
+	struct snd_card *card =3D bus->card;
+	snd_pcm_uframes_t ret;
+
+	dev_dbg(snd_card_get_device_link(card),
+		"%s: Entry, substream: %p\n", __func__, substream);
+
+	ret =3D bytes_to_frames(substream->runtime, bus->buf_pos);
+	if (ret >=3D substream->runtime->buffer_size)
+		ret -=3D substream->runtime->buffer_size;
+
+	return ret;
+}
+
+static struct snd_pcm_ops timbi2s_playback_ops =3D {
+	.open		=3D timbi2s_open,
+	.close		=3D timbi2s_close,
+	.ioctl		=3D snd_pcm_lib_ioctl,
+	.hw_params	=3D timbi2s_hw_params,
+	.hw_free	=3D timbi2s_hw_free,
+	.prepare	=3D timbi2s_prepare,
+	.trigger	=3D timbi2s_playback_trigger,
+	.pointer	=3D timbi2s_pointer,
+};
+
+static struct snd_pcm_ops timbi2s_capture_ops =3D {
+	.open		=3D timbi2s_open,
+	.close		=3D timbi2s_close,
+	.ioctl		=3D snd_pcm_lib_ioctl,
+	.hw_params	=3D timbi2s_hw_params,
+	.hw_free	=3D timbi2s_hw_free,
+	.prepare	=3D timbi2s_prepare,
+	.trigger	=3D timbi2s_capture_trigger,
+	.pointer	=3D timbi2s_pointer,
+};
+
+static void timbi2s_irq_process_rx(struct timbi2s_bus *bus)
+{
+	struct snd_pcm_runtime *runtime =3D bus->substream->runtime;
+	u32 buffer_size =3D snd_pcm_lib_buffer_bytes(bus->substream);
+	u32 ipr =3D timbi2s_bus_read(bus, TIMBI2S_BUS_IPR);
+	int i;
+
+	dev_dbg(snd_card_get_device_link(bus->card),
+		"%s: Entry, bus: %d, IPR %x\n", __func__, BUS_INDEX(bus), ipr);
+
+	for (i =3D 0; i < NUM_SAMPLES; i++) {
+		*(u32 *)(runtime->dma_area + bus->buf_pos) =3D
+			timbi2s_bus_read(bus, TIMBI2S_BUS_FIFO);
+		bus->buf_pos +=3D SAMPLE_SIZE;
+		bus->buf_pos %=3D buffer_size;
+	}
+
+	timbi2s_bus_write(bus, ipr, TIMBI2S_BUS_ICLR);
+
+	/* inform ALSA that a period was received */
+	snd_pcm_period_elapsed(bus->substream);
+}
+
+static void timbi2s_irq_process_tx(struct timbi2s_bus *bus)
+{
+	struct snd_pcm_runtime *runtime =3D bus->substream->runtime;
+	u32 buffer_size =3D snd_pcm_lib_buffer_bytes(bus->substream);
+	u32 ipr =3D timbi2s_bus_read(bus, TIMBI2S_BUS_IPR);
+	int i;
+
+	dev_dbg(snd_card_get_device_link(bus->card),
+		"%s: Entry, bus: %d, IPR %x\n", __func__, BUS_INDEX(bus), ipr);
+
+	for (i =3D 0; i < NUM_SAMPLES; i++) {
+		timbi2s_bus_write(bus,
+			*(u32 *)(runtime->dma_area + bus->buf_pos),
+			TIMBI2S_BUS_FIFO);
+		bus->buf_pos +=3D SAMPLE_SIZE;
+		bus->buf_pos %=3D buffer_size;
+	}
+
+	dev_dbg(snd_card_get_device_link(bus->card), "%s: ISR: %x, ICOR: %x\n",
+		__func__, timbi2s_bus_read(bus, TIMBI2S_BUS_ISR),
+		timbi2s_bus_read(bus, TIMBI2S_BUS_ICOR));
+
+	timbi2s_bus_write(bus, ipr, TIMBI2S_BUS_ICLR);
+
+	/* inform ALSA that a period was received */
+	snd_pcm_period_elapsed(bus->substream);
+}
+
+static void timbi2s_tasklet(unsigned long arg)
+{
+	struct snd_card *card =3D (struct snd_card *)arg;
+	struct timbi2s *i2s =3D snd_pcm_chip(card);
+	u32 uir =3D ioread32(i2s->membase + TIMBI2S_REG_UIR);
+	unsigned i;
+
+	dev_dbg(snd_card_get_device_link(card), "%s: Entry, UIR %x\n",
+		__func__, uir);
+
+	for (i =3D 0; i < i2s->num_busses; i++)
+		if (uir & (1 << i)) {
+			struct timbi2s_bus *bus =3D i2s->busses + i;
+			if (BUS_IS_RX(bus))
+				timbi2s_irq_process_rx(bus);
+			else
+				timbi2s_irq_process_tx(bus);
+		}
+
+	enable_irq(i2s->irq);
+}
+
+static irqreturn_t timbi2s_irq(int irq, void *devid)
+{
+	struct timbi2s *i2s =3D devid;
+
+	tasklet_schedule(&i2s->tasklet);
+	disable_irq_nosync(i2s->irq);
+
+	return IRQ_HANDLED;
+}
+
+static int timbi2s_setup_busses(struct snd_card *card,
+	struct platform_device *pdev)
+{
+	const struct timbi2s_platform_data *pdata =3D pdev->dev.platform_data;
+	unsigned i;
+
+	dev_dbg(&pdev->dev, "%s: Entry, no busses: %d, busses: %p\n", __func__,
+		pdata->num_busses, pdata->busses);
+
+	for (i =3D 0; i < pdata->num_busses; i++) {
+		int			capture =3D pdata->busses[i].rx;
+		int			err;
+		u32 			ctl;
+		struct timbi2s		*i2s =3D snd_pcm_chip(card);
+		struct timbi2s_bus	*bus =3D i2s->busses + i;
+
+		dev_dbg(&pdev->dev, "%s: Setting up bus: %d\n", __func__, i);
+
+		SET_BUS_INDEX(bus, i);
+		bus->sample_rate =3D pdata->busses[i].sample_rate;
+		bus->card =3D card;
+		/* prescaling only applies to master busses, we use the
+		 * knowledge of that to identify the direction later
+		 * eg, bus->prescale !=3D 0 -> master bus
+		 */
+		if (capture)
+			SET_BUS_RX(bus);
+
+		spin_lock_init(&bus->lock);
+
+		if (bus->sample_rate !=3D 44100 && bus->sample_rate !=3D 8000) {
+			dev_err(&pdev->dev,
+				"Unsupported bitrate: %d\n", bus->sample_rate);
+			return -EINVAL;
+		}
+
+		dev_dbg(&pdev->dev, "%s: Will check HW direction on bus: %d\n",
+			__func__, BUS_INDEX(bus));
+
+		/* check that the HW agrees with the direction */
+		ctl =3D timbi2s_bus_read(bus, TIMBI2S_BUS_ICOR);
+		if ((capture && !(ctl & TIMBI2S_ICOR_RX_ID)) ||
+			(!capture && !(ctl & TIMBI2S_ICOR_TX_ID))) {
+			dev_dbg(&pdev->dev,
+				"HW and platform data disagree on direction\n");
+			return -EINVAL;
+		}
+
+		dev_dbg(&pdev->dev, "%s: Will create PCM channel for bus: %d\n",
+			__func__, BUS_INDEX(bus));
+		err =3D snd_pcm_new(card, card->shortname, i, !capture,
+			capture, &bus->pcm);
+		if (err) {
+			dev_dbg(&pdev->dev, "%s, Failed to create pcm: %d\n",
+				__func__, err);
+			return err;
+		}
+
+		if (capture)
+			snd_pcm_set_ops(bus->pcm, SNDRV_PCM_STREAM_CAPTURE,
+				&timbi2s_capture_ops);
+		if (!capture)
+			snd_pcm_set_ops(bus->pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				&timbi2s_playback_ops);
+
+		dev_dbg(&pdev->dev, "%s: Will preallocate buffers to bus: %d\n",
+			__func__, BUS_INDEX(bus));
+
+		err =3D snd_pcm_lib_preallocate_pages_for_all(bus->pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL),
+			NUM_SAMPLES * NUM_PERIODS * SAMPLE_SIZE * 2,
+			NUM_SAMPLES * NUM_PERIODS * SAMPLE_SIZE * 2);
+		if (err) {
+			dev_dbg(&pdev->dev, "%s, Failed to create pcm: %d\n",
+				__func__, err);
+
+			return err;
+		}
+
+		bus->pcm->private_data =3D bus;
+		bus->pcm->info_flags =3D 0;
+		strcpy(bus->pcm->name, card->shortname);
+		i2s->num_busses++;
+	}
+
+	return 0;
+}
+
+static int __devinit timbi2s_probe(struct platform_device *pdev)
+{
+	int err;
+	int irq;
+	struct timbi2s *i2s;
+	struct resource *iomem;
+	const struct timbi2s_platform_data *pdata =3D pdev->dev.platform_data;
+	struct snd_card *card;
+	u32 ver;
+
+	if (!pdata) {
+		err =3D -ENODEV;
+		goto out;
+	}
+
+	if (pdata->num_busses > MAX_BUSSES) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		err =3D -ENODEV;
+		goto out;
+	}
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		err =3D -ENODEV;
+		goto out;
+	}
+
+	err =3D snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+		THIS_MODULE, sizeof(struct timbi2s) +
+		sizeof(struct timbi2s_bus) * pdata->num_busses, &card);
+	if (err)
+		goto out;
+
+	strcpy(card->driver, "Timberdale I2S");
+	strcpy(card->shortname, "Timberdale I2S");
+	sprintf(card->longname, "Timberdale I2S Driver");
+
+	snd_card_set_dev(card, &pdev->dev);
+
+	i2s =3D snd_pcm_chip(card);
+
+	if (!request_mem_region(iomem->start, resource_size(iomem),
+		DRIVER_NAME)) {
+		err =3D -EBUSY;
+		goto err_region;
+	}
+
+	i2s->membase =3D ioremap(iomem->start, resource_size(iomem));
+	if (!i2s->membase) {
+		err =3D -ENOMEM;
+		goto err_ioremap;
+	}
+
+	err =3D timbi2s_setup_busses(card, pdev);
+	if (err)
+		goto err_setup;
+
+	tasklet_init(&i2s->tasklet, timbi2s_tasklet, (unsigned long)card);
+	i2s->irq =3D irq;
+	i2s->main_clk =3D pdata->main_clk;
+
+	err =3D request_irq(irq, timbi2s_irq, 0, DRIVER_NAME, i2s);
+	if (err)
+		goto err_request_irq;
+
+	err =3D snd_card_register(card);
+	if (err)
+		goto err_register;
+
+	platform_set_drvdata(pdev, card);
+
+	ver =3D ioread32(i2s->membase + TIMBI2S_REG_VER);
+
+	printk(KERN_INFO
+		"Driver for Timberdale I2S (ver: %d.%d) successfully probed.\n",
+		ver >> 16 , ver & 0xffff);
+
+	return 0;
+
+err_register:
+	free_irq(irq, card);
+err_request_irq:
+err_setup:
+	iounmap(i2s->membase);
+err_ioremap:
+	release_mem_region(iomem->start, resource_size(iomem));
+err_region:
+	snd_card_free(card);
+out:
+	printk(KERN_ERR DRIVER_NAME": Failed to register: %d\n", err);
+
+	return err;
+}
+
+static int __devexit timbi2s_remove(struct platform_device *pdev)
+{
+	struct snd_card *card =3D platform_get_drvdata(pdev);
+	struct timbi2s *i2s =3D snd_pcm_chip(card);
+	struct resource *iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	tasklet_kill(&i2s->tasklet);
+	free_irq(i2s->irq, i2s);
+
+	iounmap(i2s->membase);
+	release_mem_region(iomem->start, resource_size(iomem));
+	snd_card_free(card);
+
+	platform_set_drvdata(pdev, 0);
+	return 0;
+}
+
+static struct platform_driver timbi2s_platform_driver =3D {
+	.driver =3D {
+		.name	=3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D timbi2s_probe,
+	.remove		=3D __devexit_p(timbi2s_remove),
+};
+
+/*------------------------------------------------------------------------=
--*/
+
+static int __init timbi2s_init(void)
+{
+	return platform_driver_register(&timbi2s_platform_driver);
+}
+
+static void __exit timbi2s_exit(void)
+{
+	platform_driver_unregister(&timbi2s_platform_driver);
+}
+
+module_init(timbi2s_init);
+module_exit(timbi2s_exit);
+
+MODULE_ALIAS("platform:"DRIVER_NAME);
+MODULE_DESCRIPTION("Timberdale I2S bus driver");
+MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
+MODULE_LICENSE("GPL v2");
