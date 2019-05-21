From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-lib: add helper function to
	cancel context inner callback handler
Date: Tue, 21 May 2019 23:57:35 +0900
Message-ID: <20190521145737.11809-3-o-takashi@sakamocchi.jp>
References: <20190521145737.11809-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DFD8F89709
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 16:57:47 +0200 (CEST)
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

In callback handler of isochronous context for both direction, there're
common codes to cancel context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 6977fbbef755..ce39cb92a11e 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -707,6 +707,14 @@ static inline u32 increment_cycle_count(u32 cycle, unsigned int addend)
 	return cycle;
 }
 
+static inline void cancel_stream(struct amdtp_stream *s)
+{
+	s->packet_index = -1;
+	if (in_interrupt())
+		amdtp_stream_pcm_abort(s);
+	WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
+}
+
 static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				size_t header_length, void *header,
 				void *private_data)
@@ -726,10 +734,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	for (i = 0; i < packets; ++i) {
 		cycle = increment_cycle_count(cycle, 1);
 		if (s->handle_packet(s, 0, cycle, i) < 0) {
-			s->packet_index = -1;
-			if (in_interrupt())
-				amdtp_stream_pcm_abort(s);
-			WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
+			cancel_stream(s);
 			return;
 		}
 	}
@@ -779,10 +784,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	/* Queueing error or detecting invalid payload. */
 	if (i < packets) {
-		s->packet_index = -1;
-		if (in_interrupt())
-			amdtp_stream_pcm_abort(s);
-		WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
+		cancel_stream(s);
 		return;
 	}
 
-- 
2.20.1
