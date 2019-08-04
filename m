From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/19] ALSA: firewire-digi00x: support AMDTP
	domain
Date: Sun,  4 Aug 2019 15:21:34 +0900
Message-ID: <20190804062138.1217-16-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C5DCF805A9
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:22:06 +0200 (CEST)
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

This commit adds AMDTP domain support for ALSA firewire-digi00x driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 55 ++++++++++++++-----------
 sound/firewire/digi00x/digi00x.h        |  2 +
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index cff193f00a97..d6a92460060f 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -126,9 +126,6 @@ static void finish_session(struct snd_dg00x *dg00x)
 {
 	__be32 data;
 
-	amdtp_stream_stop(&dg00x->tx_stream);
-	amdtp_stream_stop(&dg00x->rx_stream);
-
 	data = cpu_to_be32(0x00000003);
 	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_SET,
@@ -265,13 +262,23 @@ int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
 	if (err < 0)
 		destroy_stream(dg00x, &dg00x->rx_stream);
 
+	err = amdtp_domain_init(&dg00x->domain);
+	if (err < 0) {
+		destroy_stream(dg00x, &dg00x->rx_stream);
+		destroy_stream(dg00x, &dg00x->tx_stream);
+	}
+
 	return err;
 }
 
-// This function should be called before starting streams or after stopping
-// streams.
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x)
 {
+	amdtp_domain_destroy(&dg00x->domain);
+
 	destroy_stream(dg00x, &dg00x->rx_stream);
 	destroy_stream(dg00x, &dg00x->tx_stream);
 }
@@ -288,6 +295,8 @@ int snd_dg00x_stream_reserve_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 		rate = curr_rate;
 
 	if (dg00x->substreams_counter == 0 || curr_rate != rate) {
+		amdtp_domain_stop(&dg00x->domain);
+
 		finish_session(dg00x);
 
 		fw_iso_resources_free(&dg00x->tx_resources);
@@ -320,8 +329,10 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 		return 0;
 
 	if (amdtp_streaming_error(&dg00x->tx_stream) ||
-	    amdtp_streaming_error(&dg00x->rx_stream))
+	    amdtp_streaming_error(&dg00x->rx_stream)) {
+		amdtp_domain_stop(&dg00x->domain);
 		finish_session(dg00x);
+	}
 
 	if (generation != fw_parent_device(dg00x->unit)->card->generation) {
 		err = fw_iso_resources_update(&dg00x->tx_resources);
@@ -338,36 +349,30 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 	 * which source of clock is used.
 	 */
 	if (!amdtp_stream_running(&dg00x->rx_stream)) {
+		int spd = fw_parent_device(dg00x->unit)->max_speed;
+
 		err = begin_session(dg00x);
 		if (err < 0)
 			goto error;
 
-		err = amdtp_stream_start(&dg00x->rx_stream,
-				dg00x->rx_resources.channel,
-				fw_parent_device(dg00x->unit)->max_speed);
+		err = amdtp_domain_add_stream(&dg00x->domain, &dg00x->rx_stream,
+					      dg00x->rx_resources.channel, spd);
 		if (err < 0)
 			goto error;
 
-		if (!amdtp_stream_wait_callback(&dg00x->rx_stream,
-					      CALLBACK_TIMEOUT)) {
-			err = -ETIMEDOUT;
+		err = amdtp_domain_add_stream(&dg00x->domain, &dg00x->tx_stream,
+					      dg00x->tx_resources.channel, spd);
+		if (err < 0)
 			goto error;
-		}
-	}
 
-	/*
-	 * The value of SYT field in transmitted packets is always 0x0000. Thus,
-	 * duplex streams with timestamp synchronization cannot be built.
-	 */
-	if (!amdtp_stream_running(&dg00x->tx_stream)) {
-		err = amdtp_stream_start(&dg00x->tx_stream,
-				dg00x->tx_resources.channel,
-				fw_parent_device(dg00x->unit)->max_speed);
+		err = amdtp_domain_start(&dg00x->domain);
 		if (err < 0)
 			goto error;
 
-		if (!amdtp_stream_wait_callback(&dg00x->tx_stream,
-					      CALLBACK_TIMEOUT)) {
+		if (!amdtp_stream_wait_callback(&dg00x->rx_stream,
+						CALLBACK_TIMEOUT) ||
+		    !amdtp_stream_wait_callback(&dg00x->tx_stream,
+						CALLBACK_TIMEOUT)) {
 			err = -ETIMEDOUT;
 			goto error;
 		}
@@ -375,6 +380,7 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 
 	return 0;
 error:
+	amdtp_domain_stop(&dg00x->domain);
 	finish_session(dg00x);
 
 	return err;
@@ -383,6 +389,7 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x)
 {
 	if (dg00x->substreams_counter == 0) {
+		amdtp_domain_stop(&dg00x->domain);
 		finish_session(dg00x);
 
 		fw_iso_resources_free(&dg00x->tx_resources);
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 0994d191ccda..8041c65f2736 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -59,6 +59,8 @@ struct snd_dg00x {
 
 	/* Console models have additional MIDI ports for control surface. */
 	bool is_console;
+
+	struct amdtp_domain domain;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
-- 
2.20.1
