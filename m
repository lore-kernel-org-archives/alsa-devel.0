From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: firewire-lib: fix to process MIDI
	conformant data channel for AM824 format
Date: Fri, 28 Jun 2019 14:53:31 +0900
Message-ID: <20190628055331.1427-3-o-takashi@sakamocchi.jp>
References: <20190628055331.1427-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9ED7DF896B7
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 07:53:40 +0200 (CEST)
In-Reply-To: <20190628055331.1427-1-o-takashi@sakamocchi.jp>
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

In IEC 61883-6, 8 MIDI data streams are multiplexed into single MIDI
conformant data channel. The index of stream is calculated by modulo 8
of the value of data block counter. Therefore data block processing
layer requires valid value of data block counter.

In recent changes of ALSA IEC 61883-1/6 engine, the value of data block
counter is changed before calling data block processing layer. This
brings miss detection of MIDI messages in non-blocking transmission
method is used.

This commit fixes the bug by changing chached data block counter after
calling data block processing layer.

Fixes: e335425b6596 ("ALSA: firewire-lib: split helper function to check incoming CIP header")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index b341bd86605e..91b890241840 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -614,11 +614,10 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			       const __be32 *ctx_header,
 			       unsigned int *payload_length,
-			       unsigned int *data_blocks,
+			       unsigned int *data_blocks, unsigned int *dbc,
 			       unsigned int *syt, unsigned int index)
 {
 	const __be32 *cip_header;
-	unsigned int dbc;
 	int err;
 
 	*payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
@@ -633,32 +632,28 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	if (!(s->flags & CIP_NO_HEADER)) {
 		cip_header = ctx_header + 2;
 		err = check_cip_header(s, cip_header, *payload_length,
-				       data_blocks, &dbc, syt);
+				       data_blocks, dbc, syt);
 		if (err < 0) {
 			if (err != -EAGAIN)
 				return err;
 
 			*data_blocks = 0;
-			dbc = s->data_block_counter;
 		}
 	} else {
 		cip_header = NULL;
 		err = 0;
 		*data_blocks = *payload_length / sizeof(__be32) /
 			       s->data_block_quadlets;
-		dbc = s->data_block_counter;
+		*dbc = s->data_block_counter;
 		*syt = 0;
 	}
 
 	if (err >= 0 && s->flags & CIP_DBC_IS_END_EVENT)
-		s->data_block_counter = dbc;
+		s->data_block_counter = *dbc;
 
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
 			   index);
 
-	if (err >= 0 && !(s->flags & CIP_DBC_IS_END_EVENT))
-		s->data_block_counter = (dbc + *data_blocks) & 0xff;
-
 	return err;
 }
 
@@ -761,7 +756,8 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	for (i = 0; i < packets; i++) {
 		u32 cycle;
 		unsigned int payload_length;
-		unsigned int data_block;
+		unsigned int data_blocks;
+		unsigned int dbc;
 		unsigned int syt;
 		__be32 *buffer;
 		unsigned int pcm_frames = 0;
@@ -771,13 +767,19 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 		cycle = compute_cycle_count(ctx_header[1]);
 		err = parse_ir_ctx_header(s, cycle, ctx_header, &payload_length,
-					  &data_block, &syt, i);
+					  &data_blocks, &dbc, &syt, i);
 		if (err < 0 && err != -EAGAIN)
 			break;
+
 		if (err >= 0) {
 			buffer = s->buffer.packets[s->packet_index].buffer;
 			pcm_frames = s->process_data_blocks(s, buffer,
-							    data_block, &syt);
+							    data_blocks, &syt);
+
+			if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
+				s->data_block_counter =
+						(dbc + data_blocks) & 0xff;
+			}
 		}
 
 		if (queue_in_packet(s, &params) < 0)
-- 
2.20.1
