From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: firewire_lib: add tracepoints for
	packets without CIP headers
Date: Sun,  9 Apr 2017 21:33:27 +0900
Message-ID: <20170409123329.12079-2-o-takashi@sakamocchi.jp>
References: <20170409123329.12079-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 22D16266A4B
 for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2017 14:33:34 +0200 (CEST)
In-Reply-To: <20170409123329.12079-1-o-takashi@sakamocchi.jp>
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

Unique protocol is used for RME Fireface series. In this protocol,
payload format for isochronous packet is not compliant to CIP in
IEC 61883-1/6. The packet includes data blocks just with data channels,
without headers and any metadata.

In previous commits, ALSA IEC 61883-1/6 engine supports this protocol.
However, tracepoints are not supported yet, unlike implementation for
IEC 61883-1/6 protocol. This commit adds support of tracepoints for
the protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 88 +++++++++++++++++++++++++++++++++++++
 sound/firewire/amdtp-stream.c       |  8 ++++
 2 files changed, 96 insertions(+)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 850b36e..ea0d486 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -101,6 +101,94 @@ TRACE_EVENT(out_packet,
 		__entry->index)
 );
 
+TRACE_EVENT(in_packet_without_header,
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, unsigned int payload_quadlets, unsigned int data_blocks, unsigned int index),
+	TP_ARGS(s, cycles, payload_quadlets, data_blocks, index),
+	TP_STRUCT__entry(
+		__field(unsigned int, second)
+		__field(unsigned int, cycle)
+		__field(int, channel)
+		__field(int, src)
+		__field(int, dest)
+		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, data_blocks)
+		__field(unsigned int, data_block_counter)
+		__field(unsigned int, packet_index)
+		__field(unsigned int, irq)
+		__field(unsigned int, index)
+	),
+	TP_fast_assign(
+		__entry->second = cycles / CYCLES_PER_SECOND;
+		__entry->cycle = cycles % CYCLES_PER_SECOND;
+		__entry->channel = s->context->channel;
+		__entry->src = fw_parent_device(s->unit)->node_id;
+		__entry->dest = fw_parent_device(s->unit)->card->node_id;
+		__entry->payload_quadlets = payload_quadlets;
+		__entry->data_blocks = data_blocks,
+		__entry->data_block_counter = s->data_block_counter,
+		__entry->packet_index = s->packet_index;
+		__entry->irq = !!in_interrupt();
+		__entry->index = index;
+	),
+	TP_printk(
+		"%02u %04u %04x %04x %02d %03u %3u %3u %02u %01u %02u",
+		__entry->second,
+		__entry->cycle,
+		__entry->src,
+		__entry->dest,
+		__entry->channel,
+		__entry->payload_quadlets,
+		__entry->data_blocks,
+		__entry->data_block_counter,
+		__entry->packet_index,
+		__entry->irq,
+		__entry->index)
+);
+
+TRACE_EVENT(out_packet_without_header,
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
+	TP_ARGS(s, cycles, payload_length, data_blocks, index),
+	TP_STRUCT__entry(
+		__field(unsigned int, second)
+		__field(unsigned int, cycle)
+		__field(int, channel)
+		__field(int, src)
+		__field(int, dest)
+		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, data_blocks)
+		__field(unsigned int, data_block_counter)
+		__field(unsigned int, packet_index)
+		__field(unsigned int, irq)
+		__field(unsigned int, index)
+	),
+	TP_fast_assign(
+		__entry->second = cycles / CYCLES_PER_SECOND;
+		__entry->cycle = cycles % CYCLES_PER_SECOND;
+		__entry->channel = s->context->channel;
+		__entry->src = fw_parent_device(s->unit)->card->node_id;
+		__entry->dest = fw_parent_device(s->unit)->node_id;
+		__entry->payload_quadlets = payload_length / 4;
+		__entry->data_blocks = data_blocks,
+		__entry->data_blocks = s->data_block_counter,
+		__entry->packet_index = s->packet_index;
+		__entry->irq = !!in_interrupt();
+		__entry->index = index;
+	),
+	TP_printk(
+		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u",
+		__entry->second,
+		__entry->cycle,
+		__entry->src,
+		__entry->dest,
+		__entry->channel,
+		__entry->payload_quadlets,
+		__entry->data_blocks,
+		__entry->data_block_counter,
+		__entry->packet_index,
+		__entry->irq,
+		__entry->index)
+);
+
 #endif
 
 #undef TRACE_INCLUDE_PATH
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index a03b37b..f6af8e6 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -479,6 +479,10 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
 	payload_length = data_blocks * 4 * s->data_block_quadlets;
+
+	trace_out_packet_without_header(s, cycle, payload_length, data_blocks,
+					index);
+
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
 
@@ -617,6 +621,10 @@ static int handle_in_packet_without_header(struct amdtp_stream *s,
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	data_blocks = payload_quadlets / s->data_block_quadlets;
+
+	trace_in_packet_without_header(s, cycle, payload_quadlets, data_blocks,
+				       index);
+
 	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, NULL);
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
-- 
2.9.3
