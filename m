From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] ALSA: firewire-lib: use 16 bytes IR
	context header to separate CIP header
Date: Wed, 22 May 2019 23:17:07 +0900
Message-ID: <20190522141708.29159-6-o-takashi@sakamocchi.jp>
References: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E524FF8963E
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:21 +0200 (CEST)
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

In IR context, some quadlets of packet payload can be included into
context header. This is good for packet with CIP header because the
context payload buffer can includes data blocks only for with-CIP and
without-CIP pakets.

This commit uses 16 bytes IR context header for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 37 ++++++++++++++++++++++++-----------
 sound/firewire/amdtp-stream.h |  2 +-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index e9976a877944..fa99210f5a48 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -56,7 +56,10 @@
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
 
-#define IR_HEADER_SIZE		8	// For header and timestamp.
+// For iso header, tstamp and 2 CIP header.
+#define IR_CTX_HEADER_SIZE_CIP		16
+// For iso header and tstamp.
+#define IR_CTX_HEADER_SIZE_NO_CIP	8
 #define HEADER_TSTAMP_MASK	0x0000ffff
 
 static void pcm_period_tasklet(unsigned long data);
@@ -471,7 +474,7 @@ static inline int queue_out_packet(struct amdtp_stream *s,
 
 static inline int queue_in_packet(struct amdtp_stream *s)
 {
-	return queue_packet(s, s->ctx_data.tx.max_payload_length);
+	return queue_packet(s, s->ctx_data.tx.max_ctx_payload_length);
 }
 
 static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
@@ -656,6 +659,7 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 			    unsigned int index)
 {
 	unsigned int payload_length;
+	const __be32 *cip_header;
 	unsigned int syt;
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
@@ -663,14 +667,17 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 	int err;
 
 	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
-	if (payload_length > s->ctx_data.tx.max_payload_length) {
+	if (payload_length > s->ctx_data.tx.ctx_header_size +
+					s->ctx_data.tx.max_ctx_payload_length) {
 		dev_err(&s->unit->device,
 			"Detect jumbo payload: %04x %04x\n",
-			payload_length, s->ctx_data.tx.max_payload_length);
+			payload_length, s->ctx_data.tx.max_ctx_payload_length);
 		return -EIO;
 	}
 
-	err = check_cip_header(s, buffer, payload_length, &data_blocks, &syt);
+	cip_header = ctx_header + 2;
+	err = check_cip_header(s, cip_header, payload_length, &data_blocks,
+			       &syt);
 	if (err < 0) {
 		if (err != -EAGAIN)
 			return err;
@@ -678,9 +685,10 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		goto end;
 	}
 
-	trace_amdtp_packet(s, cycle, buffer, payload_length, data_blocks, index);
+	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
+			   index);
 
-	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
+	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
 end:
 	if (queue_in_packet(s) < 0)
 		return -EIO;
@@ -883,6 +891,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		[CIP_SFC_176400] = {  0,   67 },
 	};
 	unsigned int ctx_header_size;
+	unsigned int max_ctx_payload_size;
 	enum dma_data_direction dir;
 	int type, tag, err;
 
@@ -909,14 +918,21 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	if (s->direction == AMDTP_IN_STREAM) {
 		dir = DMA_FROM_DEVICE;
 		type = FW_ISO_CONTEXT_RECEIVE;
-		ctx_header_size = IR_HEADER_SIZE;
+		if (!(s->flags & CIP_NO_HEADER))
+			ctx_header_size = IR_CTX_HEADER_SIZE_CIP;
+		else
+			ctx_header_size = IR_CTX_HEADER_SIZE_NO_CIP;
 	} else {
 		dir = DMA_TO_DEVICE;
 		type = FW_ISO_CONTEXT_TRANSMIT;
 		ctx_header_size = 0;	// No effect for IT context.
 	}
+
+	max_ctx_payload_size = amdtp_stream_get_max_payload(s) -
+			       ctx_header_size;
+
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
-				      amdtp_stream_get_max_payload(s), dir);
+				      max_ctx_payload_size, dir);
 	if (err < 0)
 		goto err_unlock;
 
@@ -934,8 +950,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	amdtp_stream_update(s);
 
 	if (s->direction == AMDTP_IN_STREAM) {
-		s->ctx_data.tx.max_payload_length =
-						amdtp_stream_get_max_payload(s);
+		s->ctx_data.tx.max_ctx_payload_length = max_ctx_payload_size;
 		s->ctx_data.tx.ctx_header_size = ctx_header_size;
 	}
 
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 5aa9683593d2..234483a31df5 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -116,7 +116,7 @@ struct amdtp_stream {
 			unsigned int ctx_header_size;
 
 			// limit for payload of iso packet.
-			unsigned int max_payload_length;
+			unsigned int max_ctx_payload_length;
 
 			// For quirks of CIP headers.
 			// Fixed interval of dbc between previos/current
-- 
2.20.1
