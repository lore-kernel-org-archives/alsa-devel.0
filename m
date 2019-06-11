From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/12] ALSA: dice: code refactoring to stop
	packet streaming
Date: Tue, 11 Jun 2019 22:21:14 +0900
Message-ID: <20190611132118.8378-9-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54077F89736
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:38 +0200 (CEST)
In-Reply-To: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
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

This commit is a part of preparation to perform allocation/release
of isochronous resources in pcm.hw_params/hw_free callbacks.

There're three points to finish packet streaming but no helper
functions for common operations for it. This commit adds a helper
function for operations to finish packet streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index c3c892c5c7ff..8bce923dc4bd 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -230,6 +230,15 @@ static int keep_resources(struct snd_dice *dice,
 				fw_parent_device(dice->unit)->max_speed);
 }
 
+static void finish_session(struct snd_dice *dice, struct reg_params *tx_params,
+			   struct reg_params *rx_params)
+{
+	stop_streams(dice, AMDTP_IN_STREAM, tx_params);
+	stop_streams(dice, AMDTP_OUT_STREAM, rx_params);
+
+	snd_dice_transaction_clear_enable(dice);
+}
+
 static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 			 unsigned int rate, struct reg_params *params)
 {
@@ -328,10 +337,8 @@ static int start_duplex_streams(struct snd_dice *dice, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	/* Stop transmission. */
-	stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
-	stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
-	snd_dice_transaction_clear_enable(dice);
+	// Stop transmission.
+	finish_session(dice, &tx_params, &rx_params);
 	release_resources(dice);
 
 	err = ensure_phase_lock(dice, rate);
@@ -373,9 +380,7 @@ static int start_duplex_streams(struct snd_dice *dice, unsigned int rate)
 
 	return 0;
 error:
-	stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
-	stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
-	snd_dice_transaction_clear_enable(dice);
+	finish_session(dice, &tx_params, &rx_params);
 	release_resources(dice);
 	return err;
 }
@@ -449,12 +454,8 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 	if (dice->substreams_counter > 0)
 		return;
 
-	snd_dice_transaction_clear_enable(dice);
-
-	if (get_register_params(dice, &tx_params, &rx_params) == 0) {
-		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
-		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
-	}
+	if (get_register_params(dice, &tx_params, &rx_params) >= 0)
+		finish_session(dice, &tx_params, &rx_params);
 
 	release_resources(dice);
 }
-- 
2.20.1
