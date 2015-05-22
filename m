From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: firewire-lib: simplify function to calculate the
	number of data blocks
Date: Fri, 22 May 2015 23:00:51 +0900
Message-ID: <1432303254-4192-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This function is called according to conditions between the value of
syt and streaming mode(blocking or non-blocking).

To simplify caller's work, this commit push these conditions to the
function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 4eb8dc9..ab75ed9 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -325,17 +325,25 @@ void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_prepare);
 
-static unsigned int calculate_data_blocks(struct amdtp_stream *s)
+static unsigned int calculate_data_blocks(struct amdtp_stream *s,
+					  unsigned int syt)
 {
 	unsigned int phase, data_blocks;
 
-	if (s->flags & CIP_BLOCKING)
-		data_blocks = s->syt_interval;
-	else if (!cip_sfc_is_base_44100(s->sfc)) {
-		/* Sample_rate / 8000 is an integer, and precomputed. */
-		data_blocks = s->data_block_state;
+	/* Blocking mode. */
+	if (s->flags & CIP_BLOCKING) {
+		/* This module generate empty packet for 'no data'. */
+		if (syt == CIP_SYT_NO_INFO)
+			data_blocks = 0;
+		else
+			data_blocks = s->syt_interval;
+	/* Non-blocking mode. */
 	} else {
-		phase = s->data_block_state;
+		if (!cip_sfc_is_base_44100(s->sfc)) {
+			/* Sample_rate / 8000 is an integer, and precomputed. */
+			data_blocks = s->data_block_state;
+		} else {
+			phase = s->data_block_state;
 
 		/*
 		 * This calculates the number of data blocks per packet so that
@@ -345,16 +353,17 @@ static unsigned int calculate_data_blocks(struct amdtp_stream *s)
 		 *    as possible in the sequence (to prevent underruns of the
 		 *    device's buffer).
 		 */
-		if (s->sfc == CIP_SFC_44100)
-			/* 6 6 5 6 5 6 5 ... */
-			data_blocks = 5 + ((phase & 1) ^
-					   (phase == 0 || phase >= 40));
-		else
-			/* 12 11 11 11 11 ... or 23 22 22 22 22 ... */
-			data_blocks = 11 * (s->sfc >> 1) + (phase == 0);
-		if (++phase >= (80 >> (s->sfc >> 1)))
-			phase = 0;
-		s->data_block_state = phase;
+			if (s->sfc == CIP_SFC_44100)
+				/* 6 6 5 6 5 6 5 ... */
+				data_blocks = 5 + ((phase & 1) ^
+						   (phase == 0 || phase >= 40));
+			else
+				/* 12 11 11 11 11 ... or 23 22 22 22 22 ... */
+				data_blocks = 11 * (s->sfc >> 1) + (phase == 0);
+			if (++phase >= (80 >> (s->sfc >> 1)))
+				phase = 0;
+			s->data_block_state = phase;
+		}
 	}
 
 	return data_blocks;
@@ -651,11 +660,7 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 	if (s->packet_index < 0)
 		return;
 
-	/* this module generate empty packet for 'no data' */
-	if (!(s->flags & CIP_BLOCKING) || (syt != CIP_SYT_NO_INFO))
-		data_blocks = calculate_data_blocks(s);
-	else
-		data_blocks = 0;
+	data_blocks = calculate_data_blocks(s, syt);
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
