From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/12] ALSA: firewire-digi00x: reserve/release
	isochronous resources in pcm.hw_params/hw_free callbacks
Date: Tue, 11 Jun 2019 22:21:11 +0900
Message-ID: <20190611132118.8378-6-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36B03F89714
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:33 +0200 (CEST)
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

Once allocated, isochronous resources are available for packet
streaming, even if the streaming is cancelled. For this reason,
current implementation handles allocation of the resources and
starting packet streaming at the same time. However, this brings
complicated procedure to start packet streaming.

This commit separates the allocation and starting. The allocation is
done in pcm.hw_params callback and available till pcm.hw_free callback.
Even if any XRUN occurs, pcm.prepare callback is done to restart
packet streaming without releasing/allocating the resources.

There are two points to stop packet streaming; in pcm.hw_params and
pcm.prepare callbacks. The former point is a case that packet streaming
is already started for any MIDI substream then packet streaming is
requested with different sampling transfer frequency for any PCM
substream. The latter point is cases of any XRUN or packet queueing
error.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c   | 10 ++-
 sound/firewire/digi00x/digi00x-pcm.c    | 28 ++++++---
 sound/firewire/digi00x/digi00x-stream.c | 82 ++++++++++++++-----------
 sound/firewire/digi00x/digi00x.h        |  4 +-
 4 files changed, 73 insertions(+), 51 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 7ab3d0810f6b..cca888cce0d3 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -18,8 +18,11 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 		return err;
 
 	mutex_lock(&dg00x->mutex);
-	dg00x->substreams_counter++;
-	err = snd_dg00x_stream_start_duplex(dg00x, 0);
+	err = snd_dg00x_stream_reserve_duplex(dg00x, 0);
+	if (err >= 0) {
+		++dg00x->substreams_counter;
+		err = snd_dg00x_stream_start_duplex(dg00x);
+	}
 	mutex_unlock(&dg00x->mutex);
 	if (err < 0)
 		snd_dg00x_stream_lock_release(dg00x);
@@ -32,8 +35,9 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
 	mutex_lock(&dg00x->mutex);
-	dg00x->substreams_counter--;
+	--dg00x->substreams_counter;
 	snd_dg00x_stream_stop_duplex(dg00x);
+	snd_dg00x_stream_release_duplex(dg00x);
 	mutex_unlock(&dg00x->mutex);
 
 	snd_dg00x_stream_lock_release(dg00x);
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index fdcff0460c53..1c04747f4fcc 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -167,12 +167,16 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&dg00x->mutex);
-		dg00x->substreams_counter++;
+		err = snd_dg00x_stream_reserve_duplex(dg00x, rate);
+		if (err >= 0)
+			++dg00x->substreams_counter;
 		mutex_unlock(&dg00x->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
@@ -187,12 +191,16 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&dg00x->mutex);
-		dg00x->substreams_counter++;
+		err = snd_dg00x_stream_reserve_duplex(dg00x, rate);
+		if (err >= 0)
+			++dg00x->substreams_counter;
 		mutex_unlock(&dg00x->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
@@ -202,9 +210,10 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&dg00x->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		dg00x->substreams_counter--;
+		--dg00x->substreams_counter;
 
 	snd_dg00x_stream_stop_duplex(dg00x);
+	snd_dg00x_stream_release_duplex(dg00x);
 
 	mutex_unlock(&dg00x->mutex);
 
@@ -218,9 +227,10 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&dg00x->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		dg00x->substreams_counter--;
+		--dg00x->substreams_counter;
 
 	snd_dg00x_stream_stop_duplex(dg00x);
+	snd_dg00x_stream_release_duplex(dg00x);
 
 	mutex_unlock(&dg00x->mutex);
 
@@ -230,12 +240,11 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	mutex_lock(&dg00x->mutex);
 
-	err = snd_dg00x_stream_start_duplex(dg00x, runtime->rate);
+	err = snd_dg00x_stream_start_duplex(dg00x);
 	if (err >= 0)
 		amdtp_stream_pcm_prepare(&dg00x->tx_stream);
 
@@ -247,12 +256,11 @@ static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 static int pcm_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	mutex_lock(&dg00x->mutex);
 
-	err = snd_dg00x_stream_start_duplex(dg00x, runtime->rate);
+	err = snd_dg00x_stream_start_duplex(dg00x);
 	if (err >= 0) {
 		amdtp_stream_pcm_prepare(&dg00x->rx_stream);
 		amdtp_dot_reset(&dg00x->rx_stream);
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 2bddeb3e4bf5..3b903e42d29a 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -189,13 +189,6 @@ static int begin_session(struct snd_dg00x *dg00x)
 	return err;
 }
 
-static void release_resources(struct snd_dg00x *dg00x)
-{
-	/* Release isochronous resources. */
-	fw_iso_resources_free(&dg00x->tx_resources);
-	fw_iso_resources_free(&dg00x->rx_resources);
-}
-
 static int keep_resources(struct snd_dg00x *dg00x, struct amdtp_stream *stream,
 			  unsigned int rate)
 {
@@ -265,45 +258,65 @@ void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x)
 	fw_iso_resources_destroy(&dg00x->tx_resources);
 }
 
-int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
+int snd_dg00x_stream_reserve_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 {
 	unsigned int curr_rate;
-	int err = 0;
-
-	if (dg00x->substreams_counter == 0)
-		goto end;
+	int err;
 
-	/* Check current sampling rate. */
 	err = snd_dg00x_stream_get_local_rate(dg00x, &curr_rate);
 	if (err < 0)
-		goto error;
+		return err;
 	if (rate == 0)
 		rate = curr_rate;
-	if (curr_rate != rate ||
-	    amdtp_streaming_error(&dg00x->tx_stream) ||
-	    amdtp_streaming_error(&dg00x->rx_stream)) {
+
+	if (dg00x->substreams_counter == 0 || curr_rate != rate) {
 		finish_session(dg00x);
 
-		release_resources(dg00x);
-	}
+		fw_iso_resources_free(&dg00x->tx_resources);
+		fw_iso_resources_free(&dg00x->rx_resources);
 
-	/*
-	 * No packets are transmitted without receiving packets, reagardless of
-	 * which source of clock is used.
-	 */
-	if (!amdtp_stream_running(&dg00x->rx_stream)) {
 		err = snd_dg00x_stream_set_local_rate(dg00x, rate);
 		if (err < 0)
-			goto error;
+			return err;
 
 		err = keep_resources(dg00x, &dg00x->rx_stream, rate);
 		if (err < 0)
-			goto error;
+			return err;
 
 		err = keep_resources(dg00x, &dg00x->tx_stream, rate);
-		if (err < 0)
-			goto error;
+		if (err < 0) {
+			fw_iso_resources_free(&dg00x->rx_resources);
+			return err;
+		}
+	}
+
+	return 0;
+}
 
+void snd_dg00x_stream_release_duplex(struct snd_dg00x *dg00x)
+{
+	if (dg00x->substreams_counter == 0) {
+		fw_iso_resources_free(&dg00x->tx_resources);
+		fw_iso_resources_free(&dg00x->rx_resources);
+	}
+}
+
+int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
+{
+	int err = 0;
+
+	if (dg00x->substreams_counter == 0)
+		return 0;
+
+	if (amdtp_streaming_error(&dg00x->tx_stream) ||
+	    amdtp_streaming_error(&dg00x->rx_stream))
+		finish_session(dg00x);
+
+	/*
+	 * No packets are transmitted without receiving packets, reagardless of
+	 * which source of clock is used.
+	 */
+	if (!amdtp_stream_running(&dg00x->rx_stream)) {
 		err = begin_session(dg00x);
 		if (err < 0)
 			goto error;
@@ -338,23 +351,18 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 			goto error;
 		}
 	}
-end:
-	return err;
+
+	return 0;
 error:
 	finish_session(dg00x);
 
-	release_resources(dg00x);
-
 	return err;
 }
 
 void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x)
 {
-	if (dg00x->substreams_counter > 0)
-		return;
-
-	finish_session(dg00x);
-	release_resources(dg00x);
+	if (dg00x->substreams_counter == 0)
+		finish_session(dg00x);
 }
 
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x)
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 4dd1bbf2ed3c..3fb1c49f6f9e 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -140,8 +140,10 @@ int snd_dg00x_stream_get_clock(struct snd_dg00x *dg00x,
 int snd_dg00x_stream_check_external_clock(struct snd_dg00x *dg00x,
 					  bool *detect);
 int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x);
-int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate);
+int snd_dg00x_stream_reserve_duplex(struct snd_dg00x *dg00x, unsigned int rate);
+int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
+void snd_dg00x_stream_release_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
-- 
2.20.1
