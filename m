From: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
Subject: [PATCH 1/3] saa7146: Emagic Audiowerk8 low-level ALSA
	driver
Date: Thu, 23 Oct 2008 00:04:50 +0200
Message-ID: <48FFA382.60409@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail12.bluewin.ch (mail12.bluewin.ch [195.186.19.61])
	by alsa0.perex.cz (Postfix) with ESMTP id BB2141037F7
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 00:04:03 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

From: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>

Low-level ALSA driver for Emagic Audiowerk8 sound card.
Project page: http://sourceforge.net/projects/aw8-alsa
Built and tested with Vanilla 2.6.25.16

Signed-off-by: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
---
This is a request for submission to ALSA-tree.



diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/log.h 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/log.h
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/log.h	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/log.h	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,43 @@
+/*
+ *  Kernel log convenience macros
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#ifndef LOG_H_
+#define LOG_H_
+#define LOG_ENABLE
+#ifndef SAA7146_SUBSYS_LOG_TAG
+#define SAA7146_SUBSYS_LOG_TAG "SAA7146"
+#endif
+#ifdef LOG_ENABLE
+# define LOG_ERROR(fmt, args...) \
+	printk(KERN_ERR SAA7146_SUBSYS_LOG_TAG ": %s:%d:" fmt "\n", \
+					__func__, __LINE__, ## args);
+# define LOG_WARN(fmt, args...) \
+	printk(KERN_WARNING SAA7146_SUBSYS_LOG_TAG ": %s:%d:" fmt "\n", \
+					__func__, __LINE__, ## args);
+# define LOG_INFO(fmt, args...) \
+	printk(KERN_INFO SAA7146_SUBSYS_LOG_TAG ": %s:%d:" fmt "\n", \
+					__func__, __LINE__, ## args);
+#else
+# define LOG_ERROR(fmt, args...)
+# define LOG_WARN(fmt, args...)
+# define LOG_INFO(fmt, args...)
+#endif /* LOG_ENABLE */
+
+#endif /*LOG_H_*/
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146audio.c 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146audio.c
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146audio.c	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146audio.c	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,343 @@
+/*
+ *  SAA7146 audio stream abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#include <linux/types.h>
+#include "log.h"
+#include "saa7146.h"
+#include "saa7146i2s.h"
+#include "saa7146audio.h"
+
+/**
+ * Address maps for Audio DMA Control PCI_ADP, BaseAx_x, ProtAx_x, PageAx_x and
+ * MC1 Audio Transfer Enable: 1st dim. index corresponds to
+ * enum audio_interfaces's, 2nd to enum directions's.
+ * TODO: decouple from saa7146i2s.h by providing a function that makes a
+ *       reliable mapping (independent of int values of enum members).
+ */
+static const int Base[2][2] = {{BaseA1_in, BaseA1_out},
+				{BaseA2_in, BaseA2_out} };
+static const int Prot[2][2] = {{ProtA1_in, ProtA1_out},
+				{ProtA2_in, ProtA2_out} };
+static const int Page[2][2] = {{PageA1_in, PageA1_out},
+				{PageA2_in, PageA2_out} };
+static const int TR_E[2][2] = {{TR_E_A1_IN, TR_E_A1_OUT},
+				{TR_E_A2_IN, TR_E_A2_OUT} };
+static const int PCI_ADP[2][2] = {{PCI_ADP2, PCI_ADP1},
+				{PCI_ADP4, PCI_ADP3} };
+
+/* forward declarations */
+static struct audio_stream *stream_prepare(struct saa7146audio *chipaudio,
+					unsigned int stream_nr,
+					unsigned long buffer_base_addr,
+					int buffer_size,
+					int channel_count,
+					int sample_length,
+					enum endian endian,
+					enum directions direction);
+static int stream_check_resources(struct saa7146audio *chipaudio,
+				unsigned int stream_nr,
+				int channel_count,
+				int sample_length,
+				enum endian endian,
+				enum directions direction);
+static int stream_init(struct saa7146audio *chipaudio,
+			struct audio_stream *stream,
+			unsigned int stream_nr,
+			unsigned long buffer_base_addr,
+			int buffer_size,
+			int channel_count,
+			int sample_length,
+			enum endian endian,
+			enum directions direction);
+static int stream_setup_dma(struct saa7146audio *chipaudio,
+				struct audio_stream *audio_stream);
+static int is_valid_period(int period);
+
+/**
+ * see saa7146audio.h
+ */
+struct audio_stream *saa7146_stream_prepare_capture(
+					struct saa7146audio *chipaudio,
+					unsigned int stream_nr,
+					unsigned long buffer_base_addr,
+					int buffer_size,
+					int channel_count,
+					int sample_length,
+					enum endian endian)
+{
+	return stream_prepare(chipaudio, stream_nr, buffer_base_addr,
+			buffer_size, channel_count, sample_length, endian, in);
+}
+
+/**
+ * see saa7146audio.h
+ */
+struct audio_stream *saa7146_stream_prepare_playback(
+					struct saa7146audio *chipaudio,
+					unsigned int stream_nr,
+					unsigned long buffer_base_addr,
+					int buffer_size,
+					int channel_count,
+					int sample_length,
+					enum endian endian)
+{
+	return stream_prepare(chipaudio, stream_nr, buffer_base_addr,
+			buffer_size, channel_count, sample_length, endian, out);
+}
+
+/**
+ * see saa7146audio.h
+ */
+void saa7146_stream_unprepare(struct saa7146audio *chipaudio,
+				struct audio_stream *stream)
+{
+	int i = 0;
+	struct i2s_device *device = NULL;
+
+	if (stream != NULL) {
+		stream->number = -1;
+		stream->state = disabled;
+		stream->direction = in;
+		stream->channel_count = 0;
+		stream->sample_length = 0;
+		stream->endian = le;
+		stream->buffer_base_addr = 0;
+		stream->buffer_size = 0;
+		stream->audio_interface = NULL;
+		for (i = 0; i < MAX_I2S_DEVICES; i++) {
+			device = stream->i2s_devices[i];
+			if (device != NULL) {
+				saa7146_i2s_disable_device(&chipaudio->chipi2s,
+									device);
+				stream->i2s_devices[i] = NULL;
+			}
+		}
+	}
+}
+
+/**
+ * see saa7146audio.h
+ */
+void saa7146_stream_start(struct saa7146audio *chipaudio,
+				struct audio_stream *stream)
+{
+	int tr_e;
+
+	if (stream == NULL) {
+		LOG_WARN("stream pointer is NULL");
+		return;
+	}
+	/* enable DMA Ax IN/OUT */
+	tr_e = TR_E[stream->audio_interface->id][stream->direction];
+	saa7146_write(&chipaudio->chipi2s.chip, MC1, (tr_e<<16 | tr_e));
+	saa7146_i2s_enable_audio_interface(&chipaudio->chipi2s,
+						stream->audio_interface);
+}
+
+/**
+ * see saa7146audio.h
+ */
+void saa7146_stream_stop(struct saa7146audio *chipaudio,
+				struct audio_stream *stream)
+{
+	int tr_e;
+
+	if (stream == NULL) {
+		LOG_WARN("stream pointer is NULL");
+		return;
+	}
+	saa7146_i2s_disable_audio_interface(&chipaudio->chipi2s,
+						stream->audio_interface);
+	/* disable DMA Ax IN/OUT */
+	tr_e = TR_E[stream->audio_interface->id][stream->direction];
+	saa7146_write(&chipaudio->chipi2s.chip, MC1, (tr_e<<16));
+}
+
+/**
+ * see saa7146audio.h
+ */
+uint32_t saa7146_stream_get_hw_pointer(struct saa7146audio *chipaudio,
+					struct audio_stream *stream)
+{
+	uint32_t hw_ptr = 0;
+
+	if (stream == NULL) {
+		LOG_WARN("stream pointer is NULL");
+		return hw_ptr;
+	}
+	hw_ptr = saa7146_read(&chipaudio->chipi2s.chip,
+		PCI_ADP[stream->audio_interface->id][stream->direction]);
+	return hw_ptr;
+}
+
+static struct audio_stream *stream_prepare(struct saa7146audio *chipaudio,
+					unsigned int stream_nr,
+					unsigned long buffer_base_addr,
+					int buffer_size,
+					int channel_count,
+					int sample_length,
+					enum endian endian,
+					enum directions direction)
+{
+	struct audio_stream *stream = NULL;
+	int max_streams = (direction == in ?
+				MAX_IN_AUDIO_STREAMS : MAX_OUT_AUDIO_STREAMS);
+	struct audio_stream *streams = (direction == in ?
+				chipaudio->in_streams : chipaudio->out_streams);
+
+	if (stream_nr > max_streams || streams[stream_nr].state == enabled) {
+		LOG_WARN("Stream nr=%d not available", stream_nr);
+		return NULL;
+	}
+	stream = &streams[stream_nr];
+	if (stream_check_resources(chipaudio, stream_nr, channel_count,
+				sample_length, endian, direction) != 0)
+		return NULL;
+	if (stream_init(chipaudio, stream, stream_nr, buffer_base_addr,
+		buffer_size, channel_count, sample_length, endian, direction)
+									!= 0)
+		return NULL;
+	if (stream_setup_dma(chipaudio, stream) != 0)
+		return NULL;
+	return stream;
+}
+
+/**
+ * Check if the requested resources (channels, sample-length, endian) are
+ * available.
+ */
+static int stream_check_resources(struct saa7146audio *chipaudio,
+				unsigned int stream_nr,
+				int channel_count,
+				int sample_length,
+				enum endian endian,
+				enum directions direction)
+{
+	int i = 0;
+	int available_channels = 0;
+	int available_frame_length = 0;
+	struct i2s_device *device = NULL;
+	struct audio_interface *ai = NULL;
+
+	ai = &chipaudio->chipi2s.audio_interfaces[stream_nr];
+	available_frame_length = ai->i2s_superframe_length;
+	for (i = 0; i < MAX_I2S_DEVICES; i++) {
+		device = ai->i2s_devices[i];
+		if (device != NULL && device->direction == direction) {
+			if (device->state == disabled)
+				available_channels += 2;
+			else if (device->state == enabled &&
+					device->direction == in &&
+					device->endian != endian) {
+				LOG_WARN("Endian %s not available for capture"
+					" on audio-interface %s.",
+					(endian == le ? "le" : "be"),
+					ai->id == a1 ? "A1" : "A2");
+				return -1;
+			} else {
+				available_frame_length -=
+						2 * device->sample_length;
+			}
+		}
+	}
+	if (available_channels < channel_count ||
+		available_frame_length < (channel_count * sample_length)) {
+		LOG_WARN("Not sufficient resources available.");
+		return -1;
+	}
+	return 0;
+}
+
+static int stream_init(struct saa7146audio *chipaudio,
+			struct audio_stream *stream,
+			unsigned int stream_nr,
+			unsigned long buffer_base_addr,
+			int buffer_size,
+			int channel_count,
+			int sample_length,
+			enum endian endian,
+			enum directions direction)
+{
+	int i;
+	struct i2s_device *device = NULL;
+
+	stream->number = stream_nr;
+	stream->state = enabled;
+	stream->direction = direction;
+	stream->channel_count = channel_count;
+	stream->sample_length = sample_length;
+	stream->endian = endian;
+	stream->buffer_base_addr = buffer_base_addr;
+	stream->buffer_size = buffer_size;
+	stream->audio_interface =
+				&chipaudio->chipi2s.audio_interfaces[stream_nr];
+	for (i = 0; (i < MAX_I2S_DEVICES) && (channel_count > 0); i++) {
+		device = stream->audio_interface->i2s_devices[i];
+		if (device != NULL && device->state == disabled &&
+					device->direction == direction) {
+			if (saa7146_i2s_enable_device(&chipaudio->chipi2s,
+							device,
+							sample_length,
+							endian) != 0)
+				return -1;
+			/* use ws as index where device is stored in array */
+			stream->i2s_devices[device->ws] = device;
+			channel_count -= 2;
+		}
+	}
+	return 0;
+}
+
+static int stream_setup_dma(struct saa7146audio *chipaudio,
+				struct audio_stream *stream)
+{
+	int exp = 0;
+	int limit = 0;
+	enum audio_interfaces ai_nr = stream->audio_interface->id;
+	enum directions dir = stream->direction;
+	struct saa7146reg *chip = &chipaudio->chipi2s.chip;
+
+	if (!is_valid_period(stream->buffer_size >> 1)) {
+		LOG_ERROR("Invalid buffer size %d", stream->buffer_size);
+		return -1;
+	}
+	/* find exponent for period, required to figure out the DMA IRQ limit */
+	limit = stream->buffer_size >> 1; /* period is buffer_size/2 */
+	for (exp = 0; limit > 0; limit >>= 1, exp++);
+	/* LimitAx_in = exp - 6 (minimum limit is 64bytes = 2^6) */
+	limit = exp - 6;
+	saa7146_write(chip, Base[ai_nr][dir], stream->buffer_base_addr);
+	saa7146_write(chip, Prot[ai_nr][dir],
+				stream->buffer_base_addr + stream->buffer_size);
+	/* PageA1_in=0, MEA1_in=0, LimitA1_in=limit, PVA1_in=0 */
+	saa7146_write(chip, Page[a1][dir], limit << 4);
+	return 0;
+}
+
+/**
+ * Period size must be >= 64bytes <= 1Mb and a power of 2.
+ * This is a restriction imposed by the SAA7146 DMA capabilities: the period at
+ * which DMA IRQs are generated is 64*2^n where n={1-14}.
+ * @return 1 if the given period is valid.
+ */
+static int is_valid_period(int period)
+{
+	return (period >= 64) && (period <= (1 << 20)) && is_pow_of_2(period);
+}
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146audio.h 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146audio.h
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146audio.h	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146audio.h	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,120 @@
+/*
+ *  SAA7146 audio stream abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#ifndef SAA7146AUDIO_H_
+#define SAA7146AUDIO_H_
+
+#include <linux/types.h>
+#include "saa7146i2s.h"
+
+#define MAX_IN_AUDIO_STREAMS	2 /* SAA7146 has 2 IN-DMA channels */
+#define MAX_OUT_AUDIO_STREAMS	2 /* SAA7146 has 2 OUT-DMA channels */
+
+/**
+ * TODO: description
+ * Some of this struct's members also occur on i2s_device: this is because
+ * the 'stream abstraction' is built on top of the 'i2s abstraction'.
+ */
+struct audio_stream {
+	int number; /* stream number - corresponds to ALSA subdevice number */
+	enum states state;
+	enum directions direction;
+	int channel_count;
+	int sample_length; /* all stream channels have equal sample length */
+	enum endian endian; /* all stream channels have equal endian */
+	unsigned long buffer_base_addr;
+	int buffer_size;
+	/* a stream is controlled by one audio-interface */
+	struct audio_interface *audio_interface;
+	/* a stream can have multiple i2c devices (one per stereo channels) */
+	struct i2s_device *i2s_devices[MAX_I2S_DEVICES];
+};
+
+/**
+ * TODO: description
+ */
+struct saa7146audio {
+	struct saa7146i2s chipi2s;
+	/* we are the 'owner' of all streams */
+	struct audio_stream in_streams[MAX_IN_AUDIO_STREAMS];
+	struct audio_stream out_streams[MAX_OUT_AUDIO_STREAMS];
+};
+
+/**
+ * TODO: description
+ * @param chipaudio used for SAA7146 I2S ctrl and register access over PCI bus,
+ * must not be NULL.
+ * @return A reference to an audio_stream structure, or NULL in case the
+ * stream could not be opened.
+ */
+struct audio_stream *saa7146_stream_prepare_capture(
+					struct saa7146audio *chipaudio,
+					unsigned int stream_nr,
+					unsigned long buffer_base_addr,
+					int buffer_size,
+					int channel_count,
+					int sample_length,
+					enum endian endian);
+
+/**
+ * TODO: description
+ * @param chipaudio used for SAA7146 I2S ctrl and register access over PCI bus,
+ * must not be NULL.
+ * @return A reference to an audio_stream structure, or NULL in case the
+ * stream could not be opened.
+ */
+struct audio_stream *saa7146_stream_prepare_playback(
+					struct saa7146audio *chipaudio,
+					unsigned int stream_nr,
+					unsigned long buffer_base_addr,
+					int buffer_size,
+					int channel_count,
+					int sample_length,
+					enum endian endian);
+
+/**
+ * TODO: description
+ * @param chipaudio used for SAA7146 I2S ctrl and register access over PCI bus,
+ * must not be NULL.
+ * @param stream A reference to an audio_stream structure, opened with
+ * saa7146_open_xxxxx_stream().
+ */
+void saa7146_stream_unprepare(struct saa7146audio *chipaudio,
+				struct audio_stream *stream);
+
+/**
+ * TODO: description
+ */
+void saa7146_stream_start(struct saa7146audio *chipaudio,
+				struct audio_stream *stream);
+
+/**
+ * TODO: description
+ */
+void saa7146_stream_stop(struct saa7146audio *chipaudio,
+				struct audio_stream *stream);
+
+/**
+ * TODO: description
+ */
+uint32_t saa7146_stream_get_hw_pointer(struct saa7146audio *chipaudio,
+					struct audio_stream *stream);
+
+#endif /*SAA7146AUDIO_H_*/
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146.h 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146.h
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146.h	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146.h	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,216 @@
+/*
+ *  SAA7146 register access abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *  Based on GPLed Emagic Audiowerk8 Windows driver provided by Martijn Sipkema.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#ifndef SAA7146_H_
+#define SAA7146_H_
+
+#include <linux/types.h>
+#include <linux/pci.h>
+
+/**
+ * SAA7146 chip access data structure
+ */
+struct saa7146reg {
+	unsigned long iobase_phys;
+	void __iomem *iobase_virt;
+	int iolen;
+};
+
+/**
+ * Read an SAA7146 register, mind that PCI is little-endian.
+ * @param chip used for SAA7146 register access over PCI bus
+ * @param offset register address offset
+ * @return contents of register at the given address offset
+ */
+static inline uint32_t saa7146_read(struct saa7146reg *chip, int offset)
+{
+	return __le32_to_cpu(readl(chip->iobase_virt + offset));
+}
+
+/**
+ * Write an SAA7146 register, mind that PCI is little-endian.
+ * @param chip used for SAA7146 register access over PCI bus
+ * @param offset register address offset
+ * @param data the data to be written at the given address offset
+ */
+static inline void saa7146_write(struct saa7146reg *chip,
+				int offset,
+				uint32_t data)
+{
+	writel(__cpu_to_le32(data), chip->iobase_virt + offset);
+}
+
+/* SAA7146 register offset */
+#define PCI_BT_A	0x4C
+#define IICTRF		0x8C
+#define IICSTA		0x90
+#define BaseA1_in	0x94
+#define ProtA1_in	0x98
+#define PageA1_in	0x9C
+#define BaseA1_out	0xA0
+#define ProtA1_out	0xA4
+#define PageA1_out	0xA8
+#define BaseA2_in	0xAC
+#define ProtA2_in	0xB0
+#define PageA2_in	0xB4
+#define BaseA2_out	0xB8
+#define ProtA2_out	0xBC
+#define PageA2_out	0xC0
+#define IER		0xDC
+#define GPIO_CTRL	0xE0
+#define ACON1		0xF4
+#define ACON2		0xF8
+#define MC1		0xFC
+#define MC2		0x100
+#define ISR		0x10C
+#define PSR		0x110
+#define SSR		0x114
+#define PCI_ADP1	0x12C
+#define PCI_ADP2	0x130
+#define PCI_ADP3	0x134
+#define PCI_ADP4	0x138
+#define LEVEL_REP	0x140
+#define FB_BUFFER1	0x144
+#define FB_BUFFER2	0x148
+#define TSL1		0x180
+#define TSL2		0x1C0
+
+/* PSR/ISR/IER */
+#define PPEF		(1UL << 31)
+#define PABO		(1UL << 30)
+#define IIC_S		(1UL << 17)
+#define IIC_E		(1UL << 16)
+#define A2_in		(1UL << 15)
+#define A2_out		(1UL << 14)
+#define A1_in		(1UL << 13)
+#define A1_out		(1UL << 12)
+#define AFOU		(1UL << 11)
+#define PIN3		(1UL << 6)
+#define PIN2		(1UL << 5)
+#define PIN1		(1UL << 4)
+#define PIN0		(1UL << 3)
+#define ECS		(1UL << 2)
+#define EC3S		(1UL << 1)
+#define EC0S		(1UL << 0)
+
+/* SSR */
+#define PRQ		(1UL << 31)
+#define PMA		(1UL << 30)
+#define IIC_EA		(1UL << 21)
+#define IIC_EW		(1UL << 20)
+#define IIC_ER		(1UL << 19)
+#define IIC_EL		(1UL << 18)
+#define IIC_EF		(1UL << 17)
+#define AF2_in		(1UL << 10)
+#define AF2_out	(1UL << 9)
+#define AF1_in		(1UL << 8)
+#define AF1_out	(1UL << 7)
+#define EC5S		(1UL << 3)
+#define EC4S		(1UL << 2)
+#define EC2S		(1UL << 1)
+#define EC1S		(1UL << 0)
+
+/* PCI_BT_A */
+#define BurstA1_in	(1UL << 26)
+#define ThreshA1_in	(1UL << 24)
+#define BurstA1_out	(1UL << 18)
+#define ThreshA1_out	(1UL << 16)
+#define BurstA2_in	(1UL << 10)
+#define ThreshA2_in	(1UL << 8)
+#define BurstA2_out	(1UL << 2)
+#define ThreshA2_out	(1UL << 0)
+
+/* MC1 */
+#define MRST_N		(1UL << 15)
+#define EAP		(1UL << 9)
+#define EI2C		(1UL << 8)
+#define TR_E_A2_OUT	(1UL << 3)
+#define TR_E_A2_IN	(1UL << 2)
+#define TR_E_A1_OUT	(1UL << 1)
+#define TR_E_A1_IN	(1UL << 0)
+
+/* MC2 */
+#define UPLD_IIC	(1UL << 0)
+
+/* ACON1 bit offsets */
+#define ACON1_AUDIO_MODE	29
+#define ACON1_MAXLEVEL		22
+#define ACON1_A1_SWAP		21
+#define ACON1_A2_SWAP		20
+#define ACON1_WS0_CTRL		18
+#define ACON1_WS0_SYNC		16
+#define ACON1_WS1_CTRL		14
+#define ACON1_WS1_SYNC		12
+#define ACON1_WS2_CTRL		10
+#define ACON1_WS2_SYNC		8
+#define ACON1_WS3_CTRL		6
+#define ACON1_WS3_SYNC		4
+#define ACON1_WS4_CTRL		2
+#define ACON1_WS4_SYNC		0
+
+/* ACON2 bit offsets */
+#define ACON2_A1_CLKSRC	27
+#define ACON2_A2_CLKSRC	22
+#define ACON2_INVERT_BCLK1	21
+#define ACON2_INVERT_BCLK2	20
+#define ACON2_BCLK1_OEN	19
+#define ACON2_BCLK2_OEN	18
+
+/* TSL bit offsets */
+#define TSL_EOS		0
+#define TSL_LOW_A2		1
+#define TSL_DOD_A2		2
+#define TSL_BSEL_A2		4
+#define TSL_LF_A2		7
+#define TSL_SF_A2		8
+#define TSL_SIB_A2		9
+#define TSL_SDW_A2		10
+#define TSL_DIS_A2		11
+#define TSL_LOW_A1		14
+#define TSL_DOD_A1		15
+#define TSL_BSEL_A1		17
+#define TSL_LF_A1		20
+#define TSL_SF_A1		21
+#define TSL_SIB_A1		22
+#define TSL_SDW_A1		23
+#define TSL_DIS_A1		24
+#define TSL_WS4		27
+#define TSL_WS3		28
+#define TSL_WS2		29
+#define TSL_WS1		30
+#define TSL_WS0		31
+
+/* SD pin select for DIS_Ax and DOD_Ax */
+#define SD0_I_A2		0
+#define SD0_O_A1		0
+#define SD1_IO_Ax		1
+#define SD2_IO_Ax		2
+#define SD3_IO_Ax		3
+#define SD4_I_A1		0
+#define SD4_O_A2		0
+
+/* ACON1 WSx_CTRL select */
+#define ACON1_WSx_CTRL_IN_TSLx		0
+#define ACON1_WSx_CTRL_OUT_TSL1	1
+#define ACON1_WSx_CTRL_OUT_TSL2	2
+#define ACON1_WSx_CTRL_LOW		3
+#define ACON1_WSx_SYNC_I2S		0
+
+#endif /*SAA7146_H_*/
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2c.c 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2c.c
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2c.c	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2c.c	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,270 @@
+/*
+ *  SAA7146 I2C-bus abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#include <linux/types.h>
+#include <linux/sched.h>
+#include "log.h"
+#include "saa7146.h"
+#include "saa7146i2c.h"
+
+/* Convenience macros */
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+/**
+ * See SAA7146 tech. specification p.122 - 126 for details.
+ */
+
+#define IICSTA_ABORT	0x80
+#define IICSTA_ERR_BSY	0x7f
+#define MC1_EI2C	0x01000000
+#define MC2_UPLD_IIC	0x00010000
+#define START		3
+#define CONT		2
+#define STOP		1
+#define NOP		0
+#define RW		1
+
+/**
+ * SAA7146 available i2c clock rates to Hz mapping:
+ * The i2c status register clock-rate value is equal to the array index of its
+ * Hz value => order matters!
+ */
+static const unsigned int i2c_clk_2_hz[] = {
+	266000, /* PCI clock/120  at index 0 */
+	10000,  /* PCI clock/3200 at index 1 */
+	400000, /* PCI clock/80   at index 2 */
+	533000, /* PCI clock/60   at index 3 */
+	66000,  /* PCI clock/480  at index 4 */
+	5000,   /* PCI clock/6400 at index 5 */
+	100000, /* PCI clock/320  at index 6 */
+	133000, /* PCI clock/240  at index 7 */
+};
+
+/* forward declarations */
+static int i2c_open(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clk,
+			int read,
+			uint8_t dev_addr,
+			uint8_t *sub_addr,
+			unsigned int sub_addr_size);
+static int i2c_transmit(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clk,
+			int read,
+			uint8_t *buf,
+			unsigned int buf_size);
+static int i2c_transmit_byte(struct saa7146reg *chip,
+				enum saa7146_i2c_clock clk,
+				int read,
+				uint8_t *byte,
+				int cmd);
+static void i2c_prepare(struct saa7146reg *chip, enum saa7146_i2c_clock clk);
+static void i2c_upload(struct saa7146reg *chip, int offset, uint32_t data);
+static void i2c_wait(enum saa7146_i2c_clock clk, int bytes_to_send);
+static void i2c_abort(struct saa7146reg *chip);
+
+/**
+ * see saa7146i2c.h
+ */
+int saa7146_i2c_read(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clk,
+			uint8_t dev_addr,
+			uint8_t *sub_addr,
+			int sub_addr_size,
+			uint8_t *buffer,
+			int size)
+{
+	uint32_t ret_val = 0;
+
+	ret_val = i2c_open(chip, clk, RW, dev_addr, sub_addr, sub_addr_size);
+	if (ret_val >= 0)
+		ret_val = i2c_transmit(chip, clk, RW, buffer, size);
+	return ret_val;
+}
+
+/**
+ * see saa7146i2c.h
+ */
+int saa7146_i2c_write(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clk,
+			uint8_t dev_addr,
+			uint8_t *sub_addr,
+			int sub_addr_size,
+			uint8_t *data,
+			int size)
+{
+	uint32_t ret_val = 0;
+
+	ret_val = i2c_open(chip, clk, !RW, dev_addr, sub_addr, sub_addr_size);
+	if (ret_val >= 0)
+		ret_val = i2c_transmit(chip, clk, !RW, data, size);
+	return ret_val;
+}
+
+/**
+ * Open an i2c device:
+ * 1) transmit device-address, r/w == low and startcondition
+ * 2) optionally transmit subaddress
+ * 3) in case of READ operation, transmit device-address again with r/w == high
+ *    and startcondition.
+ * @return number of address bytes sent or -1 in case of failure.
+ */
+static int i2c_open(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clk,
+			int read,
+			uint8_t dev_addr,
+			uint8_t *sub_addr,
+			unsigned int sub_addr_size)
+{
+	int sub_addr_bytes_transmitted = 0;
+	uint8_t addr = 0;
+
+	i2c_prepare(chip, clk);
+	addr = (dev_addr<<1)&~RW;
+	if (i2c_transmit_byte(chip, clk, read, &addr, START) != 0) {
+		LOG_ERROR("i2c address phase");
+		return -1;
+	}
+	while (sub_addr_bytes_transmitted < sub_addr_size) {
+		if (i2c_transmit_byte(chip, clk, read, sub_addr++, CONT) != 0) {
+			LOG_ERROR("i2c subaddress phase");
+			return -1;
+		}
+		sub_addr_bytes_transmitted++;
+	}
+	if (read) {
+		addr = (dev_addr<<1)|RW;
+		if (i2c_transmit_byte(chip, clk, read, &addr, START) != 0) {
+			LOG_ERROR("i2c prepare READ phase");
+			return -1;
+		}
+	}
+	return sub_addr_bytes_transmitted;
+}
+
+/**
+ * Transmit data on i2c-bus: transfer is closed when all data is transmitted.
+ * Call this function after i2c_open().
+ * @return number of bytes transmitted or -1 in case of failure.
+ */
+static int i2c_transmit(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clk,
+			int read,
+			uint8_t *buffer,
+			unsigned int size)
+{
+	int bytes_transmitted = 0;
+	int attr = 0;
+
+	while (bytes_transmitted < size) {
+		attr = (bytes_transmitted++ < (size - 1) ? CONT : STOP);
+		if (i2c_transmit_byte(chip, clk, read, buffer++, attr) != 0) {
+			LOG_ERROR("i2c data transmission phase");
+			return -1;
+		}
+	}
+	saa7146_write(chip, MC1, MC1_EI2C | 0); /* disable i2c */
+	return bytes_transmitted;
+}
+
+/**
+ * In order to keep the implementation simple, we transmit only one byte per
+ * i2c-upload (IICTRF BYTE2).
+ */
+static int i2c_transmit_byte(struct saa7146reg *chip,
+				enum saa7146_i2c_clock clk,
+				int read,
+				uint8_t *byte,
+				int attr)
+{
+	uint32_t iictrf = 0; /* BYTE0..2 = 0, ATTR0..2 = NOP */
+	uint32_t iicsta = 0;
+
+	iictrf = (*byte) << (8*3) | attr << (2*3);
+	i2c_upload(chip, IICTRF, iictrf);
+	i2c_wait(clk, 1);
+	iicsta = saa7146_read(chip, IICSTA);
+	if ((iicsta & IICSTA_ERR_BSY) != 0) {
+		i2c_abort(chip);
+		LOG_ERROR("IICSTA=%#010lx", (long)iicsta);
+		return -1;
+	}
+	if (read) {
+		iictrf = saa7146_read(chip, IICTRF);
+		*byte = iictrf >> (8*3);
+	}
+	return 0;
+}
+
+/**
+ * Enable i2c, abort all pending operations, clear all errors (may be needed 2x
+ * after abort) and set clock rate.
+ */
+static void i2c_prepare(struct saa7146reg *chip, enum saa7146_i2c_clock clk)
+{
+	saa7146_write(chip, MC1, MC1_EI2C | EI2C);
+	i2c_upload(chip, IICSTA, IICSTA_ABORT);
+	i2c_upload(chip, IICSTA, 0);
+	i2c_upload(chip, IICSTA, (clk << 8));
+}
+
+/**
+ * Upload I2C register IICSTA and IICTRF from shadow RAM.
+ */
+static void i2c_upload(struct saa7146reg *chip, int offset, uint32_t data)
+{
+	if ((offset == IICSTA) || (offset == IICTRF)) {
+		saa7146_write(chip, offset, data);
+		saa7146_write(chip, MC2, (MC2_UPLD_IIC | UPLD_IIC));
+	}
+}
+
+/**
+ * Wait for a i2c transmission to complete.
+ * The required delay is calculated on the basis of the given clock-rate and
+ * the number of bytes to transmit:
+ * - each byte is followed by ACK i.e. there are 9 clock-cycles/byte, we add
+ *   one for safety
+ * - the kernel's scheduler tick (HZ) is used as time base and we add one tick
+ *   for safety
+ *
+ * 	delay[ms] = (bytes_to_send*10[bits]/clock[1/s]*1000)*HZ/1000 + 1
+ *
+ * The function returns after the required delay, regardless of the i2c state.
+ */
+static void i2c_wait(enum saa7146_i2c_clock clk, int bytes_to_send)
+{
+	int delay = 0;
+
+	delay = ((bytes_to_send*10*HZ)/i2c_clk_2_hz[clk]) + 1;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(MAX(1, delay));
+}
+
+/**
+ * Abort all pending operations, clear all errors (may be needed 2x after abort)
+ * set clock rate to lowset possible and finally disable i2c.
+ */
+static void i2c_abort(struct saa7146reg *chip)
+{
+	i2c_upload(chip, IICSTA, IICSTA_ABORT);
+	i2c_upload(chip, IICSTA, 0);
+	i2c_upload(chip, IICSTA, (bps_5k << 8));
+	saa7146_write(chip, MC1, MC1_EI2C | 0);
+}
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2c.h 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2c.h
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2c.h	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2c.h	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,81 @@
+/*
+ *  SAA7146 I2C-bus abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#ifndef SAA7146I2C_H_
+#define SAA7146I2C_H_
+
+#include <linux/types.h>
+#include "saa7146.h"
+
+/**
+ * SAA7146 available i2c clock rates (reg IICSTA IICCC[2:0] bit 8..10)
+ */
+enum saa7146_i2c_clock {
+	bps_5k = 5,   /* PCI clock/6400 */
+	bps_10k = 1,  /* PCI clock/3200 */
+	bps_66k = 4,  /* PCI clock/480  */
+	bps_100k = 6, /* PCI clock/320  */
+	bps_133k = 7, /* PCI clock/240  */
+	bps_266k = 0, /* PCI clock/120  */
+	bps_400k = 2, /* PCI clock/80   */
+	bps_533k = 3  /* PCI clock/60   */
+};
+
+/**
+ * Write n bytes to i2c bus.
+ * @param chip Used for SAA7146 register access over PCI bus
+ * @param clock One of the SAA7146 available i2c bit rates
+ * @param dev_addr the i2c (slave-) device address 7-bit
+ * @param sub_addr the i2c (slave-) device sub-address
+ * @param sub_addr_size The size of the sub-address, can be 0 if no sub-address
+ * is provided
+ * @param data Data to be written
+ * @param size Size of data to be written, must be >= 0
+ * @return Number of bytes written or -1 in case of failure
+ */
+int saa7146_i2c_write(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clock,
+			uint8_t dev_addr,
+			uint8_t *sub_addr,
+			int sub_addr_size,
+			uint8_t *data,
+			int size);
+
+/**
+ * Read n bytes from i2c bus.
+ * @param chip Used for SAA7146 register access over PCI bus
+ * @param clock One of the SAA7146 available i2c bit rates
+ * @param dev_addr the i2c (slave-) device address 7-bit
+ * @param sub_addr the i2c (slave-) device sub-address
+ * @param sub_addr_size The size of the sub-address, can be 0 if no sub-address
+ * is provided
+ * @param buffer Data buffer for bytes to be read.
+ * @param size Size of data to be read, must be >= 0.
+ * @return Number of bytes read or -1 in case of failure.
+ */
+int saa7146_i2c_read(struct saa7146reg *chip,
+			enum saa7146_i2c_clock clock,
+			uint8_t dev_addr,
+			uint8_t *sub_addr,
+			int sub_addr_size,
+			uint8_t *buffer,
+			int size);
+
+#endif /*SAA7146I2C_H_*/
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2s.c 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2s.c
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2s.c	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2s.c	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,437 @@
+/*
+ *  SAA7146 I2S and audio-interface abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#include <linux/types.h>
+#include "log.h"
+#include "saa7146.h"
+#include "saa7146i2s.h"
+
+/* Convenience macros */
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
+#define DWBUF_SIZE 4 /* SAA7146 audiointerface's DWORD buffer size */
+#define MAX_SUPERFRAME_LENGTH 16 /* 32 byte superframe is not supported */
+#define MIN_SUPERFRAME_LENGTH DWBUF_SIZE /* must be >= DWORD buffer length */
+
+/**
+ * TSL address map: array pos. corresponds to enum audio_interfaces
+ */
+static const int TSLx[2] = {TSL1, TSL2};
+
+/**
+ * TSL bit offse maps: array pos. corresponds to enum audio_interfaces
+ */
+static const int TSL_DIS_Ax[2] =  {TSL_DIS_A1,  TSL_DIS_A2};
+static const int TSL_SIB_Ax[2] =  {TSL_SIB_A1,  TSL_SIB_A2};
+static const int TSL_SDW_Ax[2] =  {TSL_SDW_A1,  TSL_SDW_A2};
+static const int TSL_SF_Ax[2] =   {TSL_SF_A1,   TSL_SF_A2};
+static const int TSL_LF_Ax[2] =   {TSL_LF_A1,   TSL_LF_A2};
+static const int TSL_BSEL_Ax[2] = {TSL_BSEL_A1, TSL_BSEL_A2};
+static const int TSL_DOD_Ax[2] =  {TSL_DOD_A1,  TSL_DOD_A2};
+
+/**
+ * ACON1 SWAP_Ax bit offset map: array pos. corresponds to enum audio_interfaces
+ */
+static const int ACON1_Ax_SWAP[2] = {ACON1_A1_SWAP, ACON1_A2_SWAP};
+
+/**
+ * ACON1 WSx_CTRL value map: array pos. correspond to enum audio_interfaces
+ */
+static const int ACON1_WSx_CTRL_OUT_TSLx[2] = {ACON1_WSx_CTRL_OUT_TSL1,
+						ACON1_WSx_CTRL_OUT_TSL2};
+
+/**
+ * ACON1 WSx_CTRL bit offset map: array pos. corresponds to enum ws_lines
+ */
+static const int ACON1_WSx_CTRL[5] = {ACON1_WS0_CTRL,
+					ACON1_WS1_CTRL,
+					ACON1_WS2_CTRL,
+					ACON1_WS3_CTRL,
+					ACON1_WS4_CTRL};
+
+/**
+ * ACON1 WSx_SYNC bit offset map: array pos. corresponds to enum ws_lines
+ */
+static const int ACON1_WSx_SYNC[5] = {ACON1_WS0_SYNC,
+					ACON1_WS1_SYNC,
+					ACON1_WS2_SYNC,
+					ACON1_WS3_SYNC,
+					ACON1_WS4_SYNC};
+
+/**
+ * TSL WSx bit offset map: array pos. correspond to enum ws_lines
+ */
+static const int TSL_WSx[5] = {TSL_WS0,
+				TSL_WS1,
+				TSL_WS2,
+				TSL_WS3,
+				TSL_WS4};
+
+/**
+ * TSL SDx bit value map: array pos. corresponds to enum sd_lines
+ */
+static const int TSL_SDx[7] = {SD0_I_A2,
+				SD0_O_A1,
+				SD1_IO_Ax,
+				SD2_IO_Ax,
+				SD3_IO_Ax,
+				SD4_I_A1,
+				SD4_O_A2};
+
+/* forward declarations */
+static int tsl_update(struct saa7146i2s *chipi2s,
+			struct audio_interface *audio_interface);
+static int tsl_build(struct audio_interface *audio_interface, uint32_t tsl[]);
+static int tsl_align_devices(struct audio_interface *audio_interface);
+static void tsl_prepare_capture_slot(struct i2s_device *dev,
+					uint32_t tsl[],
+					int slot,
+					int *total_bytes_cap);
+static void tsl_prepare_playback_slot(struct i2s_device *dev,
+					uint32_t tsl[],
+					int slot,
+					int *total_bytes_pbk,
+					int *bsel);
+static void setbits(uint32_t *reg,
+			unsigned int offset,
+			unsigned int len,
+			uint32_t val);
+
+/**
+ * see saa7146i2s.h
+ */
+int saa7146_i2s_init_audio_interface(struct saa7146i2s *chipi2s,
+					enum audio_interfaces ai_id,
+					int i2s_word_length,
+					int i2s_superframe_length)
+{
+	struct audio_interface *ai = NULL;
+
+	if (i2s_word_length > DWBUF_SIZE || i2s_word_length <= 0
+					|| !is_pow_of_2(i2s_word_length)) {
+		LOG_ERROR("Invalid i2s word-length %d",	i2s_word_length);
+		return -1;
+	}
+	if (i2s_superframe_length > MAX_SUPERFRAME_LENGTH ||
+		i2s_superframe_length < MIN_SUPERFRAME_LENGTH ||
+		!is_pow_of_2(i2s_superframe_length / i2s_word_length)) {
+		LOG_ERROR("Invalid i2s superframe-length %d",
+							i2s_superframe_length);
+		return -1;
+	}
+	ai = &chipi2s->audio_interfaces[ai_id];
+	ai->id = ai_id;
+	ai->i2s_word_length = i2s_word_length;
+	ai->i2s_superframe_length = i2s_superframe_length;
+	return 0;
+}
+
+/**
+ * see saa7146i2s.h
+ */
+void saa7146_i2s_enable_audio_interface(struct saa7146i2s *chipi2s,
+					struct audio_interface *ai)
+{
+	/* set AUDIO_MODE A1 and A2 independent */
+	if (ai->id == a1)
+		setbits(&chipi2s->acon1, ACON1_AUDIO_MODE, 1, 1);
+	else if (ai->id == a2)
+		setbits(&chipi2s->acon1, ACON1_AUDIO_MODE + 1, 1, 1);
+	saa7146_write(&chipi2s->chip, ACON1, chipi2s->acon1);
+}
+
+/**
+ * see saa7146i2s.h
+ */
+void saa7146_i2s_disable_audio_interface(struct saa7146i2s *chipi2s,
+					struct audio_interface *ai)
+{
+	/* set AUDIO_MODE A1 and A2 independent */
+	if (ai->id == a1)
+		setbits(&chipi2s->acon1, ACON1_AUDIO_MODE, 1, 0);
+	else if (ai->id == a2)
+		setbits(&chipi2s->acon1, ACON1_AUDIO_MODE + 1, 1, 0);
+	saa7146_write(&chipi2s->chip, ACON1, chipi2s->acon1);
+}
+
+/**
+ * see saa7146i2s.h
+ */
+int saa7146_i2s_init_device(struct saa7146i2s *chipi2s,
+				enum audio_interfaces ai_id,
+				enum directions dir,
+				enum ws_lines ws,
+				enum sd_lines sd)
+{
+	struct i2s_device *dev = NULL;
+
+	if (ws < MAX_I2S_DEVICES) {
+		dev = &chipi2s->i2s_devices[ws];
+		dev->ws = ws;
+		dev->sd = sd;
+		dev->sample_length = 0;
+		dev->endian = le;
+		dev->state = disabled;
+		dev->direction = dir;
+		dev->hw_mon = notmonitored;
+		dev->audio_interface = &chipi2s->audio_interfaces[ai_id];
+		dev->audio_interface->i2s_devices[ws] = dev;
+		/* set WS-Line active low (disable) by default */
+		setbits(&chipi2s->acon1, ACON1_WSx_CTRL[ws], 2,
+							ACON1_WSx_CTRL_LOW);
+	} else {
+		LOG_ERROR("invalid ws=%d", ws);
+		return -1;
+	}
+	return 0;
+}
+
+/**
+ * see saa7146i2s.h
+ */
+int saa7146_i2s_enable_device(struct saa7146i2s *chipi2s,
+				struct i2s_device *dev,
+				int sample_len,
+				enum endian endian)
+{
+	dev->sample_length = sample_len;
+	dev->endian = endian;
+	dev->state = enabled;
+	if (dev->direction == in) {
+		/* i2s WS config - for capture devices we assume slave mode */
+		setbits(&chipi2s->acon1, ACON1_WSx_CTRL[dev->ws], 2,
+							ACON1_WSx_CTRL_IN_TSLx);
+		/* handle endianness (see documentation in wiki) */
+		setbits(&chipi2s->acon1,
+			ACON1_Ax_SWAP[dev->audio_interface->id], 1,
+			(dev->endian == le) ? 0 : 1);
+	}
+	if (dev->direction == out) {
+		/* i2s WS config - for playback devices we assume master mode */
+		setbits(&chipi2s->acon1, ACON1_WSx_CTRL[dev->ws], 2,
+			ACON1_WSx_CTRL_OUT_TSLx[dev->audio_interface->id]);
+	}
+	setbits(&chipi2s->acon1, ACON1_WSx_SYNC[dev->ws], 2,
+							ACON1_WSx_SYNC_I2S);
+	saa7146_write(&chipi2s->chip, ACON1, chipi2s->acon1);
+	if (tsl_update(chipi2s, dev->audio_interface) != 0)
+		return -1;
+	return 0;
+}
+
+/**
+ * see saa7146i2s.h
+ */
+int saa7146_i2s_disable_device(struct saa7146i2s *chipi2s,
+				struct i2s_device *dev)
+{
+	dev->sample_length = 0;
+	dev->endian = le;
+	dev->state = disabled;
+	dev->hw_mon = notmonitored;
+	/* set WS-Line active low (disable) by default */
+	setbits(&chipi2s->acon1, ACON1_WSx_CTRL[dev->ws], 2,
+							ACON1_WSx_CTRL_LOW);
+	if (tsl_update(chipi2s, dev->audio_interface) != 0)
+		return -1;
+	return 0;
+}
+
+/**
+ * TODO: description
+ * TSL1 is always associated with A1, TSL2 with A2.
+ */
+static int tsl_update(struct saa7146i2s *chipi2s,
+			struct audio_interface *ai)
+{
+	int slot = 0;
+	uint32_t tsl[ai->i2s_superframe_length];
+
+	if (tsl_align_devices(ai) != 0)
+		return -1;
+	/* reset TSL array! */
+	for (slot = 0; slot < ai->i2s_superframe_length; tsl[slot++] = 0);
+	if (tsl_build(ai, tsl) == 0) {
+		for (slot = 0; slot < ai->i2s_superframe_length; slot++) {
+			saa7146_write(&chipi2s->chip,
+					TSLx[ai->id] + (4 * slot), tsl[slot]);
+		}
+		return 0;
+	}
+	return -1;
+}
+
+/**
+ * Build the TSL for the given audio-interface.
+ * The TSL is built from scratch, based on the properties of the devices that
+ * are controlled by the associated audio-interface.
+ * This function does not write the TSL down to the HW. This is done in
+ * tsl_update() - i.e. if this function fails the current TSL is not changed.
+ */
+static int tsl_build(struct audio_interface *ai, uint32_t tsl[])
+{
+	int i = 0;
+	int slot = 0;
+	int bsel = 0;
+	int total_bytes_cap = 0;
+	int total_bytes_pbk = 0;
+	struct i2s_device *dev = NULL;
+	int max_slots = ai->i2s_superframe_length;
+
+	for (slot = 0; slot < max_slots; slot++) {
+		for (i = 0; i < MAX_I2S_DEVICES; i++) {
+			dev = ai->i2s_devices[i];
+			if (dev != NULL && dev->state == enabled) {
+				if (dev->direction == in) {
+					tsl_prepare_capture_slot(dev, tsl,
+						slot, &total_bytes_cap);
+				} else if (dev->direction == out) {
+					tsl_prepare_playback_slot(dev, tsl,
+						slot, &total_bytes_pbk, &bsel);
+				}
+			}
+		}
+		/* Reset TSL pointer in the last timeslot */
+		setbits(&tsl[slot], TSL_EOS, 1, (slot == max_slots-1 ? 1 : 0));
+	}
+	if (total_bytes_cap > 0 && total_bytes_cap < DWBUF_SIZE) {
+		LOG_ERROR("Total sample-length of capture devices"
+			" on audio-interface %d < DWORD-buffer size => buffer"
+			" is never transfered to DMA", ai->id);
+		return -1;
+	}
+	if (total_bytes_pbk > 0 && total_bytes_pbk < DWBUF_SIZE) {
+		LOG_ERROR("Total sample-length of playback devices"
+			" on audio-interface %d < DWORD-buffer size => buffer"
+			" is never reloaded from DMA", ai->id);
+		return -1;
+	}
+	return 0;
+}
+
+/**
+ * Assign a TSL slot to each i2s-device on the given audio-interface: this is
+ * the TSL slot where a given i2s-device's first sample byte of its first
+ * channel is captured/played back.
+ */
+static int tsl_align_devices(struct audio_interface *ai)
+{
+	int i = 0;
+	int next_pbk_dev_start_slot = 0;
+	int next_cap_dev_start_slot = 0;
+	struct i2s_device *dev = NULL;
+
+	for (i = 0; i < MAX_I2S_DEVICES; i++) {
+		dev = ai->i2s_devices[i];
+		if (dev != NULL && dev->direction == in) {
+			if (next_cap_dev_start_slot > ai->i2s_word_length) {
+				LOG_ERROR("Total sample-length of capture "
+					"devices on audio-interface %d > "
+					"i2s word-length", ai->id);
+				return -1;
+			}
+			dev->tsl_slot = next_cap_dev_start_slot;
+			next_cap_dev_start_slot += dev->sample_length;
+		}
+		if (dev != NULL && dev->direction == out) {
+			if (next_pbk_dev_start_slot > ai->i2s_word_length) {
+				LOG_ERROR("Total sample-length of playback "
+					"devices on audio-interface %d > "
+					"i2s word-length", ai->id);
+				return -1;
+			}
+			dev->tsl_slot = next_pbk_dev_start_slot;
+			next_pbk_dev_start_slot += dev->sample_length;
+		}
+	}
+	return 0;
+}
+
+static void tsl_prepare_capture_slot(struct i2s_device *dev,
+					uint32_t tsl[],
+					int slot,
+					int *total_bytes_cap)
+{
+	int word_length = dev->audio_interface->i2s_word_length;
+
+	if (slot%word_length >= dev->tsl_slot &&
+		slot%word_length < (dev->tsl_slot + dev->sample_length)) {
+		setbits(&tsl[slot], TSL_DIS_Ax[dev->audio_interface->id], 2,
+				TSL_SDx[dev->sd]);
+		setbits(&tsl[slot], TSL_SDW_Ax[dev->audio_interface->id], 1, 1);
+		setbits(&tsl[slot], TSL_SIB_Ax[dev->audio_interface->id], 1,
+				(dev->hw_mon == source ? 1 : 0));
+		(*total_bytes_cap)++;
+		setbits(&tsl[slot], TSL_SF_Ax[dev->audio_interface->id], 1,
+				(*total_bytes_cap%DWBUF_SIZE == 0 ? 1 : 0));
+	}
+}
+
+static void tsl_prepare_playback_slot(struct i2s_device *dev,
+					uint32_t tsl[],
+					int slot,
+					int *total_bytes_pbk,
+					int *bsel)
+{
+	unsigned int tmp = 0;
+	int ws_line = 0;
+	int bsel_offset = 0;
+	int word_length = dev->audio_interface->i2s_word_length;
+
+	if (slot%word_length >= dev->tsl_slot &&
+		slot%word_length < (dev->tsl_slot + dev->sample_length)) {
+		bsel_offset = (dev->hw_mon == destination ? 4 : 0);
+		/* see documentation in wiki for details regarding endianness */
+		setbits(&tsl[slot], TSL_BSEL_Ax[dev->audio_interface->id], 3,
+			(dev->sample_length == 2 ?
+			(dev->endian == le ? (1 - *bsel) & 3 : *bsel) :
+			(dev->endian == le ? 3 - *bsel : *bsel))
+			 + bsel_offset);
+		setbits(&tsl[slot], TSL_DOD_Ax[dev->audio_interface->id], 2,
+				TSL_SDx[dev->sd]);
+		setbits(&tsl[slot], TSL_LF_Ax[dev->audio_interface->id], 1,
+				(*total_bytes_pbk%DWBUF_SIZE == 0 ? 1 : 0));
+		(*total_bytes_pbk)++;
+		*bsel = (*bsel + 1)%DWBUF_SIZE;
+	}
+	/* WS: drive high until dev->tsl_slot, then drive low for word-
+	   length slots, then drive high again */
+	tmp = ((unsigned int)slot) - dev->tsl_slot;
+	ws_line = (tmp%(2 * word_length) < word_length ? 0 : 1);
+	setbits(&tsl[slot], TSL_WSx[dev->ws], 1, ws_line);
+}
+
+
+/**
+ * Set bits at a given offset to the given value.
+ * @param reg The variable where the bits are set
+ * @param offset The offset where the bits are set
+ * @param len The number of contiguous bits
+ * @param val The value to be set
+ */
+static void setbits(uint32_t *reg,
+			unsigned int offset,
+			unsigned int len,
+			uint32_t val)
+{
+	*reg &= ~(((1 << len) - 1) << offset); /* clear bits (!) */
+	*reg |= (val << offset);
+}
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2s.h 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2s.h
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/saa7146i2s.h	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/saa7146i2s.h	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,197 @@
+/*
+ *  SAA7146 I2S and audio-interface abstraction layer
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#ifndef SAA7146I2S_H_
+#define SAA7146I2S_H_
+
+#include <linux/types.h>
+#include "saa7146.h"
+
+#define MAX_I2S_DEVICES 5 /* SAA4146 supports a max. of 5 i2s devices */
+#define MAX_AUDIO_INTERFACES 2 /* SAA7146 has 2 independent audio-interfaces */
+
+/* forward declarations due to mutual reference audio_interface<->i2s_device */
+struct audio_interface;
+
+/**
+ * Enumeration of SAA7146 audio-interfaces A1 and A2.
+ * Order matters (see head of saa7146i2s.c: address and bit offset maps)
+ */
+enum audio_interfaces {a1, a2};
+
+/**
+ * Enumeration of SAA7146 i2c WS lines.
+ * Order matters (see head of saa7146i2s.c: address and bit offset maps)
+ */
+enum ws_lines {ws0, ws1, ws2, ws3, ws4};
+
+/**
+ * Enumeration of SAA7146 i2c SD lines.
+ * sd0_i_a2: SD0 is always input on SAA7146 audiointerface A2
+ * sd0_o_a1: SD0 is always output on SAA7146 audiointerface A1
+ * sd4_i_a1: SD4 is always input on SAA7146 audiointerface A1
+ * sd4_o_a2: SD4 is always output on SAA7146 audiointerface A2
+ * Order matters (see head of saa7146i2s.c: address and bit offset maps)
+ */
+enum sd_lines {sd0_i_a2, sd0_o_a1, sd1_io_ax, sd2_io_ax, sd3_io_ax, sd4_i_a1,
+	sd4_o_a2};
+
+enum endian {le, be};
+
+enum directions {in, out};
+
+enum states {disabled, enabled};
+
+enum hw_mon {source, destination, notmonitored};
+
+/**
+ * tsl_slot: SAA7146 TSL slot-number of 1st channel MSB
+ * audio_interface: convenience reference
+ * sample_length: sample length in bytes
+ */
+struct i2s_device {
+	enum ws_lines ws;
+	enum sd_lines sd;
+	unsigned int tsl_slot;
+	struct audio_interface *audio_interface;
+	int sample_length;
+	enum endian endian;
+	enum states state;
+	enum directions direction;
+	enum hw_mon hw_mon;
+};
+
+/**
+ * i2s_word_length: word length in bytes
+ * i2s_superframe_length: superframe length in bytes
+ * fs: each audio-interface can have its own samplerate
+ */
+struct audio_interface {
+	enum audio_interfaces id;
+	int i2s_word_length;
+	int i2s_superframe_length;
+	int fs;
+	struct i2s_device *i2s_devices[MAX_I2S_DEVICES];
+};
+
+/**
+ * struct audio_interface and struct i2c_device instances are statically
+ * allocated and are 'owned' by this struct saa7146i2s -> this is the place
+ * where the actual data structures are defined (no dynamic allocation
+ * elsewhere).
+ */
+struct saa7146i2s {
+	struct saa7146reg chip;
+	struct audio_interface audio_interfaces[MAX_AUDIO_INTERFACES];
+	struct i2s_device i2s_devices[MAX_I2S_DEVICES];
+	uint32_t acon1;
+};
+
+/**
+ * Initialize an SAA7146's audio-interface. The parameter values depend on the
+ * hardware setup. As a rule, these are rather static settings and are
+ * established once in the module's lifecycle.
+ * @param chipi2s used for I2S device management and SAA7146 register access,
+ * must not be NULL.
+ * @param audio_interface_id the SAA7146 audio-interface to be initialized.
+ * @param i2s_word_length word-length of i2s devices operated by the given
+ * audio-interface. One audio-interface can handle more than one i2s device,
+ * but the word-length (i.e. 1/2 WS-period) must be the same for all.
+ * word-length 1, 2 and 4 bytes are supported.
+ * @param i2s_superframe_length a superframe contains a number of WS-periods.
+ * The following condition must match:
+ *
+ *	  (MIN_SUPERFRAME_LENGTH <= superframe-length <= MAX_SUPERFRAME_LENGTH)
+ *	   AND superframe-length == [2,4,8,16] * word-length
+ *
+ * @return 0 in case of success or -1 in case of failure.
+ */
+int saa7146_i2s_init_audio_interface(struct saa7146i2s *chipi2s,
+				enum audio_interfaces audio_interface_id,
+				int i2s_word_length,
+				int i2s_superframe_length);
+
+/**
+ * TODO: description
+ */
+void saa7146_i2s_enable_audio_interface(struct saa7146i2s *chipi2s,
+					struct audio_interface *ai);
+
+/**
+ * TODO: description
+ */
+void saa7146_i2s_disable_audio_interface(struct saa7146i2s *chipi2s,
+					struct audio_interface *ai);
+
+/**
+ * Initializes an i2s device. As a rule, init values are rather static, e.g.
+ * given by the HW wiring, and are established once in the module's lifecycle.
+ * WS determines the order in which the i2s devices (= stereo audio channels)
+ * are expected to appear in the host memory.
+ * @param chipi2s used for I2S device management and SAA7146 register access,
+ * must not be NULL.
+ * @param audio_interface_id the SAA7146 audio-interface which operates this
+ * i2s device.
+ * @param direction either 'in' or 'out'.
+ * @param ws the WS line to be used for this i2s device.
+ * @param sd the SD line to be used for this i2s device.
+ * @return 0 in case of success or -1 in case of failure.
+ */
+int saa7146_i2s_init_device(struct saa7146i2s *chipi2s,
+				enum audio_interfaces audio_interface_id,
+				enum directions direction,
+				enum ws_lines ws,
+				enum sd_lines sd);
+
+/**
+ * Enables an i2s device for capture or playback.
+ * @param chipi2s used for I2S device management and SAA7146 register access,
+ * must not be NULL.
+ * @param device A reference to the i2s_device reference returned by
+ * saa7146_i2s_init_device(), must not be NULL.
+ * @param sample_length the length of samples transferred over this i2s device.
+ * @param endian endianess of the captured bytes in the host memory.
+ * @return 0 for success or -1 for failure.
+ */
+int saa7146_i2s_enable_device(struct saa7146i2s *chipi2s,
+				struct i2s_device *device,
+				int sample_length,
+				enum endian endian);
+
+/**
+ * Disables an i2s device.
+ * @param chipi2s used for I2S device management and SAA7146 register access,
+ * must not be NULL.
+ * @param device A reference to the i2s_device reference returned by
+ * saa7146_i2s_init_device(), must not be NULL.
+ * @return 0 for success or -1 for failure.
+ */
+int saa7146_i2s_disable_device(struct saa7146i2s *chipi2s,
+				struct i2s_device *device);
+
+/**
+ * @return 1 if the given value is a power of 2.
+ */
+static inline int is_pow_of_2(int val)
+{
+	return ((val != 0) && ((val & (val - 1)) == 0));
+}
+
+#endif /*SAA7146I2S_H_*/
