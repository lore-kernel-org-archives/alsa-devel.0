From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/19] ALSA: fireworks: configure sampling
	transfer frequency in pcm.hw_params callback
Date: Wed, 12 Jun 2019 17:44:11 +0900
Message-ID: <20190612084422.5344-9-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45CFDF89737
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:41 +0200 (CEST)
In-Reply-To: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
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

At present, several operations are done in pcm.prepare callback. To
reduce load of the callback, This commit splits out an operation to
set sampling transfer frequency in pcm.hw_params callback.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.h        |  3 +-
 sound/firewire/fireworks/fireworks_midi.c   |  7 ++-
 sound/firewire/fireworks/fireworks_pcm.c    | 14 +++--
 sound/firewire/fireworks/fireworks_stream.c | 65 +++++++++++++--------
 4 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 42a73038ba4d..0c1802aa7923 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -206,7 +206,8 @@ int snd_efw_command_get_sampling_rate(struct snd_efw *efw, unsigned int *rate);
 int snd_efw_command_set_sampling_rate(struct snd_efw *efw, unsigned int rate);
 
 int snd_efw_stream_init_duplex(struct snd_efw *efw);
-int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate);
+int snd_efw_stream_reserve_duplex(struct snd_efw *efw, unsigned int rate);
+int snd_efw_stream_start_duplex(struct snd_efw *efw);
 void snd_efw_stream_stop_duplex(struct snd_efw *efw);
 void snd_efw_stream_update_duplex(struct snd_efw *efw);
 void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index ee5dc7be70b6..6d3d942e2dce 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -18,8 +18,11 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&efw->mutex);
-	++efw->substreams_counter;
-	err = snd_efw_stream_start_duplex(efw, 0);
+	err = snd_efw_stream_reserve_duplex(efw, 0);
+	if (err >= 0) {
+		++efw->substreams_counter;
+		err = snd_efw_stream_start_duplex(efw);
+	}
 	mutex_unlock(&efw->mutex);
 	if (err < 0)
 		snd_efw_stream_lock_release(efw);
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 398a6ad04c5f..287fc05d5917 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -231,12 +231,16 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&efw->mutex);
-		++efw->substreams_counter;
+		err = snd_efw_stream_reserve_duplex(efw, rate);
+		if (err >= 0)
+			++efw->substreams_counter;
 		mutex_unlock(&efw->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_hw_free(struct snd_pcm_substream *substream)
@@ -257,10 +261,9 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	err = snd_efw_stream_start_duplex(efw, runtime->rate);
+	err = snd_efw_stream_start_duplex(efw);
 	if (err >= 0)
 		amdtp_stream_pcm_prepare(&efw->tx_stream);
 
@@ -269,10 +272,9 @@ static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 static int pcm_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	err = snd_efw_stream_start_duplex(efw, runtime->rate);
+	err = snd_efw_stream_start_duplex(efw);
 	if (err >= 0)
 		amdtp_stream_pcm_prepare(&efw->rx_stream);
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 2df39befcde0..e1ebead583e9 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -189,47 +189,63 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	return err;
 }
 
-int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
+int snd_efw_stream_reserve_duplex(struct snd_efw *efw, unsigned int rate)
 {
 	unsigned int curr_rate;
-	int err = 0;
-
-	// Need no substreams.
-	if (efw->substreams_counter == 0)
-		return -EIO;
+	int err;
 
-	/*
-	 * Considering JACK/FFADO streaming:
-	 * TODO: This can be removed hwdep functionality becomes popular.
-	 */
+	// Considering JACK/FFADO streaming:
+	// TODO: This can be removed hwdep functionality becomes popular.
 	err = check_connection_used_by_others(efw, &efw->rx_stream);
 	if (err < 0)
-		goto end;
+		return err;
 
-	/* stop streams if rate is different */
+	// stop streams if rate is different.
 	err = snd_efw_command_get_sampling_rate(efw, &curr_rate);
 	if (err < 0)
-		goto end;
+		return err;
 	if (rate == 0)
 		rate = curr_rate;
-	if (rate != curr_rate ||
-	    amdtp_streaming_error(&efw->tx_stream) ||
-	    amdtp_streaming_error(&efw->rx_stream)) {
+	if (rate != curr_rate) {
 		stop_stream(efw, &efw->tx_stream);
 		stop_stream(efw, &efw->rx_stream);
 	}
 
-	/* master should be always running */
-	if (!amdtp_stream_running(&efw->rx_stream)) {
+	if (efw->substreams_counter == 0 || rate != curr_rate) {
 		err = snd_efw_command_set_sampling_rate(efw, rate);
 		if (err < 0)
-			goto end;
+			return err;
+	}
+
+	return 0;
+}
+
+int snd_efw_stream_start_duplex(struct snd_efw *efw)
+{
+	unsigned int rate;
+	int err = 0;
+
+	// Need no substreams.
+	if (efw->substreams_counter == 0)
+		return -EIO;
+
+	err = snd_efw_command_get_sampling_rate(efw, &rate);
+	if (err < 0)
+		return err;
 
+	if (amdtp_streaming_error(&efw->rx_stream) ||
+	    amdtp_streaming_error(&efw->tx_stream)) {
+		stop_stream(efw, &efw->rx_stream);
+		stop_stream(efw, &efw->tx_stream);
+	}
+
+	/* master should be always running */
+	if (!amdtp_stream_running(&efw->rx_stream)) {
 		err = start_stream(efw, &efw->rx_stream, rate);
 		if (err < 0) {
 			dev_err(&efw->unit->device,
 				"fail to start AMDTP master stream:%d\n", err);
-			goto end;
+			goto error;
 		}
 	}
 
@@ -238,11 +254,14 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 		if (err < 0) {
 			dev_err(&efw->unit->device,
 				"fail to start AMDTP slave stream:%d\n", err);
-			stop_stream(efw, &efw->tx_stream);
-			stop_stream(efw, &efw->rx_stream);
+			goto error;
 		}
 	}
-end:
+
+	return 0;
+error:
+	stop_stream(efw, &efw->rx_stream);
+	stop_stream(efw, &efw->tx_stream);
 	return err;
 }
 
-- 
2.20.1
