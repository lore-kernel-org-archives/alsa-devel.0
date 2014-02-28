From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/39] firewire-lib: Give syt value as
	parameter to handle_out_packet()
Date: Fri, 28 Feb 2014 12:27:20 +0900
Message-ID: <1393558072-25926-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id F132D261A1A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:28:05 +0100 (CET)
In-Reply-To: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

For duplex streams with synchronization, drivers should pick up
'presentation timestamp' from in-packets and use the timestamp for
out-packets. This commit is preparation for this.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index ad3521f..56b01c8 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -256,7 +256,9 @@ static unsigned int calculate_data_blocks(struct amdtp_stream *s)
 {
 	unsigned int phase, data_blocks;
 
-	if (!cip_sfc_is_base_44100(s->sfc)) {
+	if (s->flags & CIP_BLOCKING)
+		data_blocks = s->syt_interval;
+	else if (!cip_sfc_is_base_44100(s->sfc)) {
 		/* Sample_rate / 8000 is an integer, and precomputed. */
 		data_blocks = s->data_block_state;
 	} else {
@@ -620,26 +622,22 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
-static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
+static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 {
 	__be32 *buffer;
-	unsigned int index, data_blocks, syt, payload_length;
+	unsigned int data_blocks, payload_length;
 	struct snd_pcm_substream *pcm;
 
 	if (s->packet_index < 0)
 		return;
-	index = s->packet_index;
 
 	/* this module generate empty packet for 'no data' */
-	syt = calculate_syt(s, cycle);
-	if (!(s->flags & CIP_BLOCKING))
+	if (!(s->flags & CIP_BLOCKING) || (syt != CIP_SYT_NO_INFO))
 		data_blocks = calculate_data_blocks(s);
-	else if (syt != CIP_SYT_NO_INFO)
-		data_blocks = s->syt_interval;
 	else
 		data_blocks = 0;
 
-	buffer = s->buffer.packets[index].buffer;
+	buffer = s->buffer.packets[s->packet_index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << AMDTP_DBS_SHIFT) |
 				s->data_block_counter);
@@ -737,7 +735,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 				void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int i, packets = header_length / 4;
+	unsigned int i, syt, packets = header_length / 4;
 
 	/*
 	 * Compute the cycle of the last queued packet.
@@ -746,8 +744,10 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 	 */
 	cycle += QUEUE_LENGTH - packets;
 
-	for (i = 0; i < packets; ++i)
-		handle_out_packet(s, ++cycle);
+	for (i = 0; i < packets; ++i) {
+		syt = calculate_syt(s, ++cycle);
+		handle_out_packet(s, syt);
+	}
 	fw_iso_context_queue_flush(s->context);
 }
 
-- 
1.8.3.2
