From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-lib: use IT context header
	to compute cycle count for scheduling packet
Date: Tue, 21 May 2019 23:57:37 +0900
Message-ID: <20190521145737.11809-5-o-takashi@sakamocchi.jp>
References: <20190521145737.11809-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2BADF89717
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 16:57:54 +0200 (CEST)
In-Reply-To: <20190521145737.11809-1-o-takashi@sakamocchi.jp>
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

In IT context, header includes information of cycle to have processed
queued packet.

This commit uses the per-packet information to compute the cycle for
packet to be queued, instead of callback argument. In current
implementaion of ALSA IEC 61883-1/6 packet streaming engine, 48 packets
are queued at first to skip recent cycle. When IT context calls handler,
cycle information in header plus 48 cycle means the cycle to be going
to queue packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 51 +++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 5ebdac2086c0..f43943fd962d 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -694,13 +694,12 @@ static int handle_in_packet_without_header(struct amdtp_stream *s,
 	return 0;
 }
 
-/*
- * In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
- * the other hand, in DMA descriptors of 1394 OHCI, 3 bits are used to represent
- * it. Thus, via Linux firewire subsystem, we can get the 3 bits for second.
- */
-static inline u32 compute_cycle_count(u32 tstamp)
+// In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
+// the other hand, in DMA descriptors of 1394 OHCI, 3 bits are used to represent
+// it. Thus, via Linux firewire subsystem, we can get the 3 bits for second.
+static inline u32 compute_cycle_count(__be32 ctx_header_tstamp)
 {
+	u32 tstamp = be32_to_cpu(ctx_header_tstamp) & HEADER_TSTAMP_MASK;
 	return (((tstamp >> 13) & 0x07) * 8000) + (tstamp & 0x1fff);
 }
 
@@ -712,6 +711,16 @@ static inline u32 increment_cycle_count(u32 cycle, unsigned int addend)
 	return cycle;
 }
 
+// Align to actual cycle count for the packet which is going to be scheduled.
+// This module queued the same number of isochronous cycle as QUEUE_LENGTH to
+// skip isochronous cycle, therefore it's OK to just increment the cycle by
+// QUEUE_LENGTH for scheduled cycle.
+static inline u32 compute_it_cycle(const __be32 ctx_header_tstamp)
+{
+	u32 cycle = compute_cycle_count(ctx_header_tstamp);
+	return increment_cycle_count(cycle, QUEUE_LENGTH);
+}
+
 static inline void cancel_stream(struct amdtp_stream *s)
 {
 	s->packet_index = -1;
@@ -725,23 +734,23 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int i, packets = header_length / 4;
-	u32 cycle;
+	const __be32 *ctx_header = header;
+	unsigned int i, packets = header_length / sizeof(*ctx_header);
 
 	if (s->packet_index < 0)
 		return;
 
-	cycle = compute_cycle_count(tstamp);
+	for (i = 0; i < packets; ++i) {
+		u32 cycle;
 
-	/* Align to actual cycle count for the last packet. */
-	cycle = increment_cycle_count(cycle, QUEUE_LENGTH - packets);
+		cycle = compute_it_cycle(*ctx_header);
 
-	for (i = 0; i < packets; ++i) {
-		cycle = increment_cycle_count(cycle, 1);
 		if (s->handle_packet(s, 0, cycle, i) < 0) {
 			cancel_stream(s);
 			return;
 		}
+
+		++ctx_header;
 	}
 
 	fw_iso_context_queue_flush(s->context);
@@ -767,10 +776,9 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; i++) {
 		u32 iso_header = be32_to_cpu(ctx_header[0]);
-		unsigned int cycle;
+		u32 cycle;
 
-		tstamp = be32_to_cpu(ctx_header[1]) & HEADER_TSTAMP_MASK;
-		cycle = compute_cycle_count(tstamp);
+		cycle = compute_cycle_count(ctx_header[1]);
 
 		/* The number of bytes in this packet */
 		payload_length = iso_header >> ISO_DATA_LENGTH_SHIFT;
@@ -802,9 +810,8 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 					void *header, void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	__be32 *ctx_header = header;
+	const __be32 *ctx_header = header;
 	u32 cycle;
-	unsigned int packets;
 
 	/*
 	 * For in-stream, first packet has come.
@@ -814,8 +821,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 	wake_up(&s->callback_wait);
 
 	if (s->direction == AMDTP_IN_STREAM) {
-		tstamp = be32_to_cpu(ctx_header[1]) & HEADER_TSTAMP_MASK;
-		cycle = compute_cycle_count(tstamp);
+		cycle = compute_cycle_count(ctx_header[1]);
 
 		context->callback.sc = in_stream_callback;
 		if (s->flags & CIP_NO_HEADER)
@@ -823,9 +829,8 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 		else
 			s->handle_packet = handle_in_packet;
 	} else {
-		packets = header_length / 4;
-		cycle = compute_cycle_count(tstamp);
-		cycle = increment_cycle_count(cycle, QUEUE_LENGTH - packets);
+		cycle = compute_it_cycle(*ctx_header);
+
 		context->callback.sc = out_stream_callback;
 		if (s->flags & CIP_NO_HEADER)
 			s->handle_packet = handle_out_packet_without_header;
-- 
2.20.1
