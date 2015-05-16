From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-lib: pass the number of data blocks in
	incoming packets to outgoing packets
Date: Sat, 16 May 2015 20:22:44 +0900
Message-ID: <1431775365-25211-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
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
 sound/firewire/amdtp.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index e3f14a8..5892a36 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -647,17 +647,16 @@ static inline int queue_in_packet(struct amdtp_stream *s)
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
@@ -687,13 +686,12 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
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
+	unsigned int data_blocks = 0;
+	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
 	struct snd_pcm_substream *pcm = NULL;
 	bool lost;
 
@@ -793,10 +791,12 @@ end:
 	if (pcm)
 		update_pcm_pointers(s, pcm, data_blocks);
 
-	return;
+	return data_blocks;
 err:
 	s->packet_index = -1;
 	amdtp_stream_pcm_abort(s);
+
+	return -EIO;
 }
 
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
@@ -805,6 +805,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int i, syt, packets = header_length / 4;
+	unsigned int data_blocks;
 
 	/*
 	 * Compute the cycle of the last queued packet.
@@ -815,7 +816,9 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 	for (i = 0; i < packets; ++i) {
 		syt = calculate_syt(s, ++cycle);
-		handle_out_packet(s, syt);
+		data_blocks = calculate_data_blocks(s, syt);
+
+		handle_out_packet(s, data_blocks, syt);
 	}
 	fw_iso_context_queue_flush(s->context);
 }
@@ -826,6 +829,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int p, syt, packets, payload_quadlets;
+	unsigned int data_blocks;
 	__be32 *buffer, *headers = header;
 
 	/* The number of packets in buffer */
@@ -837,20 +841,28 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
+		/* The number of quadlets in this packet */
+		payload_quadlets =
+			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
+
+		data_blocks = handle_in_packet(s, payload_quadlets, buffer);
+		if (data_blocks < 0) {
+			s->packet_index = -1;
+			break;
+		}
+
 		/* Process sync slave stream */
 		if (s->sync_slave && s->sync_slave->callbacked) {
 			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-			handle_out_packet(s->sync_slave, syt);
+			handle_out_packet(s->sync_slave, data_blocks, syt);
 		}
 
-		/* The number of quadlets in this packet */
-		payload_quadlets =
-			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
-		handle_in_packet(s, payload_quadlets, buffer);
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
