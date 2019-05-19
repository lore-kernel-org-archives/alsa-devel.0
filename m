From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] firewire-lib: use the same unit for
	payload argument in tracing events
Date: Sun, 19 May 2019 19:01:07 +0900
Message-ID: <20190519100109.14167-4-o-takashi@sakamocchi.jp>
References: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25EC9F89709
 for <alsa-devel@alsa-project.org>; Sun, 19 May 2019 12:01:20 +0200 (CEST)
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

The most of tracing event in this module have the size of payload in
byte unit, however 'in_packet_without_header' event have the argument
in quadlet unit.

This commit change the unit for argument to be consistent.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 12 ++++++------
 sound/firewire/amdtp-stream.c       |  6 ++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 95343fb17583..30c547552cd2 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -39,7 +39,7 @@ TRACE_EVENT(in_packet,
 		__entry->dest = fw_parent_device(s->unit)->card->node_id;
 		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
 		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
-		__entry->payload_quadlets = payload_length / 4;
+		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks;
 		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
@@ -89,7 +89,7 @@ TRACE_EVENT(out_packet,
 		__entry->dest = fw_parent_device(s->unit)->node_id;
 		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
 		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
-		__entry->payload_quadlets = payload_length / 4;
+		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks;
 		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
@@ -114,8 +114,8 @@ TRACE_EVENT(out_packet,
 );
 
 TRACE_EVENT(in_packet_without_header,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, unsigned int payload_quadlets, unsigned int data_blocks, unsigned int index),
-	TP_ARGS(s, cycles, payload_quadlets, data_blocks, index),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
+	TP_ARGS(s, cycles, payload_length, data_blocks, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -135,7 +135,7 @@ TRACE_EVENT(in_packet_without_header,
 		__entry->channel = s->context->channel;
 		__entry->src = fw_parent_device(s->unit)->node_id;
 		__entry->dest = fw_parent_device(s->unit)->card->node_id;
-		__entry->payload_quadlets = payload_quadlets;
+		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks,
 		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
@@ -179,7 +179,7 @@ TRACE_EVENT(out_packet_without_header,
 		__entry->channel = s->context->channel;
 		__entry->src = fw_parent_device(s->unit)->card->node_id;
 		__entry->dest = fw_parent_device(s->unit)->node_id;
-		__entry->payload_quadlets = payload_length / 4;
+		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks,
 		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 67b60490e505..15ae1f2989e5 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -659,16 +659,14 @@ static int handle_in_packet_without_header(struct amdtp_stream *s,
 			unsigned int index)
 {
 	__be32 *buffer;
-	unsigned int payload_quadlets;
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
-	payload_quadlets = payload_length / 4;
-	data_blocks = payload_quadlets / s->data_block_quadlets;
+	data_blocks = payload_length / sizeof(__be32) / s->data_block_quadlets;
 
-	trace_in_packet_without_header(s, cycle, payload_quadlets, data_blocks,
+	trace_in_packet_without_header(s, cycle, payload_length, data_blocks,
 				       index);
 
 	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, NULL);
-- 
2.20.1
