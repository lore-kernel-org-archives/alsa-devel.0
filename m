From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: dice: handle several PCM substreams
	when any isochronous streams are available
Date: Mon,  7 Mar 2016 22:35:44 +0900
Message-ID: <1457357745-24756-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1457357745-24756-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id AEEE3261555
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 14:35:49 +0100 (CET)
In-Reply-To: <1457357745-24756-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commits, ALSA dice driver can handle available isochronous
streams. This commit adds support for several PCM substreams on the
streams.

The additional PCM substreams are available via another ALSA PCM character
devices so that one ALSA PCM application can handle them without cumbersome
operations. For example, two PCM substreams are available on each stream,
two ALSA character devices are added for them. In configuration space of
alsa-lib, it's represented with 'hw:0,0' and 'hw:0,1'.

The PCM substreams are constraint to parameters of the corresponding
streams. If the PCM substreams are unavailable for some reasons,
open(2) to ALSA PCM character device returns error and reports ENXIO.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 121 +++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 46 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index e252949..05e2e18 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -11,28 +11,34 @@
 
 static int limit_channels_and_rates(struct snd_dice *dice,
 				    struct snd_pcm_runtime *runtime,
-				    struct amdtp_stream *stream)
+				    enum amdtp_stream_direction dir,
+				    unsigned int index, unsigned int size)
 {
 	struct snd_pcm_hardware *hw = &runtime->hw;
+	struct amdtp_stream *stream;
 	unsigned int rate;
-	__be32 reg[2];
+	__be32 reg;
 	int err;
 
 	/*
 	 * Retrieve current Multi Bit Linear Audio data channel and limit to
 	 * it.
 	 */
-	if (stream == &dice->tx_stream[0]) {
-		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
-						   reg, sizeof(reg));
+	if (dir == AMDTP_IN_STREAM) {
+		stream = &dice->tx_stream[index];
+		err = snd_dice_transaction_read_tx(dice,
+				size * index + TX_NUMBER_AUDIO,
+				&reg, sizeof(reg));
 	} else {
-		err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
-						   reg, sizeof(reg));
+		stream = &dice->rx_stream[index];
+		err = snd_dice_transaction_read_rx(dice,
+				size * index + RX_NUMBER_AUDIO,
+				&reg, sizeof(reg));
 	}
 	if (err < 0)
 		return err;
 
-	hw->channels_min = hw->channels_max = be32_to_cpu(reg[0]);
+	hw->channels_min = hw->channels_max = be32_to_cpu(reg);
 
 	/* Retrieve current sampling transfer frequency and limit to it. */
 	err = snd_dice_transaction_get_rate(dice, &rate);
@@ -62,7 +68,10 @@ static int init_hw_info(struct snd_dice *dice,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
+	enum amdtp_stream_direction dir;
 	struct amdtp_stream *stream;
+	__be32 reg[2];
+	unsigned int count, size;
 	int err;
 
 	hw->info = SNDRV_PCM_INFO_MMAP |
@@ -74,13 +83,28 @@ static int init_hw_info(struct snd_dice *dice,
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw->formats = AM824_IN_PCM_FORMAT_BITS;
-		stream = &dice->tx_stream[0];
+		dir = AMDTP_IN_STREAM;
+		stream = &dice->tx_stream[substream->pcm->device];
+		err = snd_dice_transaction_read_tx(dice, TX_NUMBER, reg,
+						   sizeof(reg));
 	} else {
 		hw->formats = AM824_OUT_PCM_FORMAT_BITS;
-		stream = &dice->rx_stream[0];
+		dir = AMDTP_OUT_STREAM;
+		stream = &dice->rx_stream[substream->pcm->device];
+		err = snd_dice_transaction_read_rx(dice, RX_NUMBER, reg,
+						   sizeof(reg));
 	}
 
-	err = limit_channels_and_rates(dice, runtime, stream);
+	if (err < 0)
+		return err;
+
+	count = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
+	if (substream->pcm->device >= count)
+		return -ENXIO;
+
+	size = be32_to_cpu(reg[1]) * 4;
+	err = limit_channels_and_rates(dice, substream->runtime, dir,
+				       substream->pcm->device, size);
 	if (err < 0)
 		return err;
 	limit_period_and_buffer(hw);
@@ -122,7 +146,7 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->tx_stream[0];
+	struct amdtp_stream *stream = &dice->tx_stream[substream->pcm->device];
 	int err;
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -144,7 +168,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->rx_stream[0];
+	struct amdtp_stream *stream = &dice->rx_stream[substream->pcm->device];
 	int err;
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -198,7 +222,7 @@ static int playback_hw_free(struct snd_pcm_substream *substream)
 static int capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->tx_stream[0];
+	struct amdtp_stream *stream = &dice->tx_stream[substream->pcm->device];
 	int err;
 
 	mutex_lock(&dice->mutex);
@@ -212,7 +236,7 @@ static int capture_prepare(struct snd_pcm_substream *substream)
 static int playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->rx_stream[0];
+	struct amdtp_stream *stream = &dice->rx_stream[substream->pcm->device];
 	int err;
 
 	mutex_lock(&dice->mutex);
@@ -227,7 +251,7 @@ static int playback_prepare(struct snd_pcm_substream *substream)
 static int capture_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->tx_stream[0];
+	struct amdtp_stream *stream = &dice->tx_stream[substream->pcm->device];
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -245,7 +269,7 @@ static int capture_trigger(struct snd_pcm_substream *substream, int cmd)
 static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->rx_stream[0];
+	struct amdtp_stream *stream = &dice->rx_stream[substream->pcm->device];
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -264,14 +288,14 @@ static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
 static snd_pcm_uframes_t capture_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->tx_stream[0];
+	struct amdtp_stream *stream = &dice->tx_stream[substream->pcm->device];
 
 	return amdtp_stream_pcm_pointer(stream);
 }
 static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->rx_stream[0];
+	struct amdtp_stream *stream = &dice->rx_stream[substream->pcm->device];
 
 	return amdtp_stream_pcm_pointer(stream);
 }
@@ -304,40 +328,45 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 	};
 	__be32 reg;
 	struct snd_pcm *pcm;
-	unsigned int capture, playback;
+	unsigned int i, max_capture, max_playback, capture, playback;
 	int err;
 
-	/*
-	 * Check whether PCM substreams are required.
-	 *
-	 * TODO: in the case that any PCM substreams are not avail at a certain
-	 * sampling transfer frequency?
-	 */
-	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
-					   &reg, sizeof(reg));
-	if (err < 0)
-		return err;
-	if (be32_to_cpu(reg) > 0)
-		capture = 1;
-
-	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
-					   &reg, sizeof(reg));
+	/* Check whether PCM substreams are required. */
+	max_capture = max_playback = 0;
+	err = snd_dice_transaction_read_tx(dice, TX_NUMBER, &reg, sizeof(reg));
 	if (err < 0)
 		return err;
-	if (be32_to_cpu(reg) > 0)
-		playback = 1;
+	max_capture = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
 
-	err = snd_pcm_new(dice->card, "DICE", 0, playback, capture, &pcm);
+	err = snd_dice_transaction_read_rx(dice, RX_NUMBER, &reg, sizeof(reg));
 	if (err < 0)
 		return err;
-	pcm->private_data = dice;
-	strcpy(pcm->name, dice->card->shortname);
-
-	if (capture > 0)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
-
-	if (playback > 0)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	max_playback = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
+
+	for (i = 0; i < MAX_STREAMS; i++) {
+		capture = playback = 0;
+		if (i < max_capture)
+			capture = 1;
+		if (i < max_playback)
+			playback = 1;
+		if (capture == 0 && playback == 0)
+			break;
+
+		err = snd_pcm_new(dice->card, "DICE", i, playback, capture,
+				  &pcm);
+		if (err < 0)
+			return err;
+		pcm->private_data = dice;
+		strcpy(pcm->name, dice->card->shortname);
+
+		if (capture > 0)
+			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+					&capture_ops);
+
+		if (playback > 0)
+			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+					&playback_ops);
+	}
 
 	return 0;
 }
-- 
2.7.0
