From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/44] firewire-lib: Add support for AMDTP in-stream and PCM
	capture
Date: Fri, 21 Mar 2014 20:09:49 +0900
Message-ID: <1395400229-22957-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

For capturing PCM, this commit adds the functionality to handle in-stream.
This is also applied for dual-wire mode.

Currently, capturing 32bit samples are supported.

When the sequence of in-packet has discontinuity of dbc, in-stream isn't handled
and amdtp_streaming_error() returns true.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 231 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 213 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 74b1045..be1aabc 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -39,6 +39,7 @@
  * only "Clock-based rate control mode" is supported
  */
 #define AMDTP_FDF_AM824		(0 << (CIP_FDF_SFC_SHIFT + 3))
+#define AMDTP_FDF_NO_DATA	0xff
 #define AMDTP_DBS_MASK		0x00ff0000
 #define AMDTP_DBS_SHIFT		16
 #define AMDTP_DBC_MASK		0x000000ff
@@ -47,6 +48,7 @@
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
 
+#define IN_PACKET_HEADER_SIZE	4
 #define OUT_PACKET_HEADER_SIZE	0
 
 static void pcm_period_tasklet(unsigned long data);
@@ -179,6 +181,12 @@ static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
 static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
 				     struct snd_pcm_substream *pcm,
 				     __be32 *buffer, unsigned int frames);
+static void amdtp_read_s32(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames);
+static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
+				    struct snd_pcm_substream *pcm,
+				    __be32 *buffer, unsigned int frames);
 
 /**
  * amdtp_stream_set_pcm_format - set the PCM format
@@ -200,16 +208,27 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 		WARN_ON(1);
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S16:
-		if (s->dual_wire)
-			s->transfer_samples = amdtp_write_s16_dualwire;
-		else
-			s->transfer_samples = amdtp_write_s16;
-		break;
+		if (s->direction == AMDTP_OUT_STREAM) {
+			if (s->dual_wire)
+				s->transfer_samples = amdtp_write_s16_dualwire;
+			else
+				s->transfer_samples = amdtp_write_s16;
+			break;
+		}
+		WARN_ON(1);
+		/* fall through */
 	case SNDRV_PCM_FORMAT_S32:
-		if (s->dual_wire)
-			s->transfer_samples = amdtp_write_s32_dualwire;
-		else
-			s->transfer_samples = amdtp_write_s32;
+		if (s->direction == AMDTP_OUT_STREAM) {
+			if (s->dual_wire)
+				s->transfer_samples = amdtp_write_s32_dualwire;
+			else
+				s->transfer_samples = amdtp_write_s32;
+		} else {
+			if (s->dual_wire)
+				s->transfer_samples = amdtp_read_s32_dualwire;
+			else
+				s->transfer_samples = amdtp_read_s32;
+		}
 		break;
 	}
 }
@@ -420,6 +439,59 @@ static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
 	}
 }
 
+static void amdtp_read_s32(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	u32 *dst;
+
+	channels = s->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(buffer[c]) << 8;
+			dst++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
+				    struct snd_pcm_substream *pcm,
+				    __be32 *buffer, unsigned int frames)
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
+			*dst = be32_to_cpu(buffer[c * 2]) << 8;
+			dst++;
+		}
+		buffer += 1;
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(buffer[c * 2]) << 8;
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
@@ -504,6 +576,12 @@ static inline int queue_out_packet(struct amdtp_stream *s,
 			    payload_length, skip);
 }
 
+static inline int queue_in_packet(struct amdtp_stream *s)
+{
+	return queue_packet(s, IN_PACKET_HEADER_SIZE,
+			    amdtp_stream_get_max_payload(s), false);
+}
+
 static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
@@ -552,6 +630,80 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 		update_pcm_pointers(s, pcm, data_blocks);
 }
 
+static void handle_in_packet(struct amdtp_stream *s,
+			     unsigned int payload_quadlets,
+			     __be32 *buffer)
+{
+	u32 cip_header[2];
+	unsigned int data_blocks, data_block_quadlets, data_block_counter;
+	struct snd_pcm_substream *pcm = NULL;
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
+		dev_info_ratelimited(&s->unit->device,
+				"Invalid CIP header for AMDTP: %08X:%08X\n",
+				cip_header[0], cip_header[1]);
+		goto end;
+	}
+
+	/* Calculate data blocks */
+	if (payload_quadlets < 3 ||
+	    ((cip_header[1] & CIP_FDF_MASK) ==
+				(AMDTP_FDF_NO_DATA << CIP_FDF_SFC_SHIFT))) {
+		data_blocks = 0;
+	} else {
+		data_block_quadlets =
+			(cip_header[0] & AMDTP_DBS_MASK) >> AMDTP_DBS_SHIFT;
+		/* avoid division by zero */
+		if (data_block_quadlets == 0) {
+			dev_info_ratelimited(&s->unit->device,
+				"Detect invalid value in dbs field: %08X\n",
+				cip_header[0]);
+			goto err;
+		}
+
+		data_blocks = (payload_quadlets - 2) / data_block_quadlets;
+	}
+
+	/* Check data block counter continuity */
+	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
+	if (data_block_counter != s->data_block_counter) {
+		dev_info(&s->unit->device,
+			 "Detect discontinuity of CIP: %02X %02X\n",
+			 s->data_block_counter, data_block_counter);
+		goto err;
+	}
+
+	if (data_blocks > 0) {
+		buffer += 2;
+
+		pcm = ACCESS_ONCE(s->pcm);
+		if (pcm)
+			s->transfer_samples(s, pcm, buffer, data_blocks);
+	}
+
+	s->data_block_counter = (data_block_counter + data_blocks) & 0xff;
+end:
+	if (queue_in_packet(s) < 0)
+		goto err;
+
+	if (pcm)
+		update_pcm_pointers(s, pcm, data_blocks);
+
+	return;
+err:
+	s->packet_index = -1;
+	amdtp_stream_pcm_abort(s);
+}
+
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 				size_t header_length, void *header,
 				void *private_data)
@@ -571,6 +723,31 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 	fw_iso_context_queue_flush(s->context);
 }
 
+static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
+			       size_t header_length, void *header,
+			       void *private_data)
+{
+	struct amdtp_stream *s = private_data;
+	unsigned int p, packets, payload_quadlets;
+	__be32 *buffer, *headers = header;
+
+	/* The number of packets in buffer */
+	packets = header_length / IN_PACKET_HEADER_SIZE;
+
+	for (p = 0; p < packets; p++) {
+		if (s->packet_index < 0)
+			return;
+		buffer = s->buffer.packets[s->packet_index].buffer;
+
+		/* The number of quadlets in this packet */
+		payload_quadlets =
+			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
+		handle_in_packet(s, payload_quadlets, buffer);
+	}
+
+	fw_iso_context_queue_flush(s->context);
+}
+
 /**
  * amdtp_stream_start - start transferring packets
  * @s: the AMDTP stream to start
@@ -595,7 +772,10 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		[CIP_SFC_88200]  = {  0,   67 },
 		[CIP_SFC_176400] = {  0,   67 },
 	};
-	int err;
+	unsigned int header_size;
+	enum dma_data_direction dir;
+	fw_iso_callback_t cb;
+	int type, err;
 
 	mutex_lock(&s->mutex);
 
@@ -605,20 +785,31 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		goto err_unlock;
 	}
 
+	s->data_block_counter = 0;
 	s->data_block_state = initial_state[s->sfc].data_block;
 	s->syt_offset_state = initial_state[s->sfc].syt_offset;
 	s->last_syt_offset = TICKS_PER_CYCLE;
 
+	/* initialize packet buffer */
+	if (s->direction == AMDTP_IN_STREAM) {
+		dir = DMA_FROM_DEVICE;
+		type = FW_ISO_CONTEXT_RECEIVE;
+		header_size = IN_PACKET_HEADER_SIZE;
+		cb = in_stream_callback;
+	} else {
+		dir = DMA_TO_DEVICE;
+		type = FW_ISO_CONTEXT_TRANSMIT;
+		header_size = OUT_PACKET_HEADER_SIZE;
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
 	if (IS_ERR(s->context)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
@@ -631,13 +822,17 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->packet_index = 0;
 	do {
-		err = queue_out_packet(s, 0, true);
+		if (s->direction == AMDTP_IN_STREAM)
+			err = queue_in_packet(s);
+		else
+			err = queue_out_packet(s, 0, true);
 		if (err < 0)
 			goto err_context;
 	} while (s->packet_index > 0);
 
-	s->data_block_counter = 0;
-	err = fw_iso_context_start(s->context, -1, 0, 0);
+	/* NOTE: TAG1 matches CIP. This just affects in stream. */
+	err = fw_iso_context_start(s->context, -1, 0,
+				   FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
 		goto err_context;
 
-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
