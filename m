From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/10] ALSA: firewire-motu: code refactoring to
	finish streaming session
Date: Mon, 17 Jun 2019 17:15:07 +0900
Message-ID: <20190617081510.11025-8-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18A34F896F9
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:28 +0200 (CEST)
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

The operation to finish packet streaming includes stopping isochronous
contexts. This commit merges it to the helper function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 4fbec35eaad5..53c43848b137 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -101,6 +101,9 @@ static void finish_session(struct snd_motu *motu)
 	if (err < 0)
 		return;
 
+	amdtp_stream_stop(&motu->tx_stream);
+	amdtp_stream_stop(&motu->rx_stream);
+
 	err = snd_motu_transaction_read(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
 					sizeof(reg));
 	if (err < 0)
@@ -219,11 +222,8 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 		rate = curr_rate;
 	if (rate != curr_rate ||
 	    amdtp_streaming_error(&motu->rx_stream) ||
-	    amdtp_streaming_error(&motu->tx_stream)) {
-		amdtp_stream_stop(&motu->rx_stream);
-		amdtp_stream_stop(&motu->tx_stream);
+	    amdtp_streaming_error(&motu->tx_stream))
 		finish_session(motu);
-	}
 
 	if (!amdtp_stream_running(&motu->rx_stream)) {
 		err = protocol->set_clock_rate(motu, rate);
@@ -278,13 +278,8 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 
 void snd_motu_stream_stop_duplex(struct snd_motu *motu)
 {
-	if (motu->substreams_counter == 0) {
-		amdtp_stream_stop(&motu->tx_stream);
-		amdtp_stream_stop(&motu->rx_stream);
-
-		fw_iso_resources_free(&motu->tx_resources);
-		fw_iso_resources_free(&motu->rx_resources);
-	}
+	if (motu->substreams_counter == 0)
+		finish_session(motu);
 }
 
 static int init_stream(struct snd_motu *motu, enum amdtp_stream_direction dir)
-- 
2.20.1
