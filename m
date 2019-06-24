From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] ALSA: firewire-motu: unify common
	tracepoints for both direction
Date: Mon, 24 Jun 2019 18:16:46 +0900
Message-ID: <20190624091646.7955-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83EFBF8071F
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 11:16:52 +0200 (CEST)
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

In ALSA firewire-motu driver, some tracepoints are supported to probe
vendor-specific data fields for SPH and status/control messages in
payload of isochronous packet. At present, the events of tracepoints
are unique each of direction, however the pair of events has the
same structure and print format. It's possible to unify the pair.

This commit unifies the pair. From userspace, direction is specified
by filtering for src/dst fields in the structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu-trace.h | 70 ++++++--------------------
 sound/firewire/motu/amdtp-motu.c       |  8 +--
 2 files changed, 20 insertions(+), 58 deletions(-)

diff --git a/sound/firewire/motu/amdtp-motu-trace.h b/sound/firewire/motu/amdtp-motu-trace.h
index cd0cbfa9f96f..edc551d4ca50 100644
--- a/sound/firewire/motu/amdtp-motu-trace.h
+++ b/sound/firewire/motu/amdtp-motu-trace.h
@@ -18,7 +18,7 @@ static void copy_sph(u32 *frame, __be32 *buffer, unsigned int data_blocks,
 static void copy_message(u64 *frames, __be32 *buffer, unsigned int data_blocks,
 			 unsigned int data_block_quadlets);
 
-TRACE_EVENT(in_data_block_sph,
+TRACE_EVENT(data_block_sph,
 	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
 	TP_ARGS(s, data_blocks, buffer),
 	TP_STRUCT__entry(
@@ -28,8 +28,13 @@ TRACE_EVENT(in_data_block_sph,
 		__dynamic_array(u32, tstamps, data_blocks)
 	),
 	TP_fast_assign(
-		__entry->src = fw_parent_device(s->unit)->node_id;
-		__entry->dst = fw_parent_device(s->unit)->card->node_id;
+		if (s->direction == AMDTP_IN_STREAM) {
+			__entry->src = fw_parent_device(s->unit)->node_id;
+			__entry->dst = fw_parent_device(s->unit)->card->node_id;
+		} else {
+			__entry->src = fw_parent_device(s->unit)->card->node_id;
+			__entry->dst = fw_parent_device(s->unit)->node_id;
+		}
 		__entry->data_blocks = data_blocks;
 		copy_sph(__get_dynamic_array(tstamps), buffer, data_blocks, s->data_block_quadlets);
 	),
@@ -42,55 +47,7 @@ TRACE_EVENT(in_data_block_sph,
 	)
 );
 
-TRACE_EVENT(out_data_block_sph,
-	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
-	TP_ARGS(s, data_blocks, buffer),
-	TP_STRUCT__entry(
-		__field(int, src)
-		__field(int, dst)
-		__field(unsigned int, data_blocks)
-		__dynamic_array(u32, tstamps, data_blocks)
-	),
-	TP_fast_assign(
-		__entry->src = fw_parent_device(s->unit)->card->node_id;
-		__entry->dst = fw_parent_device(s->unit)->node_id;
-		__entry->data_blocks = data_blocks;
-		copy_sph(__get_dynamic_array(tstamps), buffer, data_blocks, s->data_block_quadlets);
-	),
-	TP_printk(
-		"%04x %04x %u %s",
-		__entry->src,
-		__entry->dst,
-		__entry->data_blocks,
-		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, 4)
-	)
-);
-
-TRACE_EVENT(in_data_block_message,
-	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
-	TP_ARGS(s, data_blocks, buffer),
-	TP_STRUCT__entry(
-		__field(int, src)
-		__field(int, dst)
-		__field(unsigned int, data_blocks)
-		__dynamic_array(u64, messages, data_blocks)
-	),
-	TP_fast_assign(
-		__entry->src = fw_parent_device(s->unit)->node_id;
-		__entry->dst = fw_parent_device(s->unit)->card->node_id;
-		__entry->data_blocks = data_blocks;
-		copy_message(__get_dynamic_array(messages), buffer, data_blocks, s->data_block_quadlets);
-	),
-	TP_printk(
-		"%04x %04x %u %s",
-		__entry->src,
-		__entry->dst,
-		__entry->data_blocks,
-		__print_array(__get_dynamic_array(messages), __entry->data_blocks, 8)
-	)
-);
-
-TRACE_EVENT(out_data_block_message,
+TRACE_EVENT(data_block_message,
 	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
 	TP_ARGS(s, data_blocks, buffer),
 	TP_STRUCT__entry(
@@ -100,8 +57,13 @@ TRACE_EVENT(out_data_block_message,
 		__dynamic_array(u64, messages, data_blocks)
 	),
 	TP_fast_assign(
-		__entry->src = fw_parent_device(s->unit)->card->node_id;
-		__entry->dst = fw_parent_device(s->unit)->node_id;
+		if (s->direction == AMDTP_IN_STREAM) {
+			__entry->src = fw_parent_device(s->unit)->node_id;
+			__entry->dst = fw_parent_device(s->unit)->card->node_id;
+		} else {
+			__entry->src = fw_parent_device(s->unit)->card->node_id;
+			__entry->dst = fw_parent_device(s->unit)->node_id;
+		}
 		__entry->data_blocks = data_blocks;
 		copy_message(__get_dynamic_array(messages), buffer, data_blocks, s->data_block_quadlets);
 	),
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 62685f2528ce..1c9ce04a2e89 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -306,8 +306,8 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 	struct amdtp_motu *p = s->protocol;
 	struct snd_pcm_substream *pcm;
 
-	trace_in_data_block_sph(s, data_blocks, buffer);
-	trace_in_data_block_message(s, data_blocks, buffer);
+	trace_data_block_sph(s, data_blocks, buffer);
+	trace_data_block_message(s, data_blocks, buffer);
 
 	if (p->midi_ports)
 		read_midi_messages(s, buffer, data_blocks);
@@ -384,8 +384,8 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 
 	write_sph(s, buffer, data_blocks);
 
-	trace_out_data_block_sph(s, data_blocks, buffer);
-	trace_out_data_block_message(s, data_blocks, buffer);
+	trace_data_block_sph(s, data_blocks, buffer);
+	trace_data_block_message(s, data_blocks, buffer);
 
 	return data_blocks;
 }
-- 
2.20.1
