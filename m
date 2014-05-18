From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/13] dice: Add support for duplex streams
	with synchronization
Date: Sun, 18 May 2014 22:36:35 +0900
Message-ID: <1400420198-24312-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 11FCC264F47
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 15:36:59 +0200 (CEST)
In-Reply-To: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds support for AMDTP in-stream. As a result, Dice driver
supports full duplex streams with synchronization.

When Dice chipset is 'enabled', it starts stream with correct settings.
And 'enabling' is global setting. So, when a stream is running, an opposite
stream can't start unless turning off 'enabling'. So a pair of streams must
be running. This is a loss of CPU usage when single stream is required.

Currently, sampling clock source is restricted to SYT-Match mode. This is
improved in followed commit. I note that at SYT-Match mode, Dice can select
from 4 streams for synchronization but this driver just uses the 1st stream
for simplicity.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c        |  18 ++-
 sound/firewire/dice/dice.h        |  26 +++--
 sound/firewire/dice/dice_pcm.c    |   4 +-
 sound/firewire/dice/dice_stream.c | 227 ++++++++++++++++++++++++++++----------
 4 files changed, 202 insertions(+), 73 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 33c5253..6e849e0 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -141,6 +141,8 @@ static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
 	int err;
 
 	if (highest_supported_mode_rate(dice, mode, &rate) < 0) {
+		dice->tx_channels[mode] = 0;
+		dice->tx_midi_ports[mode] = 0;
 		dice->rx_channels[mode] = 0;
 		dice->rx_midi_ports[mode] = 0;
 		return 0;
@@ -150,6 +152,14 @@ static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
 	if (err < 0)
 		return err;
 
+	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
+					   values, 2 * 4);
+	if (err < 0)
+		return err;
+
+	dice->tx_channels[mode]   = be32_to_cpu(values[0]);
+	dice->tx_midi_ports[mode] = be32_to_cpu(values[1]);
+
 	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
 					   values, 2 * 4);
 	if (err < 0)
@@ -279,13 +289,13 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	snd_dice_create_proc(dice);
 
-	err = snd_dice_stream_init(dice);
+	err = snd_dice_stream_init_duplex(dice);
 	if (err < 0)
 		goto error;
 
 	err = snd_card_register(card);
 	if (err < 0) {
-		snd_dice_stream_destroy(dice);
+		snd_dice_stream_destroy_duplex(dice);
 		goto error;
 	}
 
@@ -303,7 +313,7 @@ static void dice_remove(struct fw_unit *unit)
 
 	snd_card_disconnect(dice->card);
 
-	snd_dice_stream_destroy(dice);
+	snd_dice_stream_destroy_duplex(dice);
 
 	snd_card_free_when_closed(dice->card);
 }
@@ -320,7 +330,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 	}
 	dice->global_enabled = false;
 
-	snd_dice_stream_update(dice);
+	snd_dice_stream_update_duplex(dice);
 }
 
 #define DICE_INTERFACE	0x000001
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 8be530f..a868485 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -52,18 +52,28 @@ struct snd_dice {
 	unsigned int rsrv_offset;
 
 	unsigned int clock_caps;
+	unsigned int tx_channels[3];
 	unsigned int rx_channels[3];
+	unsigned int tx_midi_ports[3];
 	unsigned int rx_midi_ports[3];
+
 	struct fw_address_handler notification_handler;
 	int owner_generation;
+	u32 notification_bits;
+
+	/* For uapi */
 	int dev_lock_count; /* > 0 driver, < 0 userspace */
 	bool dev_lock_changed;
-	bool global_enabled;
-	struct completion clock_accepted;
 	wait_queue_head_t hwdep_wait;
-	u32 notification_bits;
+
+	/* For streaming */
+	struct fw_iso_resources tx_resources;
 	struct fw_iso_resources rx_resources;
+	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
+	bool global_enabled;
+	struct completion clock_accepted;
+	atomic_t substreams_counter;
 };
 
 enum snd_dice_addr_type {
@@ -160,11 +170,11 @@ extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
 int snd_dice_stream_get_rate_mode(struct snd_dice *dice,
 				  unsigned int rate, unsigned int *mode);
 
-int snd_dice_stream_start(struct snd_dice *dice, unsigned int rate);
-void snd_dice_stream_stop(struct snd_dice *dice);
-int snd_dice_stream_init(struct snd_dice *dice);
-void snd_dice_stream_destroy(struct snd_dice *dice);
-void snd_dice_stream_update(struct snd_dice *dice);
+int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate);
+void snd_dice_stream_stop_duplex(struct snd_dice *dice);
+int snd_dice_stream_init_duplex(struct snd_dice *dice);
+void snd_dice_stream_destroy_duplex(struct snd_dice *dice);
+void snd_dice_stream_update_duplex(struct snd_dice *dice);
 
 int snd_dice_stream_lock_try(struct snd_dice *dice);
 void snd_dice_stream_lock_release(struct snd_dice *dice);
diff --git a/sound/firewire/dice/dice_pcm.c b/sound/firewire/dice/dice_pcm.c
index 79958e5..414c1c6 100644
--- a/sound/firewire/dice/dice_pcm.c
+++ b/sound/firewire/dice/dice_pcm.c
@@ -181,7 +181,7 @@ static int playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
 
-	snd_dice_stream_stop(dice);
+	snd_dice_stream_stop_duplex(dice);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
@@ -191,7 +191,7 @@ static int playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_dice *dice = substream->private_data;
 	int err;
 
-	err = snd_dice_stream_start(dice, substream->runtime->rate);
+	err = snd_dice_stream_start_duplex(dice, substream->runtime->rate);
 	if (err >= 0)
 		amdtp_stream_pcm_prepare(&dice->rx_stream);
 
diff --git a/sound/firewire/dice/dice_stream.c b/sound/firewire/dice/dice_stream.c
index ed5c961..d8b2ca6 100644
--- a/sound/firewire/dice/dice_stream.c
+++ b/sound/firewire/dice/dice_stream.c
@@ -40,52 +40,79 @@ int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
 	return -EINVAL;
 }
 
-static void release_resources(struct snd_dice *dice)
+static void release_resources(struct snd_dice *dice,
+			      struct fw_iso_resources *resources)
 {
 	unsigned int channel;
 
 	/* Reset channel number */
 	channel = cpu_to_be32((u32)-1);
-	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
-
-	fw_iso_resources_free(&dice->rx_resources);
+	if (resources == &dice->tx_resources)
+		snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
+					      &channel, 4);
+	else
+		snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
+					      &channel, 4);
+
+	fw_iso_resources_free(resources);
 }
 
-static int keep_resources(struct snd_dice *dice, unsigned int max_payload_bytes)
+static int keep_resources(struct snd_dice *dice,
+			  struct fw_iso_resources *resources,
+			  unsigned int max_payload_bytes)
 {
 	unsigned int channel;
 	int err;
 
-	err = fw_iso_resources_allocate(&dice->rx_resources, max_payload_bytes,
-			fw_parent_device(dice->unit)->max_speed);
+	err = fw_iso_resources_allocate(resources, max_payload_bytes,
+				fw_parent_device(dice->unit)->max_speed);
 	if (err < 0)
 		goto end;
 
 	/* Set channel number */
-	channel = cpu_to_be32(dice->rx_resources.channel);
-	err = snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
-					    &channel, 4);
+	channel = cpu_to_be32(resources->channel);
+	if (resources == &dice->tx_resources)
+		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
+						    &channel, 4);
+	else
+		err = snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
+						    &channel, 4);
 	if (err < 0)
-		release_resources(dice);
+		release_resources(dice, resources);
 end:
 	return err;
 }
 
-static void stop_stream(struct snd_dice *dice)
+static void stop_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 {
-	amdtp_stream_pcm_abort(&dice->rx_stream);
-	amdtp_stream_stop(&dice->rx_stream);
-	release_resources(dice);
+	amdtp_stream_pcm_abort(stream);
+	amdtp_stream_stop(stream);
+
+	if (stream == &dice->tx_stream)
+		release_resources(dice, &dice->tx_resources);
+	else
+		release_resources(dice, &dice->rx_resources);
 }
 
-static int start_stream(struct snd_dice *dice, unsigned int rate)
+static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
+			unsigned int rate)
 {
+	struct fw_iso_resources *resources;
 	unsigned int i, mode, pcm_chs, midi_ports;
 	int err;
 
 	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
 	if (err < 0)
 		goto end;
+	if (stream == &dice->tx_stream) {
+		resources = &dice->tx_resources;
+		pcm_chs = dice->tx_channels[mode];
+		midi_ports = dice->tx_midi_ports[mode];
+	} else {
+		resources = &dice->rx_resources;
+		pcm_chs = dice->rx_channels[mode];
+		midi_ports = dice->rx_midi_ports[mode];
+	}
 
 	/*
 	 * At rates above 96 kHz, pretend that the stream runs at half the
@@ -93,47 +120,67 @@ static int start_stream(struct snd_dice *dice, unsigned int rate)
 	 * of a channel are stored consecutively in the packet. Requires
 	 * blocking mode and PCM buffer size should be aligned to SYT_INTERVAL.
 	 */
-	pcm_chs = dice->rx_channels[mode];
-	midi_ports = dice->rx_midi_ports[mode];
 	if (mode >= 2) {
 		for (i = 0; i < pcm_chs; i++) {
-			dice->rx_stream.pcm_positions[i * 2] = i;
-			dice->rx_stream.pcm_positions[i * 2 + 1] = i + pcm_chs;
+			stream->pcm_positions[i * 2] = i;
+			stream->pcm_positions[i * 2 + 1] = i + pcm_chs;
 		}
 
 		rate /= 2;
 		pcm_chs *= 2;
 	}
 
-	amdtp_stream_set_parameters(&dice->rx_stream, rate,
-				    pcm_chs, midi_ports);
+	amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports);
 
-	err = keep_resources(dice,
-			     amdtp_stream_get_max_payload(&dice->rx_stream));
+	err = keep_resources(dice, resources,
+			     amdtp_stream_get_max_payload(stream));
 	if (err < 0) {
 		dev_err(&dice->unit->device,
 			"fail to keep isochronous resources\n");
 		goto end;
 	}
 
-	err = amdtp_stream_start(&dice->rx_stream, dice->rx_resources.channel,
+	err = amdtp_stream_start(stream, resources->channel,
 				 fw_parent_device(dice->unit)->max_speed);
 	if (err < 0)
-		release_resources(dice);
+		release_resources(dice, resources);
 end:
 	return err;
 }
 
-int snd_dice_stream_start(struct snd_dice *dice, unsigned int rate)
+static int get_sync_mode(struct snd_dice *dice, enum cip_flags *sync_mode)
 {
+	/* Currently, clock source is fixed at SYT-Match mode. */
+	*sync_mode = 0;
+	return 0;
+}
+
+int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
+{
+	struct amdtp_stream *master, *slave;
 	unsigned int curr_rate;
-	int err;
+	enum cip_flags sync_mode;
+	int err = 0;
+
+	if (atomic_read(&dice->substreams_counter) == 0)
+		goto end;
 
 	mutex_lock(&dice->mutex);
 
+	err = get_sync_mode(dice, &sync_mode);
+	if (err < 0)
+		goto end;
+	if (sync_mode == CIP_SYNC_TO_DEVICE) {
+		master = &dice->tx_stream;
+		slave  = &dice->rx_stream;
+	} else {
+		master = &dice->rx_stream;
+		slave  = &dice->tx_stream;
+	}
+
 	/* Some packet queueing errors. */
-	if (amdtp_streaming_error(&dice->rx_stream))
-		stop_stream(dice);
+	if (amdtp_streaming_error(master) || amdtp_streaming_error(slave))
+		stop_stream(dice, slave);
 
 	/* Stop stream if rate is different. */
 	err = snd_dice_transaction_get_rate(dice, &curr_rate);
@@ -143,11 +190,17 @@ int snd_dice_stream_start(struct snd_dice *dice, unsigned int rate)
 		goto end;
 	}
 	if (rate != curr_rate)
-		stop_stream(dice);
+		stop_stream(dice, slave);
 
-	if (!amdtp_stream_running(&dice->rx_stream)) {
+	if (!amdtp_stream_running(slave))
+		stop_stream(dice, master);
+
+	if (!amdtp_stream_running(master)) {
+		stop_stream(dice, slave);
 		snd_dice_transaction_clear_enable(dice);
 
+		amdtp_stream_set_sync(sync_mode, master, slave);
+
 		err = snd_dice_transaction_set_rate(dice, rate);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
@@ -155,82 +208,135 @@ int snd_dice_stream_start(struct snd_dice *dice, unsigned int rate)
 			goto end;
 		}
 
-		/* Start stream. */
-		err = start_stream(dice, rate);
+		/* Start both streams. */
+		err = start_stream(dice, master, rate);
+		if (err < 0) {
+			dev_err(&dice->unit->device,
+				"fail to start AMDTP master stream\n");
+			goto end;
+		}
+		err = start_stream(dice, slave, rate);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
-				"fail to start AMDTP stream\n");
+				"fail to start AMDTP slave stream\n");
+			stop_stream(dice, master);
 			goto end;
 		}
 		err = snd_dice_transaction_set_enable(dice);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
 				"fail to enable interface\n");
-			stop_stream(dice);
+			stop_stream(dice, slave);
+			stop_stream(dice, master);
 			goto end;
 		}
 
-		if (!amdtp_stream_wait_callback(&dice->rx_stream,
-						CALLBACK_TIMEOUT)) {
+		/* Wait first callbacks */
+		if (!amdtp_stream_wait_callback(master, CALLBACK_TIMEOUT) ||
+		    !amdtp_stream_wait_callback(slave, CALLBACK_TIMEOUT)) {
 			snd_dice_transaction_clear_enable(dice);
-			stop_stream(dice);
+			stop_stream(dice, master);
+			stop_stream(dice, slave);
 			err = -ETIMEDOUT;
 		}
 	}
-
 end:
 	mutex_unlock(&dice->mutex);
 	return err;
 }
 
-void snd_dice_stream_stop(struct snd_dice *dice)
+void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 {
+	if (atomic_read(&dice->substreams_counter) > 0)
+		return;
+
 	mutex_lock(&dice->mutex);
 
 	snd_dice_transaction_clear_enable(dice);
-	stop_stream(dice);
+
+	stop_stream(dice, &dice->tx_stream);
+	stop_stream(dice, &dice->rx_stream);
 
 	mutex_unlock(&dice->mutex);
 }
 
-int snd_dice_stream_init(struct snd_dice *dice)
+static int init_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 {
 	int err;
+	struct fw_iso_resources *resources;
 
-	err = fw_iso_resources_init(&dice->rx_resources, dice->unit);
+	if (stream == &dice->tx_stream)
+		resources = &dice->tx_resources;
+	else
+		resources = &dice->rx_resources;
+
+	err = fw_iso_resources_init(resources, dice->unit);
 	if (err < 0)
 		goto end;
-	dice->rx_resources.channels_mask = 0x00000000ffffffffuLL;
+	resources->channels_mask = 0x00000000ffffffffuLL;
 
-	err = amdtp_stream_init(&dice->rx_stream, dice->unit, AMDTP_OUT_STREAM,
+	err = amdtp_stream_init(stream, dice->unit, AMDTP_OUT_STREAM,
 				CIP_BLOCKING);
+	if (err < 0) {
+		amdtp_stream_destroy(stream);
+		fw_iso_resources_destroy(resources);
+	}
+end:
+	return err;
+}
+
+static void destroy_stream(struct snd_dice *dice, struct amdtp_stream *stream)
+{
+	amdtp_stream_destroy(stream);
+
+	if (stream == &dice->tx_stream)
+		fw_iso_resources_destroy(&dice->rx_resources);
+	else
+		fw_iso_resources_destroy(&dice->rx_resources);
+}
+
+int snd_dice_stream_init_duplex(struct snd_dice *dice)
+{
+	int err;
+
+	atomic_set(&dice->substreams_counter, 0);
+
+	err = init_stream(dice, &dice->tx_stream);
 	if (err < 0)
-		goto error;
+		goto end;
 
-	err = snd_dice_transaction_set_clock_source(dice, CLOCK_SOURCE_ARX1);
+	err = init_stream(dice, &dice->rx_stream);
 	if (err < 0)
-		goto error;
+		goto end;
+
+	/* Currently, clock source is fixed at SYT-Match mode. */
+	err = snd_dice_transaction_set_clock_source(dice, CLOCK_SOURCE_ARX1);
+	if (err < 0) {
+		destroy_stream(dice, &dice->rx_stream);
+		destroy_stream(dice, &dice->tx_stream);
+	}
 end:
 	return err;
-error:
-	amdtp_stream_destroy(&dice->rx_stream);
-	fw_iso_resources_destroy(&dice->rx_resources);
-	return err;
 }
 
-void snd_dice_stream_destroy(struct snd_dice *dice)
+void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
 	mutex_lock(&dice->mutex);
 
 	snd_dice_transaction_clear_enable(dice);
-	stop_stream(dice);
-	amdtp_stream_destroy(&dice->rx_stream);
-	fw_iso_resources_destroy(&dice->rx_resources);
+
+	stop_stream(dice, &dice->tx_stream);
+	destroy_stream(dice, &dice->tx_stream);
+
+	stop_stream(dice, &dice->rx_stream);
+	destroy_stream(dice, &dice->rx_stream);
+
+	atomic_set(&dice->substreams_counter, 0);
 
 	mutex_unlock(&dice->mutex);
 }
 
-void snd_dice_stream_update(struct snd_dice *dice)
+void snd_dice_stream_update_duplex(struct snd_dice *dice)
 {
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
@@ -242,7 +348,10 @@ void snd_dice_stream_update(struct snd_dice *dice)
 	 */
 	mutex_lock(&dice->mutex);
 
-	stop_stream(dice);
+	stop_stream(dice, &dice->tx_stream);
+	stop_stream(dice, &dice->rx_stream);
+
+	fw_iso_resources_update(&dice->tx_resources);
 	fw_iso_resources_update(&dice->rx_resources);
 
 	mutex_unlock(&dice->mutex);
-- 
1.8.3.2
