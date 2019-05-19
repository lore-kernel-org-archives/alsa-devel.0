From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] firewire-lib: use dynamic array for CIP
	header of tracing events
Date: Sun, 19 May 2019 19:01:08 +0900
Message-ID: <20190519100109.14167-5-o-takashi@sakamocchi.jp>
References: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0E52F89618
 for <alsa-devel@alsa-project.org>; Sun, 19 May 2019 12:01:21 +0200 (CEST)
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

This modules handles two types of isochronous packet; one has CIP header
in IEC 61883-1/6 and another doesn't. The module also have tracing events
corresponding to the types of packet. To unify the events, one event
should be probed with or without CIP header.

This commit uses dynamic array for the events to be available for the
types of packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 36 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 30c547552cd2..614dfd08aa48 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -22,8 +22,7 @@ TRACE_EVENT(in_packet,
 		__field(int, channel)
 		__field(int, src)
 		__field(int, dest)
-		__field(u32, cip_header0)
-		__field(u32, cip_header1)
+		__dynamic_array(u8, cip_header, cip_header ? 8 : 0)
 		__field(unsigned int, payload_quadlets)
 		__field(unsigned int, data_blocks)
 		__field(unsigned int, data_block_counter)
@@ -37,8 +36,10 @@ TRACE_EVENT(in_packet,
 		__entry->channel = s->context->channel;
 		__entry->src = fw_parent_device(s->unit)->node_id;
 		__entry->dest = fw_parent_device(s->unit)->card->node_id;
-		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
-		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
+		if (cip_header) {
+			memcpy(__get_dynamic_array(cip_header), cip_header,
+			       __get_dynamic_array_len(cip_header));
+		}
 		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks;
 		__entry->data_block_counter = s->data_block_counter,
@@ -47,20 +48,21 @@ TRACE_EVENT(in_packet,
 		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %03u %02u %01u %02u",
+		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u %s",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
 		__entry->dest,
 		__entry->channel,
-		__entry->cip_header0,
-		__entry->cip_header1,
 		__entry->payload_quadlets,
 		__entry->data_blocks,
 		__entry->data_block_counter,
 		__entry->packet_index,
 		__entry->irq,
-		__entry->index)
+		__entry->index,
+		__print_array(__get_dynamic_array(cip_header),
+			      __get_dynamic_array_len(cip_header),
+			      sizeof(u8)))
 );
 
 TRACE_EVENT(out_packet,
@@ -72,8 +74,7 @@ TRACE_EVENT(out_packet,
 		__field(int, channel)
 		__field(int, src)
 		__field(int, dest)
-		__field(u32, cip_header0)
-		__field(u32, cip_header1)
+		__dynamic_array(u8, cip_header, cip_header ? 8 : 0)
 		__field(unsigned int, payload_quadlets)
 		__field(unsigned int, data_blocks)
 		__field(unsigned int, data_block_counter)
@@ -87,8 +88,10 @@ TRACE_EVENT(out_packet,
 		__entry->channel = s->context->channel;
 		__entry->src = fw_parent_device(s->unit)->card->node_id;
 		__entry->dest = fw_parent_device(s->unit)->node_id;
-		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
-		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
+		if (cip_header) {
+			memcpy(__get_dynamic_array(cip_header), cip_header,
+			       __get_dynamic_array_len(cip_header));
+		}
 		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks;
 		__entry->data_block_counter = s->data_block_counter,
@@ -97,20 +100,21 @@ TRACE_EVENT(out_packet,
 		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %03u %02u %01u %02u",
+		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u %s",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
 		__entry->dest,
 		__entry->channel,
-		__entry->cip_header0,
-		__entry->cip_header1,
 		__entry->payload_quadlets,
 		__entry->data_blocks,
 		__entry->data_block_counter,
 		__entry->packet_index,
 		__entry->irq,
-		__entry->index)
+		__entry->index,
+		__print_array(__get_dynamic_array(cip_header),
+			      __get_dynamic_array_len(cip_header),
+			      sizeof(u8)))
 );
 
 TRACE_EVENT(in_packet_without_header,
-- 
2.20.1
