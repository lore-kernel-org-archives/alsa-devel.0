From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-lib: code refactoring to
	queueing packets
Date: Fri, 24 May 2019 00:14:39 +0900
Message-ID: <20190523151440.5127-4-o-takashi@sakamocchi.jp>
References: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD783F89670
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 17:14:50 +0200 (CEST)
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

This commit is a preparation to queue IT packet with header. To enable
packet handler to fill the header, this commit uses kernel stack for
data structure of packet parameter in several part of this file.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 54 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index b11a8d244f89..e813d31ff2ad 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -430,30 +430,15 @@ static void pcm_period_tasklet(unsigned long data)
 		snd_pcm_period_elapsed(pcm);
 }
 
-static int queue_packet(struct amdtp_stream *s, unsigned int payload_length)
+static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params)
 {
-	struct fw_iso_packet p = {0};
-	int err = 0;
-
-	if (IS_ERR(s->context))
-		goto end;
-
-	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
-	p.tag = s->tag;
+	int err;
 
-	if (s->direction == AMDTP_IN_STREAM) {
-		// Queue one packet for IR context.
-		p.header_length = s->ctx_data.tx.ctx_header_size;
-	} else {
-		// No header for this packet.
-		p.header_length = 0;
-	}
+	params->interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
+	params->tag = s->tag;
+	params->sy = 0;
 
-	if (payload_length > 0)
-		p.payload_length = payload_length;
-	else
-		p.skip = true;
-	err = fw_iso_context_queue(s->context, &p, &s->buffer.iso_buffer,
+	err = fw_iso_context_queue(s->context, params, &s->buffer.iso_buffer,
 				   s->buffer.packets[s->packet_index].offset);
 	if (err < 0) {
 		dev_err(&s->unit->device, "queueing error: %d\n", err);
@@ -467,14 +452,24 @@ static int queue_packet(struct amdtp_stream *s, unsigned int payload_length)
 }
 
 static inline int queue_out_packet(struct amdtp_stream *s,
+				   struct fw_iso_packet *params,
 				   unsigned int payload_length)
 {
-	return queue_packet(s, payload_length);
+	// No header for this packet.
+	params->header_length = 0;
+	params->payload_length = payload_length;
+	params->skip = !!(payload_length == 0);
+	return queue_packet(s, params);
 }
 
-static inline int queue_in_packet(struct amdtp_stream *s)
+static inline int queue_in_packet(struct amdtp_stream *s,
+				  struct fw_iso_packet *params)
 {
-	return queue_packet(s, s->ctx_data.tx.max_ctx_payload_length);
+	// Queue one packet for IR context.
+	params->header_length = s->ctx_data.tx.ctx_header_size;
+	params->payload_length = s->ctx_data.tx.max_ctx_payload_length;
+	params->skip = false;
+	return queue_packet(s, params);
 }
 
 static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
@@ -500,6 +495,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 	__be32 *cip_header;
 	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
+	struct fw_iso_packet params = {0};
 
 	syt = calculate_syt(s, cycle);
 	data_blocks = calculate_data_blocks(s, syt);
@@ -529,7 +525,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
 			   index);
 
-	if (queue_out_packet(s, payload_length) < 0)
+	if (queue_out_packet(s, &params, payload_length) < 0)
 		return -EIO;
 
 	pcm = READ_ONCE(s->pcm);
@@ -651,6 +647,7 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
+	struct fw_iso_packet params = {0};
 	int err;
 
 	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
@@ -684,7 +681,7 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 
 	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
 end:
-	if (queue_in_packet(s) < 0)
+	if (queue_in_packet(s, &params) < 0)
 		return -EIO;
 
 	pcm = READ_ONCE(s->pcm);
@@ -920,10 +917,11 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->packet_index = 0;
 	do {
+		struct fw_iso_packet params;
 		if (s->direction == AMDTP_IN_STREAM)
-			err = queue_in_packet(s);
+			err = queue_in_packet(s, &params);
 		else
-			err = queue_out_packet(s, 0);
+			err = queue_out_packet(s, &params, 0);
 		if (err < 0)
 			goto err_context;
 	} while (s->packet_index > 0);
-- 
2.20.1
