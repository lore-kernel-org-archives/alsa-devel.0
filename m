From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/25] ALSA: firewire-tascam: add data
	processing layer
Date: Thu, 13 Aug 2015 09:20:16 +0900
Message-ID: <1439425221-30826-21-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E7A2615FC
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:38 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

TASCAM FireWire series uses non-blocking transmission for AMDTP packet
streaming, while the format of data blocks is unique.

The CIP headers includes specific value in FMT field and no SYT
information.

In transmitted packets, the first data channel represents event counter,
and the last data channel has status and control information. The rest
has 24bit PCM samples with right padding.

In received packets, all of data channels include 16, 24, 32bit PCM
samples. There's no the other kind of information.

This commit adds support for this protocol. For convinience, the size of
PCM samples in outgoing packet is 16, 24bit. The status and control
information will be supported in a future commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile       |   2 +-
 sound/firewire/tascam/amdtp-tascam.c | 248 +++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.h       |  18 +++
 3 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/amdtp-tascam.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index 63f08c6..5d11cad 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-tascam-objs := tascam-proc.o tascam.o
+snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam.o
 obj-m += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
new file mode 100644
index 0000000..6c15b98
--- /dev/null
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -0,0 +1,248 @@
+/*
+ * amdtp-tascam.c - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <sound/pcm.h>
+#include "tascam.h"
+
+#define AMDTP_FMT_TSCM_TX	0x1e
+#define AMDTP_FMT_TSCM_RX	0x3e
+
+struct amdtp_tscm {
+	unsigned int pcm_channels;
+
+	void (*transfer_samples)(struct amdtp_stream *s,
+				 struct snd_pcm_runtime *pcm,
+				 __be32 *buffer, unsigned int frames);
+};
+
+int amdtp_tscm_set_parameters(struct amdtp_stream *s, unsigned int rate)
+{
+	struct amdtp_tscm *p = s->protocol;
+	unsigned int data_channels;
+
+	if (amdtp_stream_running(s))
+		return -EBUSY;
+
+	data_channels = p->pcm_channels;
+	if (s->direction == AMDTP_IN_STREAM)
+		data_channels += 2;
+
+	return amdtp_stream_set_parameters(s, rate, data_channels);
+}
+
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_runtime *runtime,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_tscm *p = s->protocol;
+	unsigned int channels, remaining_frames, i, c;
+	const u32 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[c] = cpu_to_be32(*src);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_s16(struct amdtp_stream *s,
+			  struct snd_pcm_runtime *runtime,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_tscm *p = s->protocol;
+	unsigned int channels, remaining_frames, i, c;
+	const u16 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[c] = cpu_to_be32(*src << 16);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void read_pcm_s32(struct amdtp_stream *s,
+			 struct snd_pcm_runtime *runtime,
+			 __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_tscm *p = s->protocol;
+	unsigned int channels, remaining_frames, i, c;
+	u32 *dst;
+
+	channels = p->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	/* The first data channel is for event counter. */
+	buffer += 1;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(buffer[c]);
+			dst++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_silence(struct amdtp_stream *s, __be32 *buffer,
+			      unsigned int data_blocks)
+{
+	struct amdtp_tscm *p = s->protocol;
+	unsigned int channels, i, c;
+
+	channels = p->pcm_channels;
+
+	for (i = 0; i < data_blocks; ++i) {
+		for (c = 0; c < channels; ++c)
+			buffer[c] = 0x00000000;
+		buffer += s->data_block_quadlets;
+	}
+}
+
+int amdtp_tscm_add_pcm_hw_constraints(struct amdtp_stream *s,
+				      struct snd_pcm_runtime *runtime)
+{
+	int err;
+
+	/*
+	 * Our implementation allows this protocol to deliver 24 bit sample in
+	 * 32bit data channel.
+	 */
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	if (err < 0)
+		return err;
+
+	return amdtp_stream_add_pcm_hw_constraints(s, runtime);
+}
+
+void amdtp_tscm_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
+{
+	struct amdtp_tscm *p = s->protocol;
+
+	if (WARN_ON(amdtp_stream_pcm_running(s)))
+		return;
+
+	switch (format) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case SNDRV_PCM_FORMAT_S16:
+		if (s->direction == AMDTP_OUT_STREAM) {
+			p->transfer_samples = write_pcm_s16;
+			break;
+		}
+		WARN_ON(1);
+		/* fall through */
+	case SNDRV_PCM_FORMAT_S32:
+		if (s->direction == AMDTP_OUT_STREAM)
+			p->transfer_samples = write_pcm_s32;
+		else
+			p->transfer_samples = read_pcm_s32;
+		break;
+	}
+}
+
+static void read_control_messages(struct amdtp_stream *s,
+				  __be32 *buffer, unsigned int data_blocks)
+{
+	unsigned int first, index = 0;
+	unsigned int i;
+
+	first = (buffer[0] >> 15) % 64;
+
+	/* TODO */
+	for (i = 0; i < data_blocks; i++) {
+		index = be32_to_cpu(buffer[0]) % 64;
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_tscm *p = (struct amdtp_tscm *)s->protocol;
+	struct snd_pcm_substream *pcm;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (data_blocks > 0 && pcm)
+		p->transfer_samples(s, pcm->runtime, buffer, data_blocks);
+
+	read_control_messages(s, buffer, data_blocks);
+
+	return data_blocks;
+}
+
+static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_tscm *p = (struct amdtp_tscm *)s->protocol;
+	struct snd_pcm_substream *pcm;
+
+	/* This field is not used. */
+	*syt = 0x0000;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm)
+		p->transfer_samples(s, pcm->runtime, buffer, data_blocks);
+	else
+		write_pcm_silence(s, buffer, data_blocks);
+
+	return data_blocks;
+}
+
+int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
+		    enum amdtp_stream_direction dir, unsigned int pcm_channels)
+{
+	struct amdtp_tscm *p;
+	int err;
+
+	err = amdtp_stream_init(s, unit, dir,
+				CIP_NONBLOCKING | CIP_SKIP_DBC_ZERO_CHECK,
+				sizeof(struct amdtp_tscm));
+	if (err < 0)
+		return 0;
+
+	if (dir == AMDTP_IN_STREAM) {
+		s->fmt = AMDTP_FMT_TSCM_TX;
+		s->process_data_blocks = process_tx_data_blocks;
+	} else {
+		s->fmt = AMDTP_FMT_TSCM_RX;
+		s->process_data_blocks = process_rx_data_blocks;
+	}
+	s->fdf = 0x00;
+
+	p = s->protocol;
+	p->pcm_channels = pcm_channels;
+
+	return 0;
+}
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 8d4eb3f..7f8ec3d 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -18,8 +18,13 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "../lib.h"
+#include "../packets-buffer.h"
+#include "../iso-resources.h"
+#include "../amdtp-stream.h"
 
 struct snd_tscm_spec {
 	const char *const name;
@@ -39,6 +44,12 @@ struct snd_tscm {
 	struct mutex mutex;
 
 	struct snd_tscm_spec *spec;
+
+	struct fw_iso_resources tx_resources;
+	struct fw_iso_resources rx_resources;
+	struct amdtp_stream tx_stream;
+	struct amdtp_stream rx_stream;
+	unsigned int substreams_counter;
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
@@ -48,4 +59,11 @@ struct snd_tscm {
 #define TSCM_OFFSET_FIRMWARE_ARM	0x0008
 #define TSCM_OFFSET_FIRMWARE_HW		0x000c
 
+int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
+		  enum amdtp_stream_direction dir, unsigned int pcm_channels);
+int amdtp_tscm_set_parameters(struct amdtp_stream *s, unsigned int rate);
+int amdtp_tscm_add_pcm_hw_constraints(struct amdtp_stream *s,
+				      struct snd_pcm_runtime *runtime);
+void amdtp_tscm_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
+
 void snd_tscm_proc_init(struct snd_tscm *tscm);
-- 
2.1.4
