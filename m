From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/30] ALSA: dice: Add support for capturing
	PCM samples
Date: Sat, 29 Nov 2014 00:59:22 +0900
Message-ID: <1417190379-4172-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id DB99E2604E2
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:51 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds a support for capturing PCM samples.

When opposite PCM substream is already running, available sampling rate is
limited at current one.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig         |   3 -
 sound/firewire/dice/dice-pcm.c | 163 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 149 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 46dff64..c8e704c 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -20,9 +20,6 @@ config SND_DICE
 	  Say Y here to include support for many DACs based on the DICE
 	  chip family (DICE-II/Jr/Mini) from TC Applied Technologies.
 
-	  At the moment, this driver supports playback only.  If you
-	  want to use devices that support capturing, use FFADO instead.
-
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-dice.
 
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 062b7a3..ec1d568 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -12,7 +12,8 @@
 static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
-	struct snd_dice *dice = rule->private;
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_dice *dice = substream->private_data;
 
 	const struct snd_interval *c =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
@@ -21,7 +22,12 @@ static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 	struct snd_interval rates = {
 		.min = UINT_MAX, .max = 0, .integer = 1
 	};
-	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
+	unsigned int i, rate, mode, *pcm_channels;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_channels = dice->tx_channels;
+	else
+		pcm_channels = dice->rx_channels;
 
 	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
 		rate = snd_dice_rates[i];
@@ -41,7 +47,8 @@ static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 static int dice_channels_constraint(struct snd_pcm_hw_params *params,
 				    struct snd_pcm_hw_rule *rule)
 {
-	struct snd_dice *dice = rule->private;
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_dice *dice = substream->private_data;
 
 	const struct snd_interval *r =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
@@ -50,7 +57,12 @@ static int dice_channels_constraint(struct snd_pcm_hw_params *params,
 	struct snd_interval channels = {
 		.min = UINT_MAX, .max = 0, .integer = 1
 	};
-	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
+	unsigned int i, rate, mode, *pcm_channels;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_channels = dice->tx_channels;
+	else
+		pcm_channels = dice->rx_channels;
 
 	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
 		rate = snd_dice_rates[i];
@@ -109,30 +121,42 @@ static int init_hw_info(struct snd_dice *dice,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
+	struct amdtp_stream *stream;
+	unsigned int *pcm_channels;
 	int err;
 
 	hw->info = SNDRV_PCM_INFO_MMAP |
 		   SNDRV_PCM_INFO_MMAP_VALID |
 		   SNDRV_PCM_INFO_BATCH |
 		   SNDRV_PCM_INFO_INTERLEAVED |
+		   SNDRV_PCM_INFO_JOINT_DUPLEX |
 		   SNDRV_PCM_INFO_BLOCK_TRANSFER;
-	hw->formats = AMDTP_OUT_PCM_FORMAT_BITS;
 
-	limit_channels_and_rates(dice, runtime, dice->rx_channels);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		hw->formats = AMDTP_IN_PCM_FORMAT_BITS;
+		stream = &dice->tx_stream;
+		pcm_channels = dice->tx_channels;
+	} else {
+		hw->formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		stream = &dice->rx_stream;
+		pcm_channels = dice->rx_channels;
+	}
+
+	limit_channels_and_rates(dice, runtime, pcm_channels);
 	limit_period_and_buffer(hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  dice_rate_constraint, dice,
+				  dice_rate_constraint, substream,
 				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		goto end;
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				  dice_channels_constraint, dice,
+				  dice_channels_constraint, substream,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(&dice->rx_stream, runtime);
+	err = amdtp_stream_add_pcm_hw_constraints(stream, runtime);
 end:
 	return err;
 }
@@ -172,10 +196,12 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	}
 
 	/*
-	 * When source of clock is not internal, available sampling rate is
-	 * limited at current sampling rate.
+	 * When source of clock is not internal or any PCM streams are running,
+	 * available sampling rate is limited at current sampling rate.
 	 */
-	if (!internal) {
+	if (!internal ||
+	    amdtp_stream_pcm_running(&dice->tx_stream) ||
+	    amdtp_stream_pcm_running(&dice->rx_stream)) {
 		err = snd_dice_transaction_get_rate(dice, &rate);
 		if (err < 0)
 			goto err_locked;
@@ -200,10 +226,36 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int capture_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	mutex_lock(&dice->mutex);
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		dice->substreams_counter++;
+
+	mutex_unlock(&dice->mutex);
+
+	amdtp_stream_set_pcm_format(&dice->tx_stream,
+				    params_format(hw_params));
+
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
 static int playback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
+
+	mutex_lock(&dice->mutex);
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		dice->substreams_counter++;
+
+	mutex_unlock(&dice->mutex);
+
 	amdtp_stream_set_pcm_format(&dice->rx_stream,
 				    params_format(hw_params));
 
@@ -211,17 +263,51 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 						params_buffer_bytes(hw_params));
 }
 
+static int capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	mutex_lock(&dice->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		dice->substreams_counter--;
+
+	snd_dice_stream_stop_duplex(dice);
+
+	mutex_unlock(&dice->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
 static int playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
 
 	mutex_lock(&dice->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		dice->substreams_counter--;
+
 	snd_dice_stream_stop_duplex(dice);
+
 	mutex_unlock(&dice->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
+static int capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+	int err;
+
+	mutex_lock(&dice->mutex);
+	err = snd_dice_stream_start_duplex(dice, substream->runtime->rate);
+	mutex_unlock(&dice->mutex);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&dice->tx_stream);
+
+	return 0;
+}
 static int playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
@@ -236,6 +322,23 @@ static int playback_prepare(struct snd_pcm_substream *substream)
 	return err;
 }
 
+static int capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&dice->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&dice->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dice *dice = substream->private_data;
@@ -254,6 +357,12 @@ static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
+static snd_pcm_uframes_t capture_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	return amdtp_stream_pcm_pointer(&dice->tx_stream);
+}
 static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
@@ -263,6 +372,18 @@ static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 
 int snd_dice_create_pcm(struct snd_dice *dice)
 {
+	static struct snd_pcm_ops capture_ops = {
+		.open      = pcm_open,
+		.close     = pcm_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = capture_hw_params,
+		.hw_free   = capture_hw_free,
+		.prepare   = capture_prepare,
+		.trigger   = capture_trigger,
+		.pointer   = capture_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
 	static struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
@@ -276,14 +397,28 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
+	unsigned int i, capture, playback;
 	int err;
 
-	err = snd_pcm_new(dice->card, "DICE", 0, 1, 0, &pcm);
+	capture = playback = 0;
+	for (i = 0; i < 3; i++) {
+		if (dice->tx_channels[i] > 0)
+			capture = 1;
+		if (dice->rx_channels[i] > 0)
+			playback = 1;
+	}
+
+	err = snd_pcm_new(dice->card, "DICE", 0, playback, capture, &pcm);
 	if (err < 0)
 		return err;
 	pcm->private_data = dice;
 	strcpy(pcm->name, dice->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+
+	if (capture > 0)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
+
+	if (playback > 0)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
 
 	return 0;
 }
-- 
2.1.0
