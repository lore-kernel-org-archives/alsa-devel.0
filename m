From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/18] ALSA: firewire-lib: record cycle count
	for the first packet
Date: Wed, 22 Mar 2017 21:30:15 +0900
Message-ID: <20170322123028.24148-6-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C292F2673BC
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:42 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

Currently, packet streaming layer passes generated SYT value to data block
processing layer. However, this is not enough in a case that the data block
processing layer generates time stamps by its own ways.

For out-packet stream, the packet streaming layer guarantees 8,000 times
calls of data block processing layers per sec. Therefore, when cycle count
of the first packet is recorded, data block processing layers can calculate
own time stamps with the recorded value.

For the reason, this commit allows packet streaming layer to record the
first cycle count. Each data block processing layer can read the count by
accessing a member of structure for packet streaming layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 15 +++++++++++++--
 sound/firewire/amdtp-stream.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 00060c4..371cf97 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -671,6 +671,8 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 					void *header, void *private_data)
 {
 	struct amdtp_stream *s = private_data;
+	u32 cycle;
+	unsigned int packets;
 
 	/*
 	 * For in-stream, first packet has come.
@@ -679,10 +681,19 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 	s->callbacked = true;
 	wake_up(&s->callback_wait);
 
-	if (s->direction == AMDTP_IN_STREAM)
+	cycle = compute_cycle_count(tstamp);
+
+	if (s->direction == AMDTP_IN_STREAM) {
+		packets = header_length / IN_PACKET_HEADER_SIZE;
+		cycle = decrement_cycle_count(cycle, packets);
 		context->callback.sc = in_stream_callback;
-	else
+	} else {
+		packets = header_length / 4;
+		cycle = increment_cycle_count(cycle, QUEUE_LENGTH - packets);
 		context->callback.sc = out_stream_callback;
+	}
+
+	s->start_cycle = cycle;
 
 	context->callback.sc(context, tstamp, header_length, header, s);
 }
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index c1bc7fa..edf5646 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -130,6 +130,7 @@ struct amdtp_stream {
 	/* To wait for first packet. */
 	bool callbacked;
 	wait_queue_head_t callback_wait;
+	u32 start_cycle;
 
 	/* For backends to process data blocks. */
 	void *protocol;
-- 
2.9.3
