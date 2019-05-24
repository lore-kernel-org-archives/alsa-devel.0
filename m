From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-lib: refactoring to
	obsolete IR packet handler
Date: Fri, 24 May 2019 18:03:42 +0900
Message-ID: <20190524090342.15619-5-o-takashi@sakamocchi.jp>
References: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2825CF89636
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 11:03:55 +0200 (CEST)
In-Reply-To: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
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

As a result of heavy refactoring based on IR context header, the packet
handler becomes simpler.

This commit merges the packet handler into function for IR context
callback. The logic to parse IR context header and tracepoints event is
split to a function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 76 ++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 03ed2757dfc8..3aef6a78a188 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -619,59 +619,42 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 	return 0;
 }
 
-static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
-			    const __be32 *ctx_header, __be32 *buffer,
-			    unsigned int index)
+static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
+			       const __be32 *ctx_header,
+			       unsigned int *payload_length,
+			       unsigned int *data_blocks,
+			       unsigned int *syt, unsigned int index)
 {
-	unsigned int payload_length;
 	const __be32 *cip_header;
-	unsigned int syt;
-	unsigned int data_blocks;
-	struct snd_pcm_substream *pcm;
-	unsigned int pcm_frames;
-	struct fw_iso_packet params = {0};
 	int err;
 
-	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
-	if (payload_length > s->ctx_data.tx.ctx_header_size +
+	*payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
+	if (*payload_length > s->ctx_data.tx.ctx_header_size +
 					s->ctx_data.tx.max_ctx_payload_length) {
 		dev_err(&s->unit->device,
 			"Detect jumbo payload: %04x %04x\n",
-			payload_length, s->ctx_data.tx.max_ctx_payload_length);
+			*payload_length, s->ctx_data.tx.max_ctx_payload_length);
 		return -EIO;
 	}
 
-	cip_header = ctx_header + 2;
 	if (!(s->flags & CIP_NO_HEADER)) {
-		cip_header = &ctx_header[2];
-		err = check_cip_header(s, cip_header, payload_length,
-				       &data_blocks, &syt);
-		if (err < 0) {
-			if (err != -EAGAIN)
-				return err;
-			pcm_frames = 0;
-			goto end;
-		}
+		cip_header = ctx_header + 2;
+		err = check_cip_header(s, cip_header, *payload_length,
+				       data_blocks, syt);
+		if (err < 0)
+			return err;
 	} else {
 		cip_header = NULL;
-		data_blocks = payload_length / 4 / s->data_block_quadlets;
-		syt = 0;
+		*data_blocks = *payload_length / sizeof(__be32) /
+			       s->data_block_quadlets;
+		*syt = 0;
 		s->data_block_counter =
-				(s->data_block_counter + data_blocks) & 0xff;
+				(s->data_block_counter + *data_blocks) & 0xff;
 	}
 
-	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
+	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
 			   index);
 
-	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
-end:
-	if (queue_in_packet(s, &params) < 0)
-		return -EIO;
-
-	pcm = READ_ONCE(s->pcm);
-	if (pcm && pcm_frames > 0)
-		update_pcm_pointers(s, pcm, pcm_frames);
-
 	return 0;
 }
 
@@ -773,14 +756,33 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; i++) {
 		u32 cycle;
+		unsigned int payload_length;
+		unsigned int data_block;
+		unsigned int syt;
 		__be32 *buffer;
+		unsigned int pcm_frames = 0;
+		struct fw_iso_packet params = {0};
+		struct snd_pcm_substream *pcm;
+		int err;
 
 		cycle = compute_cycle_count(ctx_header[1]);
-		buffer = s->buffer.packets[s->packet_index].buffer;
+		err = parse_ir_ctx_header(s, cycle, ctx_header, &payload_length,
+					  &data_block, &syt, i);
+		if (err < 0 && err != -EAGAIN)
+			break;
+		if (err >= 0) {
+			buffer = s->buffer.packets[s->packet_index].buffer;
+			pcm_frames = s->process_data_blocks(s, buffer,
+							    data_block, &syt);
+		}
 
-		if (handle_in_packet(s, cycle, ctx_header, buffer, i) < 0)
+		if (queue_in_packet(s, &params) < 0)
 			break;
 
+		pcm = READ_ONCE(s->pcm);
+		if (pcm && pcm_frames > 0)
+			update_pcm_pointers(s, pcm, pcm_frames);
+
 		ctx_header += s->ctx_data.tx.ctx_header_size / sizeof(*ctx_header);
 	}
 
-- 
2.20.1
