From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/14] ALSA: firewire-lib: use the same
	prototype for functions to handle packet
Date: Fri, 31 Mar 2017 22:06:06 +0900
Message-ID: <20170331130612.18331-9-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6DDE026724B
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:25 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
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

Audio and music units of RME Fireface series use its own protocol for
isochronous packets to transfer data. This protocol requires ALSA IEC
61883-1/6 engine to have alternative functions.

This commit is a preparation for the protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h |  6 +++---
 sound/firewire/amdtp-stream.c       | 31 ++++++++++++++++---------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 9c04faf..850b36e 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -14,8 +14,8 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(in_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, u32 cip_header[2], unsigned int payload_quadlets, unsigned int index),
-	TP_ARGS(s, cycles, cip_header, payload_quadlets, index),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, u32 cip_header[2], unsigned int payload_length, unsigned int index),
+	TP_ARGS(s, cycles, cip_header, payload_length, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -37,7 +37,7 @@ TRACE_EVENT(in_packet,
 		__entry->dest = fw_parent_device(s->unit)->card->node_id;
 		__entry->cip_header0 = cip_header[0];
 		__entry->cip_header1 = cip_header[1];
-		__entry->payload_quadlets = payload_quadlets;
+		__entry->payload_quadlets = payload_length / 4;
 		__entry->packet_index = s->packet_index;
 		__entry->irq = !!in_interrupt();
 		__entry->index = index;
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 112ad03..646e8e3 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -411,13 +411,13 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s));
 }
 
-static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
+static int handle_out_packet(struct amdtp_stream *s,
+			     unsigned int payload_length, unsigned int cycle,
 			     unsigned int index)
 {
 	__be32 *buffer;
 	unsigned int syt;
 	unsigned int data_blocks;
-	unsigned int payload_length;
 	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
 
@@ -458,7 +458,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 }
 
 static int handle_in_packet(struct amdtp_stream *s,
-			    unsigned int payload_quadlets, unsigned int cycle,
+			    unsigned int payload_length, unsigned int cycle,
 			    unsigned int index)
 {
 	__be32 *buffer;
@@ -474,7 +474,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
-	trace_in_packet(s, cycle, cip_header, payload_quadlets, index);
+	trace_in_packet(s, cycle, cip_header, payload_length, index);
 
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
@@ -505,7 +505,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 
 	/* Calculate data blocks */
 	fdf = (cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SHIFT;
-	if (payload_quadlets < 3 ||
+	if (payload_length < 12 ||
 	    (fmt == CIP_FMT_AM && fdf == AMDTP_FDF_NO_DATA)) {
 		data_blocks = 0;
 	} else {
@@ -521,7 +521,8 @@ static int handle_in_packet(struct amdtp_stream *s,
 		if (s->flags & CIP_WRONG_DBS)
 			data_block_quadlets = s->data_block_quadlets;
 
-		data_blocks = (payload_quadlets - 2) / data_block_quadlets;
+		data_blocks = (payload_length / 4 - 2) /
+							data_block_quadlets;
 	}
 
 	/* Check data block counter continuity */
@@ -615,7 +616,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		cycle = increment_cycle_count(cycle, 1);
-		if (handle_out_packet(s, cycle, i) < 0) {
+		if (handle_out_packet(s, 0, cycle, i) < 0) {
 			s->packet_index = -1;
 			amdtp_stream_pcm_abort(s);
 			return;
@@ -631,7 +632,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int i, packets;
-	unsigned int payload_quadlets, max_payload_quadlets;
+	unsigned int payload_length, max_payload_length;
 	__be32 *headers = header;
 	u32 cycle;
 
@@ -647,22 +648,22 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	cycle = decrement_cycle_count(cycle, packets);
 
 	/* For buffer-over-run prevention. */
-	max_payload_quadlets = amdtp_stream_get_max_payload(s) / 4;
+	max_payload_length = amdtp_stream_get_max_payload(s);
 
 	for (i = 0; i < packets; i++) {
 		cycle = increment_cycle_count(cycle, 1);
 
 		/* The number of quadlets in this packet */
-		payload_quadlets =
-			(be32_to_cpu(headers[i]) >> ISO_DATA_LENGTH_SHIFT) / 4;
-		if (payload_quadlets > max_payload_quadlets) {
+		payload_length =
+			(be32_to_cpu(headers[i]) >> ISO_DATA_LENGTH_SHIFT);
+		if (payload_length > max_payload_length) {
 			dev_err(&s->unit->device,
-				"Detect jumbo payload: %02x %02x\n",
-				payload_quadlets, max_payload_quadlets);
+				"Detect jumbo payload: %04x %04x\n",
+				payload_length, max_payload_length);
 			break;
 		}
 
-		if (handle_in_packet(s, payload_quadlets, cycle, i) < 0)
+		if (handle_in_packet(s, payload_length, cycle, i) < 0)
 			break;
 	}
 
-- 
2.9.3
