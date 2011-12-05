From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v3 4/6] core: add API header and driver header
	files
Date: Mon,  5 Dec 2011 13:09:49 +0530
Message-ID: <1323070791-12620-5-git-send-email-vinod.koul@linux.intel.com>
References: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id EDE76103A51
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 08:41:57 +0100 (CET)
In-Reply-To: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the header files for ioctl definations and header file for
driver APIs for lower level device drivers to use

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/compress_driver.h  |  164 ++++++++++++++++++++++++++++++++++++++
 include/sound/compress_offload.h |  151 +++++++++++++++++++++++++++++++++++
 2 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/compress_driver.h
 create mode 100644 include/sound/compress_offload.h

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
new file mode 100644
index 0000000..600156b
--- /dev/null
+++ b/include/sound/compress_driver.h
@@ -0,0 +1,164 @@
+/*
+ *  compress_driver.h - compress offload driver definations
+ *
+ *  Copyright (C) 2011 Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
+ *		Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+#ifndef __COMPRESS_DRIVER_H
+#define __COMPRESS_DRIVER_H
+
+#include <sound/compress_offload.h>
+#include <sound/asound.h>
+#include <sound/pcm.h>
+
+struct snd_compr_ops;
+
+/**
+ * struct snd_compr_runtime: runtime stream description
+ * @state: stream state
+ * @ops: pointer to DSP callbacks
+ * @buffer: pointer to kernel buffer, valid only when not in mmap mode or
+ *	DSP doesn't implement copy
+ * @buffer_size: size of the above buffer
+ * @fragment_size: size of buffer fragment in bytes
+ * @fragments: number of such fragments
+ * @hw_pointer: offset of last location in buffer where DSP copied data
+ * @app_pointer: offset of last location in buffer where app wrote data
+ * @bytes_written: cummilative bytes written to device
+ * @bytes_copied: cummilative bytes copied by DSP
+ * @sleep: poll sleep
+ */
+struct snd_compr_runtime {
+	snd_pcm_state_t state;
+	struct snd_compr_ops *ops;
+	void *buffer;
+	size_t buffer_size;
+	size_t fragment_size;
+	unsigned int fragments;
+	size_t hw_pointer;
+	size_t app_pointer;
+	size_t bytes_written;
+	size_t bytes_copied;
+	wait_queue_head_t sleep;
+};
+
+/**
+ * struct snd_compr_stream: compressed stream
+ * @name: device name
+ * @ops: pointer to DSP callbacks
+ * @runtime: pointer to runtime structure
+ * @device: device pointer
+ * @direction: stream direction, playback/recording
+ * @private_data: pointer to DSP private data
+ */
+struct snd_compr_stream {
+	const char *name;
+	struct snd_compr_ops *ops;
+	struct snd_compr_runtime *runtime;
+	struct snd_compr *device;
+	unsigned int direction;
+	void *private_data;
+};
+
+/**
+ * struct snd_compr_ops: compressed path DSP operations
+ * @open: Open the compressed stream
+ * This callback is mandatory and shall keep dsp ready to receive the stream
+ * parameter
+ * @free: Close the compressed stream, mandatory
+ * @set_params: Sets the compressed stream parameters, mandatory
+ * This can be called in during stream creation only to set codec params
+ * and the stream properties
+ * @get_params: retrieve the codec parameters, mandatory
+ * @trigger: Trigger operations like start, pause, resume, drain, stop.
+ * This callback is mandatory
+ * @pointer: Retrieve current h/w pointer information. Mandatory
+ * @copy: Copy the compressed data to/from userspace, Optional
+ * Can't be implemented if DSP supports mmap
+ * @mmap: DSP mmap method to mmap DSP memory
+ * @ack: Ack for DSP when data is written to audio buffer, Optional
+ * Not valid if copy is implemented
+ * @get_caps: Retrieve DSP capabilities, mandatory
+ * @get_codec_caps: Retrieve capabilities for a specific codec, mandatory
+ */
+struct snd_compr_ops {
+	int (*open)(struct snd_compr_stream *stream);
+	int (*free)(struct snd_compr_stream *stream);
+	int (*set_params)(struct snd_compr_stream *stream,
+			struct snd_compr_params *params);
+	int (*get_params)(struct snd_compr_stream *stream,
+			struct snd_codec *params);
+	int (*trigger)(struct snd_compr_stream *stream, int cmd);
+	int (*pointer)(struct snd_compr_stream *stream,
+			struct snd_compr_tstamp *tstamp);
+	int (*copy)(struct snd_compr_stream *stream, const char __user *buf,
+		       size_t count);
+	int (*mmap)(struct snd_compr_stream *stream,
+			struct vm_area_struct *vma);
+	int (*ack)(struct snd_compr_stream *stream, size_t bytes);
+	int (*get_caps) (struct snd_compr_stream *stream,
+			struct snd_compr_caps *caps);
+	int (*get_codec_caps) (struct snd_compr_stream *stream,
+			struct snd_compr_codec_caps *codec);
+};
+
+/**
+ * struct snd_compr: Compressed device
+ * @name: DSP device name
+ * @dev: Device pointer
+ * @ops: pointer to DSP callbacks
+ * @private_data: pointer to DSP pvt data
+ * @card: sound card pointer
+ * @direction: Playback or capture direction
+ * @lock: device lock
+ * @device: device id
+ */
+struct snd_compr {
+	const char *name;
+	struct device *dev;
+	struct snd_compr_ops *ops;
+	void *private_data;
+	struct snd_card *card;
+	unsigned int direction;
+	struct mutex lock;
+	int device;
+};
+
+/* compress device register APIs */
+int snd_compress_register(struct snd_compr *device);
+int snd_compress_deregister(struct snd_compr *device);
+int snd_compress_new(struct snd_card *card, int device,
+			int type, struct snd_compr *compr);
+
+/* dsp driver callback apis
+ * For playback: driver should call snd_compress_fragment_elapsed() to let the
+ * framework know that a fragment has been consumed from the ring buffer
+ *
+ * For recording: we want to know when a frame is available or when
+ * at least one frame is available so snd_compress_frame_elapsed()
+ * callback should be called when a encodeded frame is available
+ */
+static inline void snd_compr_fragment_elapsed(struct snd_compr_stream *stream)
+{
+	wake_up(&stream->runtime->sleep);
+}
+
+#endif
diff --git a/include/sound/compress_offload.h b/include/sound/compress_offload.h
new file mode 100644
index 0000000..2358c86
--- /dev/null
+++ b/include/sound/compress_offload.h
@@ -0,0 +1,151 @@
+/*
+ *  compress_offload.h - compress offload header definations
+ *
+ *  Copyright (C) 2011 Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
+ *		Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+#ifndef __COMPRESS_OFFLOAD_H
+#define __COMPRESS_OFFLOAD_H
+
+#include <linux/types.h>
+#include <sound/asound.h>
+#include <sound/snd_compress_params.h>
+
+
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 0)
+/**
+ * struct snd_compressed_buffer: compressed buffer
+ * @fragment_size: size of buffer fragment in bytes
+ * @fragments: number of such fragments
+ */
+struct snd_compressed_buffer {
+	size_t fragment_size;
+	int fragments;
+};
+
+/**
+ * struct snd_compr_params: compressed stream params
+ * @buffer: buffer description
+ * @codec: codec parameters
+ * @no_wake_mode: dont wake on fragment elapsed
+ */
+struct snd_compr_params {
+	struct snd_compressed_buffer buffer;
+	struct snd_codec codec;
+	bool no_wake_mode;
+};
+
+/**
+ * struct snd_compr_tstamp: timestamp descriptor
+ * @copied_bytes: Number of bytes offset in ring buffer to DSP
+ * @copied_total: Total number of bytes copied from/to ring buffer to/by DSP
+ * @frames: Frames decoded or encoded by DSP
+ * @rendered: Frames rendered or recieved by DSP into a mixer or an audio
+ * output/input
+ * @sampling_rate: sampling rate of audio
+ */
+struct snd_compr_tstamp {
+	size_t copied_bytes;
+	size_t copied_total;
+	size_t frames;
+	size_t rendered;
+	__u32 sampling_rate;
+};
+
+/**
+ * struct snd_compr_avail: avail descriptor
+ * @avail: Number of bytes available in ring buffer for writing/reading
+ * @tstamp: timestamp infomation
+ */
+struct snd_compr_avail {
+	size_t avail;
+	struct snd_compr_tstamp tstamp;
+};
+
+/**
+ * struct snd_compr_caps: caps descriptor
+ * @codecs: pointer to array of codecs
+ * @min_fragment_size: minimum fragment supported by DSP
+ * @max_fragment_size: maximum fragment supported by DSP
+ * @min_fragments: min fragments supported by DSP
+ * @max_fragments: max fragments supported by DSP
+ * @num_codecs: number of codecs supported
+ * @reserved: reserved field
+ */
+struct snd_compr_caps {
+	__u32 num_codecs;
+	__u32 min_fragment_size;
+	__u32 max_fragment_size;
+	__u32 min_fragments;
+	__u32 max_fragments;
+	__u32 codecs[MAX_NUM_CODECS];
+	__u32 reserved[11];
+};
+
+/**
+ * struct snd_compr_codec_caps: query capability of codec
+ * @codec: codec for which capability is queried
+ * @num_descriptors: number of codec descriptors
+ * @descriptor: array of codec capability descriptor
+ */
+struct snd_compr_codec_caps {
+	__u32 codec;
+	__u32 num_descriptors;
+	struct snd_codec_desc descriptor[MAX_NUM_CODEC_DESCRIPTORS];
+};
+
+/**
+ * compress path ioctl definitions
+ * SNDRV_COMPRESS_GET_CAPS: Query capability of DSP
+ * SNDRV_COMPRESS_GET_CODEC_CAPS: Query capability of a codec
+ * SNDRV_COMPRESS_SET_PARAMS: Set codec and stream parameters
+ * Note: only codec params can be changed runtime and stream params cant be
+ * SNDRV_COMPRESS_GET_PARAMS: Query codec params
+ * SNDRV_COMPRESS_TSTAMP: get the current timestamp value
+ * SNDRV_COMPRESS_AVAIL: get the current buffer avail value.
+ * This also queries the tstamp properties
+ * SNDRV_COMPRESS_PAUSE: Pause the running stream
+ * SNDRV_COMPRESS_RESUME: resume a paused stream
+ * SNDRV_COMPRESS_START: Start a stream
+ * SNDRV_COMPRESS_STOP: stop a running stream, discarding ring buffer content
+ * and the buffers currently with DSP
+ * SNDRV_COMPRESS_DRAIN: Play till end of buffers and stop after that
+ * SNDRV_COMPRESS_IOCTL_VERSION: Query the API version
+ */
+#define SNDRV_COMPRESS_IOCTL_VERSION	_IOR('C', 0x00, int)
+#define SNDRV_COMPRESS_GET_CAPS		_IOWR('C', 0x10, struct snd_compr_caps)
+#define SNDRV_COMPRESS_GET_CODEC_CAPS	_IOWR('C', 0x11, struct snd_compr_codec_caps)
+#define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x12, struct snd_compr_params)
+#define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x13, struct snd_codec)
+#define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
+#define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
+#define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
+#define SNDRV_COMPRESS_RESUME		_IO('C', 0x31)
+#define SNDRV_COMPRESS_START		_IO('C', 0x32)
+#define SNDRV_COMPRESS_STOP		_IO('C', 0x33)
+#define SNDRV_COMPRESS_DRAIN		_IO('C', 0x34)
+/*
+ * TODO
+ * 1. add mmap support
+ *
+ */
+#define SND_COMPR_TRIGGER_DRAIN 7 /*FIXME move this to pcm.h */
+#endif
-- 
1.7.0.4
