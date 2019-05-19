From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] firewire-lib: unify tracing events to
	'amdtp_packet' event
Date: Sun, 19 May 2019 19:01:09 +0900
Message-ID: <20190519100109.14167-6-o-takashi@sakamocchi.jp>
References: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C520F8961D
 for <alsa-devel@alsa-project.org>; Sun, 19 May 2019 12:01:23 +0200 (CEST)
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

Now four events of this module have the same arguments and probe timing.
This commit adds a new event, 'amdtp_packet', and replace them. Filtering
functionality of tracing framework is available to pick up events for
inbound/outbound isochronous packets.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 149 ++--------------------------
 sound/firewire/amdtp-stream.c       |  10 +-
 2 files changed, 11 insertions(+), 148 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 614dfd08aa48..ab708857979f 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -13,7 +13,7 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(in_packet,
+TRACE_EVENT(amdtp_packet,
 	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
 	TP_ARGS(s, cycles, cip_header, payload_length, data_blocks, index),
 	TP_STRUCT__entry(
@@ -34,60 +34,13 @@ TRACE_EVENT(in_packet,
 		__entry->second = cycles / CYCLES_PER_SECOND;
 		__entry->cycle = cycles % CYCLES_PER_SECOND;
 		__entry->channel = s->context->channel;
-		__entry->src = fw_parent_device(s->unit)->node_id;
-		__entry->dest = fw_parent_device(s->unit)->card->node_id;
-		if (cip_header) {
-			memcpy(__get_dynamic_array(cip_header), cip_header,
-			       __get_dynamic_array_len(cip_header));
+		if (s->direction == AMDTP_IN_STREAM) {
+			__entry->src = fw_parent_device(s->unit)->node_id;
+			__entry->dest = fw_parent_device(s->unit)->card->node_id;
+		} else {
+			__entry->src = fw_parent_device(s->unit)->card->node_id;
+			__entry->dest = fw_parent_device(s->unit)->node_id;
 		}
-		__entry->payload_quadlets = payload_length / sizeof(__be32);
-		__entry->data_blocks = data_blocks;
-		__entry->data_block_counter = s->data_block_counter,
-		__entry->packet_index = s->packet_index;
-		__entry->irq = !!in_interrupt();
-		__entry->index = index;
-	),
-	TP_printk(
-		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u %s",
-		__entry->second,
-		__entry->cycle,
-		__entry->src,
-		__entry->dest,
-		__entry->channel,
-		__entry->payload_quadlets,
-		__entry->data_blocks,
-		__entry->data_block_counter,
-		__entry->packet_index,
-		__entry->irq,
-		__entry->index,
-		__print_array(__get_dynamic_array(cip_header),
-			      __get_dynamic_array_len(cip_header),
-			      sizeof(u8)))
-);
-
-TRACE_EVENT(out_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
-	TP_ARGS(s, cycles, cip_header, payload_length, data_blocks, index),
-	TP_STRUCT__entry(
-		__field(unsigned int, second)
-		__field(unsigned int, cycle)
-		__field(int, channel)
-		__field(int, src)
-		__field(int, dest)
-		__dynamic_array(u8, cip_header, cip_header ? 8 : 0)
-		__field(unsigned int, payload_quadlets)
-		__field(unsigned int, data_blocks)
-		__field(unsigned int, data_block_counter)
-		__field(unsigned int, packet_index)
-		__field(unsigned int, irq)
-		__field(unsigned int, index)
-	),
-	TP_fast_assign(
-		__entry->second = cycles / CYCLES_PER_SECOND;
-		__entry->cycle = cycles % CYCLES_PER_SECOND;
-		__entry->channel = s->context->channel;
-		__entry->src = fw_parent_device(s->unit)->card->node_id;
-		__entry->dest = fw_parent_device(s->unit)->node_id;
 		if (cip_header) {
 			memcpy(__get_dynamic_array(cip_header), cip_header,
 			       __get_dynamic_array_len(cip_header));
@@ -117,94 +70,6 @@ TRACE_EVENT(out_packet,
 			      sizeof(u8)))
 );
 
-TRACE_EVENT(in_packet_without_header,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
-	TP_ARGS(s, cycles, payload_length, data_blocks, index),
-	TP_STRUCT__entry(
-		__field(unsigned int, second)
-		__field(unsigned int, cycle)
-		__field(int, channel)
-		__field(int, src)
-		__field(int, dest)
-		__field(unsigned int, payload_quadlets)
-		__field(unsigned int, data_blocks)
-		__field(unsigned int, data_block_counter)
-		__field(unsigned int, packet_index)
-		__field(unsigned int, irq)
-		__field(unsigned int, index)
-	),
-	TP_fast_assign(
-		__entry->second = cycles / CYCLES_PER_SECOND;
-		__entry->cycle = cycles % CYCLES_PER_SECOND;
-		__entry->channel = s->context->channel;
-		__entry->src = fw_parent_device(s->unit)->node_id;
-		__entry->dest = fw_parent_device(s->unit)->card->node_id;
-		__entry->payload_quadlets = payload_length / sizeof(__be32);
-		__entry->data_blocks = data_blocks,
-		__entry->data_block_counter = s->data_block_counter,
-		__entry->packet_index = s->packet_index;
-		__entry->irq = !!in_interrupt();
-		__entry->index = index;
-	),
-	TP_printk(
-		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u",
-		__entry->second,
-		__entry->cycle,
-		__entry->src,
-		__entry->dest,
-		__entry->channel,
-		__entry->payload_quadlets,
-		__entry->data_blocks,
-		__entry->data_block_counter,
-		__entry->packet_index,
-		__entry->irq,
-		__entry->index)
-);
-
-TRACE_EVENT(out_packet_without_header,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
-	TP_ARGS(s, cycles, payload_length, data_blocks, index),
-	TP_STRUCT__entry(
-		__field(unsigned int, second)
-		__field(unsigned int, cycle)
-		__field(int, channel)
-		__field(int, src)
-		__field(int, dest)
-		__field(unsigned int, payload_quadlets)
-		__field(unsigned int, data_blocks)
-		__field(unsigned int, data_block_counter)
-		__field(unsigned int, packet_index)
-		__field(unsigned int, irq)
-		__field(unsigned int, index)
-	),
-	TP_fast_assign(
-		__entry->second = cycles / CYCLES_PER_SECOND;
-		__entry->cycle = cycles % CYCLES_PER_SECOND;
-		__entry->channel = s->context->channel;
-		__entry->src = fw_parent_device(s->unit)->card->node_id;
-		__entry->dest = fw_parent_device(s->unit)->node_id;
-		__entry->payload_quadlets = payload_length / sizeof(__be32);
-		__entry->data_blocks = data_blocks,
-		__entry->data_block_counter = s->data_block_counter,
-		__entry->packet_index = s->packet_index;
-		__entry->irq = !!in_interrupt();
-		__entry->index = index;
-	),
-	TP_printk(
-		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u",
-		__entry->second,
-		__entry->cycle,
-		__entry->src,
-		__entry->dest,
-		__entry->channel,
-		__entry->payload_quadlets,
-		__entry->data_blocks,
-		__entry->data_block_counter,
-		__entry->packet_index,
-		__entry->irq,
-		__entry->index)
-);
-
 #endif
 
 #undef TRACE_INCLUDE_PATH
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 15ae1f2989e5..6b3f936fab91 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -493,7 +493,7 @@ static int handle_out_packet(struct amdtp_stream *s,
 				(s->data_block_counter + data_blocks) & 0xff;
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 
-	trace_out_packet(s, cycle, buffer, payload_length, data_blocks, index);
+	trace_amdtp_packet(s, cycle, buffer, payload_length, data_blocks, index);
 
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
@@ -524,8 +524,7 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 
 	payload_length = data_blocks * 4 * s->data_block_quadlets;
 
-	trace_out_packet_without_header(s, cycle, payload_length, data_blocks,
-					index);
+	trace_amdtp_packet(s, cycle, NULL, payload_length, data_blocks, index);
 
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
@@ -633,7 +632,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 		return -EIO;
 	}
 
-	trace_in_packet(s, cycle, buffer, payload_length, data_blocks, index);
+	trace_amdtp_packet(s, cycle, buffer, payload_length, data_blocks, index);
 
 	syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
@@ -666,8 +665,7 @@ static int handle_in_packet_without_header(struct amdtp_stream *s,
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	data_blocks = payload_length / sizeof(__be32) / s->data_block_quadlets;
 
-	trace_in_packet_without_header(s, cycle, payload_length, data_blocks,
-				       index);
+	trace_amdtp_packet(s, cycle, NULL, payload_length, data_blocks, index);
 
 	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, NULL);
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
-- 
2.20.1
