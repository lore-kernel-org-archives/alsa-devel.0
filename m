From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/19] ALSA: firewire-motu: support AMDTP domain
Date: Sun,  4 Aug 2019 15:21:36 +0900
Message-ID: <20190804062138.1217-18-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B199F805A1
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:22:09 +0200 (CEST)
In-Reply-To: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
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

This commit adds AMDTP domain support for ALSA firewire-motu driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 83 +++++++++++++++----------------
 sound/firewire/motu/motu.h        |  2 +
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index cc9f34426a47..813e38e6a86e 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -92,9 +92,6 @@ static void finish_session(struct snd_motu *motu)
 	if (err < 0)
 		return;
 
-	amdtp_stream_stop(&motu->tx_stream);
-	amdtp_stream_stop(&motu->rx_stream);
-
 	err = snd_motu_transaction_read(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
 					sizeof(reg));
 	if (err < 0)
@@ -109,27 +106,6 @@ static void finish_session(struct snd_motu *motu)
 				   sizeof(reg));
 }
 
-static int start_isoc_ctx(struct snd_motu *motu, struct amdtp_stream *stream)
-{
-	struct fw_iso_resources *resources;
-	int err;
-
-	if (stream == &motu->rx_stream)
-		resources = &motu->rx_resources;
-	else
-		resources = &motu->tx_resources;
-
-	err = amdtp_stream_start(stream, resources->channel,
-				 fw_parent_device(motu->unit)->max_speed);
-	if (err < 0)
-		return err;
-
-	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT))
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
 int snd_motu_stream_cache_packet_formats(struct snd_motu *motu)
 {
 	int err;
@@ -169,6 +145,7 @@ int snd_motu_stream_reserve_duplex(struct snd_motu *motu, unsigned int rate)
 		rate = curr_rate;
 
 	if (motu->substreams_counter == 0 || curr_rate != rate) {
+		amdtp_domain_stop(&motu->domain);
 		finish_session(motu);
 
 		fw_iso_resources_free(&motu->tx_resources);
@@ -234,8 +211,10 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 		return 0;
 
 	if (amdtp_streaming_error(&motu->rx_stream) ||
-	    amdtp_streaming_error(&motu->tx_stream))
+	    amdtp_streaming_error(&motu->tx_stream)) {
+		amdtp_domain_stop(&motu->domain);
 		finish_session(motu);
+	}
 
 	if (generation != fw_parent_device(motu->unit)->card->generation) {
 		err = fw_iso_resources_update(&motu->rx_resources);
@@ -248,6 +227,8 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 	}
 
 	if (!amdtp_stream_running(&motu->rx_stream)) {
+		int spd = fw_parent_device(motu->unit)->max_speed;
+
 		err = ensure_packet_formats(motu);
 		if (err < 0)
 			return err;
@@ -259,26 +240,32 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 			goto stop_streams;
 		}
 
-		err = start_isoc_ctx(motu, &motu->rx_stream);
-		if (err < 0) {
-			dev_err(&motu->unit->device,
-				"fail to start IT context: %d\n", err);
+		err = amdtp_domain_add_stream(&motu->domain, &motu->tx_stream,
+					      motu->tx_resources.channel, spd);
+		if (err < 0)
 			goto stop_streams;
-		}
 
-		err = motu->spec->protocol->switch_fetching_mode(motu, true);
-		if (err < 0) {
-			dev_err(&motu->unit->device,
-				"fail to enable frame fetching: %d\n", err);
+		err = amdtp_domain_add_stream(&motu->domain, &motu->rx_stream,
+					      motu->rx_resources.channel, spd);
+		if (err < 0)
+			goto stop_streams;
+
+		err = amdtp_domain_start(&motu->domain);
+		if (err < 0)
+			goto stop_streams;
+
+		if (!amdtp_stream_wait_callback(&motu->tx_stream,
+						CALLBACK_TIMEOUT) ||
+		    !amdtp_stream_wait_callback(&motu->rx_stream,
+						CALLBACK_TIMEOUT)) {
+			err = -ETIMEDOUT;
 			goto stop_streams;
 		}
-	}
 
-	if (!amdtp_stream_running(&motu->tx_stream)) {
-		err = start_isoc_ctx(motu, &motu->tx_stream);
+		err = motu->spec->protocol->switch_fetching_mode(motu, true);
 		if (err < 0) {
 			dev_err(&motu->unit->device,
-				"fail to start IR context: %d", err);
+				"fail to enable frame fetching: %d\n", err);
 			goto stop_streams;
 		}
 	}
@@ -286,6 +273,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 	return 0;
 
 stop_streams:
+	amdtp_domain_stop(&motu->domain);
 	finish_session(motu);
 	return err;
 }
@@ -293,6 +281,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 void snd_motu_stream_stop_duplex(struct snd_motu *motu)
 {
 	if (motu->substreams_counter == 0) {
+		amdtp_domain_stop(&motu->domain);
 		finish_session(motu);
 
 		fw_iso_resources_free(&motu->tx_resources);
@@ -344,18 +333,26 @@ int snd_motu_stream_init_duplex(struct snd_motu *motu)
 		return err;
 
 	err = init_stream(motu, &motu->rx_stream);
-	if (err < 0)
+	if (err < 0) {
 		destroy_stream(motu, &motu->tx_stream);
+		return err;
+	}
+
+	err = amdtp_domain_init(&motu->domain);
+	if (err < 0) {
+		destroy_stream(motu, &motu->tx_stream);
+		destroy_stream(motu, &motu->rx_stream);
+	}
 
 	return err;
 }
 
-/*
- * This function should be called before starting streams or after stopping
- * streams.
- */
+// This function should be called before starting streams or after stopping
+// streams.
 void snd_motu_stream_destroy_duplex(struct snd_motu *motu)
 {
+	amdtp_domain_destroy(&motu->domain);
+
 	destroy_stream(motu, &motu->rx_stream);
 	destroy_stream(motu, &motu->tx_stream);
 
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 09d1451d7de4..350ee2c16f4a 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -69,6 +69,8 @@ struct snd_motu {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	struct amdtp_domain domain;
 };
 
 enum snd_motu_spec_flags {
-- 
2.20.1
