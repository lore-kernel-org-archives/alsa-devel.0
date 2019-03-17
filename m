From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: use 8 byte header for IR
	context to get isochronous cycle
Date: Sun, 17 Mar 2019 20:25:06 +0900
Message-ID: <20190317112506.20243-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5A2CF89636
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2019 12:25:14 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In kernel API of Linux FireWire subsystem, handlers of isochronous
receive (IR) context can get context headers as an argument of
callback. When 4 byte header is used, the context header includes
isochronous packet header for each packet. When 8 byte header is
used, it includes isochronous cycle as well.

ALSA IEC 61883-1/6 engine uses 4 byte header, and computes isochronous
cycle from the cycle of interrupt. The usage of 8 byte header can
obsolete the computation.

Furthermore, this change works well for a case that a series of
packet in one interrupt includes skipped isochronous cycle,

This commit uses 8 byte header to handle isochronous cycle.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 44 +++++++++++++++--------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 3ada55ed5381..43f28b813386 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -56,8 +56,9 @@
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
 
-#define IN_PACKET_HEADER_SIZE	4
+#define IR_HEADER_SIZE		8	// For header and timestamp.
 #define OUT_PACKET_HEADER_SIZE	0
+#define HEADER_TSTAMP_MASK	0x0000ffff
 
 static void pcm_period_tasklet(unsigned long data);
 
@@ -456,7 +457,7 @@ static inline int queue_out_packet(struct amdtp_stream *s,
 
 static inline int queue_in_packet(struct amdtp_stream *s)
 {
-	return queue_packet(s, IN_PACKET_HEADER_SIZE, s->max_payload_length);
+	return queue_packet(s, IR_HEADER_SIZE, s->max_payload_length);
 }
 
 static int handle_out_packet(struct amdtp_stream *s,
@@ -701,13 +702,6 @@ static inline u32 increment_cycle_count(u32 cycle, unsigned int addend)
 	return cycle;
 }
 
-static inline u32 decrement_cycle_count(u32 cycle, unsigned int subtrahend)
-{
-	if (cycle < subtrahend)
-		cycle += 8 * CYCLES_PER_SECOND;
-	return cycle - subtrahend;
-}
-
 static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				size_t header_length, void *header,
 				void *private_data)
@@ -745,29 +739,26 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	struct amdtp_stream *s = private_data;
 	unsigned int i, packets;
 	unsigned int payload_length, max_payload_length;
-	__be32 *headers = header;
-	u32 cycle;
+	__be32 *ctx_header = header;
 
 	if (s->packet_index < 0)
 		return;
 
 	/* The number of packets in buffer */
-	packets = header_length / IN_PACKET_HEADER_SIZE;
-
-	cycle = compute_cycle_count(tstamp);
-
-	/* Align to actual cycle count for the last packet. */
-	cycle = decrement_cycle_count(cycle, packets);
+	packets = header_length / IR_HEADER_SIZE;
 
 	/* For buffer-over-run prevention. */
 	max_payload_length = s->max_payload_length;
 
 	for (i = 0; i < packets; i++) {
-		cycle = increment_cycle_count(cycle, 1);
+		u32 iso_header = be32_to_cpu(ctx_header[0]);
+		unsigned int cycle;
+
+		tstamp = be32_to_cpu(ctx_header[1]) & HEADER_TSTAMP_MASK;
+		cycle = compute_cycle_count(tstamp);
 
 		/* The number of bytes in this packet */
-		payload_length =
-			(be32_to_cpu(headers[i]) >> ISO_DATA_LENGTH_SHIFT);
+		payload_length = iso_header >> ISO_DATA_LENGTH_SHIFT;
 		if (payload_length > max_payload_length) {
 			dev_err(&s->unit->device,
 				"Detect jumbo payload: %04x %04x\n",
@@ -777,6 +768,8 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 		if (s->handle_packet(s, payload_length, cycle, i) < 0)
 			break;
+
+		ctx_header += IR_HEADER_SIZE / sizeof(__be32);
 	}
 
 	/* Queueing error or detecting invalid payload. */
@@ -797,6 +790,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 					void *header, void *private_data)
 {
 	struct amdtp_stream *s = private_data;
+	__be32 *ctx_header = header;
 	u32 cycle;
 	unsigned int packets;
 
@@ -807,11 +801,10 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 	s->callbacked = true;
 	wake_up(&s->callback_wait);
 
-	cycle = compute_cycle_count(tstamp);
-
 	if (s->direction == AMDTP_IN_STREAM) {
-		packets = header_length / IN_PACKET_HEADER_SIZE;
-		cycle = decrement_cycle_count(cycle, packets);
+		tstamp = be32_to_cpu(ctx_header[1]) & HEADER_TSTAMP_MASK;
+		cycle = compute_cycle_count(tstamp);
+
 		context->callback.sc = in_stream_callback;
 		if (s->flags & CIP_NO_HEADER)
 			s->handle_packet = handle_in_packet_without_header;
@@ -819,6 +812,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 			s->handle_packet = handle_in_packet;
 	} else {
 		packets = header_length / 4;
+		cycle = compute_cycle_count(tstamp);
 		cycle = increment_cycle_count(cycle, QUEUE_LENGTH - packets);
 		context->callback.sc = out_stream_callback;
 		if (s->flags & CIP_NO_HEADER)
@@ -880,7 +874,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	if (s->direction == AMDTP_IN_STREAM) {
 		dir = DMA_FROM_DEVICE;
 		type = FW_ISO_CONTEXT_RECEIVE;
-		header_size = IN_PACKET_HEADER_SIZE;
+		header_size = IR_HEADER_SIZE;
 	} else {
 		dir = DMA_TO_DEVICE;
 		type = FW_ISO_CONTEXT_TRANSMIT;
-- 
2.19.1
