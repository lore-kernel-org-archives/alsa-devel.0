From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/6] ALSA: firewire-lib: split helper function
	to check incoming CIP header
Date: Wed, 22 May 2019 23:17:06 +0900
Message-ID: <20190522141708.29159-5-o-takashi@sakamocchi.jp>
References: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5517FF8962C
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:20 +0200 (CEST)
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

A parser for CIP header in incoming packet is enough large.

This commit splits it into a helper function to better looks of packet
handler.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 100 ++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index ab9dc7e9ffa4..e9976a877944 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -549,29 +549,19 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 	return 0;
 }
 
-static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
-			    const __be32 *ctx_header, __be32 *buffer,
-			    unsigned int index)
+static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
+			    unsigned int payload_length,
+			    unsigned int *data_blocks, unsigned int *syt)
 {
-	unsigned int payload_length;
 	u32 cip_header[2];
-	unsigned int sph, fmt, fdf, syt;
-	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
-	unsigned int data_blocks;
-	struct snd_pcm_substream *pcm;
-	unsigned int pcm_frames;
+	unsigned int sph;
+	unsigned int fmt;
+	unsigned int fdf;
+	unsigned int data_block_counter;
 	bool lost;
 
-	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
-	if (payload_length > s->ctx_data.tx.max_payload_length) {
-		dev_err(&s->unit->device,
-			"Detect jumbo payload: %04x %04x\n",
-			payload_length, s->ctx_data.tx.max_payload_length);
-		return -EIO;
-	}
-
-	cip_header[0] = be32_to_cpu(buffer[0]);
-	cip_header[1] = be32_to_cpu(buffer[1]);
+	cip_header[0] = be32_to_cpu(buf[0]);
+	cip_header[1] = be32_to_cpu(buf[1]);
 
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
@@ -583,9 +573,7 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
-		data_blocks = 0;
-		pcm_frames = 0;
-		goto end;
+		return -EAGAIN;
 	}
 
 	/* Check valid protocol or not. */
@@ -595,19 +583,17 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		dev_info_ratelimited(&s->unit->device,
 				     "Detect unexpected protocol: %08x %08x\n",
 				     cip_header[0], cip_header[1]);
-		data_blocks = 0;
-		pcm_frames = 0;
-		goto end;
+		return -EAGAIN;
 	}
 
 	/* Calculate data blocks */
 	fdf = (cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SHIFT;
-	if (payload_length < 12 ||
+	if (payload_length < sizeof(__be32) * 2 ||
 	    (fmt == CIP_FMT_AM && fdf == AMDTP_FDF_NO_DATA)) {
-		data_blocks = 0;
+		*data_blocks = 0;
 	} else {
-		data_block_quadlets =
-			(cip_header[0] & CIP_DBS_MASK) >> CIP_DBS_SHIFT;
+		unsigned int data_block_quadlets =
+				(cip_header[0] & CIP_DBS_MASK) >> CIP_DBS_SHIFT;
 		/* avoid division by zero */
 		if (data_block_quadlets == 0) {
 			dev_err(&s->unit->device,
@@ -618,13 +604,13 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		if (s->flags & CIP_WRONG_DBS)
 			data_block_quadlets = s->data_block_quadlets;
 
-		data_blocks = (payload_length / 4 - 2) /
+		*data_blocks = (payload_length / sizeof(__be32) - 2) /
 							data_block_quadlets;
 	}
 
 	/* Check data block counter continuity */
 	data_block_counter = cip_header[0] & CIP_DBC_MASK;
-	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
+	if (*data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
 	    s->data_block_counter != UINT_MAX)
 		data_block_counter = s->data_block_counter;
 
@@ -635,10 +621,12 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
 	} else {
-		if (data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
+		unsigned int dbc_interval;
+
+		if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
 			dbc_interval = s->ctx_data.tx.dbc_interval;
 		else
-			dbc_interval = data_blocks;
+			dbc_interval = *data_blocks;
 
 		lost = data_block_counter !=
 		       ((s->data_block_counter + dbc_interval) & 0xff);
@@ -651,16 +639,48 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		return -EIO;
 	}
 
-	trace_amdtp_packet(s, cycle, buffer, payload_length, data_blocks, index);
-
-	syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
+	*syt = cip_header[1] & CIP_SYT_MASK;
 
-	if (s->flags & CIP_DBC_IS_END_EVENT)
+	if (s->flags & CIP_DBC_IS_END_EVENT) {
 		s->data_block_counter = data_block_counter;
-	else
+	} else {
 		s->data_block_counter =
-				(data_block_counter + data_blocks) & 0xff;
+				(data_block_counter + *data_blocks) & 0xff;
+	}
+
+	return 0;
+}
+
+static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
+			    const __be32 *ctx_header, __be32 *buffer,
+			    unsigned int index)
+{
+	unsigned int payload_length;
+	unsigned int syt;
+	unsigned int data_blocks;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+	int err;
+
+	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
+	if (payload_length > s->ctx_data.tx.max_payload_length) {
+		dev_err(&s->unit->device,
+			"Detect jumbo payload: %04x %04x\n",
+			payload_length, s->ctx_data.tx.max_payload_length);
+		return -EIO;
+	}
+
+	err = check_cip_header(s, buffer, payload_length, &data_blocks, &syt);
+	if (err < 0) {
+		if (err != -EAGAIN)
+			return err;
+		pcm_frames = 0;
+		goto end;
+	}
+
+	trace_amdtp_packet(s, cycle, buffer, payload_length, data_blocks, index);
+
+	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
 end:
 	if (queue_in_packet(s) < 0)
 		return -EIO;
-- 
2.20.1
