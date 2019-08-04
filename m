From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/19] ALSA: dice: support AMDTP domain
Date: Sun,  4 Aug 2019 15:21:33 +0900
Message-ID: <20190804062138.1217-15-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E70C6F804CA
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:22:04 +0200 (CEST)
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

This commit adds AMDTP domain support for ALSA dice driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 32 ++++++++++++++++++++++++-------
 sound/firewire/dice/dice.h        |  2 ++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index a9f0c77734c3..af8c5a2c28f3 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -154,14 +154,10 @@ static void stop_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 	for (i = 0; i < params->count; i++) {
 		reg = cpu_to_be32((u32)-1);
 		if (dir == AMDTP_IN_STREAM) {
-			amdtp_stream_stop(&dice->tx_stream[i]);
-
 			snd_dice_transaction_write_tx(dice,
 					params->size * i + TX_ISOCHRONOUS,
 					&reg, sizeof(reg));
 		} else {
-			amdtp_stream_stop(&dice->rx_stream[i]);
-
 			snd_dice_transaction_write_rx(dice,
 					params->size * i + RX_ISOCHRONOUS,
 					&reg, sizeof(reg));
@@ -297,10 +293,11 @@ int snd_dice_stream_reserve_duplex(struct snd_dice *dice, unsigned int rate)
 	if (dice->substreams_counter == 0 || curr_rate != rate) {
 		struct reg_params tx_params, rx_params;
 
+		amdtp_domain_stop(&dice->domain);
+
 		err = get_register_params(dice, &tx_params, &rx_params);
 		if (err < 0)
 			return err;
-
 		finish_session(dice, &tx_params, &rx_params);
 
 		release_resources(dice);
@@ -377,7 +374,8 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 				return err;
 		}
 
-		err = amdtp_stream_start(stream, resources->channel, max_speed);
+		err = amdtp_domain_add_stream(&dice->domain, stream,
+					      resources->channel, max_speed);
 		if (err < 0)
 			return err;
 	}
@@ -410,6 +408,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice)
 	for (i = 0; i < MAX_STREAMS; ++i) {
 		if (amdtp_streaming_error(&dice->tx_stream[i]) ||
 		    amdtp_streaming_error(&dice->rx_stream[i])) {
+			amdtp_domain_stop(&dice->domain);
 			finish_session(dice, &tx_params, &rx_params);
 			break;
 		}
@@ -456,6 +455,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice)
 			goto error;
 		}
 
+		err = amdtp_domain_start(&dice->domain);
+		if (err < 0)
+			goto error;
+
 		for (i = 0; i < MAX_STREAMS; i++) {
 			if ((i < tx_params.count &&
 			    !amdtp_stream_wait_callback(&dice->tx_stream[i],
@@ -471,6 +474,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice)
 
 	return 0;
 error:
+	amdtp_domain_stop(&dice->domain);
 	finish_session(dice, &tx_params, &rx_params);
 	return err;
 }
@@ -485,8 +489,10 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 	struct reg_params tx_params, rx_params;
 
 	if (dice->substreams_counter == 0) {
-		if (get_register_params(dice, &tx_params, &rx_params) >= 0)
+		if (get_register_params(dice, &tx_params, &rx_params) >= 0) {
+			amdtp_domain_stop(&dice->domain);
 			finish_session(dice, &tx_params, &rx_params);
+		}
 
 		release_resources(dice);
 	}
@@ -567,6 +573,14 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice)
 			break;
 		}
 	}
+
+	err = amdtp_domain_init(&dice->domain);
+	if (err < 0) {
+		for (i = 0; i < MAX_STREAMS; ++i) {
+			destroy_stream(dice, AMDTP_OUT_STREAM, i);
+			destroy_stream(dice, AMDTP_IN_STREAM, i);
+		}
+	}
 end:
 	return err;
 }
@@ -579,6 +593,8 @@ void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 		destroy_stream(dice, AMDTP_IN_STREAM, i);
 		destroy_stream(dice, AMDTP_OUT_STREAM, i);
 	}
+
+	amdtp_domain_destroy(&dice->domain);
 }
 
 void snd_dice_stream_update_duplex(struct snd_dice *dice)
@@ -596,6 +612,8 @@ void snd_dice_stream_update_duplex(struct snd_dice *dice)
 	dice->global_enabled = false;
 
 	if (get_register_params(dice, &tx_params, &rx_params) == 0) {
+		amdtp_domain_stop(&dice->domain);
+
 		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
 		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 	}
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index c6304e5e9fc4..fa6d74303f54 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -112,6 +112,8 @@ struct snd_dice {
 	bool global_enabled;
 	struct completion clock_accepted;
 	unsigned int substreams_counter;
+
+	struct amdtp_domain domain;
 };
 
 enum snd_dice_addr_type {
-- 
2.20.1
