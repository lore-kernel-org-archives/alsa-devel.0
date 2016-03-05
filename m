From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: dice: handle whole available
	isochronous streams
Date: Sat,  5 Mar 2016 20:58:05 +0900
Message-ID: <1457179087-27604-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8109C2608B4
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 12:58:11 +0100 (CET)
In-Reply-To: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit enables ALSA dice driver to handle whole available streams.

In Dice, certain registers represent the number of available streams at
current sampling transfer frequency for both directions. The parameters
of each stream are represented in a block of register. This block is
aligned sequentially. These streams start simultaneously by writing
enable bit to a register.

This commit operates these registers when starting/stopping streams. I
note that this driver fails to handle dice units in which several streams
are available while IEEE 1394 host controllers support fewer isochronous
contexts.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 400 ++++++++++++++++++++++++--------------
 1 file changed, 257 insertions(+), 143 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 15d581d..e7658af 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -65,85 +65,85 @@ static int ensure_phase_lock(struct snd_dice *dice)
 	return 0;
 }
 
-static void release_resources(struct snd_dice *dice,
-			      struct fw_iso_resources *resources)
+static int get_register_params(struct snd_dice *dice, unsigned int params[4])
 {
-	__be32 channel;
-
-	/* Reset channel number */
-	channel = cpu_to_be32((u32)-1);
-	if (resources == &dice->tx_resources[0])
-		snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
-					      &channel, sizeof(channel));
-	else
-		snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
-					      &channel, sizeof(channel));
-
-	fw_iso_resources_free(resources);
-}
-
-static int keep_resources(struct snd_dice *dice,
-			  struct fw_iso_resources *resources,
-			  unsigned int max_payload_bytes)
-{
-	__be32 channel;
+	__be32 reg[2];
 	int err;
 
-	err = fw_iso_resources_allocate(resources, max_payload_bytes,
-				fw_parent_device(dice->unit)->max_speed);
+	err = snd_dice_transaction_read_tx(dice, TX_NUMBER, reg, sizeof(reg));
 	if (err < 0)
-		goto end;
+		return err;
+	params[0] = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
+	params[1] = be32_to_cpu(reg[1]) * 4;
 
-	/* Set channel number */
-	channel = cpu_to_be32(resources->channel);
-	if (resources == &dice->tx_resources[0])
-		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
-						    &channel, sizeof(channel));
-	else
-		err = snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
-						    &channel, sizeof(channel));
+	err = snd_dice_transaction_read_rx(dice, RX_NUMBER, reg, sizeof(reg));
 	if (err < 0)
-		release_resources(dice, resources);
-end:
-	return err;
+		return err;
+	params[2] = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
+	params[3] = be32_to_cpu(reg[1]) * 4;
+
+	return 0;
 }
 
-static void stop_stream(struct snd_dice *dice, struct amdtp_stream *stream)
+static void release_resources(struct snd_dice *dice)
 {
-	amdtp_stream_pcm_abort(stream);
-	amdtp_stream_stop(stream);
+	unsigned int i;
+
+	for (i = 0; i < MAX_STREAMS; i++) {
+		if (amdtp_stream_running(&dice->tx_stream[i])) {
+			amdtp_stream_pcm_abort(&dice->tx_stream[i]);
+			amdtp_stream_stop(&dice->tx_stream[i]);
+		}
+		if (amdtp_stream_running(&dice->rx_stream[i])) {
+			amdtp_stream_pcm_abort(&dice->rx_stream[i]);
+			amdtp_stream_stop(&dice->rx_stream[i]);
+		}
 
-	if (stream == &dice->tx_stream[0])
-		release_resources(dice, &dice->tx_resources[0]);
-	else
-		release_resources(dice, &dice->rx_resources[0]);
+		fw_iso_resources_free(&dice->tx_resources[i]);
+		fw_iso_resources_free(&dice->rx_resources[i]);
+	}
 }
 
-static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
-			unsigned int rate)
+static void stop_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
+			 unsigned int count, unsigned int size)
 {
+	__be32 reg;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		/* 0x0008 is TX_ISOCHRONOUS/RX_ISOCHRONOUS. */
+		reg = cpu_to_be32((u32)-1);
+		if (dir == AMDTP_IN_STREAM) {
+			snd_dice_transaction_write_tx(dice,
+						size * i + TX_ISOCHRONOUS,
+						&reg, sizeof(reg));
+		} else {
+			snd_dice_transaction_write_rx(dice,
+						size * i + RX_ISOCHRONOUS,
+						&reg, sizeof(reg));
+		}
+	}
+}
+
+static int keep_resources(struct snd_dice *dice,
+			  enum amdtp_stream_direction dir, unsigned int index,
+			  unsigned int rate, unsigned int pcm_chs,
+			  unsigned int midi_ports)
+{
+	struct amdtp_stream *stream;
 	struct fw_iso_resources *resources;
-	__be32 reg[2];
-	unsigned int i, pcm_chs, midi_ports;
 	bool double_pcm_frames;
+	unsigned int i;
 	int err;
 
-	if (stream == &dice->tx_stream[0]) {
-		resources = &dice->tx_resources[0];
-		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
-						   reg, sizeof(reg));
+	if (dir == AMDTP_IN_STREAM) {
+		stream = &dice->tx_stream[index];
+		resources = &dice->tx_resources[index];
 	} else {
-		resources = &dice->rx_resources[0];
-		err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
-						   reg, sizeof(reg));
+		stream = &dice->rx_stream[index];
+		resources = &dice->rx_resources[index];
 	}
 
-	if (err < 0)
-		goto end;
-
-	pcm_chs = be32_to_cpu(reg[0]);
-	midi_ports = be32_to_cpu(reg[1]);
-
 	/*
 	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
 	 * one data block of AMDTP packet. Thus sampling transfer frequency is
@@ -163,7 +163,7 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 	err = amdtp_am824_set_parameters(stream, rate, pcm_chs, midi_ports,
 					 double_pcm_frames);
 	if (err < 0)
-		goto end;
+		return err;
 
 	if (double_pcm_frames) {
 		pcm_chs /= 2;
@@ -175,122 +175,209 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 		}
 	}
 
-	err = keep_resources(dice, resources,
-			     amdtp_stream_get_max_payload(stream));
-	if (err < 0) {
-		dev_err(&dice->unit->device,
-			"fail to keep isochronous resources\n");
-		goto end;
+	return fw_iso_resources_allocate(resources,
+				amdtp_stream_get_max_payload(stream),
+				fw_parent_device(dice->unit)->max_speed);
+}
+
+static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
+			 unsigned int rate, unsigned int count,
+			 unsigned int size)
+{
+	__be32 reg[2];
+	unsigned int i, pcm_chs, midi_ports;
+	struct amdtp_stream *streams;
+	struct fw_iso_resources *resources;
+	int err = 0;
+
+	if (dir == AMDTP_IN_STREAM) {
+		streams = dice->tx_stream;
+		resources = dice->tx_resources;
+	} else {
+		streams = dice->rx_stream;
+		resources = dice->rx_resources;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (dir == AMDTP_IN_STREAM) {
+			err = snd_dice_transaction_read_tx(dice,
+						size * i + TX_NUMBER_AUDIO,
+						reg, sizeof(reg));
+		} else {
+			err = snd_dice_transaction_read_rx(dice,
+						size * i + RX_NUMBER_AUDIO,
+						reg, sizeof(reg));
+		}
+		if (err < 0)
+			return err;
+		pcm_chs = be32_to_cpu(reg[0]);
+		midi_ports = be32_to_cpu(reg[1]);
+
+		err = keep_resources(dice, dir, i, rate, pcm_chs, midi_ports);
+		if (err < 0)
+			return err;
+
+		/* 0x0008 is TX_ISOCHRONOUS/RX_ISOCHRONOUS. */
+		reg[0] = cpu_to_be32(resources[i].channel);
+		if (dir == AMDTP_IN_STREAM) {
+			err = snd_dice_transaction_write_tx(dice,
+						size * i + TX_ISOCHRONOUS,
+						reg, sizeof(reg[0]));
+		} else {
+			err = snd_dice_transaction_write_rx(dice,
+						size * i + RX_ISOCHRONOUS,
+						reg, sizeof(reg[0]));
+		}
+		if (err < 0)
+			return err;
+
+		err = amdtp_stream_start(&streams[i], resources[i].channel,
+				fw_parent_device(dice->unit)->max_speed);
+		if (err < 0)
+			return err;
 	}
 
-	err = amdtp_stream_start(stream, resources->channel,
-				 fw_parent_device(dice->unit)->max_speed);
-	if (err < 0)
-		release_resources(dice, resources);
-end:
 	return err;
 }
 
+/*
+ * MEMO: After this function, there're two states of streams:
+ *  - None streams are running.
+ *  - All streams are running.
+ */
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 {
-	struct amdtp_stream *master, *slave;
 	unsigned int curr_rate;
-	int err = 0;
+	unsigned int i;
+	unsigned int reg_params[4];
+	bool need_to_start;
+	int err;
 
 	if (dice->substreams_counter == 0)
-		goto end;
-
-	master = &dice->rx_stream[0];
-	slave  = &dice->tx_stream[0];
+		return -EIO;
 
-	/* Some packet queueing errors. */
-	if (amdtp_streaming_error(master) || amdtp_streaming_error(slave))
-		stop_stream(dice, master);
+	err = get_register_params(dice, reg_params);
+	if (err < 0)
+		return err;
 
-	/* Stop stream if rate is different. */
 	err = snd_dice_transaction_get_rate(dice, &curr_rate);
 	if (err < 0) {
 		dev_err(&dice->unit->device,
 			"fail to get sampling rate\n");
-		goto end;
+		return err;
 	}
 	if (rate == 0)
 		rate = curr_rate;
-	if (rate != curr_rate) {
-		err = -EINVAL;
-		goto end;
+	if (rate != curr_rate)
+		return -EINVAL;
+
+	/* Judge to need to restart streams. */
+	for (i = 0; i < MAX_STREAMS; i++) {
+		if (i < reg_params[0]) {
+			if (amdtp_streaming_error(&dice->tx_stream[i]) ||
+			    !amdtp_stream_running(&dice->tx_stream[i]))
+				break;
+		}
+		if (i < reg_params[2]) {
+			if (amdtp_streaming_error(&dice->rx_stream[i]) ||
+			    !amdtp_stream_running(&dice->rx_stream[i]))
+				break;
+		}
 	}
+	need_to_start = (i < MAX_STREAMS);
 
-	if (!amdtp_stream_running(master)) {
-		stop_stream(dice, slave);
+	if (need_to_start) {
+		/* Stop transmission. */
 		snd_dice_transaction_clear_enable(dice);
+		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
+			     reg_params[1]);
+		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
+			     reg_params[3]);
+		release_resources(dice);
 
 		err = ensure_phase_lock(dice);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
 				"fail to ensure phase lock\n");
-			goto end;
+			return err;
 		}
 
 		/* Start both streams. */
-		err = start_stream(dice, master, rate);
-		if (err < 0) {
-			dev_err(&dice->unit->device,
-				"fail to start AMDTP master stream\n");
-			goto end;
-		}
-		err = start_stream(dice, slave, rate);
-		if (err < 0) {
-			dev_err(&dice->unit->device,
-				"fail to start AMDTP slave stream\n");
-			stop_stream(dice, master);
-			goto end;
-		}
+		err = start_streams(dice, AMDTP_IN_STREAM, rate, reg_params[0],
+				    reg_params[1]);
+		if (err < 0)
+			goto error;
+		err = start_streams(dice, AMDTP_OUT_STREAM, rate, reg_params[2],
+				    reg_params[3]);
+		if (err < 0)
+			goto error;
+
 		err = snd_dice_transaction_set_enable(dice);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
 				"fail to enable interface\n");
-			stop_stream(dice, master);
-			stop_stream(dice, slave);
-			goto end;
+			goto error;
 		}
 
-		/* Wait first callbacks */
-		if (!amdtp_stream_wait_callback(master, CALLBACK_TIMEOUT) ||
-		    !amdtp_stream_wait_callback(slave, CALLBACK_TIMEOUT)) {
-			snd_dice_transaction_clear_enable(dice);
-			stop_stream(dice, master);
-			stop_stream(dice, slave);
-			err = -ETIMEDOUT;
+		for (i = 0; i < MAX_STREAMS; i++) {
+			if ((i < reg_params[0] &&
+			    !amdtp_stream_wait_callback(&dice->tx_stream[i],
+							CALLBACK_TIMEOUT)) ||
+			    (i < reg_params[2] &&
+			     !amdtp_stream_wait_callback(&dice->rx_stream[i],
+							 CALLBACK_TIMEOUT))) {
+				err = -ETIMEDOUT;
+				goto error;
+			}
 		}
 	}
-end:
+
+	return err;
+error:
+	snd_dice_transaction_clear_enable(dice);
+	stop_streams(dice, AMDTP_IN_STREAM, reg_params[0], reg_params[1]);
+	stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2], reg_params[3]);
+	release_resources(dice);
 	return err;
 }
 
+/*
+ * MEMO: After this function, there're two states of streams:
+ *  - None streams are running.
+ *  - All streams are running.
+ */
 void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 {
+	unsigned int reg_params[4];
+
 	if (dice->substreams_counter > 0)
 		return;
 
 	snd_dice_transaction_clear_enable(dice);
 
-	stop_stream(dice, &dice->tx_stream[0]);
-	stop_stream(dice, &dice->rx_stream[0]);
+	if (get_register_params(dice, reg_params) == 0) {
+		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
+			     reg_params[1]);
+		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
+			     reg_params[3]);
+	}
+
+	release_resources(dice);
 }
 
-static int init_stream(struct snd_dice *dice, struct amdtp_stream *stream)
+static int init_stream(struct snd_dice *dice, enum amdtp_stream_direction dir,
+		       unsigned int index)
 {
-	int err;
+	struct amdtp_stream *stream;
 	struct fw_iso_resources *resources;
-	enum amdtp_stream_direction dir;
+	int err;
 
-	if (stream == &dice->tx_stream[0]) {
-		resources = &dice->tx_resources[0];
-		dir = AMDTP_IN_STREAM;
+	if (dir == AMDTP_IN_STREAM) {
+		stream = &dice->tx_stream[index];
+		resources = &dice->tx_resources[index];
 	} else {
-		resources = &dice->rx_resources[0];
-		dir = AMDTP_OUT_STREAM;
+		stream = &dice->rx_stream[index];
+		resources = &dice->rx_resources[index];
 	}
 
 	err = fw_iso_resources_init(resources, dice->unit);
@@ -311,14 +398,20 @@ end:
  * This function should be called before starting streams or after stopping
  * streams.
  */
-static void destroy_stream(struct snd_dice *dice, struct amdtp_stream *stream)
+static void destroy_stream(struct snd_dice *dice,
+			   enum amdtp_stream_direction dir,
+			   unsigned int index)
 {
+	struct amdtp_stream *stream;
 	struct fw_iso_resources *resources;
 
-	if (stream == &dice->tx_stream[0])
-		resources = &dice->tx_resources[0];
-	else
-		resources = &dice->rx_resources[0];
+	if (dir == AMDTP_IN_STREAM) {
+		stream = &dice->tx_stream[index];
+		resources = &dice->tx_resources[index];
+	} else {
+		stream = &dice->rx_stream[index];
+		resources = &dice->rx_resources[index];
+	}
 
 	amdtp_stream_destroy(stream);
 	fw_iso_resources_destroy(resources);
@@ -326,33 +419,53 @@ static void destroy_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 
 int snd_dice_stream_init_duplex(struct snd_dice *dice)
 {
-	int err;
+	int i, err;
 
-	dice->substreams_counter = 0;
-
-	err = init_stream(dice, &dice->tx_stream[0]);
-	if (err < 0)
-		goto end;
+	for (i = 0; i < MAX_STREAMS; i++) {
+		err = init_stream(dice, AMDTP_IN_STREAM, i);
+		if (err < 0) {
+			for (; i >= 0; i--)
+				destroy_stream(dice, AMDTP_OUT_STREAM, i);
+			goto end;
+		}
+	}
 
-	err = init_stream(dice, &dice->rx_stream[0]);
-	if (err < 0)
-		destroy_stream(dice, &dice->tx_stream[0]);
+	for (i = 0; i < MAX_STREAMS; i++) {
+		err = init_stream(dice, AMDTP_OUT_STREAM, i);
+		if (err < 0) {
+			for (; i >= 0; i--)
+				destroy_stream(dice, AMDTP_OUT_STREAM, i);
+			for (i = 0; i < MAX_STREAMS; i++)
+				destroy_stream(dice, AMDTP_IN_STREAM, i);
+			break;
+		}
+	}
 end:
 	return err;
 }
 
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
+	unsigned int reg_params[4];
+
 	snd_dice_transaction_clear_enable(dice);
 
-	destroy_stream(dice, &dice->tx_stream[0]);
-	destroy_stream(dice, &dice->rx_stream[0]);
+	if (get_register_params(dice, reg_params) == 0) {
+		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
+			     reg_params[1]);
+		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
+			     reg_params[3]);
+	}
+
+	release_resources(dice);
 
 	dice->substreams_counter = 0;
 }
 
 void snd_dice_stream_update_duplex(struct snd_dice *dice)
 {
+	unsigned int reg_params[4];
+
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
 	 * off contemplating its own navel for hundreds of milliseconds before
@@ -363,11 +476,12 @@ void snd_dice_stream_update_duplex(struct snd_dice *dice)
 	 */
 	dice->global_enabled = false;
 
-	stop_stream(dice, &dice->rx_stream[0]);
-	stop_stream(dice, &dice->tx_stream[0]);
-
-	fw_iso_resources_update(&dice->rx_resources[0]);
-	fw_iso_resources_update(&dice->tx_resources[0]);
+	if (get_register_params(dice, reg_params) == 0) {
+		stop_streams(dice, AMDTP_IN_STREAM, reg_params[0],
+			     reg_params[1]);
+		stop_streams(dice, AMDTP_OUT_STREAM, reg_params[2],
+			     reg_params[3]);
+	}
 }
 
 static void dice_lock_changed(struct snd_dice *dice)
-- 
2.7.0
