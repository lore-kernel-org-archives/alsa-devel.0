From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/12] ALSA: dice: code refactoring to keep
	isochronous resources
Date: Tue, 11 Jun 2019 22:21:15 +0900
Message-ID: <20190611132118.8378-10-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F2AFF89730
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:40 +0200 (CEST)
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

This commit adds a helper function to allocate isochronous resources,
separated from operations to start packet streaming, I note that some
dice-based devices have two pair of endpoints for isochronous packet
straeming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 133 +++++++++++++++++-------------
 1 file changed, 74 insertions(+), 59 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 8bce923dc4bd..010cbf02de4f 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -175,35 +175,22 @@ static void stop_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 	}
 }
 
-static int keep_resources(struct snd_dice *dice,
-			  enum amdtp_stream_direction dir, unsigned int index,
-			  unsigned int rate, unsigned int pcm_chs,
-			  unsigned int midi_ports)
+static int keep_resources(struct snd_dice *dice, struct amdtp_stream *stream,
+			  struct fw_iso_resources *resources, unsigned int rate,
+			  unsigned int pcm_chs, unsigned int midi_ports)
 {
-	struct amdtp_stream *stream;
-	struct fw_iso_resources *resources;
 	bool double_pcm_frames;
 	unsigned int i;
 	int err;
 
-	if (dir == AMDTP_IN_STREAM) {
-		stream = &dice->tx_stream[index];
-		resources = &dice->tx_resources[index];
-	} else {
-		stream = &dice->rx_stream[index];
-		resources = &dice->rx_resources[index];
-	}
-
-	/*
-	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
-	 * one data block of AMDTP packet. Thus sampling transfer frequency is
-	 * a half of PCM sampling frequency, i.e. PCM frames at 192.0 kHz are
-	 * transferred on AMDTP packets at 96 kHz. Two successive samples of a
-	 * channel are stored consecutively in the packet. This quirk is called
-	 * as 'Dual Wire'.
-	 * For this quirk, blocking mode is required and PCM buffer size should
-	 * be aligned to SYT_INTERVAL.
-	 */
+	// At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
+	// one data block of AMDTP packet. Thus sampling transfer frequency is
+	// a half of PCM sampling frequency, i.e. PCM frames at 192.0 kHz are
+	// transferred on AMDTP packets at 96 kHz. Two successive samples of a
+	// channel are stored consecutively in the packet. This quirk is called
+	// as 'Dual Wire'.
+	// For this quirk, blocking mode is required and PCM buffer size should
+	// be aligned to SYT_INTERVAL.
 	double_pcm_frames = rate > 96000;
 	if (double_pcm_frames) {
 		rate /= 2;
@@ -230,49 +217,40 @@ static int keep_resources(struct snd_dice *dice,
 				fw_parent_device(dice->unit)->max_speed);
 }
 
-static void finish_session(struct snd_dice *dice, struct reg_params *tx_params,
-			   struct reg_params *rx_params)
+static int keep_dual_resources(struct snd_dice *dice, unsigned int rate,
+			       enum amdtp_stream_direction dir,
+			       struct reg_params *params)
 {
-	stop_streams(dice, AMDTP_IN_STREAM, tx_params);
-	stop_streams(dice, AMDTP_OUT_STREAM, rx_params);
-
-	snd_dice_transaction_clear_enable(dice);
-}
-
-static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
-			 unsigned int rate, struct reg_params *params)
-{
-	__be32 reg[2];
 	enum snd_dice_rate_mode mode;
-	unsigned int i, pcm_chs, midi_ports;
-	struct amdtp_stream *streams;
-	struct fw_iso_resources *resources;
-	struct fw_device *fw_dev = fw_parent_device(dice->unit);
-	int err = 0;
-
-	if (dir == AMDTP_IN_STREAM) {
-		streams = dice->tx_stream;
-		resources = dice->tx_resources;
-	} else {
-		streams = dice->rx_stream;
-		resources = dice->rx_resources;
-	}
+	int i;
+	int err;
 
 	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < params->count; i++) {
+	for (i = 0; i < params->count; ++i) {
+		__be32 reg[2];
+		struct amdtp_stream *stream;
+		struct fw_iso_resources *resources;
 		unsigned int pcm_cache;
 		unsigned int midi_cache;
+		unsigned int pcm_chs;
+		unsigned int midi_ports;
 
 		if (dir == AMDTP_IN_STREAM) {
+			stream = &dice->tx_stream[i];
+			resources = &dice->tx_resources[i];
+
 			pcm_cache = dice->tx_pcm_chs[i][mode];
 			midi_cache = dice->tx_midi_ports[i];
 			err = snd_dice_transaction_read_tx(dice,
 					params->size * i + TX_NUMBER_AUDIO,
 					reg, sizeof(reg));
 		} else {
+			stream = &dice->rx_stream[i];
+			resources = &dice->rx_resources[i];
+
 			pcm_cache = dice->rx_pcm_chs[i][mode];
 			midi_cache = dice->rx_midi_ports[i];
 			err = snd_dice_transaction_read_rx(dice,
@@ -284,7 +262,7 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 		pcm_chs = be32_to_cpu(reg[0]);
 		midi_ports = be32_to_cpu(reg[1]);
 
-		/* These are important for developer of this driver. */
+		// These are important for developer of this driver.
 		if (pcm_chs != pcm_cache || midi_ports != midi_cache) {
 			dev_info(&dice->unit->device,
 				 "cache mismatch: pcm: %u:%u, midi: %u:%u\n",
@@ -292,34 +270,71 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 			return -EPROTO;
 		}
 
-		err = keep_resources(dice, dir, i, rate, pcm_chs, midi_ports);
+		err = keep_resources(dice, stream, resources, rate, pcm_chs,
+				     midi_ports);
 		if (err < 0)
 			return err;
+	}
+
+	return 0;
+}
+
+static void finish_session(struct snd_dice *dice, struct reg_params *tx_params,
+			   struct reg_params *rx_params)
+{
+	stop_streams(dice, AMDTP_IN_STREAM, tx_params);
+	stop_streams(dice, AMDTP_OUT_STREAM, rx_params);
+
+	snd_dice_transaction_clear_enable(dice);
+}
+
+static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
+			 unsigned int rate, struct reg_params *params)
+{
+	unsigned int max_speed = fw_parent_device(dice->unit)->max_speed;
+	int i;
+	int err;
+
+	err = keep_dual_resources(dice, rate, dir, params);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < params->count; i++) {
+		struct amdtp_stream *stream;
+		struct fw_iso_resources *resources;
+		__be32 reg;
+
+		if (dir == AMDTP_IN_STREAM) {
+			stream = dice->tx_stream + i;
+			resources = dice->tx_resources + i;
+		} else {
+			stream = dice->rx_stream + i;
+			resources = dice->rx_resources + i;
+		}
 
-		reg[0] = cpu_to_be32(resources[i].channel);
+		reg = cpu_to_be32(resources->channel);
 		if (dir == AMDTP_IN_STREAM) {
 			err = snd_dice_transaction_write_tx(dice,
 					params->size * i + TX_ISOCHRONOUS,
-					reg, sizeof(reg[0]));
+					&reg, sizeof(reg));
 		} else {
 			err = snd_dice_transaction_write_rx(dice,
 					params->size * i + RX_ISOCHRONOUS,
-					reg, sizeof(reg[0]));
+					&reg, sizeof(reg));
 		}
 		if (err < 0)
 			return err;
 
 		if (dir == AMDTP_IN_STREAM) {
-			reg[0] = cpu_to_be32(fw_dev->max_speed);
+			reg = cpu_to_be32(max_speed);
 			err = snd_dice_transaction_write_tx(dice,
 					params->size * i + TX_SPEED,
-					reg, sizeof(reg[0]));
+					&reg, sizeof(reg));
 			if (err < 0)
 				return err;
 		}
 
-		err = amdtp_stream_start(&streams[i], resources[i].channel,
-					 fw_dev->max_speed);
+		err = amdtp_stream_start(stream, resources->channel, max_speed);
 		if (err < 0)
 			return err;
 	}
-- 
2.20.1
