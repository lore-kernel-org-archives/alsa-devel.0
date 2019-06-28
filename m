From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: firewire-lib: cache next
	data_block_counter after probing tracepoints event for IR context
Date: Fri, 28 Jun 2019 14:53:30 +0900
Message-ID: <20190628055331.1427-2-o-takashi@sakamocchi.jp>
References: <20190628055331.1427-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 238C0F80058
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 07:53:38 +0200 (CEST)
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

For debugging purpose, ALSA IEC 61883-1/6 engine has tracepoints event.
In current implementation, next data block counter is stored as current
data block counter before probing the event for IR isoc context. It's not
good to check current packet parameter.

This commit changes to assign the next data block counter after probing
the event.

Besides, Fireworks devices has a quirk to transfer isoc packet with
data block counter for the last data block. For this quirk, the
assignment is done before calling data block processing layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 48 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 3aef6a78a188..b341bd86605e 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -519,13 +519,13 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 
 static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 			    unsigned int payload_length,
-			    unsigned int *data_blocks, unsigned int *syt)
+			    unsigned int *data_blocks, unsigned int *dbc,
+			    unsigned int *syt)
 {
 	u32 cip_header[2];
 	unsigned int sph;
 	unsigned int fmt;
 	unsigned int fdf;
-	unsigned int data_block_counter;
 	bool lost;
 
 	cip_header[0] = be32_to_cpu(buf[0]);
@@ -577,17 +577,17 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 	}
 
 	/* Check data block counter continuity */
-	data_block_counter = cip_header[0] & CIP_DBC_MASK;
+	*dbc = cip_header[0] & CIP_DBC_MASK;
 	if (*data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
 	    s->data_block_counter != UINT_MAX)
-		data_block_counter = s->data_block_counter;
+		*dbc = s->data_block_counter;
 
 	if (((s->flags & CIP_SKIP_DBC_ZERO_CHECK) &&
-	     data_block_counter == s->ctx_data.tx.first_dbc) ||
+	     *dbc == s->ctx_data.tx.first_dbc) ||
 	    s->data_block_counter == UINT_MAX) {
 		lost = false;
 	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
-		lost = data_block_counter != s->data_block_counter;
+		lost = *dbc != s->data_block_counter;
 	} else {
 		unsigned int dbc_interval;
 
@@ -596,26 +596,18 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 		else
 			dbc_interval = *data_blocks;
 
-		lost = data_block_counter !=
-		       ((s->data_block_counter + dbc_interval) & 0xff);
+		lost = *dbc != ((s->data_block_counter + dbc_interval) & 0xff);
 	}
 
 	if (lost) {
 		dev_err(&s->unit->device,
 			"Detect discontinuity of CIP: %02X %02X\n",
-			s->data_block_counter, data_block_counter);
+			s->data_block_counter, *dbc);
 		return -EIO;
 	}
 
 	*syt = cip_header[1] & CIP_SYT_MASK;
 
-	if (s->flags & CIP_DBC_IS_END_EVENT) {
-		s->data_block_counter = data_block_counter;
-	} else {
-		s->data_block_counter =
-				(data_block_counter + *data_blocks) & 0xff;
-	}
-
 	return 0;
 }
 
@@ -626,6 +618,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			       unsigned int *syt, unsigned int index)
 {
 	const __be32 *cip_header;
+	unsigned int dbc;
 	int err;
 
 	*payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
@@ -640,22 +633,33 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	if (!(s->flags & CIP_NO_HEADER)) {
 		cip_header = ctx_header + 2;
 		err = check_cip_header(s, cip_header, *payload_length,
-				       data_blocks, syt);
-		if (err < 0)
-			return err;
+				       data_blocks, &dbc, syt);
+		if (err < 0) {
+			if (err != -EAGAIN)
+				return err;
+
+			*data_blocks = 0;
+			dbc = s->data_block_counter;
+		}
 	} else {
 		cip_header = NULL;
+		err = 0;
 		*data_blocks = *payload_length / sizeof(__be32) /
 			       s->data_block_quadlets;
+		dbc = s->data_block_counter;
 		*syt = 0;
-		s->data_block_counter =
-				(s->data_block_counter + *data_blocks) & 0xff;
 	}
 
+	if (err >= 0 && s->flags & CIP_DBC_IS_END_EVENT)
+		s->data_block_counter = dbc;
+
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
 			   index);
 
-	return 0;
+	if (err >= 0 && !(s->flags & CIP_DBC_IS_END_EVENT))
+		s->data_block_counter = (dbc + *data_blocks) & 0xff;
+
+	return err;
 }
 
 // In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
-- 
2.20.1
