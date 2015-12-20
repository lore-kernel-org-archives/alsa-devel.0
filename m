From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/11] fireface: add data processing layer
Date: Sun, 20 Dec 2015 21:28:40 +0900
Message-ID: <1450614523-9367-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 422F42606DA
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:50 +0100 (CET)
In-Reply-To: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
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

RME Fireface series doesn't apply IEC 61883-6 for its format of data block.
Its data channel includes no labels. The PCM sample is aligned to little
endian. The upper 1 byte of each channel includes information of device's
status.

This commit adds own data processing layer. The device's status is not
supported yet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile   |   2 +-
 sound/firewire/fireface/amdtp-ff.c | 221 +++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/fireface.h |   8 ++
 3 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/amdtp-ff.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index c9d1f4e..f22f0b5 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,3 +1,3 @@
 snd-fireface-objs := fireface.o fireface-transaction.o fireface-midi.o \
-		     fireface-proc.o
+		     fireface-proc.o amdtp-ff.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/amdtp-ff.c b/sound/firewire/fireface/amdtp-ff.c
new file mode 100644
index 0000000..ab2a99d
--- /dev/null
+++ b/sound/firewire/fireface/amdtp-ff.c
@@ -0,0 +1,221 @@
+/*
+ * amdtp-ff.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <sound/pcm.h>
+#include "fireface.h"
+
+struct amdtp_ff {
+	unsigned int pcm_channels;
+
+	void (*transfer_samples)(struct amdtp_stream *s,
+				 struct snd_pcm_substream *pcm,
+				 __be32 *buffer, unsigned int frames);
+};
+
+int amdtp_ff_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			    unsigned int pcm_channels)
+{
+	struct amdtp_ff *p = s->protocol;
+	unsigned int data_channels;
+
+	if (amdtp_stream_running(s))
+		return -EBUSY;
+
+	p->pcm_channels = pcm_channels;
+	data_channels = pcm_channels;
+
+	return amdtp_stream_set_parameters(s, rate, data_channels);
+}
+
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_ff *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
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
+			/* TODO: fill upper 1 byte for the other aim. */
+			buffer[c] = cpu_to_le32(*src);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_s16(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_ff *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
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
+			/* TODO: fill upper 1 byte for the other aim. */
+			buffer[c] = cpu_to_le32(*src << 16);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void read_pcm_s32(struct amdtp_stream *s,
+			 struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_ff *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	u32 *dst;
+
+	channels = p->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			/* TODO: read upper 1 byte for the other aim. */
+			*dst = cpu_to_le32(buffer[c]) & 0xffffff00;
+			dst++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_silence(struct amdtp_stream *s,
+			      __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_ff *p = s->protocol;
+	unsigned int i, c, channels = p->pcm_channels;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c)
+			/* TODO: write upper 1 byte for the other aim. */
+			buffer[c] = cpu_to_le32(0x00000000);
+		buffer += s->data_block_quadlets;
+	}
+}
+
+void amdtp_ff_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
+{
+	struct amdtp_ff *p = s->protocol;
+
+	if (WARN_ON(amdtp_stream_pcm_running(s)))
+		return;
+
+	switch (format) {
+	default:
+		WARN_ON(1);
+		/* fail through */
+	case SNDRV_PCM_FORMAT_S16:
+		if (s->direction == AMDTP_OUT_STREAM) {
+			p->transfer_samples = write_pcm_s16;
+			break;
+		}
+		WARN_ON(1);
+		/* fail through */
+	case SNDRV_PCM_FORMAT_S32:
+		if (s->direction == AMDTP_OUT_STREAM)
+			p->transfer_samples = write_pcm_s32;
+		else
+			p->transfer_samples = read_pcm_s32;
+		break;
+	}
+}
+
+int amdtp_ff_add_pcm_hw_constraints(struct amdtp_stream *s,
+				    struct snd_pcm_runtime *runtime)
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
+static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_ff *p = s->protocol;
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		p->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		write_pcm_silence(s, buffer, data_blocks);
+		pcm_frames = 0;
+	}
+
+	return pcm_frames;
+}
+
+static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_ff *p = s->protocol;
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		p->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		pcm_frames = 0;
+	}
+
+	return pcm_frames;
+}
+
+int amdtp_ff_init(struct amdtp_stream *s, struct fw_unit *unit,
+		  enum amdtp_stream_direction dir)
+{
+	amdtp_stream_process_data_blocks_t process_data_blocks;
+
+	if (dir == AMDTP_IN_STREAM)
+		process_data_blocks = process_tx_data_blocks;
+	else
+		process_data_blocks = process_rx_data_blocks;
+
+	return amdtp_stream_init(s, unit, dir, CIP_NO_HEADERS, 0,
+				 process_data_blocks, sizeof(struct amdtp_ff));
+}
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index 38a200e..dd50261 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -76,6 +76,14 @@ int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
 
+int amdtp_ff_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			    unsigned int pcm_channels);
+void amdtp_ff_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
+int amdtp_ff_add_pcm_hw_constraints(struct amdtp_stream *s,
+				    struct snd_pcm_runtime *runtime);
+int amdtp_ff_init(struct amdtp_stream *s, struct fw_unit *unit,
+		  enum amdtp_stream_direction dir);
+
 void snd_ff_proc_init(struct snd_ff *ff);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
-- 
2.5.0
