From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: firewire-lib: set streaming error outside of
	packetization
Date: Fri, 22 May 2015 23:00:53 +0900
Message-ID: <1432303254-4192-5-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, error handling for incoming packet processing is
outside of packetization. This is nice for reading the codes.

This commit applies this idea for outgoing packet processing, too.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index c5034e7..5c0e3ce 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -651,16 +651,13 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
-static void handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
-			      unsigned int syt)
+static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
+			     unsigned int syt)
 {
 	__be32 *buffer;
 	unsigned int payload_length;
 	struct snd_pcm_substream *pcm;
 
-	if (s->packet_index < 0)
-		return;
-
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << AMDTP_DBS_SHIFT) |
@@ -680,14 +677,14 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
-	if (queue_out_packet(s, payload_length, false) < 0) {
-		s->packet_index = -1;
-		amdtp_stream_pcm_abort(s);
-		return;
-	}
+	if (queue_out_packet(s, payload_length, false) < 0)
+		return -EIO;
 
 	if (pcm)
 		update_pcm_pointers(s, pcm, data_blocks);
+
+	/* No need to return the number of handled data blocks. */
+	return 0;
 }
 
 static int handle_in_packet(struct amdtp_stream *s,
@@ -799,6 +796,9 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 	unsigned int i, syt, packets = header_length / 4;
 	unsigned int data_blocks;
 
+	if (s->packet_index < 0)
+		return;
+
 	/*
 	 * Compute the cycle of the last queued packet.
 	 * (We need only the four lowest bits for the SYT, so we can ignore
@@ -810,8 +810,13 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 		syt = calculate_syt(s, ++cycle);
 		data_blocks = calculate_data_blocks(s, syt);
 
-		handle_out_packet(s, data_blocks, syt);
+		if (handle_out_packet(s, data_blocks, syt) < 0) {
+			s->packet_index = -1;
+			amdtp_stream_pcm_abort(s);
+			return;
+		}
 	}
+
 	fw_iso_context_queue_flush(s->context);
 }
 
@@ -825,6 +830,9 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 	unsigned int data_blocks;
 	__be32 *buffer, *headers = header;
 
+	if (s->packet_index < 0)
+		return;
+
 	/* The number of packets in buffer */
 	packets = header_length / IN_PACKET_HEADER_SIZE;
 
@@ -832,9 +840,6 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 	max_payload_quadlets = amdtp_stream_get_max_payload(s) / 4;
 
 	for (p = 0; p < packets; p++) {
-		if (s->packet_index < 0)
-			break;
-
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
 		/* The number of quadlets in this packet */
@@ -857,7 +862,11 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 		/* Process sync slave stream */
 		if (s->sync_slave && s->sync_slave->callbacked) {
 			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-			handle_out_packet(s->sync_slave, data_blocks, syt);
+			if (handle_out_packet(s->sync_slave,
+					      data_blocks, syt) < 0) {
+				s->packet_index = -1;
+				break;
+			}
 		}
 	}
 
-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
