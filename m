From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] Add handling AMDTP receive stream
Date: Mon, 29 Apr 2013 18:47:21 +0900
Message-ID: <1367228841-8526-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367228841-8526-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1367228841-8526-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

To handle AMDTP receive stream, this patch adds some codes with condition of its
direction and new functions. Once amdtp_stream_init() is executed with its
direction, AMDTP receive and transmit stream can be handles by the same way.

Unfortunatelly Echo Audio's Fireworks(TM) is not fully compliant to IEC 61883-6
against their guide. This patch include some work arounds for Fireworks.

For future implementation of MIDI referring to MMA/AMEI RP-027, this commit add
some variables and functions which are currently useless.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c |  275 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 263 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 59fd34c..136087b 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -56,6 +56,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 		return -EINVAL;
 
 	s->unit = fw_unit_get(unit);
+	s->direction = direction;
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
@@ -138,7 +139,10 @@ unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 	s->data_block_quadlets = s->pcm_channels;
 	s->data_block_quadlets += DIV_ROUND_UP(s->midi_ports, 8);
 
-	return 8 + max_data_blocks[s->sfc] * 4 * s->data_block_quadlets;
+	if (s->direction == AMDTP_STREAM_RECEIVE)
+		return 8 + s->syt_interval * s->data_block_quadlets * 4;
+	else
+		return 8 + max_data_blocks[s->sfc] * 4 * s->data_block_quadlets;
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
@@ -148,6 +152,12 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 static void amdtp_write_s32(struct amdtp_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames);
+static void amdtp_read_s16(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames);
+static void amdtp_read_s32(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames);
 
 /**
  * amdtp_stream_set_pcm_format - set the PCM format
@@ -168,10 +178,16 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 		WARN_ON(1);
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S16:
-		s->transfer_samples = amdtp_write_s16;
+		if (s->direction == AMDTP_STREAM_RECEIVE)
+			s->transfer_samples = amdtp_read_s16;
+		else
+			s->transfer_samples = amdtp_write_s16;
 		break;
 	case SNDRV_PCM_FORMAT_S32:
-		s->transfer_samples = amdtp_write_s32;
+		if (s->direction == AMDTP_STREAM_RECEIVE)
+			s->transfer_samples = amdtp_read_s32;
+		else
+			s->transfer_samples = amdtp_write_s32;
 		break;
 	}
 }
@@ -320,6 +336,58 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 	}
 }
 
+static void amdtp_read_s32(struct amdtp_stream *s,
+			   struct snd_pcm_substream *pcm,
+			   __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, frame_step, i, c;
+	u32 *dst;
+
+	channels = s->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+	frame_step = s->data_block_quadlets - channels;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(*buffer) << 8;
+			dst += 1;
+			buffer += 1;
+		}
+		buffer += frame_step;
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
+	unsigned int channels, remaining_frames, frame_step, i, c;
+	u16 *dst;
+
+	channels = s->pcm_channels;
+	dst = (void *)runtime->dma_area +
+			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+	frame_step = s->data_block_quadlets - channels;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(*buffer) << 8;
+			dst += 1;
+			buffer += 1;
+		}
+		buffer += frame_step;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
 static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 				   __be32 *buffer, unsigned int frames)
 {
@@ -342,6 +410,13 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 						cpu_to_be32(0x80000000);
 }
 
+static void amdtp_pull_midi(struct amdtp_stream *s,
+			    __be32 *buffer, unsigned int frames)
+{
+	/* not implemented yet */
+	return;
+}
+
 static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
@@ -410,6 +485,117 @@ static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
 	}
 }
 
+static void handle_in_packet_data(struct amdtp_stream *s,
+				  unsigned int data_quadlets)
+{
+	__be32 *buffer;
+	u32 cip_header[2];
+	unsigned int index, frames, data_block_quadlets,
+					data_block_counter, ptr;
+	struct snd_pcm_substream *pcm;
+	struct fw_iso_packet packet;
+	int err;
+
+	if (s->packet_index < 0)
+		return;
+	index = s->packet_index;
+
+	buffer = s->buffer.packets[index].buffer;
+	cip_header[0] = be32_to_cpu(buffer[0]);
+	cip_header[1] = be32_to_cpu(buffer[1]);
+
+	/* checking CIP headers for AMDTP with restriction of this module */
+	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
+	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH) ||
+	    ((cip_header[1] & CIP_FMT_MASK) != CIP_FMT_AM)) {
+		dev_err(&s->unit->device, "CIP header error: %08X:%08X\n",
+			cip_header[0], cip_header[1]);
+		pcm = NULL;
+	} else if ((data_quadlets < 3) ||
+		   ((cip_header[1] & AMDTP_FDF_MASK) == AMDTP_FDF_NO_DATA)) {
+		pcm = NULL;
+	} else {
+		/*
+		 * NOTE: this module doesn't check dbc and syt field
+		 *
+		 * Echo Audio's Fireworks reports wrong number of data block
+		 * counter. It always reports it with increment by 8 blocks
+		 * even if actual data blocks different from 8.
+		 *
+		 * Handling syt field is related to "presentation" time stamp,
+		 * but ALSA has no implements equivalent to it so this module
+		 * don't support it.
+		 */
+		data_block_quadlets = (cip_header[0] & AMDTP_DBS_MASK) >>
+								AMDTP_DBS_SHIFT;
+		data_block_counter  = cip_header[0] & AMDTP_DBC_MASK;
+
+		/*
+		 * NOTE: Echo Audio's Fireworks reports a fixed value for data
+		 * block quadlets but the actual value differs depending on
+		 * current sampling rate. This is a workaround for Fireworks.
+		 */
+		if ((data_quadlets - 2) % data_block_quadlets > 0)
+			s->data_block_quadlets =
+					s->pcm_channels + s->midi_ports;
+		else
+			s->data_block_quadlets = data_block_quadlets;
+
+		/* finish to check CIP header */
+		buffer += 2;
+
+		/*
+		 * NOTE: here "frames" is equivalent to "events"
+		 * in IEC 61883-1
+		 */
+		frames = (data_quadlets - 2) / s->data_block_quadlets;
+		pcm = ACCESS_ONCE(s->pcm);
+		if (pcm)
+			s->transfer_samples(s, pcm, buffer, frames);
+		if (s->midi_ports)
+			amdtp_pull_midi(s, buffer, frames);
+
+		/* for next packet */
+		s->data_block_quadlets = data_block_quadlets;
+		s->data_block_counter  = data_block_counter;
+	}
+
+	/* queueing a packet for next cycle */
+	packet.payload_length = amdtp_stream_get_max_payload(s);
+	packet.interrupt = IS_ALIGNED(index + 1, INTERRUPT_INTERVAL);
+	packet.skip = 0;
+	packet.header_length = 4;
+
+	err = fw_iso_context_queue(s->context, &packet, &s->buffer.iso_buffer,
+				   s->buffer.packets[index].offset);
+	if (err < 0) {
+		dev_err(&s->unit->device, "queueing error: %d\n", err);
+		s->packet_index = -1;
+		amdtp_stream_pcm_abort(s);
+		return;
+	}
+
+	/* calculate packet index */
+	if (++index >= QUEUE_LENGTH)
+		index = 0;
+	s->packet_index = index;
+
+	/* calculate period and buffer borders */
+	if (pcm != NULL) {
+		ptr = s->pcm_buffer_pointer + frames;
+		if (ptr >= pcm->runtime->buffer_size)
+			ptr -= pcm->runtime->buffer_size;
+		ACCESS_ONCE(s->pcm_buffer_pointer) = ptr;
+
+		s->pcm_period_pointer += frames;
+		if (s->pcm_period_pointer >= pcm->runtime->period_size) {
+			s->pcm_period_pointer -= pcm->runtime->period_size;
+			s->pointer_flush = false;
+			tasklet_hi_schedule(&s->period_tasklet);
+		}
+	}
+}
+
 static void pcm_period_tasklet(unsigned long data)
 {
 	struct amdtp_stream *s = (void *)data;
@@ -437,6 +623,50 @@ static void out_packet_callback(struct fw_iso_context *context, u32 cycle,
 	fw_iso_context_queue_flush(s->context);
 }
 
+static void in_packet_callback(struct fw_iso_context *context, u32 cycle,
+			size_t header_length, void *header, void *private_data)
+{
+	struct amdtp_stream *s = private_data;
+	unsigned int p, data_quadlets, packets = header_length / 4;
+	__be32 *headers = header;
+
+	/* each fields in an isochronous header are already used in juju */
+	for (p = 0; p < packets; p += 1) {
+		/* how many quadlet for data in this packet */
+		data_quadlets =
+			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
+		/* handle each packet data */
+		handle_in_packet_data(s, data_quadlets);
+	}
+
+	fw_iso_context_queue_flush(s->context);
+}
+
+static int queue_initial_packets(struct amdtp_stream *s)
+{
+	struct fw_iso_packet initial_packet;
+	unsigned int i;
+	int err;
+
+	/* header length is needed for receive stream */
+	initial_packet.payload_length = amdtp_stream_get_max_payload(s);
+	initial_packet.skip = 0;
+	initial_packet.header_length = 4;
+
+	for (i = 0; i < QUEUE_LENGTH; ++i) {
+		initial_packet.interrupt = IS_ALIGNED(s->packet_index + 1,
+						INTERRUPT_INTERVAL);
+		err = fw_iso_context_queue(s->context, &initial_packet,
+			&s->buffer.iso_buffer, s->buffer.packets[i].offset);
+		if (err < 0)
+			return err;
+		if (++s->packet_index >= QUEUE_LENGTH)
+			s->packet_index = 0;
+	}
+
+	return 0;
+}
+
 static int queue_initial_skip_packets(struct amdtp_stream *s)
 {
 	struct fw_iso_packet skip_packet = {
@@ -497,16 +727,31 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->syt_offset_state = initial_state[s->sfc].syt_offset;
 	s->last_syt_offset = TICKS_PER_CYCLE;
 
-	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
-				      amdtp_stream_get_max_payload(s),
-				      DMA_TO_DEVICE);
+	/* initialize packet buffer */
+	if (s->direction == AMDTP_STREAM_RECEIVE)
+		err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
+					amdtp_stream_get_max_payload(s),
+					DMA_FROM_DEVICE);
+	else
+		err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
+					amdtp_stream_get_max_payload(s),
+					DMA_TO_DEVICE);
 	if (err < 0)
 		goto err_unlock;
 
-	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
-					   FW_ISO_CONTEXT_TRANSMIT,
-					   channel, speed, 0,
-					   out_packet_callback, s);
+	/* create isochronous context */
+	if (s->direction == AMDTP_STREAM_RECEIVE)
+		s->context =
+			fw_iso_context_create(fw_parent_device(s->unit)->card,
+					FW_ISO_CONTEXT_RECEIVE,
+					channel, speed, 4,
+					in_packet_callback, s);
+	else
+		s->context =
+			fw_iso_context_create(fw_parent_device(s->unit)->card,
+					FW_ISO_CONTEXT_TRANSMIT,
+					channel, speed, 4,
+					out_packet_callback, s);
 	if (IS_ERR(s->context)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
@@ -519,11 +764,17 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->packet_index = 0;
 	s->data_block_counter = 0;
-	err = queue_initial_skip_packets(s);
+
+	if (s->direction == AMDTP_STREAM_RECEIVE)
+		err = queue_initial_packets(s);
+	else
+		err = queue_initial_skip_packets(s);
 	if (err < 0)
 		goto err_context;
 
-	err = fw_iso_context_start(s->context, -1, 0, 0);
+	/* NOTE: TAG1 matches CIP. This just affects receive stream */
+	err = fw_iso_context_start(s->context, -1, 0,
+					FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
 		goto err_context;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
