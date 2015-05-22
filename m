From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-lib: macro arrangement for
	code cleanup
Date: Fri, 22 May 2015 23:21:12 +0900
Message-ID: <1432304474-6533-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id CC7D4265D07
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 16:21:18 +0200 (CEST)
In-Reply-To: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some macros include my misunderstanding for IEC 61883-1 or -6.
Additionally, some fixed values appear on codes.

This commit replaces these with macros with proper names.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 9d72345..29efbda 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -40,24 +40,28 @@
 #define TAG_CIP			1
 
 /* common isochronous packet header parameters */
-#define CIP_EOH			(1u << 31)
+#define CIP_EOH_SHIFT		31
+#define CIP_EOH			(1u << CIP_EOH_SHIFT)
 #define CIP_EOH_MASK		0x80000000
-#define CIP_FMT_AM		(0x10 << 24)
+#define CIP_SID_SHIFT		24
+#define CIP_SID_MASK		0x3f000000
+#define CIP_DBS_MASK		0x00ff0000
+#define CIP_DBS_SHIFT		16
+#define CIP_DBC_MASK		0x000000ff
+#define CIP_FMT_SHIFT		24
 #define CIP_FMT_MASK		0x3f000000
+#define CIP_FDF_MASK		0x00ff0000
+#define CIP_FDF_SHIFT		16
 #define CIP_SYT_MASK		0x0000ffff
 #define CIP_SYT_NO_INFO		0xffff
-#define CIP_FDF_MASK		0x00ff0000
-#define CIP_FDF_SFC_SHIFT	16
 
 /*
  * Audio and Music transfer protocol specific parameters
  * only "Clock-based rate control mode" is supported
  */
-#define AMDTP_FDF_AM824		(0 << (CIP_FDF_SFC_SHIFT + 3))
+#define CIP_FMT_AM		(0x10 << CIP_FMT_SHIFT)
+#define AMDTP_FDF_AM824		(0 << (CIP_FDF_SHIFT + 3))
 #define AMDTP_FDF_NO_DATA	0xff
-#define AMDTP_DBS_MASK		0x00ff0000
-#define AMDTP_DBS_SHIFT		16
-#define AMDTP_DBC_MASK		0x000000ff
 
 /* TODO: make these configurable */
 #define INTERRUPT_INTERVAL	16
@@ -656,10 +660,10 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
-				(s->data_block_quadlets << AMDTP_DBS_SHIFT) |
+				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				s->data_block_counter);
 	buffer[1] = cpu_to_be32(CIP_EOH | CIP_FMT_AM | AMDTP_FDF_AM824 |
-				(s->sfc << CIP_FDF_SFC_SHIFT) | syt);
+				(s->sfc << CIP_FDF_SHIFT) | syt);
 	buffer += 2;
 
 	pcm = ACCESS_ONCE(s->pcm);
@@ -712,11 +716,11 @@ static int handle_in_packet(struct amdtp_stream *s,
 	/* Calculate data blocks */
 	if (payload_quadlets < 3 ||
 	    ((cip_header[1] & CIP_FDF_MASK) ==
-				(AMDTP_FDF_NO_DATA << CIP_FDF_SFC_SHIFT))) {
+				(AMDTP_FDF_NO_DATA << CIP_FDF_SHIFT))) {
 		data_blocks = 0;
 	} else {
 		data_block_quadlets =
-			(cip_header[0] & AMDTP_DBS_MASK) >> AMDTP_DBS_SHIFT;
+			(cip_header[0] & CIP_DBS_MASK) >> CIP_DBS_SHIFT;
 		/* avoid division by zero */
 		if (data_block_quadlets == 0) {
 			dev_info_ratelimited(&s->unit->device,
@@ -731,7 +735,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	}
 
 	/* Check data block counter continuity */
-	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
+	data_block_counter = cip_header[0] & CIP_DBC_MASK;
 	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
 	    s->data_block_counter != UINT_MAX)
 		data_block_counter = s->data_block_counter;
@@ -1050,8 +1054,10 @@ EXPORT_SYMBOL(amdtp_stream_pcm_pointer);
  */
 void amdtp_stream_update(struct amdtp_stream *s)
 {
+	/* Precomputing. */
 	ACCESS_ONCE(s->source_node_id_field) =
-		(fw_parent_device(s->unit)->card->node_id & 0x3f) << 24;
+		(fw_parent_device(s->unit)->card->node_id << CIP_SID_SHIFT) &
+								CIP_SID_MASK;
 }
 EXPORT_SYMBOL(amdtp_stream_update);
 
-- 
2.1.4
