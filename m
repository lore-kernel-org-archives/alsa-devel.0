From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] ALSA: firewire-lib: unify packet handler
	for IR context
Date: Wed, 22 May 2019 23:17:08 +0900
Message-ID: <20190522141708.29159-7-o-takashi@sakamocchi.jp>
References: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D86DF89630
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:23 +0200 (CEST)
In-Reply-To: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
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

Usage of 16 bytes IR context header allows to handle context payload by
the same code for with-CIP and without-CIP packets.

This commit unifies both handlers of with-CIP and without-CIP packets.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 54 ++++++++++-------------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index fa99210f5a48..2d9c764061d1 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -676,13 +676,20 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 	}
 
 	cip_header = ctx_header + 2;
-	err = check_cip_header(s, cip_header, payload_length, &data_blocks,
-			       &syt);
-	if (err < 0) {
-		if (err != -EAGAIN)
-			return err;
-		pcm_frames = 0;
-		goto end;
+	if (!(s->flags & CIP_NO_HEADER)) {
+		cip_header = &ctx_header[2];
+		err = check_cip_header(s, cip_header, payload_length,
+				       &data_blocks, &syt);
+		if (err < 0) {
+			if (err != -EAGAIN)
+				return err;
+			pcm_frames = 0;
+			goto end;
+		}
+	} else {
+		cip_header = NULL;
+		data_blocks = payload_length / 4 / s->data_block_quadlets;
+		syt = 0;
 	}
 
 	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
@@ -700,33 +707,6 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 	return 0;
 }
 
-static int handle_in_packet_without_header(struct amdtp_stream *s,
-				unsigned int cycle, const __be32 *ctx_header,
-				__be32 *buffer, unsigned int index)
-{
-	unsigned int payload_length;
-	unsigned int data_blocks;
-	struct snd_pcm_substream *pcm;
-	unsigned int pcm_frames;
-
-	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
-	data_blocks = payload_length / 4 / s->data_block_quadlets;
-
-	trace_amdtp_packet(s, cycle, NULL, payload_length, data_blocks, index);
-
-	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, NULL);
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
-
-	if (queue_in_packet(s) < 0)
-		return -EIO;
-
-	pcm = READ_ONCE(s->pcm);
-	if (pcm && pcm_frames > 0)
-		update_pcm_pointers(s, pcm, pcm_frames);
-
-	return 0;
-}
-
 // In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
 // the other hand, in DMA descriptors of 1394 OHCI, 3 bits are used to represent
 // it. Thus, via Linux firewire subsystem, we can get the 3 bits for second.
@@ -812,7 +792,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		cycle = compute_cycle_count(ctx_header[1]);
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
-		if (s->handle_packet(s, cycle, ctx_header, buffer, i) < 0)
+		if (handle_in_packet(s, cycle, ctx_header, buffer, i) < 0)
 			break;
 
 		ctx_header += s->ctx_data.tx.ctx_header_size / sizeof(*ctx_header);
@@ -847,10 +827,6 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 		cycle = compute_cycle_count(ctx_header[1]);
 
 		context->callback.sc = in_stream_callback;
-		if (s->flags & CIP_NO_HEADER)
-			s->handle_packet = handle_in_packet_without_header;
-		else
-			s->handle_packet = handle_in_packet;
 	} else {
 		cycle = compute_it_cycle(*ctx_header);
 
-- 
2.20.1
