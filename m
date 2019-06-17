From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/10] ALSA: firewire-motu: code refactoring
	for condition to stop streaming
Date: Mon, 17 Jun 2019 17:15:04 +0900
Message-ID: <20190617081510.11025-5-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 673DFF89693
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:23 +0200 (CEST)
In-Reply-To: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
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

In snd_motu_stream_start_duplex() function, there're two points to stop
packet streaming, however they can be merged.  This commit merges them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 35b4e0f72fe2..a3f45f2c817c 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -217,19 +217,11 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 	if (motu->substreams_counter == 0)
 		return 0;
 
-	/* Some packet queueing errors. */
-	if (amdtp_streaming_error(&motu->rx_stream) ||
-	    amdtp_streaming_error(&motu->tx_stream)) {
-		amdtp_stream_stop(&motu->rx_stream);
-		amdtp_stream_stop(&motu->tx_stream);
-		stop_both_streams(motu);
-	}
-
 	err = snd_motu_stream_cache_packet_formats(motu);
 	if (err < 0)
 		return err;
 
-	/* Stop stream if rate is different. */
+	// Stop stream if rate is different.
 	err = protocol->get_clock_rate(motu, &curr_rate);
 	if (err < 0) {
 		dev_err(&motu->unit->device,
@@ -238,7 +230,9 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 	}
 	if (rate == 0)
 		rate = curr_rate;
-	if (rate != curr_rate) {
+	if (rate != curr_rate ||
+	    amdtp_streaming_error(&motu->rx_stream) ||
+	    amdtp_streaming_error(&motu->tx_stream)) {
 		amdtp_stream_stop(&motu->rx_stream);
 		amdtp_stream_stop(&motu->tx_stream);
 		stop_both_streams(motu);
-- 
2.20.1
