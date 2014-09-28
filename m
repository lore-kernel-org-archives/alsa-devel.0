From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/13] ALSA: dice: Change the way to start
	stream
Date: Mon, 29 Sep 2014 00:58:19 +0900
Message-ID: <1411919903-10981-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8174B26058E
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:55 +0200 (CEST)
In-Reply-To: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Streaming functionality can start streams when rate is given but currently
some codes are in PCM functionality.

This commit changes the way to start stream and add some arrangement
to make it easy to understand the way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c    |  79 ++-------------
 sound/firewire/dice/dice-stream.c | 201 ++++++++++++++++++++++++++++----------
 sound/firewire/dice/dice.c        |  10 +-
 sound/firewire/dice/dice.h        |   4 +-
 4 files changed, 157 insertions(+), 137 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 2e531bd..904cb80 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -169,74 +169,18 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
-	unsigned int mode, rate, channels, i;
-	int err;
-
-	mutex_lock(&dice->mutex);
-	snd_dice_stream_stop(dice);
-	mutex_unlock(&dice->mutex);
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
-
-	rate = params_rate(hw_params);
-	err = snd_dice_transaction_set_rate(dice, rate);
-	if (err < 0)
-		return err;
-
-	if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
-		return err;
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
-	channels = params_channels(hw_params);
-	if (mode > 1) {
-		if (channels > AMDTP_MAX_CHANNELS_FOR_PCM / 2) {
-			err = -ENOSYS;
-			return err;
-		}
-
-		rate /= 2;
-		channels *= 2;
-		dice->rx_stream.double_pcm_frames = true;
-	} else {
-		dice->rx_stream.double_pcm_frames = false;
-	}
-
-	amdtp_stream_set_parameters(&dice->rx_stream, rate, channels,
-				    dice->rx_midi_ports[mode]);
-	if (mode > 1) {
-		channels /= 2;
-
-		for (i = 0; i < channels; i++) {
-			dice->rx_stream.pcm_positions[i] = i * 2;
-			dice->rx_stream.pcm_positions[i + channels] = i * 2 + 1;
-		}
-	}
-
 	amdtp_stream_set_pcm_format(&dice->rx_stream,
 				    params_format(hw_params));
 
-	return 0;
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
 }
 
 static int playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
 
-	mutex_lock(&dice->mutex);
 	snd_dice_stream_stop(dice);
-	mutex_unlock(&dice->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
@@ -246,22 +190,11 @@ static int playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_dice *dice = substream->private_data;
 	int err;
 
-	mutex_lock(&dice->mutex);
-
-	if (amdtp_streaming_error(&dice->rx_stream))
-		snd_dice_stream_stop_packets(dice);
+	err = snd_dice_stream_start(dice, substream->runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&dice->rx_stream);
 
-	err = snd_dice_stream_start(dice);
-	if (err < 0) {
-		mutex_unlock(&dice->mutex);
-		return err;
-	}
-
-	mutex_unlock(&dice->mutex);
-
-	amdtp_stream_pcm_prepare(&dice->rx_stream);
-
-	return 0;
+	return err;
 }
 
 static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index ba8fe8d..25dcf64 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -9,6 +9,8 @@
 
 #include "dice.h"
 
+#define	CALLBACK_TIMEOUT	200
+
 const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	/* mode 0 */
 	[0] =  32000,
@@ -38,82 +40,170 @@ int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
 	return -EINVAL;
 }
 
-int snd_dice_stream_start_packets(struct snd_dice *dice)
+static void release_resources(struct snd_dice *dice)
+{
+	unsigned int channel;
+
+	/* Reset channel number */
+	channel = cpu_to_be32((u32)-1);
+	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
+
+	fw_iso_resources_free(&dice->rx_resources);
+}
+
+static int keep_resources(struct snd_dice *dice, unsigned int max_payload_bytes)
 {
+	unsigned int channel;
 	int err;
 
-	if (amdtp_stream_running(&dice->rx_stream))
-		return 0;
+	err = fw_iso_resources_allocate(&dice->rx_resources, max_payload_bytes,
+			fw_parent_device(dice->unit)->max_speed);
+	if (err < 0)
+		goto end;
 
-	err = amdtp_stream_start(&dice->rx_stream, dice->rx_resources.channel,
-				 fw_parent_device(dice->unit)->max_speed);
+	/* Set channel number */
+	channel = cpu_to_be32(dice->rx_resources.channel);
+	err = snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
+					    &channel, 4);
 	if (err < 0)
-		return err;
+		release_resources(dice);
+end:
+	return err;
+}
 
-	err = snd_dice_transaction_set_enable(dice);
-	if (err < 0) {
-		amdtp_stream_stop(&dice->rx_stream);
-		return err;
-	}
+static void stop_stream(struct snd_dice *dice)
+{
+	if (!amdtp_stream_running(&dice->rx_stream))
+		return;
 
-	return 0;
+	amdtp_stream_pcm_abort(&dice->rx_stream);
+	amdtp_stream_stop(&dice->rx_stream);
+	release_resources(dice);
 }
 
-int snd_dice_stream_start(struct snd_dice *dice)
+static int start_stream(struct snd_dice *dice, unsigned int rate)
 {
-	__be32 channel;
+	unsigned int i, mode, pcm_chs, midi_ports;
 	int err;
 
-	if (!dice->rx_resources.allocated) {
-		err = fw_iso_resources_allocate(&dice->rx_resources,
-				amdtp_stream_get_max_payload(&dice->rx_stream),
-				fw_parent_device(dice->unit)->max_speed);
-		if (err < 0)
-			goto error;
-
-		channel = cpu_to_be32(dice->rx_resources.channel);
-		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
-						    &channel, 4);
-		if (err < 0)
-			goto err_resources;
+	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
+	 * one data block of AMDTP packet. Thus sampling transfer frequency is
+	 * a half of PCM sampling frequency, i.e. PCM frames at 192.0 kHz are
+	 * transferred on AMDTP packets at 96 kHz. Two successive samples of a
+	 * channel are stored consecutively in the packet. This quirk is called
+	 * as 'Dual Wire'.
+	 * For this quirk, blocking mode is required and PCM buffer size should
+	 * be aligned to SYT_INTERVAL.
+	 */
+	pcm_chs = dice->rx_channels[mode];
+	midi_ports = dice->rx_midi_ports[mode];
+	if (mode > 1) {
+		rate /= 2;
+		pcm_chs *= 2;
+		dice->rx_stream.double_pcm_frames = true;
+	} else {
+		dice->rx_stream.double_pcm_frames = false;
 	}
 
-	err = snd_dice_stream_start_packets(dice);
-	if (err < 0)
-		goto err_rx_channel;
+	amdtp_stream_set_parameters(&dice->rx_stream, rate,
+				    pcm_chs, midi_ports);
+	if (mode > 1) {
+		pcm_chs /= 2;
 
-	return 0;
+		for (i = 0; i < pcm_chs; i++) {
+			dice->rx_stream.pcm_positions[i] = i * 2;
+			dice->rx_stream.pcm_positions[i + pcm_chs] = i * 2 + 1;
+		}
+	}
 
-err_rx_channel:
-	channel = cpu_to_be32((u32)-1);
-	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
-err_resources:
-	fw_iso_resources_free(&dice->rx_resources);
-error:
+	err = keep_resources(dice,
+			     amdtp_stream_get_max_payload(&dice->rx_stream));
+	if (err < 0) {
+		dev_err(&dice->unit->device,
+			"fail to keep isochronous resources\n");
+		goto end;
+	}
+
+	err = amdtp_stream_start(&dice->rx_stream, dice->rx_resources.channel,
+				 fw_parent_device(dice->unit)->max_speed);
+	if (err < 0)
+		release_resources(dice);
+end:
 	return err;
 }
 
-void snd_dice_stream_stop_packets(struct snd_dice *dice)
+int snd_dice_stream_start(struct snd_dice *dice, unsigned int rate)
 {
-	if (amdtp_stream_running(&dice->rx_stream)) {
+	unsigned int curr_rate;
+	int err;
+
+	mutex_lock(&dice->mutex);
+
+	/* Some packet queueing errors. */
+	if (amdtp_streaming_error(&dice->rx_stream))
+		stop_stream(dice);
+
+	/* Stop stream if rate is different. */
+	err = snd_dice_transaction_get_rate(dice, &curr_rate);
+	if (err < 0) {
+		dev_err(&dice->unit->device,
+			"fail to get sampling rate\n");
+		goto end;
+	}
+	if (rate != curr_rate)
+		stop_stream(dice);
+
+	if (!amdtp_stream_running(&dice->rx_stream)) {
 		snd_dice_transaction_clear_enable(dice);
-		amdtp_stream_stop(&dice->rx_stream);
+
+		err = snd_dice_transaction_set_rate(dice, rate);
+		if (err < 0) {
+			dev_err(&dice->unit->device,
+				"fail to set sampling rate\n");
+			goto end;
+		}
+
+		/* Start stream. */
+		err = start_stream(dice, rate);
+		if (err < 0) {
+			dev_err(&dice->unit->device,
+				"fail to start AMDTP stream\n");
+			goto end;
+		}
+		err = snd_dice_transaction_set_enable(dice);
+		if (err < 0) {
+			dev_err(&dice->unit->device,
+				"fail to enable interface\n");
+			stop_stream(dice);
+			goto end;
+		}
+
+		if (!amdtp_stream_wait_callback(&dice->rx_stream,
+						CALLBACK_TIMEOUT)) {
+			snd_dice_transaction_clear_enable(dice);
+			stop_stream(dice);
+			err = -ETIMEDOUT;
+		}
 	}
+
+end:
+	mutex_unlock(&dice->mutex);
+	return err;
 }
 
 void snd_dice_stream_stop(struct snd_dice *dice)
 {
-	__be32 channel;
+	mutex_lock(&dice->mutex);
 
-	snd_dice_stream_stop_packets(dice);
+	snd_dice_transaction_clear_enable(dice);
+	stop_stream(dice);
 
-	if (!dice->rx_resources.allocated)
-		return;
-
-	channel = cpu_to_be32((u32)-1);
-	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
-
-	fw_iso_resources_free(&dice->rx_resources);
+	mutex_unlock(&dice->mutex);
 }
 
 int snd_dice_stream_init(struct snd_dice *dice)
@@ -143,10 +233,14 @@ error:
 
 void snd_dice_stream_destroy(struct snd_dice *dice)
 {
-	amdtp_stream_pcm_abort(&dice->rx_stream);
-	snd_dice_stream_stop(dice);
+	mutex_lock(&dice->mutex);
+
+	snd_dice_transaction_clear_enable(dice);
+	stop_stream(dice);
 	amdtp_stream_destroy(&dice->rx_stream);
 	fw_iso_resources_destroy(&dice->rx_resources);
+
+	mutex_unlock(&dice->mutex);
 }
 
 void snd_dice_stream_update(struct snd_dice *dice)
@@ -159,9 +253,12 @@ void snd_dice_stream_update(struct snd_dice *dice)
 	 * to stop so that the application can restart them in an orderly
 	 * manner.
 	 */
-	amdtp_stream_pcm_abort(&dice->rx_stream);
-	snd_dice_stream_stop_packets(dice);
+	mutex_lock(&dice->mutex);
+
+	stop_stream(dice);
 	fw_iso_resources_update(&dice->rx_resources);
+
+	mutex_unlock(&dice->mutex);
 }
 
 static void dice_lock_changed(struct snd_dice *dice)
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 95befa9..ff445b4 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -304,12 +304,8 @@ static void dice_remove(struct fw_unit *unit)
 
 	snd_card_disconnect(dice->card);
 
-	mutex_lock(&dice->mutex);
-
 	snd_dice_stream_destroy(dice);
 
-	mutex_unlock(&dice->mutex);
-
 	snd_card_free_when_closed(dice->card);
 }
 
@@ -325,11 +321,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 	}
 	dice->global_enabled = false;
 
-	mutex_lock(&dice->mutex);
-
-	snd_dice_stream_stop_packets(dice);
-
-	mutex_unlock(&dice->mutex);
+	snd_dice_stream_update(dice);
 }
 
 #define DICE_INTERFACE	0x000001
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 969189a..8be530f 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -160,9 +160,7 @@ extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
 int snd_dice_stream_get_rate_mode(struct snd_dice *dice,
 				  unsigned int rate, unsigned int *mode);
 
-int snd_dice_stream_start_packets(struct snd_dice *dice);
-int snd_dice_stream_start(struct snd_dice *dice);
-void snd_dice_stream_stop_packets(struct snd_dice *dice);
+int snd_dice_stream_start(struct snd_dice *dice, unsigned int rate);
 void snd_dice_stream_stop(struct snd_dice *dice);
 int snd_dice_stream_init(struct snd_dice *dice);
 void snd_dice_stream_destroy(struct snd_dice *dice);
-- 
1.9.1
