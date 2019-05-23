From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-lib: use 8 byte packet
	header for IT context to separate CIP header from CIP payload
Date: Fri, 24 May 2019 00:14:40 +0900
Message-ID: <20190523151440.5127-5-o-takashi@sakamocchi.jp>
References: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F208F80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 17:14:52 +0200 (CEST)
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

In Linux firewire subsystem, for IT context, some quadlets of isochronous
packet payload can be indicated as a part of packet header to queue to
the context.

This commit uses the packet header to split CIP headers from CIP
payload. As a result, regardless of CIP or non-CIP, context payload
includes data blocks only.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 63 +++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index e813d31ff2ad..791efa5585c2 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -62,6 +62,9 @@
 #define IR_CTX_HEADER_SIZE_NO_CIP	8
 #define HEADER_TSTAMP_MASK	0x0000ffff
 
+#define IT_PKT_HEADER_SIZE_CIP		8 // For 2 CIP header.
+#define IT_PKT_HEADER_SIZE_NO_CIP	0 // Nothing.
+
 static void pcm_period_tasklet(unsigned long data);
 
 /**
@@ -452,13 +455,10 @@ static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params)
 }
 
 static inline int queue_out_packet(struct amdtp_stream *s,
-				   struct fw_iso_packet *params,
-				   unsigned int payload_length)
+				   struct fw_iso_packet *params)
 {
-	// No header for this packet.
-	params->header_length = 0;
-	params->payload_length = payload_length;
-	params->skip = !!(payload_length == 0);
+	params->skip =
+		!!(params->header_length == 0 && params->payload_length == 0);
 	return queue_packet(s, params);
 }
 
@@ -491,41 +491,41 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 {
 	unsigned int syt;
 	unsigned int data_blocks;
-	unsigned int payload_length;
 	__be32 *cip_header;
 	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
-	struct fw_iso_packet params = {0};
+	struct {
+		struct fw_iso_packet params;
+		__be32 header[IT_PKT_HEADER_SIZE_CIP / sizeof(__be32)];
+	} template = { {0}, {0} };
 
 	syt = calculate_syt(s, cycle);
 	data_blocks = calculate_data_blocks(s, syt);
-
-	payload_length = data_blocks * sizeof(__be32) * s->data_block_quadlets;
-	if (!(s->flags & CIP_NO_HEADER)) {
-		cip_header = buffer;
-		buffer += 2;
-		payload_length += 2 * sizeof(__be32);
-	} else {
-		cip_header = NULL;
-	}
-
 	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
 
-	if (cip_header)
+	if (!(s->flags & CIP_NO_HEADER)) {
+		cip_header = (__be32 *)template.params.header;
 		generate_cip_header(s, cip_header, syt);
+		template.params.header_length = 2 * sizeof(__be32);
+	} else {
+		cip_header = NULL;
+	}
 
 	if (!(s->flags & CIP_DBC_IS_END_EVENT))
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
 
-	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
-			   index);
+	template.params.payload_length =
+			data_blocks * sizeof(__be32) * s->data_block_quadlets;
+
+	trace_amdtp_packet(s, cycle, cip_header, template.params.payload_length,
+			   data_blocks, index);
 
-	if (queue_out_packet(s, &params, payload_length) < 0)
+	if (queue_out_packet(s, &template.params) < 0)
 		return -EIO;
 
 	pcm = READ_ONCE(s->pcm);
@@ -878,14 +878,18 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 			ctx_header_size = IR_CTX_HEADER_SIZE_CIP;
 		else
 			ctx_header_size = IR_CTX_HEADER_SIZE_NO_CIP;
+
+		max_ctx_payload_size = amdtp_stream_get_max_payload(s) -
+				       ctx_header_size;
 	} else {
 		dir = DMA_TO_DEVICE;
 		type = FW_ISO_CONTEXT_TRANSMIT;
 		ctx_header_size = 0;	// No effect for IT context.
-	}
 
-	max_ctx_payload_size = amdtp_stream_get_max_payload(s) -
-			       ctx_header_size;
+		max_ctx_payload_size = amdtp_stream_get_max_payload(s);
+		if (!(s->flags & CIP_NO_HEADER))
+			max_ctx_payload_size -= IT_PKT_HEADER_SIZE_CIP;
+	}
 
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
 				      max_ctx_payload_size, dir);
@@ -918,10 +922,13 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->packet_index = 0;
 	do {
 		struct fw_iso_packet params;
-		if (s->direction == AMDTP_IN_STREAM)
+		if (s->direction == AMDTP_IN_STREAM) {
 			err = queue_in_packet(s, &params);
-		else
-			err = queue_out_packet(s, &params, 0);
+		} else {
+			params.header_length = 0;
+			params.payload_length = 0;
+			err = queue_out_packet(s, &params);
+		}
 		if (err < 0)
 			goto err_context;
 	} while (s->packet_index > 0);
-- 
2.20.1
