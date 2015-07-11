From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 28/37] ALSA: firewire-lib: enable protocol
	layer to handle current cycle count
Date: Sat, 11 Jul 2015 23:12:39 +0900
Message-ID: <1436623968-10780-29-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 202932605C8
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:07 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

The previous commit off-loads the work to generate source packet header
to each protocol implementation. In IEC 61883-1, the source packet
header shows timestamps, thus the protocol layer needs current cycle
count.

This commit allows the protocol layer to get the cycle count.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c         |  2 ++
 sound/firewire/amdtp-stream.c        | 54 ++++++++++++++++++++++++------------
 sound/firewire/amdtp-stream.h        |  1 +
 sound/firewire/digi00x/amdtp-dot.c   |  2 ++
 sound/firewire/tascam/amdtp-tascam.c |  2 ++
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index 37541bd..211654b 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -360,6 +360,7 @@ EXPORT_SYMBOL(amdtp_am824_midi_trigger);
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
+					   unsigned int cycles,
 					   unsigned int *syt)
 {
 	struct amdtp_am824 *p = (struct amdtp_am824 *)s->protocol;
@@ -383,6 +384,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
+					   unsigned int cycles,
 					   unsigned int *syt)
 {
 	struct amdtp_am824 *p = (struct amdtp_am824 *)s->protocol;
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 58f6ae0..8555b84 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -403,7 +403,7 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 }
 
 static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
-			     unsigned int syt)
+			     unsigned int cycle, unsigned int syt)
 {
 	__be32 *buffer;
 	unsigned int payload_length;
@@ -412,7 +412,8 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 
 	/* CIP processing. */
 	buffer = s->buffer.packets[s->packet_index].buffer;
-	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
+	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, cycle,
+					    &syt);
 
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
@@ -440,10 +441,11 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 
 static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int payload_quadlets, __be32 *buffer,
-			    unsigned int *data_blocks)
+			    unsigned int *data_blocks, unsigned int cycle,
+			    unsigned int syt)
 {
 	u32 cip_header[2];
-	unsigned int sph, fmt, fdf, syt;
+	unsigned int sph, fmt, fdf;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
@@ -523,8 +525,8 @@ static int handle_in_packet(struct amdtp_stream *s,
 	}
 
 	/* CIP processing. */
-	syt = cip_header[1] & CIP_SYT_MASK;
-	pcm_frames = s->process_data_blocks(s, buffer + 2, *data_blocks, &syt);
+	pcm_frames = s->process_data_blocks(s, buffer + 2, *data_blocks,
+					    cycle, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter = data_block_counter;
@@ -543,6 +545,18 @@ end:
 	return 0;
 }
 
+#define INCREMENT_CYCLE(cycle, addend, seconds, counts)			\
+	do {								\
+		seconds = cycle >> 13;					\
+		counts = (cycle & 0x0fff) + (addend);			\
+		if (counts >= 8000) {					\
+			counts %= 8000;					\
+			if (++seconds >= 8)				\
+				seconds %= 8;				\
+		}							\
+		cycle = (seconds << 13) | counts;			\
+	} while (0)
+
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 				size_t header_length, void *header,
 				void *private_data)
@@ -550,26 +564,27 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 	struct amdtp_stream *s = private_data;
 	unsigned int i, syt, packets = header_length / 4;
 	unsigned int data_blocks;
+	unsigned int seconds;
+	unsigned int counts;
 
 	if (s->packet_index < 0)
 		return;
 
-	/*
-	 * Compute the cycle of the last queued packet.
-	 * (We need only the four lowest bits for the SYT, so we can ignore
-	 * that bits 0-11 must wrap around at 3072.)
-	 */
-	cycle += QUEUE_LENGTH - packets;
+	/* Compute the cycle count for the first packet in this time. */
+	INCREMENT_CYCLE(cycle, QUEUE_LENGTH - packets + 1, seconds, counts);
 
 	for (i = 0; i < packets; ++i) {
-		syt = calculate_syt(s, ++cycle);
+		syt = calculate_syt(s, cycle);
 		data_blocks = calculate_data_blocks(s, syt);
 
-		if (handle_out_packet(s, data_blocks, syt) < 0) {
+		if (handle_out_packet(s, data_blocks, cycle, syt) < 0) {
 			s->packet_index = -1;
 			amdtp_stream_pcm_abort(s);
 			return;
 		}
+
+		/* Increment cycle count. */
+		INCREMENT_CYCLE(cycle, 1, seconds, counts);
 	}
 
 	fw_iso_context_queue_flush(s->context);
@@ -584,6 +599,8 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 	unsigned int payload_quadlets, max_payload_quadlets;
 	unsigned int data_blocks;
 	__be32 *buffer, *headers = header;
+	unsigned int seconds;
+	unsigned int counts;
 
 	if (s->packet_index < 0)
 		return;
@@ -607,22 +624,25 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			s->packet_index = -1;
 			break;
 		}
+		syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 
 		if (handle_in_packet(s, payload_quadlets, buffer,
-							&data_blocks) < 0) {
+					&data_blocks, cycle, syt) < 0) {
 			s->packet_index = -1;
 			break;
 		}
 
 		/* Process sync slave stream */
 		if (s->sync_slave && s->sync_slave->callbacked) {
-			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 			if (handle_out_packet(s->sync_slave,
-					      data_blocks, syt) < 0) {
+					data_blocks, cycle, syt) < 0) {
 				s->packet_index = -1;
 				break;
 			}
 		}
+
+		/* Increment cycle count. */
+		INCREMENT_CYCLE(cycle, 1, seconds, counts);
 	}
 
 	/* Queueing error or detecting discontinuity */
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index aa5d04d..4bcd2e4 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -126,6 +126,7 @@ struct amdtp_stream {
 	unsigned int (*process_data_blocks)(struct amdtp_stream *s,
 					    __be32 *buffer,
 					    unsigned int data_blocks,
+					    unsigned int cycle,
 					    unsigned int *syt);
 
 	/* For one PCM runtime processing. */
diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index 338e884..43dba43 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -343,6 +343,7 @@ void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
+					   unsigned int cycle,
 					   unsigned int *syt)
 {
 	struct amdtp_dot *p = (struct amdtp_dot *)s->protocol;
@@ -366,6 +367,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
+					   unsigned int cycle,
 					   unsigned int *syt)
 {
 	struct amdtp_dot *p = (struct amdtp_dot *)s->protocol;
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index ca54b85..a1a9337 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -172,6 +172,7 @@ static void read_control_messages(struct amdtp_stream *s,
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
+					   unsigned int cycle,
 					   unsigned int *syt)
 {
 	struct amdtp_tscm *p = (struct amdtp_tscm *)s->protocol;
@@ -189,6 +190,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
+					   unsigned int cycle,
 					   unsigned int *syt)
 {
 	struct amdtp_tscm *p = (struct amdtp_tscm *)s->protocol;
-- 
2.1.4
