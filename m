From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/14] ALSA: fireface: add unique data
	processing layer
Date: Fri, 31 Mar 2017 22:06:08 +0900
Message-ID: <20170331130612.18331-11-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 41E00267234
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:25 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
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

As long as investigating Fireface 400, format of payload of each
isochronous packet is not IEC 61883-1/6, thus its format of data block
is not AM824. The remarkable points of the format are:
 * The payload just consists of some data channels of quadlet size without
   CIP header.
 * Each data channels includes data aligned to little endian order.
 * One data channel consists of two parts; 8 bit ancillary field and 24 bit
   PCM frame.

Due to lack of CIP headers, rx/tx packets include no CIP headers and
different way to check packet discontinuity. For tx packet, the ancillary
field is used for counter. However, the way of counting is different
depending on positions of data channels. At 44.1 kHz, ancillary field in:
 * 1st/6th/9th/10th/14th/17th data channels: not used for this purpose.
 * 2nd/18th data channels: incremented every data block (0x00-0xff).
 * 3rd/4th/5th/11th/12th/13th data channels: incremented every 256 data
   blocks (0x00-0x07).
 * 7th/8th/15th/16th data channels: incremented per the number of data
   blocks in a packet. The increment can occur per packet (0x00-0xff).

For tx packet, tag of each isochronous packet is used for this purpose.
The value of tag cyclically changes between 0, 1, 2 and 3 in this order.
The interval is different depending on sampling transmission frequency.
At 44.1/48.0 kHz, it's 256 data blocks. At 88.2 kHz, it's 96 data blocks.

The number of data blocks in tx packet is exactly the same as
SYT_INTERVAL. There's no empty packet or no-data packet, thus the
throughput is not 8,000 packets per sec. On the other hand, the one in
rx packet is 8,000 packets per sec, thus the number of data blocks is
different between each packet, depending on sampling transmission
frequency:
 * 44.1 kHz: 5 or 6
 * 48.0 kHz: 5 or 6 or 7
 * 88.2 kHz: 10 or 11 or 12

This commit adds data processing layer to satisfy the above specification
in a policy of 'best effort'. Although PCM frames are handled for
intermediate buffer to user space, the ancillary data is not handled at all
to reduce CPU usage, thus counter is not checked. 0 is always used for tag
of isochronous packet. Furthermore, the packet streaming layer is
responsible for calculation of the number of data blocks for each packet,
thus it's not exactly the same sequence from the above observation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile   |   2 +-
 sound/firewire/fireface/amdtp-ff.c | 155 +++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.h       |   8 ++
 3 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/amdtp-ff.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index e88ff9e..e06e9da 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,2 @@
-snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o
+snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/amdtp-ff.c b/sound/firewire/fireface/amdtp-ff.c
new file mode 100644
index 0000000..780da9d
--- /dev/null
+++ b/sound/firewire/fireface/amdtp-ff.c
@@ -0,0 +1,155 @@
+/*
+ * amdtp-ff.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <sound/pcm.h>
+#include "ff.h"
+
+struct amdtp_ff {
+	unsigned int pcm_channels;
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
+			  __le32 *buffer, unsigned int frames)
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
+			buffer[c] = cpu_to_le32(*src);
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
+			 __le32 *buffer, unsigned int frames)
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
+			*dst = le32_to_cpu(buffer[c]) & 0xffffff00;
+			dst++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_silence(struct amdtp_stream *s,
+			      __le32 *buffer, unsigned int frames)
+{
+	struct amdtp_ff *p = s->protocol;
+	unsigned int i, c, channels = p->pcm_channels;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c)
+			buffer[c] = cpu_to_le32(0x00000000);
+		buffer += s->data_block_quadlets;
+	}
+}
+
+int amdtp_ff_add_pcm_hw_constraints(struct amdtp_stream *s,
+				    struct snd_pcm_runtime *runtime)
+{
+	int err;
+
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
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		write_pcm_s32(s, pcm, (__le32 *)buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		write_pcm_silence(s, (__le32 *)buffer, data_blocks);
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
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		read_pcm_s32(s, pcm, (__le32 *)buffer, data_blocks);
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
+	return amdtp_stream_init(s, unit, dir, CIP_NO_HEADER, 0,
+				 process_data_blocks, sizeof(struct amdtp_ff));
+}
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 2d1fab2..fa7242f 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -23,6 +23,7 @@
 #include <sound/rawmidi.h>
 
 #include "../lib.h"
+#include "../amdtp-stream.h"
 
 #define SND_FF_STREAM_MODES		3
 
@@ -99,6 +100,13 @@ int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
 
+int amdtp_ff_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			    unsigned int pcm_channels);
+int amdtp_ff_add_pcm_hw_constraints(struct amdtp_stream *s,
+				    struct snd_pcm_runtime *runtime);
+int amdtp_ff_init(struct amdtp_stream *s, struct fw_unit *unit,
+		  enum amdtp_stream_direction dir);
+
 void snd_ff_proc_init(struct snd_ff *ff);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
-- 
2.9.3
