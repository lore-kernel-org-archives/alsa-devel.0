From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/20] ALSA: firewire-lib: operate data block
	counter in top level of processing for IR context
Date: Mon, 22 Jul 2019 12:36:55 +0900
Message-ID: <20190722033710.28107-6-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD413F803F4
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:24 +0200 (CEST)
In-Reply-To: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
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

In ALSA IEC 61883-1/6 packet streaming engine, two types of data block
counter are supported. This commit applies code refactoring to make it
explicitly for IR context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 53 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c89083ccd729..3435bef97a8b 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -512,13 +512,14 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 
 static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 			    unsigned int payload_length,
-			    unsigned int *data_blocks, unsigned int *dbc,
-			    unsigned int *syt)
+			    unsigned int *data_blocks,
+			    unsigned int *data_block_counter, unsigned int *syt)
 {
 	u32 cip_header[2];
 	unsigned int sph;
 	unsigned int fmt;
 	unsigned int fdf;
+	unsigned int dbc;
 	bool lost;
 
 	cip_header[0] = be32_to_cpu(buf[0]);
@@ -570,16 +571,16 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 	}
 
 	/* Check data block counter continuity */
-	*dbc = cip_header[0] & CIP_DBC_MASK;
+	dbc = cip_header[0] & CIP_DBC_MASK;
 	if (*data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
-	    s->data_block_counter != UINT_MAX)
-		*dbc = s->data_block_counter;
+	    *data_block_counter != UINT_MAX)
+		dbc = *data_block_counter;
 
-	if ((*dbc == 0x00 && (s->flags & CIP_SKIP_DBC_ZERO_CHECK)) ||
-	    s->data_block_counter == UINT_MAX) {
+	if ((dbc == 0x00 && (s->flags & CIP_SKIP_DBC_ZERO_CHECK)) ||
+	    *data_block_counter == UINT_MAX) {
 		lost = false;
 	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
-		lost = *dbc != s->data_block_counter;
+		lost = dbc != *data_block_counter;
 	} else {
 		unsigned int dbc_interval;
 
@@ -588,13 +589,13 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 		else
 			dbc_interval = *data_blocks;
 
-		lost = *dbc != ((s->data_block_counter + dbc_interval) & 0xff);
+		lost = dbc != ((*data_block_counter + dbc_interval) & 0xff);
 	}
 
 	if (lost) {
 		dev_err(&s->unit->device,
 			"Detect discontinuity of CIP: %02X %02X\n",
-			s->data_block_counter, *dbc);
+			*data_block_counter, dbc);
 		return -EIO;
 	}
 
@@ -606,10 +607,10 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			       const __be32 *ctx_header,
 			       unsigned int *payload_length,
-			       unsigned int *data_blocks, unsigned int *syt,
-			       unsigned int index)
+			       unsigned int *data_blocks,
+			       unsigned int *data_block_counter,
+			       unsigned int *syt, unsigned int index)
 {
-	unsigned int dbc;
 	const __be32 *cip_header;
 	int err;
 
@@ -625,7 +626,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	if (!(s->flags & CIP_NO_HEADER)) {
 		cip_header = ctx_header + 2;
 		err = check_cip_header(s, cip_header, *payload_length,
-				       data_blocks, &dbc, syt);
+				       data_blocks, data_block_counter, syt);
 		if (err < 0)
 			return err;
 	} else {
@@ -635,16 +636,12 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			       s->data_block_quadlets;
 		*syt = 0;
 
-		if (s->data_block_counter != UINT_MAX)
-			dbc = s->data_block_counter;
-		else
-			dbc = 0;
+		if (*data_block_counter == UINT_MAX)
+			*data_block_counter = 0;
 	}
 
-	s->data_block_counter = dbc;
-
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
-			   s->data_block_counter, index);
+			   *data_block_counter, index);
 
 	return err;
 }
@@ -761,6 +758,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		u32 cycle;
 		unsigned int payload_length;
 		unsigned int data_blocks;
+		unsigned int dbc;
 		unsigned int syt;
 		__be32 *buffer;
 		unsigned int pcm_frames = 0;
@@ -769,22 +767,23 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		int err;
 
 		cycle = compute_cycle_count(ctx_header[1]);
+		dbc = s->data_block_counter;
 		err = parse_ir_ctx_header(s, cycle, ctx_header, &payload_length,
-					  &data_blocks, &syt, i);
+					  &data_blocks, &dbc, &syt, i);
 		if (err < 0 && err != -EAGAIN)
 			break;
 
 		if (err >= 0) {
 			buffer = s->buffer.packets[s->packet_index].buffer;
 			pcm_frames = s->process_data_blocks(s, buffer,
-				data_blocks, s->data_block_counter, &syt);
+				data_blocks, dbc, &syt);
 
-			if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
-				s->data_block_counter += data_blocks;
-				s->data_block_counter &= 0xff;
-			}
+			if (!(s->flags & CIP_DBC_IS_END_EVENT))
+				dbc = (dbc + data_blocks) & 0xff;
 		}
 
+		s->data_block_counter = dbc;
+
 		if (queue_in_packet(s, &params) < 0)
 			break;
 
-- 
2.20.1
