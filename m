From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 09/13] ALSA: dice: add a helper function to
	restart all of available streams
Date: Sun, 29 Apr 2018 15:50:28 +0900
Message-ID: <20180429065032.13869-10-o-takashi@sakamocchi.jp>
References: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D94BE26761B
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 08:51:20 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id f15so4452321pfn.0
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 23:51:20 -0700 (PDT)
In-Reply-To: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit is a small refactoring for better readability.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 119 ++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 57 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index b81e98c238c7..6a73528013d3 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -274,6 +274,63 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 	return err;
 }
 
+static int start_duplex_streams(struct snd_dice *dice, unsigned int rate)
+{
+	struct reg_params tx_params, rx_params;
+	int i;
+	int err;
+
+	err = get_register_params(dice, &tx_params, &rx_params);
+	if (err < 0)
+		return err;
+
+	/* Stop transmission. */
+	stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+	stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
+	snd_dice_transaction_clear_enable(dice);
+	release_resources(dice);
+
+	err = ensure_phase_lock(dice);
+	if (err < 0) {
+		dev_err(&dice->unit->device, "fail to ensure phase lock\n");
+		return err;
+	}
+
+	/* Start both streams. */
+	err = start_streams(dice, AMDTP_IN_STREAM, rate, &tx_params);
+	if (err < 0)
+		goto error;
+	err = start_streams(dice, AMDTP_OUT_STREAM, rate, &rx_params);
+	if (err < 0)
+		goto error;
+
+	err = snd_dice_transaction_set_enable(dice);
+	if (err < 0) {
+		dev_err(&dice->unit->device, "fail to enable interface\n");
+		goto error;
+	}
+
+	for (i = 0; i < MAX_STREAMS; i++) {
+		if ((i < tx_params.count &&
+		    !amdtp_stream_wait_callback(&dice->tx_stream[i],
+						CALLBACK_TIMEOUT)) ||
+		    (i < rx_params.count &&
+		     !amdtp_stream_wait_callback(&dice->rx_stream[i],
+						 CALLBACK_TIMEOUT))) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+	stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
+	snd_dice_transaction_clear_enable(dice);
+	release_resources(dice);
+	return err;
+}
+
 /*
  * MEMO: After this function, there're two states of streams:
  *  - None streams are running.
@@ -283,8 +340,6 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 {
 	unsigned int curr_rate;
 	unsigned int i;
-	struct reg_params tx_params, rx_params;
-	bool need_to_start = false;
 	unsigned int mode;
 	int err;
 
@@ -311,7 +366,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 			break;
 	}
 	if (i < MAX_STREAMS)
-		need_to_start = true;
+		goto restart;
 
 	/* Check required streams are running or not. */
 	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
@@ -326,61 +381,11 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 			break;
 	}
 	if (i < MAX_STREAMS)
-		need_to_start = true;
-
-	if (need_to_start) {
-		err = get_register_params(dice, &tx_params, &rx_params);
-		if (err < 0)
-			return err;
-
-		/* Stop transmission. */
-		snd_dice_transaction_clear_enable(dice);
-		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
-		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
-		release_resources(dice);
+		goto restart;
 
-		err = ensure_phase_lock(dice);
-		if (err < 0) {
-			dev_err(&dice->unit->device,
-				"fail to ensure phase lock\n");
-			goto error;
-		}
-
-		/* Start both streams. */
-		err = start_streams(dice, AMDTP_IN_STREAM, rate, &tx_params);
-		if (err < 0)
-			goto error;
-		err = start_streams(dice, AMDTP_OUT_STREAM, rate, &rx_params);
-		if (err < 0)
-			goto error;
-
-		err = snd_dice_transaction_set_enable(dice);
-		if (err < 0) {
-			dev_err(&dice->unit->device,
-				"fail to enable interface\n");
-			goto error;
-		}
-
-		for (i = 0; i < MAX_STREAMS; i++) {
-			if ((i < tx_params.count &&
-			    !amdtp_stream_wait_callback(&dice->tx_stream[i],
-							CALLBACK_TIMEOUT)) ||
-			    (i < rx_params.count &&
-			     !amdtp_stream_wait_callback(&dice->rx_stream[i],
-							 CALLBACK_TIMEOUT))) {
-				err = -ETIMEDOUT;
-				goto error;
-			}
-		}
-	}
-
-	return err;
-error:
-	snd_dice_transaction_clear_enable(dice);
-	stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
-	stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
-	release_resources(dice);
-	return err;
+	return 0;
+restart:
+	return start_duplex_streams(dice, rate);
 }
 
 /*
-- 
2.14.1
