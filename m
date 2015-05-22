From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: firewire-lib: pass the number of data blocks in
	incoming packets to outgoing packets
Date: Fri, 22 May 2015 23:00:52 +0900
Message-ID: <1432303254-4192-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Current implementation reuses the value of syt field in incoming packet to
outgoing packet for full duplex timestamp synchronization, while the number
of data blocks in outgoing packets refers to hard-coded table and the
synchronization cannot be applied to non-blocking stream.

This commit passes the number of data blocks from incoming packet
processing to outgoing packet processing for the synchronization. For
normal mode, isochronous callback handler is changed to generate the values
of syt and data blocks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 54 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index ab75ed9..c5034e7 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -651,17 +651,16 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
-static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
+static void handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
+			      unsigned int syt)
 {
 	__be32 *buffer;
-	unsigned int data_blocks, payload_length;
+	unsigned int payload_length;
 	struct snd_pcm_substream *pcm;
 
 	if (s->packet_index < 0)
 		return;
 
-	data_blocks = calculate_data_blocks(s, syt);
-
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << AMDTP_DBS_SHIFT) |
@@ -691,13 +690,12 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 		update_pcm_pointers(s, pcm, data_blocks);
 }
 
-static void handle_in_packet(struct amdtp_stream *s,
-			     unsigned int payload_quadlets,
-			     __be32 *buffer)
+static int handle_in_packet(struct amdtp_stream *s,
+			    unsigned int payload_quadlets, __be32 *buffer)
 {
 	u32 cip_header[2];
-	unsigned int data_blocks, data_block_quadlets, data_block_counter,
-		     dbc_interval;
+	unsigned int data_blocks;
+	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
 	struct snd_pcm_substream *pcm = NULL;
 	bool lost;
 
@@ -714,6 +712,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
+		data_blocks = 0;
 		goto end;
 	}
 
@@ -730,7 +729,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 			dev_info_ratelimited(&s->unit->device,
 				"Detect invalid value in dbs field: %08X\n",
 				cip_header[0]);
-			goto err;
+			return -EIO;
 		}
 		if (s->flags & CIP_WRONG_DBS)
 			data_block_quadlets = s->data_block_quadlets;
@@ -763,7 +762,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 		dev_info(&s->unit->device,
 			 "Detect discontinuity of CIP: %02X %02X\n",
 			 s->data_block_counter, data_block_counter);
-		goto err;
+		return -EIO;
 	}
 
 	if (data_blocks > 0) {
@@ -784,15 +783,12 @@ static void handle_in_packet(struct amdtp_stream *s,
 				(data_block_counter + data_blocks) & 0xff;
 end:
 	if (queue_in_packet(s) < 0)
-		goto err;
+		return -EIO;
 
 	if (pcm)
 		update_pcm_pointers(s, pcm, data_blocks);
 
-	return;
-err:
-	s->packet_index = -1;
-	amdtp_stream_pcm_abort(s);
+	return data_blocks;
 }
 
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
@@ -801,6 +797,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int i, syt, packets = header_length / 4;
+	unsigned int data_blocks;
 
 	/*
 	 * Compute the cycle of the last queued packet.
@@ -811,7 +808,9 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 	for (i = 0; i < packets; ++i) {
 		syt = calculate_syt(s, ++cycle);
-		handle_out_packet(s, syt);
+		data_blocks = calculate_data_blocks(s, syt);
+
+		handle_out_packet(s, data_blocks, syt);
 	}
 	fw_iso_context_queue_flush(s->context);
 }
@@ -823,6 +822,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 	struct amdtp_stream *s = private_data;
 	unsigned int p, syt, packets;
 	unsigned int payload_quadlets, max_payload_quadlets;
+	unsigned int data_blocks;
 	__be32 *buffer, *headers = header;
 
 	/* The number of packets in buffer */
@@ -837,12 +837,6 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
-		/* Process sync slave stream */
-		if (s->sync_slave && s->sync_slave->callbacked) {
-			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-			handle_out_packet(s->sync_slave, syt);
-		}
-
 		/* The number of quadlets in this packet */
 		payload_quadlets =
 			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
@@ -854,11 +848,23 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			break;
 		}
 
-		handle_in_packet(s, payload_quadlets, buffer);
+		data_blocks = handle_in_packet(s, payload_quadlets, buffer);
+		if (data_blocks < 0) {
+			s->packet_index = -1;
+			break;
+		}
+
+		/* Process sync slave stream */
+		if (s->sync_slave && s->sync_slave->callbacked) {
+			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+			handle_out_packet(s->sync_slave, data_blocks, syt);
+		}
 	}
 
 	/* Queueing error or detecting discontinuity */
 	if (s->packet_index < 0) {
+		amdtp_stream_pcm_abort(s);
+
 		/* Abort sync slave. */
 		if (s->sync_slave) {
 			s->sync_slave->packet_index = -1;
-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
