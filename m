From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/17] firewire-lib: Add support for AMDTP
	transmit stream and PCM capture
Date: Sat, 23 Nov 2013 15:07:52 +0900
Message-ID: <1385186884-8259-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A045F2619FB
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:12 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For capturing PCM, this commit adds the functionality to handle transmitted
stream. This is also applied for dual-wire mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 263 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 253 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index c32d75d..456eb64 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -48,6 +48,7 @@
 #define QUEUE_LENGTH		48
 
 #define TRANSMIT_PACKET_HEADER_SIZE	4
+#define RECEIVE_PACKET_HEADER_SIZE	0
 
 static void pcm_period_tasklet(unsigned long data);
 
@@ -179,6 +180,18 @@ static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
 static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
 				     struct snd_pcm_substream *pcm,
 				     __be32 *buffer, unsigned int frames);
+static void amdtp_read_s16(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames);
+static void amdtp_read_s32(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames);
+static void amdtp_read_s16_dualwire(struct amdtp_stream *s,
+				    struct snd_pcm_substream *pcm,
+				    __be32 *buffer, unsigned int frames);
+static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
+				    struct snd_pcm_substream *pcm,
+				    __be32 *buffer, unsigned int frames);
 
 /**
  * amdtp_stream_set_pcm_format - set the PCM format
@@ -200,13 +213,23 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 		WARN_ON(1);
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S16:
-		if (s->dual_wire)
+		if (s->direction == AMDTP_TRANSMIT_STREAM) {
+			if (s->dual_wire)
+				s->transfer_samples = amdtp_read_s16_dualwire;
+			else
+				s->transfer_samples = amdtp_read_s16;
+		} else if (s->dual_wire)
 			s->transfer_samples = amdtp_write_s16_dualwire;
 		else
 			s->transfer_samples = amdtp_write_s16;
 		break;
 	case SNDRV_PCM_FORMAT_S32:
-		if (s->dual_wire)
+		if (s->direction == AMDTP_TRANSMIT_STREAM) {
+			if (s->dual_wire)
+				s->transfer_samples = amdtp_read_s32_dualwire;
+			else
+				s->transfer_samples = amdtp_read_s32;
+		} else if (s->dual_wire)
 			s->transfer_samples = amdtp_write_s32_dualwire;
 		else
 			s->transfer_samples = amdtp_write_s32;
@@ -420,6 +443,114 @@ static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
 	}
 }
 
+static void amdtp_read_s32(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int remaining_frames, i, c;
+	u32 *dst;
+
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < s->pcm_channels; ++c) {
+			*dst = be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void amdtp_read_s16(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int remaining_frames, i, c;
+	u16 *dst;
+
+	dst = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < s->pcm_channels; ++c) {
+			*dst = be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer +=s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
+				     struct snd_pcm_substream *pcm,
+				     __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	u32 *dst;
+
+	dst = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+	channels = s->pcm_channels / 2;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst =
+			     be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer += 1;
+		for (c = 0; c < channels; ++c) {
+			*dst =
+			     be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer += s->data_block_quadlets - 1;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void amdtp_read_s16_dualwire(struct amdtp_stream *s,
+				     struct snd_pcm_substream *pcm,
+				     __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	u16 *dst;
+
+	dst = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+	channels = s->pcm_channels / 2;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst =
+			     be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer += 1;
+		for (c = 0; c < channels; ++c) {
+			*dst =
+			     be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer += s->data_block_quadlets - 1;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
 static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 				   __be32 *buffer, unsigned int frames)
 {
@@ -505,6 +636,12 @@ static inline int queue_out_packet(struct amdtp_stream *s,
 			    payload_length, skip);
 }
 
+static inline int queue_in_packet(struct amdtp_stream *s)
+{
+	return queue_packet(s, TRANSMIT_PACKET_HEADER_SIZE,
+			    amdtp_stream_get_max_payload(s), false);
+}
+
 static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
@@ -552,6 +689,66 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 		check_pcm_pointer(s, pcm, data_blocks);
 }
 
+static void handle_in_packet(struct amdtp_stream *s,
+			     unsigned int payload_quadlets,
+			     __be32 *buffer)
+{
+	u32 cip_header[2];
+	unsigned int data_block_quadlets, data_blocks, data_block_counter;
+	struct snd_pcm_substream *pcm;
+
+	cip_header[0] = be32_to_cpu(buffer[0]);
+	cip_header[1] = be32_to_cpu(buffer[1]);
+
+	/*
+	 * This module supports 'Two-quadlet CIP header with SYT field'.
+	 * For convinience, also check FMT field is AM824 or not.
+	 */
+	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
+	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH) ||
+	    ((cip_header[1] & CIP_FMT_MASK) != CIP_FMT_AM)) {
+		dev_info(&s->unit->device,
+			 "Invalid CIP header for AMDTP: %08X:%08X\n",
+			 cip_header[0], cip_header[1]);
+		return;
+	}
+
+	if ((payload_quadlets < 3) ||
+	     ((s->flags & CIP_BLOCKING) &&
+	      ((cip_header[1] & CIP_SYT_MASK) == CIP_SYT_NO_INFO)))
+		return;
+
+	data_block_quadlets =
+			(cip_header[1] & AMDTP_DBS_MASK) >> AMDTP_DBS_SHIFT;
+	/* avoid division by zero */
+	if (data_block_quadlets == 0) {
+		dev_info(&s->unit->device,
+			 "Detect invalid value in dbs field: %08X\n",
+			 data_block_quadlets);
+		return;
+	}
+
+	data_blocks = (payload_quadlets - 2) / data_block_quadlets;
+	data_block_counter = (cip_header[1] & AMDTP_DBC_MASK);
+
+	/* check packet continuity */
+	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+	if (s->data_block_counter != data_block_counter) {
+		dev_err(&s->unit->device,
+			"Detect uncontinuity of CIP packets\n");
+		s->data_block_counter = data_block_counter;
+		return;
+	}
+
+	buffer += 2;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm) {
+		s->transfer_samples(s, pcm, buffer, data_blocks);
+		check_pcm_pointer(s, pcm, data_blocks);
+	}
+}
+
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 				size_t header_length, void *header,
 				void *private_data)
@@ -571,6 +768,35 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 	fw_iso_context_queue_flush(s->context);
 }
 
+static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
+			       size_t header_length, void *header,
+			       void *private_data)
+{
+	struct amdtp_stream *s = private_data;
+	unsigned int p, packets, data_quadlets;
+	__be32 *buffer, *headers = header;
+
+	/* The number of packets in buffer */
+	packets = header_length / TRANSMIT_PACKET_HEADER_SIZE;
+
+	for (p = 0; p < packets; p++) {
+		buffer = s->buffer.packets[s->packet_index].buffer;
+
+		/* The number of quadlets in this packet */
+		data_quadlets =
+			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
+		/* handle each packet data */
+		handle_in_packet(s, data_quadlets, buffer);
+
+		if (queue_in_packet(s) < 0) {
+			amdtp_stream_pcm_abort(s);
+			return;
+		}
+	}
+
+	fw_iso_context_queue_flush(s->context);
+}
+
 /**
  * amdtp_stream_start - start sending packets
  * @s: the AMDTP stream to start
@@ -595,7 +821,10 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		[CIP_SFC_88200]  = {  0,   67 },
 		[CIP_SFC_176400] = {  0,   67 },
 	};
-	int err;
+	unsigned int header_size;
+	enum dma_data_direction dir;
+	fw_iso_callback_t cb;
+	int type, err;
 
 	mutex_lock(&s->mutex);
 
@@ -609,16 +838,26 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->syt_offset_state = initial_state[s->sfc].syt_offset;
 	s->last_syt_offset = TICKS_PER_CYCLE;
 
+	/* initialize packet buffer */
+	if (s->direction == AMDTP_TRANSMIT_STREAM) {
+		dir = DMA_FROM_DEVICE;
+		type = FW_ISO_CONTEXT_RECEIVE;
+		header_size = TRANSMIT_PACKET_HEADER_SIZE;
+		cb = in_stream_callback;
+	} else {
+		dir = DMA_TO_DEVICE;
+		type = FW_ISO_CONTEXT_TRANSMIT;
+		header_size = RECEIVE_PACKET_HEADER_SIZE;
+		cb = out_stream_callback;
+	}
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
-				      amdtp_stream_get_max_payload(s),
-				      DMA_TO_DEVICE);
+				      amdtp_stream_get_max_payload(s), dir);
 	if (err < 0)
 		goto err_unlock;
 
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
-					   FW_ISO_CONTEXT_TRANSMIT,
-					   channel, speed, 0,
-					   out_stream_callback, s);
+					   type, channel, speed, header_size,
+					   cb, s);
 	if (!amdtp_stream_running(s)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
@@ -631,13 +870,17 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->packet_index = 0;
 	do {
-		err = queue_out_packet(s, 0, true);
+		if (s->direction == AMDTP_TRANSMIT_STREAM)
+			err = queue_in_packet(s);
+		else
+			err = queue_out_packet(s, 0, true);
 		if (err < 0)
 			goto err_context;
 	} while (s->packet_index > 0);
 
+	/* NOTE: TAG1 matches CIP. This just affects in stream */
 	s->data_block_counter = 0;
-	err = fw_iso_context_start(s->context, -1, 0, 0);
+	err = fw_iso_context_start(s->context, -1, 0, FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
 		goto err_context;
 
-- 
1.8.3.2
