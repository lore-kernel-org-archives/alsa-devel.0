From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] ALSA: firewire-lib: code cleanup for
	outgoing packet handling
Date: Mon, 25 Apr 2016 21:46:03 +0900
Message-ID: <1461588363-21157-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B0A672650D4
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 14:46:07 +0200 (CEST)
In-Reply-To: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, this module has no need to re-use parameters in
incoming packets for outgoing packets anymore. This commit arranges some
needless codes for outgoing packet processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index a49459d..12a8354 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -411,15 +411,18 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
-static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
-			     unsigned int cycle, unsigned int syt)
+static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
+	unsigned int syt;
+	unsigned int data_blocks;
 	unsigned int payload_length;
 	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
+	syt = calculate_syt(s, cycle);
+	data_blocks = calculate_data_blocks(s, syt);
 	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
 
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
@@ -442,7 +445,6 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
 
-	/* No need to return the number of handled data blocks. */
 	return 0;
 }
 
@@ -588,8 +590,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int i, syt, packets = header_length / 4;
-	unsigned int data_blocks;
+	unsigned int i, packets = header_length / 4;
 	u32 cycle;
 
 	if (s->packet_index < 0)
@@ -602,10 +603,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		cycle = increment_cycle_count(cycle, 1);
-		syt = calculate_syt(s, cycle);
-		data_blocks = calculate_data_blocks(s, syt);
-
-		if (handle_out_packet(s, data_blocks, cycle, syt) < 0) {
+		if (handle_out_packet(s, cycle) < 0) {
 			s->packet_index = -1;
 			amdtp_stream_pcm_abort(s);
 			return;
-- 
2.7.4
