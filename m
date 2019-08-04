From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/19] ALSA: fireface: support AMDTP domain
Date: Sun,  4 Aug 2019 15:21:37 +0900
Message-ID: <20190804062138.1217-19-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E69A7F805E0
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:22:10 +0200 (CEST)
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

This commit adds AMDTP domain support for ALSA fireface driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-stream.c | 57 +++++++++++++++++------------
 sound/firewire/fireface/ff.h        |  2 +
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index e4710204f481..e8e6f9fd6433 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -32,9 +32,6 @@ int snd_ff_stream_get_multiplier_mode(enum cip_sfc sfc,
 
 static inline void finish_session(struct snd_ff *ff)
 {
-	amdtp_stream_stop(&ff->tx_stream);
-	amdtp_stream_stop(&ff->rx_stream);
-
 	ff->spec->protocol->finish_session(ff);
 	ff->spec->protocol->switch_fetching_mode(ff, false);
 }
@@ -83,8 +80,16 @@ int snd_ff_stream_init_duplex(struct snd_ff *ff)
 		return err;
 
 	err = init_stream(ff, &ff->tx_stream);
-	if (err < 0)
+	if (err < 0) {
 		destroy_stream(ff, &ff->rx_stream);
+		return err;
+	}
+
+	err = amdtp_domain_init(&ff->domain);
+	if (err < 0) {
+		destroy_stream(ff, &ff->rx_stream);
+		destroy_stream(ff, &ff->tx_stream);
+	}
 
 	return err;
 }
@@ -95,6 +100,8 @@ int snd_ff_stream_init_duplex(struct snd_ff *ff)
  */
 void snd_ff_stream_destroy_duplex(struct snd_ff *ff)
 {
+	amdtp_domain_destroy(&ff->domain);
+
 	destroy_stream(ff, &ff->rx_stream);
 	destroy_stream(ff, &ff->tx_stream);
 }
@@ -113,6 +120,7 @@ int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate)
 		enum snd_ff_stream_mode mode;
 		int i;
 
+		amdtp_domain_stop(&ff->domain);
 		finish_session(ff);
 
 		fw_iso_resources_free(&ff->tx_resources);
@@ -155,51 +163,52 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 		return 0;
 
 	if (amdtp_streaming_error(&ff->tx_stream) ||
-	    amdtp_streaming_error(&ff->rx_stream))
+	    amdtp_streaming_error(&ff->rx_stream)) {
+		amdtp_domain_stop(&ff->domain);
 		finish_session(ff);
+	}
 
 	/*
 	 * Regardless of current source of clock signal, drivers transfer some
 	 * packets. Then, the device transfers packets.
 	 */
 	if (!amdtp_stream_running(&ff->rx_stream)) {
+		int spd = fw_parent_device(ff->unit)->max_speed;
+
 		err = ff->spec->protocol->begin_session(ff, rate);
 		if (err < 0)
 			goto error;
 
-		err = amdtp_stream_start(&ff->rx_stream,
-					 ff->rx_resources.channel,
-					 fw_parent_device(ff->unit)->max_speed);
+		err = amdtp_domain_add_stream(&ff->domain, &ff->rx_stream,
+					      ff->rx_resources.channel, spd);
 		if (err < 0)
 			goto error;
 
-		if (!amdtp_stream_wait_callback(&ff->rx_stream,
-						CALLBACK_TIMEOUT_MS)) {
-			err = -ETIMEDOUT;
-			goto error;
-		}
-
-		err = ff->spec->protocol->switch_fetching_mode(ff, true);
+		err = amdtp_domain_add_stream(&ff->domain, &ff->tx_stream,
+					      ff->tx_resources.channel, spd);
 		if (err < 0)
 			goto error;
-	}
 
-	if (!amdtp_stream_running(&ff->tx_stream)) {
-		err = amdtp_stream_start(&ff->tx_stream,
-					 ff->tx_resources.channel,
-					 fw_parent_device(ff->unit)->max_speed);
+		err = amdtp_domain_start(&ff->domain);
 		if (err < 0)
 			goto error;
 
-		if (!amdtp_stream_wait_callback(&ff->tx_stream,
+		if (!amdtp_stream_wait_callback(&ff->rx_stream,
+						CALLBACK_TIMEOUT_MS) ||
+		    !amdtp_stream_wait_callback(&ff->tx_stream,
 						CALLBACK_TIMEOUT_MS)) {
 			err = -ETIMEDOUT;
 			goto error;
 		}
+
+		err = ff->spec->protocol->switch_fetching_mode(ff, true);
+		if (err < 0)
+			goto error;
 	}
 
 	return 0;
 error:
+	amdtp_domain_stop(&ff->domain);
 	finish_session(ff);
 
 	return err;
@@ -208,6 +217,7 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 void snd_ff_stream_stop_duplex(struct snd_ff *ff)
 {
 	if (ff->substreams_counter == 0) {
+		amdtp_domain_stop(&ff->domain);
 		finish_session(ff);
 
 		fw_iso_resources_free(&ff->tx_resources);
@@ -217,12 +227,11 @@ void snd_ff_stream_stop_duplex(struct snd_ff *ff)
 
 void snd_ff_stream_update_duplex(struct snd_ff *ff)
 {
+	amdtp_domain_stop(&ff->domain);
+
 	// The device discontinue to transfer packets.
 	amdtp_stream_pcm_abort(&ff->tx_stream);
-	amdtp_stream_stop(&ff->tx_stream);
-
 	amdtp_stream_pcm_abort(&ff->rx_stream);
-	amdtp_stream_stop(&ff->rx_stream);
 }
 
 void snd_ff_stream_lock_changed(struct snd_ff *ff)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 36dd0c75b9f7..b4c22ca6079e 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -91,6 +91,8 @@ struct snd_ff {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	struct amdtp_domain domain;
 };
 
 enum snd_ff_clock_src {
-- 
2.20.1
