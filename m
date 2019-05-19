From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] firewire-lib: add
	data_blocks/data_block_counter parameter to
	in_packet/out_packet tracing events
Date: Sun, 19 May 2019 19:01:06 +0900
Message-ID: <20190519100109.14167-3-o-takashi@sakamocchi.jp>
References: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D056F89630
 for <alsa-devel@alsa-project.org>; Sun, 19 May 2019 12:01:18 +0200 (CEST)
In-Reply-To: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
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

Tracing events for packets without CIP header have a parameter of
data_blocks/data_block_counter, but events for packets with CIP header
don't. This is not good to unify these events.

This commit adds the missing parameters to the events. In timing to
probe 'in_packet' event, data_blocks and data_block_counter are not
calculated yet. This commit also changes the timing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 24 ++++++++++++++++++------
 sound/firewire/amdtp-stream.c       |  6 +++---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index a86a827eab90..95343fb17583 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -14,8 +14,8 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(in_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int index),
-	TP_ARGS(s, cycles, cip_header, payload_length, index),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
+	TP_ARGS(s, cycles, cip_header, payload_length, data_blocks, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -25,6 +25,8 @@ TRACE_EVENT(in_packet,
 		__field(u32, cip_header0)
 		__field(u32, cip_header1)
 		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, data_blocks)
+		__field(unsigned int, data_block_counter)
 		__field(unsigned int, packet_index)
 		__field(unsigned int, irq)
 		__field(unsigned int, index)
@@ -38,12 +40,14 @@ TRACE_EVENT(in_packet,
 		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
 		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
 		__entry->payload_quadlets = payload_length / 4;
+		__entry->data_blocks = data_blocks;
+		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
 		__entry->irq = !!in_interrupt();
 		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %01u %02u",
+		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %03u %02u %01u %02u",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
@@ -52,14 +56,16 @@ TRACE_EVENT(in_packet,
 		__entry->cip_header0,
 		__entry->cip_header1,
 		__entry->payload_quadlets,
+		__entry->data_blocks,
+		__entry->data_block_counter,
 		__entry->packet_index,
 		__entry->irq,
 		__entry->index)
 );
 
 TRACE_EVENT(out_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, __be32 *cip_header, unsigned int payload_length, unsigned int index),
-	TP_ARGS(s, cycles, cip_header, payload_length, index),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
+	TP_ARGS(s, cycles, cip_header, payload_length, data_blocks, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -69,6 +75,8 @@ TRACE_EVENT(out_packet,
 		__field(u32, cip_header0)
 		__field(u32, cip_header1)
 		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, data_blocks)
+		__field(unsigned int, data_block_counter)
 		__field(unsigned int, packet_index)
 		__field(unsigned int, irq)
 		__field(unsigned int, index)
@@ -82,12 +90,14 @@ TRACE_EVENT(out_packet,
 		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
 		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
 		__entry->payload_quadlets = payload_length / 4;
+		__entry->data_blocks = data_blocks;
+		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
 		__entry->irq = !!in_interrupt();
 		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %01u %02u",
+		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %03u %02u %01u %02u",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
@@ -96,6 +106,8 @@ TRACE_EVENT(out_packet,
 		__entry->cip_header0,
 		__entry->cip_header1,
 		__entry->payload_quadlets,
+		__entry->data_blocks,
+		__entry->data_block_counter,
 		__entry->packet_index,
 		__entry->irq,
 		__entry->index)
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 2614fa551e24..67b60490e505 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -493,7 +493,7 @@ static int handle_out_packet(struct amdtp_stream *s,
 				(s->data_block_counter + data_blocks) & 0xff;
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 
-	trace_out_packet(s, cycle, buffer, payload_length, index);
+	trace_out_packet(s, cycle, buffer, payload_length, data_blocks, index);
 
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
@@ -555,8 +555,6 @@ static int handle_in_packet(struct amdtp_stream *s,
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
-	trace_in_packet(s, cycle, buffer, payload_length, index);
-
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
 	 * For convenience, also check FMT field is AM824 or not.
@@ -635,6 +633,8 @@ static int handle_in_packet(struct amdtp_stream *s,
 		return -EIO;
 	}
 
+	trace_in_packet(s, cycle, buffer, payload_length, data_blocks, index);
+
 	syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
 
-- 
2.20.1
