From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-lib: unify packet handler
	for IT context
Date: Fri, 24 May 2019 00:14:38 +0900
Message-ID: <20190523151440.5127-3-o-takashi@sakamocchi.jp>
References: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C694BF89674
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 17:14:49 +0200 (CEST)
In-Reply-To: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
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

The handlers for packet with CIP and without CIP include common codes.
This commit unifies them and remove an member for pointer to callback
function from data structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 59 +++++++++++------------------------
 sound/firewire/amdtp-stream.h |  3 --
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 25985663bb2b..b11a8d244f89 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -496,56 +496,38 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 {
 	unsigned int syt;
 	unsigned int data_blocks;
-	unsigned int pcm_frames;
 	unsigned int payload_length;
+	__be32 *cip_header;
+	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
 
 	syt = calculate_syt(s, cycle);
 	data_blocks = calculate_data_blocks(s, syt);
-	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
+
+	payload_length = data_blocks * sizeof(__be32) * s->data_block_quadlets;
+	if (!(s->flags & CIP_NO_HEADER)) {
+		cip_header = buffer;
+		buffer += 2;
+		payload_length += 2 * sizeof(__be32);
+	} else {
+		cip_header = NULL;
+	}
+
+	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
 
-	generate_cip_header(s, buffer, syt);
+	if (cip_header)
+		generate_cip_header(s, cip_header, syt);
 
 	if (!(s->flags & CIP_DBC_IS_END_EVENT))
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
-	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 
-	trace_amdtp_packet(s, cycle, buffer, payload_length, data_blocks, index);
-
-	if (queue_out_packet(s, payload_length) < 0)
-		return -EIO;
-
-	pcm = READ_ONCE(s->pcm);
-	if (pcm && pcm_frames > 0)
-		update_pcm_pointers(s, pcm, pcm_frames);
-
-	/* No need to return the number of handled data blocks. */
-	return 0;
-}
-
-static int handle_out_packet_without_header(struct amdtp_stream *s,
-				unsigned int cycle, const __be32 *ctx_header,
-				__be32 *buffer, unsigned int index)
-{
-	unsigned int syt;
-	unsigned int data_blocks;
-	unsigned int pcm_frames;
-	unsigned int payload_length;
-	struct snd_pcm_substream *pcm;
-
-	syt = calculate_syt(s, cycle);
-	data_blocks = calculate_data_blocks(s, syt);
-	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
-
-	payload_length = data_blocks * 4 * s->data_block_quadlets;
-
-	trace_amdtp_packet(s, cycle, NULL, payload_length, data_blocks, index);
+	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
+			   index);
 
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
@@ -554,7 +536,6 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
 
-	/* No need to return the number of handled data blocks. */
 	return 0;
 }
 
@@ -766,7 +747,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		cycle = compute_it_cycle(*ctx_header);
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
-		if (s->handle_packet(s, cycle, ctx_header, buffer, i) < 0) {
+		if (handle_out_packet(s, cycle, ctx_header, buffer, i) < 0) {
 			cancel_stream(s);
 			return;
 		}
@@ -837,10 +818,6 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 		cycle = compute_it_cycle(*ctx_header);
 
 		context->callback.sc = out_stream_callback;
-		if (s->flags & CIP_NO_HEADER)
-			s->handle_packet = handle_out_packet_without_header;
-		else
-			s->handle_packet = handle_out_packet;
 	}
 
 	s->start_cycle = cycle;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 234483a31df5..3942894c11ac 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -108,9 +108,6 @@ struct amdtp_stream {
 	struct iso_packets_buffer buffer;
 	int packet_index;
 	int tag;
-	int (*handle_packet)(struct amdtp_stream *s, unsigned int cycle,
-			     const __be32 *ctx_header, __be32 *buffer,
-			     unsigned int index);
 	union {
 		struct {
 			unsigned int ctx_header_size;
-- 
2.20.1
