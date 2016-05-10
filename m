From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: drop skip argument from
	helper functions to queue a packet
Date: Wed, 11 May 2016 07:35:09 +0900
Message-ID: <1462919709-8692-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 211E226618B
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 00:35:15 +0200 (CEST)
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

On most of audio and music units on IEEE 1394 bus which ALSA firewire stack
supports (or plans to support), CIP with two quadlets header is used.
Thus, there's no cases to queue packets with blank payload. If such packets
are going to be queued, it means that they're for skips of the cycle.

This commit simplifies helper functions to queue a packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 830a95c..e7163bd 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -370,9 +370,8 @@ static void pcm_period_tasklet(unsigned long data)
 		snd_pcm_period_elapsed(pcm);
 }
 
-static int queue_packet(struct amdtp_stream *s,
-			unsigned int header_length,
-			unsigned int payload_length, bool skip)
+static int queue_packet(struct amdtp_stream *s, unsigned int header_length,
+			unsigned int payload_length)
 {
 	struct fw_iso_packet p = {0};
 	int err = 0;
@@ -383,8 +382,10 @@ static int queue_packet(struct amdtp_stream *s,
 	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
 	p.tag = TAG_CIP;
 	p.header_length = header_length;
-	p.payload_length = (!skip) ? payload_length : 0;
-	p.skip = skip;
+	if (payload_length > 0)
+		p.payload_length = payload_length;
+	else
+		p.skip = true;
 	err = fw_iso_context_queue(s->context, &p, &s->buffer.iso_buffer,
 				   s->buffer.packets[s->packet_index].offset);
 	if (err < 0) {
@@ -399,16 +400,15 @@ end:
 }
 
 static inline int queue_out_packet(struct amdtp_stream *s,
-				   unsigned int payload_length, bool skip)
+				   unsigned int payload_length)
 {
-	return queue_packet(s, OUT_PACKET_HEADER_SIZE,
-			    payload_length, skip);
+	return queue_packet(s, OUT_PACKET_HEADER_SIZE, payload_length);
 }
 
 static inline int queue_in_packet(struct amdtp_stream *s)
 {
 	return queue_packet(s, IN_PACKET_HEADER_SIZE,
-			    amdtp_stream_get_max_payload(s), false);
+			    amdtp_stream_get_max_payload(s));
 }
 
 static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
@@ -438,7 +438,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 
 	trace_out_packet(s, cycle, buffer, payload_length);
 
-	if (queue_out_packet(s, payload_length, false) < 0)
+	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
 
 	pcm = ACCESS_ONCE(s->pcm);
@@ -764,7 +764,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		if (s->direction == AMDTP_IN_STREAM)
 			err = queue_in_packet(s);
 		else
-			err = queue_out_packet(s, 0, true);
+			err = queue_out_packet(s, 0);
 		if (err < 0)
 			goto err_context;
 	} while (s->packet_index > 0);
-- 
2.7.4
