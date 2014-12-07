From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/15] ALSA: oxfw: add support for capturing
	PCM samples
Date: Sun,  7 Dec 2014 22:19:06 +0900
Message-ID: <1417958348-30333-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CAEC26068B
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 14:19:17 +0100 (CET)
In-Reply-To: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, a support for transmitted packets is added. This commit
add a support for capturing PCM samples.

When any streams are already started, this driver should not change sampling
rate of the device, thus this commit also adds a restriction of sampling rate
in this situation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-pcm.c | 200 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 180 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index a78339c..e84fc9c 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -118,21 +118,31 @@ static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
 	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
 }
 
-static int pcm_open(struct snd_pcm_substream *substream)
+static int init_hw_params(struct snd_oxfw *oxfw,
+			  struct snd_pcm_substream *substream)
 {
-	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	u8 **formats;
+	struct amdtp_stream *stream;
 	int err;
 
-	formats = oxfw->rx_stream_formats;
-
 	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
 			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
 			   SNDRV_PCM_INFO_INTERLEAVED |
+			   SNDRV_PCM_INFO_JOINT_DUPLEX |
 			   SNDRV_PCM_INFO_MMAP |
 			   SNDRV_PCM_INFO_MMAP_VALID;
 
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		stream = &oxfw->tx_stream;
+		formats = oxfw->tx_stream_formats;
+	} else {
+		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		stream = &oxfw->rx_stream;
+		formats = oxfw->rx_stream_formats;
+	}
+
 	limit_channels_and_rates(&runtime->hw, formats);
 	limit_period_and_buffer(&runtime->hw);
 
@@ -148,10 +158,55 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(&oxfw->rx_stream, runtime);
+	err = amdtp_stream_add_pcm_hw_constraints(stream, runtime);
+end:
+	return err;
+}
+
+static int limit_to_current_params(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_oxfw_stream_formation formation;
+	enum avc_general_plug_dir dir;
+	int err;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
+	else
+		dir = AVC_GENERAL_PLUG_DIR_IN;
+
+	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
+	if (err < 0)
+		goto end;
+
+	substream->runtime->hw.channels_min = formation.pcm;
+	substream->runtime->hw.channels_max = formation.pcm;
+	substream->runtime->hw.rate_min = formation.rate;
+	substream->runtime->hw.rate_max = formation.rate;
+end:
+	return err;
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	int err;
+
+	err = init_hw_params(oxfw, substream);
 	if (err < 0)
 		goto end;
 
+	/*
+	 * When any PCM streams are already running, the available sampling
+	 * rate is limited at current value.
+	 */
+	if (amdtp_stream_pcm_running(&oxfw->tx_stream) ||
+	    amdtp_stream_pcm_running(&oxfw->rx_stream)) {
+		err = limit_to_current_params(substream);
+		if (err < 0)
+			goto end;
+	}
+
 	snd_pcm_set_sync(substream);
 end:
 	return err;
@@ -162,28 +217,89 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int pcm_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *hw_params)
+static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&oxfw->mutex);
+		oxfw->capture_substreams++;
+		mutex_unlock(&oxfw->mutex);
+	}
+
+	amdtp_stream_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
+
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&oxfw->mutex);
+		oxfw->playback_substreams++;
+		mutex_unlock(&oxfw->mutex);
+	}
+
 	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
+
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
 }
 
-static int pcm_hw_free(struct snd_pcm_substream *substream)
+static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	mutex_lock(&oxfw->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		oxfw->capture_substreams--;
+
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
+
+	mutex_unlock(&oxfw->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
 	mutex_lock(&oxfw->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		oxfw->playback_substreams--;
+
 	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+
 	mutex_unlock(&oxfw->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
-static int pcm_prepare(struct snd_pcm_substream *substream)
+static int pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&oxfw->mutex);
+	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream,
+					    runtime->rate, runtime->channels);
+	mutex_unlock(&oxfw->mutex);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_pcm_prepare(&oxfw->tx_stream);
+end:
+	return err;
+}
+static int pcm_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -201,7 +317,25 @@ end:
 	return err;
 }
 
-static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+static int pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_substream *pcm;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		pcm = substream;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		pcm = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	amdtp_stream_pcm_trigger(&oxfw->tx_stream, pcm);
+	return 0;
+}
+static int pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_substream *pcm;
@@ -220,35 +354,61 @@ static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t pcm_capture_pointer(struct snd_pcm_substream *sbstm)
 {
-	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_oxfw *oxfw = sbstm->private_data;
+
+	return amdtp_stream_pcm_pointer(&oxfw->tx_stream);
+}
+static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstm)
+{
+	struct snd_oxfw *oxfw = sbstm->private_data;
 
 	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
 }
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 {
-	static struct snd_pcm_ops ops = {
+	static struct snd_pcm_ops capture_ops = {
+		.open      = pcm_open,
+		.close     = pcm_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = pcm_capture_hw_params,
+		.hw_free   = pcm_capture_hw_free,
+		.prepare   = pcm_capture_prepare,
+		.trigger   = pcm_capture_trigger,
+		.pointer   = pcm_capture_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	static struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = pcm_hw_params,
-		.hw_free   = pcm_hw_free,
-		.prepare   = pcm_prepare,
-		.trigger   = pcm_trigger,
-		.pointer   = pcm_pointer,
+		.hw_params = pcm_playback_hw_params,
+		.hw_free   = pcm_playback_hw_free,
+		.prepare   = pcm_playback_prepare,
+		.trigger   = pcm_playback_trigger,
+		.pointer   = pcm_playback_pointer,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
+	unsigned int cap = 0;
 	int err;
 
-	err = snd_pcm_new(oxfw->card, oxfw->card->driver, 0, 1, 0, &pcm);
+	if (oxfw->has_output)
+		cap = 1;
+
+	err = snd_pcm_new(oxfw->card, oxfw->card->driver, 0, 1, cap, &pcm);
 	if (err < 0)
 		return err;
+
 	pcm->private_data = oxfw;
 	strcpy(pcm->name, oxfw->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	if (cap > 0)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
+
 	return 0;
 }
-- 
2.1.0
