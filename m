From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] ALSA: firewire-lib: calculate the length
	of packet payload in packet handler
Date: Wed, 22 May 2019 23:17:04 +0900
Message-ID: <20190522141708.29159-3-o-takashi@sakamocchi.jp>
References: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B44FCF89625
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:17 +0200 (CEST)
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

In current packet handler, the length of payload is given as an argument
of callback function, however this value is just required to process
payload of transferred isoc packet, thus just for IR context.

This commit replaces the argument for payload of packet with the
argument of context header. As a result, the length of payload is
computed in packet handler for IR context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 49 ++++++++++++++++-------------------
 sound/firewire/amdtp-stream.h |  5 ++--
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 020edf2b1726..4584525a7f30 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -474,14 +474,14 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 	return queue_packet(s, s->ctx_data.tx.max_payload_length);
 }
 
-static int handle_out_packet(struct amdtp_stream *s,
-			     unsigned int payload_length, unsigned int cycle,
-			     unsigned int index)
+static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
+			     const __be32 *ctx_header, unsigned int index)
 {
 	__be32 *buffer;
 	unsigned int syt;
 	unsigned int data_blocks;
 	unsigned int pcm_frames;
+	unsigned int payload_length;
 	struct snd_pcm_substream *pcm;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
@@ -521,13 +521,14 @@ static int handle_out_packet(struct amdtp_stream *s,
 }
 
 static int handle_out_packet_without_header(struct amdtp_stream *s,
-			unsigned int payload_length, unsigned int cycle,
-			unsigned int index)
+				unsigned int cycle, const __be32 *ctx_header,
+				unsigned int index)
 {
 	__be32 *buffer;
 	unsigned int syt;
 	unsigned int data_blocks;
 	unsigned int pcm_frames;
+	unsigned int payload_length;
 	struct snd_pcm_substream *pcm;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
@@ -551,11 +552,11 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 	return 0;
 }
 
-static int handle_in_packet(struct amdtp_stream *s,
-			    unsigned int payload_length, unsigned int cycle,
-			    unsigned int index)
+static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
+			    const __be32 *ctx_header, unsigned int index)
 {
 	__be32 *buffer;
+	unsigned int payload_length;
 	u32 cip_header[2];
 	unsigned int sph, fmt, fdf, syt;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
@@ -564,6 +565,14 @@ static int handle_in_packet(struct amdtp_stream *s,
 	unsigned int pcm_frames;
 	bool lost;
 
+	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
+	if (payload_length > s->ctx_data.tx.max_payload_length) {
+		dev_err(&s->unit->device,
+			"Detect jumbo payload: %04x %04x\n",
+			payload_length, s->ctx_data.tx.max_payload_length);
+		return -EIO;
+	}
+
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
@@ -668,14 +677,16 @@ static int handle_in_packet(struct amdtp_stream *s,
 }
 
 static int handle_in_packet_without_header(struct amdtp_stream *s,
-			unsigned int payload_length, unsigned int cycle,
-			unsigned int index)
+				unsigned int cycle, const __be32 *ctx_header,
+				unsigned int index)
 {
 	__be32 *buffer;
+	unsigned int payload_length;
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
+	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	data_blocks = payload_length / sizeof(__be32) / s->data_block_quadlets;
 
@@ -745,7 +756,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 		cycle = compute_it_cycle(*ctx_header);
 
-		if (s->handle_packet(s, 0, cycle, i) < 0) {
+		if (s->handle_packet(s, cycle, ctx_header, i) < 0) {
 			cancel_stream(s);
 			return;
 		}
@@ -762,7 +773,6 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int i, packets;
-	unsigned int payload_length, max_payload_length;
 	__be32 *ctx_header = header;
 
 	if (s->packet_index < 0)
@@ -771,25 +781,12 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	// The number of packets in buffer.
 	packets = header_length / s->ctx_data.tx.ctx_header_size;
 
-	/* For buffer-over-run prevention. */
-	max_payload_length = s->ctx_data.tx.max_payload_length;
-
 	for (i = 0; i < packets; i++) {
-		u32 iso_header = be32_to_cpu(ctx_header[0]);
 		u32 cycle;
 
 		cycle = compute_cycle_count(ctx_header[1]);
 
-		/* The number of bytes in this packet */
-		payload_length = iso_header >> ISO_DATA_LENGTH_SHIFT;
-		if (payload_length > max_payload_length) {
-			dev_err(&s->unit->device,
-				"Detect jumbo payload: %04x %04x\n",
-				payload_length, max_payload_length);
-			break;
-		}
-
-		if (s->handle_packet(s, payload_length, cycle, i) < 0)
+		if (s->handle_packet(s, cycle, ctx_header, i) < 0)
 			break;
 
 		ctx_header += s->ctx_data.tx.ctx_header_size / sizeof(*ctx_header);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 1945ef59ab92..d317fdc6ab5f 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -108,9 +108,8 @@ struct amdtp_stream {
 	struct iso_packets_buffer buffer;
 	int packet_index;
 	int tag;
-	int (*handle_packet)(struct amdtp_stream *s,
-			unsigned int payload_quadlets, unsigned int cycle,
-			unsigned int index);
+	int (*handle_packet)(struct amdtp_stream *s, unsigned int cycle,
+			     const __be32 *ctx_header, unsigned int index);
 	union {
 		struct {
 			unsigned int ctx_header_size;
-- 
2.20.1
