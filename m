From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: dice: have two sets of isochronous
	resources/streams
Date: Sat,  5 Mar 2016 20:58:04 +0900
Message-ID: <1457179087-27604-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 79E892606F7
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

Currently ALSA dice driver handles a pair of isochronous resources for
IEC 61883-1/6 packet streaming. While, according to some documents about
ASICs named as 'Dice', several isochronous streams are available.

Here, I start to describe ASICs produced under 'Dice' name.
 * Dice II (designed by wavefront semiconductor, including TCAT's IP)
   * STD (with limited functionality of DTCP)
   * CP  (with full functionality of DTCP)
 * TCD2210/2210-E (so-called 'Dice Mini')
 * TCD2220/2220-E (so-called 'Dice Jr.')
 * TCD3070-CH (so-called 'Dice III')

Some documents are public and we can see hardware design of them. We can
find some articles about hardware internal register definitions
(not registers exported to IEEE 1394 bus).

* DICE II User Guide
  * http://www.tctechnologies.tc/archive/downloads/dice_ii_user_guide.pdf
    * 6.1 AVS Audio Receivers
      * Table 6.1: AVS Audio Receiver Memory Map
        * ARX1-ARX4
    * 6.2 AVS Audio Transmitters
      * Table 6.2: AVS Audio Transmitter Memory Map
        * ATX1, ATX2
* TCD22xx User Guide
  * http://www.tctechnologies.tc/downloads/tcd22xx_user_guide.pdf
    * 6.1 AVS Audio Receivers
      * Table 66: AVS Audio Receiver Memory Map
        * ARX1, ARX2
    * 6/2 AVS Audio Transmitters
      * Table 67: AVS Audio Transmitter Memory Map
        * ATX1, ATX2
* DICE III
  * http://www.tctechnologies.tc/downloads/TCD3070-CH.pdf
    * Dual stream 63 channel transmitter/receiver

For Dice II and TCD22xx series, maximum 16 data channels are transferred in
an AMDTP packet, while for Dice III, maximum 32 data channels are
transferred.

According to the design of the series of these ASICs, this commit allows
this driver to handle additional set of isochronous resources. For
practical reason, two pair of isochronous resources are added. As of this
commit, this driver still use a pair of the first isochronous resources.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c   |  8 +++---
 sound/firewire/dice/dice-pcm.c    | 34 ++++++++++++++----------
 sound/firewire/dice/dice-stream.c | 54 +++++++++++++++++++--------------------
 sound/firewire/dice/dice.h        | 31 +++++++++++++++++++---
 4 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index 2461311..a040617 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -52,10 +52,10 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&dice->lock, flags);
 
 	if (up)
-		amdtp_am824_midi_trigger(&dice->tx_stream,
+		amdtp_am824_midi_trigger(&dice->tx_stream[0],
 					  substrm->number, substrm);
 	else
-		amdtp_am824_midi_trigger(&dice->tx_stream,
+		amdtp_am824_midi_trigger(&dice->tx_stream[0],
 					  substrm->number, NULL);
 
 	spin_unlock_irqrestore(&dice->lock, flags);
@@ -69,10 +69,10 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&dice->lock, flags);
 
 	if (up)
-		amdtp_am824_midi_trigger(&dice->rx_stream,
+		amdtp_am824_midi_trigger(&dice->rx_stream[0],
 					 substrm->number, substrm);
 	else
-		amdtp_am824_midi_trigger(&dice->rx_stream,
+		amdtp_am824_midi_trigger(&dice->rx_stream[0],
 					 substrm->number, NULL);
 
 	spin_unlock_irqrestore(&dice->lock, flags);
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index a5c9b58..e252949 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -22,7 +22,7 @@ static int limit_channels_and_rates(struct snd_dice *dice,
 	 * Retrieve current Multi Bit Linear Audio data channel and limit to
 	 * it.
 	 */
-	if (stream == &dice->tx_stream) {
+	if (stream == &dice->tx_stream[0]) {
 		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
 						   reg, sizeof(reg));
 	} else {
@@ -74,10 +74,10 @@ static int init_hw_info(struct snd_dice *dice,
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw->formats = AM824_IN_PCM_FORMAT_BITS;
-		stream = &dice->tx_stream;
+		stream = &dice->tx_stream[0];
 	} else {
 		hw->formats = AM824_OUT_PCM_FORMAT_BITS;
-		stream = &dice->rx_stream;
+		stream = &dice->rx_stream[0];
 	}
 
 	err = limit_channels_and_rates(dice, runtime, stream);
@@ -122,6 +122,7 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->tx_stream[0];
 	int err;
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -135,7 +136,7 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&dice->tx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(stream, params_format(hw_params));
 
 	return 0;
 }
@@ -143,6 +144,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->rx_stream[0];
 	int err;
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -156,7 +158,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&dice->rx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(stream, params_format(hw_params));
 
 	return 0;
 }
@@ -196,26 +198,28 @@ static int playback_hw_free(struct snd_pcm_substream *substream)
 static int capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->tx_stream[0];
 	int err;
 
 	mutex_lock(&dice->mutex);
 	err = snd_dice_stream_start_duplex(dice, substream->runtime->rate);
 	mutex_unlock(&dice->mutex);
 	if (err >= 0)
-		amdtp_stream_pcm_prepare(&dice->tx_stream);
+		amdtp_stream_pcm_prepare(stream);
 
 	return 0;
 }
 static int playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->rx_stream[0];
 	int err;
 
 	mutex_lock(&dice->mutex);
 	err = snd_dice_stream_start_duplex(dice, substream->runtime->rate);
 	mutex_unlock(&dice->mutex);
 	if (err >= 0)
-		amdtp_stream_pcm_prepare(&dice->rx_stream);
+		amdtp_stream_pcm_prepare(stream);
 
 	return err;
 }
@@ -223,13 +227,14 @@ static int playback_prepare(struct snd_pcm_substream *substream)
 static int capture_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->tx_stream[0];
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		amdtp_stream_pcm_trigger(&dice->tx_stream, substream);
+		amdtp_stream_pcm_trigger(stream, substream);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		amdtp_stream_pcm_trigger(&dice->tx_stream, NULL);
+		amdtp_stream_pcm_trigger(stream, NULL);
 		break;
 	default:
 		return -EINVAL;
@@ -240,13 +245,14 @@ static int capture_trigger(struct snd_pcm_substream *substream, int cmd)
 static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->rx_stream[0];
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		amdtp_stream_pcm_trigger(&dice->rx_stream, substream);
+		amdtp_stream_pcm_trigger(stream, substream);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		amdtp_stream_pcm_trigger(&dice->rx_stream, NULL);
+		amdtp_stream_pcm_trigger(stream, NULL);
 		break;
 	default:
 		return -EINVAL;
@@ -258,14 +264,16 @@ static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
 static snd_pcm_uframes_t capture_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->tx_stream[0];
 
-	return amdtp_stream_pcm_pointer(&dice->tx_stream);
+	return amdtp_stream_pcm_pointer(stream);
 }
 static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->rx_stream[0];
 
-	return amdtp_stream_pcm_pointer(&dice->rx_stream);
+	return amdtp_stream_pcm_pointer(stream);
 }
 
 int snd_dice_create_pcm(struct snd_dice *dice)
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index df035b1..15d581d 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -72,7 +72,7 @@ static void release_resources(struct snd_dice *dice,
 
 	/* Reset channel number */
 	channel = cpu_to_be32((u32)-1);
-	if (resources == &dice->tx_resources)
+	if (resources == &dice->tx_resources[0])
 		snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
 					      &channel, sizeof(channel));
 	else
@@ -96,7 +96,7 @@ static int keep_resources(struct snd_dice *dice,
 
 	/* Set channel number */
 	channel = cpu_to_be32(resources->channel);
-	if (resources == &dice->tx_resources)
+	if (resources == &dice->tx_resources[0])
 		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
 						    &channel, sizeof(channel));
 	else
@@ -113,10 +113,10 @@ static void stop_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 	amdtp_stream_pcm_abort(stream);
 	amdtp_stream_stop(stream);
 
-	if (stream == &dice->tx_stream)
-		release_resources(dice, &dice->tx_resources);
+	if (stream == &dice->tx_stream[0])
+		release_resources(dice, &dice->tx_resources[0]);
 	else
-		release_resources(dice, &dice->rx_resources);
+		release_resources(dice, &dice->rx_resources[0]);
 }
 
 static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
@@ -128,12 +128,12 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 	bool double_pcm_frames;
 	int err;
 
-	if (stream == &dice->tx_stream) {
-		resources = &dice->tx_resources;
+	if (stream == &dice->tx_stream[0]) {
+		resources = &dice->tx_resources[0];
 		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
 						   reg, sizeof(reg));
 	} else {
-		resources = &dice->rx_resources;
+		resources = &dice->rx_resources[0];
 		err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
 						   reg, sizeof(reg));
 	}
@@ -200,8 +200,8 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	if (dice->substreams_counter == 0)
 		goto end;
 
-	master = &dice->rx_stream;
-	slave  = &dice->tx_stream;
+	master = &dice->rx_stream[0];
+	slave  = &dice->tx_stream[0];
 
 	/* Some packet queueing errors. */
 	if (amdtp_streaming_error(master) || amdtp_streaming_error(slave))
@@ -275,8 +275,8 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 
 	snd_dice_transaction_clear_enable(dice);
 
-	stop_stream(dice, &dice->tx_stream);
-	stop_stream(dice, &dice->rx_stream);
+	stop_stream(dice, &dice->tx_stream[0]);
+	stop_stream(dice, &dice->rx_stream[0]);
 }
 
 static int init_stream(struct snd_dice *dice, struct amdtp_stream *stream)
@@ -285,11 +285,11 @@ static int init_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 	struct fw_iso_resources *resources;
 	enum amdtp_stream_direction dir;
 
-	if (stream == &dice->tx_stream) {
-		resources = &dice->tx_resources;
+	if (stream == &dice->tx_stream[0]) {
+		resources = &dice->tx_resources[0];
 		dir = AMDTP_IN_STREAM;
 	} else {
-		resources = &dice->rx_resources;
+		resources = &dice->rx_resources[0];
 		dir = AMDTP_OUT_STREAM;
 	}
 
@@ -315,10 +315,10 @@ static void destroy_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 {
 	struct fw_iso_resources *resources;
 
-	if (stream == &dice->tx_stream)
-		resources = &dice->tx_resources;
+	if (stream == &dice->tx_stream[0])
+		resources = &dice->tx_resources[0];
 	else
-		resources = &dice->rx_resources;
+		resources = &dice->rx_resources[0];
 
 	amdtp_stream_destroy(stream);
 	fw_iso_resources_destroy(resources);
@@ -330,13 +330,13 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice)
 
 	dice->substreams_counter = 0;
 
-	err = init_stream(dice, &dice->tx_stream);
+	err = init_stream(dice, &dice->tx_stream[0]);
 	if (err < 0)
 		goto end;
 
-	err = init_stream(dice, &dice->rx_stream);
+	err = init_stream(dice, &dice->rx_stream[0]);
 	if (err < 0)
-		destroy_stream(dice, &dice->tx_stream);
+		destroy_stream(dice, &dice->tx_stream[0]);
 end:
 	return err;
 }
@@ -345,8 +345,8 @@ void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
 	snd_dice_transaction_clear_enable(dice);
 
-	destroy_stream(dice, &dice->tx_stream);
-	destroy_stream(dice, &dice->rx_stream);
+	destroy_stream(dice, &dice->tx_stream[0]);
+	destroy_stream(dice, &dice->rx_stream[0]);
 
 	dice->substreams_counter = 0;
 }
@@ -363,11 +363,11 @@ void snd_dice_stream_update_duplex(struct snd_dice *dice)
 	 */
 	dice->global_enabled = false;
 
-	stop_stream(dice, &dice->rx_stream);
-	stop_stream(dice, &dice->tx_stream);
+	stop_stream(dice, &dice->rx_stream[0]);
+	stop_stream(dice, &dice->tx_stream[0]);
 
-	fw_iso_resources_update(&dice->rx_resources);
-	fw_iso_resources_update(&dice->tx_resources);
+	fw_iso_resources_update(&dice->rx_resources[0]);
+	fw_iso_resources_update(&dice->tx_resources[0]);
 }
 
 static void dice_lock_changed(struct snd_dice *dice)
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 423cdba..8fba87d 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -39,6 +39,29 @@
 #include "../lib.h"
 #include "dice-interface.h"
 
+/*
+ * This module support maximum 2 pairs of tx/rx isochronous streams for
+ * our convinience.
+ *
+ * In documents for ASICs called with a name of 'DICE':
+ *  - ASIC for DICE II:
+ *   - Maximum 2 tx and 4 rx are supported.
+ *   - A packet supports maximum 16 data channels.
+ *  - TCD2210/2210-E (so-called 'Dice Mini'):
+ *   - Maximum 2 tx and 2 rx are supported.
+ *   - A packet supports maximum 16 data channels.
+ *  - TCD2220/2220-E (so-called 'Dice Jr.')
+ *   - 2 tx and 2 rx are supported.
+ *   - A packet supports maximum 16 data channels.
+ *  - TCD3070-CH (so-called 'Dice III')
+ *   - Maximum 2 tx and 2 rx are supported.
+ *   - A packet supports maximum 32 data channels.
+ *
+ * For the above, MIDI conformant data channel is just on the first isochronous
+ * stream.
+ */
+#define MAX_STREAMS	2
+
 struct snd_dice {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -67,10 +90,10 @@ struct snd_dice {
 	wait_queue_head_t hwdep_wait;
 
 	/* For streaming */
-	struct fw_iso_resources tx_resources;
-	struct fw_iso_resources rx_resources;
-	struct amdtp_stream tx_stream;
-	struct amdtp_stream rx_stream;
+	struct fw_iso_resources tx_resources[MAX_STREAMS];
+	struct fw_iso_resources rx_resources[MAX_STREAMS];
+	struct amdtp_stream tx_stream[MAX_STREAMS];
+	struct amdtp_stream rx_stream[MAX_STREAMS];
 	bool global_enabled;
 	struct completion clock_accepted;
 	unsigned int substreams_counter;
-- 
2.7.0
