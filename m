From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] ALSA: firewire-lib: code cleanup for
	incoming packet handling
Date: Mon, 25 Apr 2016 21:46:02 +0900
Message-ID: <1461588363-21157-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B5C60265139
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 14:46:07 +0200 (CEST)
In-Reply-To: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In previous commit, this module has no need to re-use parameters in
incoming packets for outgoing packets anymore. This commit arranges some
needless codes for incoming packet processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index d377dbe..a49459d 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -447,17 +447,18 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 }
 
 static int handle_in_packet(struct amdtp_stream *s,
-			    unsigned int payload_quadlets, __be32 *buffer,
-			    unsigned int *data_blocks, unsigned int cycle,
-			    unsigned int syt)
+			    unsigned int payload_quadlets, unsigned int cycle)
 {
+	__be32 *buffer;
 	u32 cip_header[2];
-	unsigned int fmt, fdf;
+	unsigned int fmt, fdf, syt;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
+	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 	bool lost;
 
+	buffer = s->buffer.packets[s->packet_index].buffer;
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
@@ -472,7 +473,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
-		*data_blocks = 0;
+		data_blocks = 0;
 		pcm_frames = 0;
 		goto end;
 	}
@@ -483,7 +484,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 		dev_info_ratelimited(&s->unit->device,
 				     "Detect unexpected protocol: %08x %08x\n",
 				     cip_header[0], cip_header[1]);
-		*data_blocks = 0;
+		data_blocks = 0;
 		pcm_frames = 0;
 		goto end;
 	}
@@ -492,7 +493,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	fdf = (cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SHIFT;
 	if (payload_quadlets < 3 ||
 	    (fmt == CIP_FMT_AM && fdf == AMDTP_FDF_NO_DATA)) {
-		*data_blocks = 0;
+		data_blocks = 0;
 	} else {
 		data_block_quadlets =
 			(cip_header[0] & CIP_DBS_MASK) >> CIP_DBS_SHIFT;
@@ -506,12 +507,12 @@ static int handle_in_packet(struct amdtp_stream *s,
 		if (s->flags & CIP_WRONG_DBS)
 			data_block_quadlets = s->data_block_quadlets;
 
-		*data_blocks = (payload_quadlets - 2) / data_block_quadlets;
+		data_blocks = (payload_quadlets - 2) / data_block_quadlets;
 	}
 
 	/* Check data block counter continuity */
 	data_block_counter = cip_header[0] & CIP_DBC_MASK;
-	if (*data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
+	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
 	    s->data_block_counter != UINT_MAX)
 		data_block_counter = s->data_block_counter;
 
@@ -522,10 +523,10 @@ static int handle_in_packet(struct amdtp_stream *s,
 	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
 	} else {
-		if ((*data_blocks > 0) && (s->tx_dbc_interval > 0))
+		if (data_blocks > 0 && s->tx_dbc_interval > 0)
 			dbc_interval = s->tx_dbc_interval;
 		else
-			dbc_interval = *data_blocks;
+			dbc_interval = data_blocks;
 
 		lost = data_block_counter !=
 		       ((s->data_block_counter + dbc_interval) & 0xff);
@@ -538,13 +539,14 @@ static int handle_in_packet(struct amdtp_stream *s,
 		return -EIO;
 	}
 
-	pcm_frames = s->process_data_blocks(s, buffer + 2, *data_blocks, &syt);
+	syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter = data_block_counter;
 	else
 		s->data_block_counter =
-				(data_block_counter + *data_blocks) & 0xff;
+				(data_block_counter + data_blocks) & 0xff;
 end:
 	if (queue_in_packet(s) < 0)
 		return -EIO;
@@ -618,10 +620,9 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			       void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int p, syt, packets;
+	unsigned int p, packets;
 	unsigned int payload_quadlets, max_payload_quadlets;
-	unsigned int data_blocks;
-	__be32 *buffer, *headers = header;
+	__be32 *headers = header;
 	u32 cycle;
 
 	if (s->packet_index < 0)
@@ -640,7 +641,6 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (p = 0; p < packets; p++) {
 		cycle = increment_cycle_count(cycle, 1);
-		buffer = s->buffer.packets[s->packet_index].buffer;
 
 		/* The number of quadlets in this packet */
 		payload_quadlets =
@@ -653,9 +653,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			break;
 		}
 
-		syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-		if (handle_in_packet(s, payload_quadlets, buffer,
-						&data_blocks, cycle, syt) < 0) {
+		if (handle_in_packet(s, payload_quadlets, cycle) < 0) {
 			s->packet_index = -1;
 			break;
 		}
-- 
2.7.4
