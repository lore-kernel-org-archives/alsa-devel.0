From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-lib: obsolete macro for
	header of IT context
Date: Tue, 21 May 2019 23:57:36 +0900
Message-ID: <20190521145737.11809-4-o-takashi@sakamocchi.jp>
References: <20190521145737.11809-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87C81F89715
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 16:57:49 +0200 (CEST)
In-Reply-To: <20190521145737.11809-1-o-takashi@sakamocchi.jp>
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

The header size parameter of 1394 OHCI IT context has no effect.
Besides the header size of queued packet is different from context
header.

This commit cleans codes relevant to these two headers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index ce39cb92a11e..5ebdac2086c0 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -57,7 +57,6 @@
 #define QUEUE_LENGTH		48
 
 #define IR_HEADER_SIZE		8	// For header and timestamp.
-#define OUT_PACKET_HEADER_SIZE	0
 #define HEADER_TSTAMP_MASK	0x0000ffff
 
 static void pcm_period_tasklet(unsigned long data);
@@ -428,8 +427,7 @@ static void pcm_period_tasklet(unsigned long data)
 		snd_pcm_period_elapsed(pcm);
 }
 
-static int queue_packet(struct amdtp_stream *s, unsigned int header_length,
-			unsigned int payload_length)
+static int queue_packet(struct amdtp_stream *s, unsigned int payload_length)
 {
 	struct fw_iso_packet p = {0};
 	int err = 0;
@@ -439,7 +437,15 @@ static int queue_packet(struct amdtp_stream *s, unsigned int header_length,
 
 	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
 	p.tag = s->tag;
-	p.header_length = header_length;
+
+	if (s->direction == AMDTP_IN_STREAM) {
+		// Queue one packet for IR context.
+		p.header_length = s->ctx_data.tx.ctx_header_size;
+	} else {
+		// No header for this packet.
+		p.header_length = 0;
+	}
+
 	if (payload_length > 0)
 		p.payload_length = payload_length;
 	else
@@ -460,13 +466,12 @@ static int queue_packet(struct amdtp_stream *s, unsigned int header_length,
 static inline int queue_out_packet(struct amdtp_stream *s,
 				   unsigned int payload_length)
 {
-	return queue_packet(s, OUT_PACKET_HEADER_SIZE, payload_length);
+	return queue_packet(s, payload_length);
 }
 
 static inline int queue_in_packet(struct amdtp_stream *s)
 {
-	return queue_packet(s, s->ctx_data.tx.ctx_header_size,
-			    s->ctx_data.tx.max_payload_length);
+	return queue_packet(s, s->ctx_data.tx.max_payload_length);
 }
 
 static int handle_out_packet(struct amdtp_stream *s,
@@ -888,7 +893,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	} else {
 		dir = DMA_TO_DEVICE;
 		type = FW_ISO_CONTEXT_TRANSMIT;
-		ctx_header_size = OUT_PACKET_HEADER_SIZE;
+		ctx_header_size = 0;	// No effect for IT context.
 	}
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
 				      amdtp_stream_get_max_payload(s), dir);
-- 
2.20.1
