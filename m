From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: use structure to represent
	register parameters instead of array with basic type element
Date: Thu, 10 Mar 2016 21:44:28 +0900
Message-ID: <1457613868-14891-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id E49AC261492
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 13:44:35 +0100 (CET)
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

In dice interface, two blocks of register are accessible via IEEE 1394
asynchronous transaction to represent the number of supported isochronous
streams and the number of quadlets for stream information.

Current ALSA dice driver uses array with 'unsigned int' element for
temporary cache of these information. But using structure is preferable
for begin easily comprehensible.

This commit applies a local structure for this aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 110 +++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 56 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 2077f18..845d5e5 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -12,6 +12,11 @@
 #define	CALLBACK_TIMEOUT	200
 #define NOTIFICATION_TIMEOUT_MS	(2 * MSEC_PER_SEC)
 
+struct reg_params {
+	unsigned int count;
+	unsigned int size;
+};
+
 const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	/* mode 0 */
 	[0] =  32000,
@@ -65,7 +70,9 @@ static int ensure_phase_lock(struct snd_dice *dice)
 	return 0;
 }
 
-static int get_register_params(struct snd_dice *dice, unsigned int params[4])
+static int get_register_params(struct snd_dice *dice,
+			       struct reg_params *tx_params,
+			       struct reg_params *rx_params)
 {
 	__be32 reg[2];
 	int err;
@@ -73,14 +80,16 @@ static int get_register_params(struct snd_dice *dice, unsigned int params[4])
 	err = snd_dice_transaction_read_tx(dice, TX_NUMBER, reg, sizeof(reg));
 	if (err < 0)
 		return err;
-	params[0] = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
-	params[1] = be32_to_cpu(reg[1]) * 4;
+	tx_params->count =
+			min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
+	tx_params->size = be32_to_cpu(reg[1]) * 4;
 
 	err = snd_dice_transaction_read_rx(dice, RX_NUMBER, reg, sizeof(reg));
 	if (err < 0)
 		return err;
-	params[2] = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
-	params[3] = be32_to_cpu(reg[1]) * 4;
+	rx_params->count =
+			min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
+	rx_params->size = be32_to_cpu(reg[1]) * 4;
 
 	return 0;
 }
@@ -105,21 +114,21 @@ static void release_resources(struct snd_dice *dice)
 }
 
 static void stop_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
-			 unsigned int count, unsigned int size)
+			 struct reg_params *params)
 {
 	__be32 reg;
 	unsigned int i;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < params->count; i++) {
 		reg = cpu_to_be32((u32)-1);
 		if (dir == AMDTP_IN_STREAM) {
 			snd_dice_transaction_write_tx(dice,
-						size * i + TX_ISOCHRONOUS,
-						&reg, sizeof(reg));
+					params->size * i + TX_ISOCHRONOUS,
+					&reg, sizeof(reg));
 		} else {
 			snd_dice_transaction_write_rx(dice,
-						size * i + RX_ISOCHRONOUS,
-						&reg, sizeof(reg));
+					params->size * i + RX_ISOCHRONOUS,
+					&reg, sizeof(reg));
 		}
 	}
 }
@@ -180,8 +189,7 @@ static int keep_resources(struct snd_dice *dice,
 }
 
 static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
-			 unsigned int rate, unsigned int count,
-			 unsigned int size)
+			 unsigned int rate, struct reg_params *params)
 {
 	__be32 reg[2];
 	unsigned int i, pcm_chs, midi_ports;
@@ -197,15 +205,15 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 		resources = dice->rx_resources;
 	}
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < params->count; i++) {
 		if (dir == AMDTP_IN_STREAM) {
 			err = snd_dice_transaction_read_tx(dice,
-						size * i + TX_NUMBER_AUDIO,
-						reg, sizeof(reg));
+					params->size * i + TX_NUMBER_AUDIO,
+					reg, sizeof(reg));
 		} else {
 			err = snd_dice_transaction_read_rx(dice,
-						size * i + RX_NUMBER_AUDIO,
-						reg, sizeof(reg));
+					params->size * i + RX_NUMBER_AUDIO,
+					reg, sizeof(reg));
 		}
 		if (err < 0)
 			return err;
@@ -219,12 +227,12 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 		reg[0] = cpu_to_be32(resources[i].channel);
 		if (dir == AMDTP_IN_STREAM) {
 			err = snd_dice_transaction_write_tx(dice,
-						size * i + TX_ISOCHRONOUS,
-						reg, sizeof(reg[0]));
+					params->size * i + TX_ISOCHRONOUS,
+					reg, sizeof(reg[0]));
 		} else {
 			err = snd_dice_transaction_write_rx(dice,
-						size * i + RX_ISOCHRONOUS,
-						reg, sizeof(reg[0]));
+					params->size * i + RX_ISOCHRONOUS,
+					reg, sizeof(reg[0]));
 		}
 		if (err < 0)
 			return err;
@@ -247,14 +255,14 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 {
 	unsigned int curr_rate;
 	unsigned int i;
-	unsigned int reg_params[4];
+	struct reg_params tx_params, rx_params;
 	bool need_to_start;
 	int err;
 
 	if (dice->substreams_counter == 0)
 		return -EIO;
 
-	err = get_register_params(dice, reg_params);
+	err = get_register_params(dice, &tx_params, &rx_params);
 	if (err < 0)
 		return err;
 
@@ -271,12 +279,12 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 
 	/* Judge to need to restart streams. */
 	for (i = 0; i < MAX_STREAMS; i++) {
-		if (i < reg_params[0]) {
+		if (i < tx_params.count) {
 			if (amdtp_streaming_error(&dice->tx_stream[i]) ||
 			    !amdtp_stream_running(&dice->tx_stream[i]))
 				break;
 		}
-		if (i < reg_params[2]) {
+		if (i < rx_params.count) {
 			if (amdtp_streaming_error(&dice->rx_stream[i]) ||
 			    !amdtp_stream_running(&dice->rx_stream[i]))
 				break;
@@ -287,10 +295,8 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	if (need_to_start) {
 		/* Stop transmission. */
 		snd_dice_transaction_clear_enable(dice);
-		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
-			     reg_params[1]);
-		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
-			     reg_params[3]);
+		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 		release_resources(dice);
 
 		err = ensure_phase_lock(dice);
@@ -301,12 +307,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 		}
 
 		/* Start both streams. */
-		err = start_streams(dice, AMDTP_IN_STREAM, rate, reg_params[0],
-				    reg_params[1]);
+		err = start_streams(dice, AMDTP_IN_STREAM, rate, &tx_params);
 		if (err < 0)
 			goto error;
-		err = start_streams(dice, AMDTP_OUT_STREAM, rate, reg_params[2],
-				    reg_params[3]);
+		err = start_streams(dice, AMDTP_OUT_STREAM, rate, &rx_params);
 		if (err < 0)
 			goto error;
 
@@ -318,10 +322,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 		}
 
 		for (i = 0; i < MAX_STREAMS; i++) {
-			if ((i < reg_params[0] &&
+			if ((i < tx_params.count &&
 			    !amdtp_stream_wait_callback(&dice->tx_stream[i],
 							CALLBACK_TIMEOUT)) ||
-			    (i < reg_params[2] &&
+			    (i < rx_params.count &&
 			     !amdtp_stream_wait_callback(&dice->rx_stream[i],
 							 CALLBACK_TIMEOUT))) {
 				err = -ETIMEDOUT;
@@ -333,8 +337,8 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	return err;
 error:
 	snd_dice_transaction_clear_enable(dice);
-	stop_streams(dice, AMDTP_IN_STREAM, reg_params[0], reg_params[1]);
-	stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2], reg_params[3]);
+	stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+	stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 	release_resources(dice);
 	return err;
 }
@@ -346,18 +350,16 @@ error:
  */
 void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 {
-	unsigned int reg_params[4];
+	struct reg_params tx_params, rx_params;
 
 	if (dice->substreams_counter > 0)
 		return;
 
 	snd_dice_transaction_clear_enable(dice);
 
-	if (get_register_params(dice, reg_params) == 0) {
-		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
-			     reg_params[1]);
-		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
-			     reg_params[3]);
+	if (get_register_params(dice, &tx_params, &rx_params) == 0) {
+		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 	}
 
 	release_resources(dice);
@@ -444,15 +446,13 @@ end:
 
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
-	unsigned int reg_params[4];
+	struct reg_params tx_params, rx_params;
 
 	snd_dice_transaction_clear_enable(dice);
 
-	if (get_register_params(dice, reg_params) == 0) {
-		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
-			     reg_params[1]);
-		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
-			     reg_params[3]);
+	if (get_register_params(dice, &tx_params, &rx_params) == 0) {
+		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 	}
 
 	release_resources(dice);
@@ -462,7 +462,7 @@ void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 
 void snd_dice_stream_update_duplex(struct snd_dice *dice)
 {
-	unsigned int reg_params[4];
+	struct reg_params tx_params, rx_params;
 
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
@@ -474,11 +474,9 @@ void snd_dice_stream_update_duplex(struct snd_dice *dice)
 	 */
 	dice->global_enabled = false;
 
-	if (get_register_params(dice, reg_params) == 0) {
-		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
-			     reg_params[1]);
-		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
-			     reg_params[3]);
+	if (get_register_params(dice, &tx_params, &rx_params) == 0) {
+		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
+		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 	}
 }
 
-- 
2.7.0
