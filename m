From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/15] ALSA: firewire-tascam: reserve/release
	isochronous resources in pcm.hw_params/hw_free callbacks
Date: Sun,  2 Jun 2019 16:12:48 +0900
Message-ID: <20190602071259.21622-5-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAEBFF80CC4
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:11 +0200 (CEST)
In-Reply-To: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
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
packet streaming for allocated the resources.

There are two points to stop packet streaming; in pcm.hw_params and
pcm.prepare callbacks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-pcm.c    | 22 ++++++--
 sound/firewire/tascam/tascam-stream.c | 79 ++++++++++++++++-----------
 sound/firewire/tascam/tascam.h        |  2 +
 3 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index e4cc8990e195..962ef1212ac0 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -96,12 +96,16 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&tscm->mutex);
-		tscm->substreams_counter++;
+		err = snd_tscm_stream_reserve_duplex(tscm, rate);
+		if (err >= 0)
+			++tscm->substreams_counter;
 		mutex_unlock(&tscm->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
@@ -116,12 +120,16 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&tscm->mutex);
-		tscm->substreams_counter++;
+		err = snd_tscm_stream_reserve_duplex(tscm, rate);
+		if (err >= 0)
+			++tscm->substreams_counter;
 		mutex_unlock(&tscm->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
@@ -131,9 +139,10 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&tscm->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		tscm->substreams_counter--;
+		--tscm->substreams_counter;
 
 	snd_tscm_stream_stop_duplex(tscm);
+	snd_tscm_stream_release_duplex(tscm);
 
 	mutex_unlock(&tscm->mutex);
 
@@ -147,9 +156,10 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&tscm->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		tscm->substreams_counter--;
+		--tscm->substreams_counter;
 
 	snd_tscm_stream_stop_duplex(tscm);
+	snd_tscm_stream_release_duplex(tscm);
 
 	mutex_unlock(&tscm->mutex);
 
diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 6ad149274050..18d554d46be5 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -166,7 +166,7 @@ static int set_stream_formats(struct snd_tscm *tscm, unsigned int rate)
 	__be32 reg;
 	int err;
 
-	/* Set an option for unknown purpose. */
+	// Set an option for unknown purpose.
 	reg = cpu_to_be32(0x00200000);
 	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
 				 TSCM_ADDR_BASE + TSCM_OFFSET_SET_OPTION,
@@ -174,11 +174,7 @@ static int set_stream_formats(struct snd_tscm *tscm, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	err = enable_data_channels(tscm);
-	if (err < 0)
-		return err;
-
-	return set_clock(tscm, rate, INT_MAX);
+	return enable_data_channels(tscm);
 }
 
 static void finish_session(struct snd_tscm *tscm)
@@ -348,38 +344,66 @@ void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm)
 	fw_iso_resources_destroy(&tscm->tx_resources);
 }
 
-int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
+int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate)
 {
 	unsigned int curr_rate;
 	int err;
 
-	if (tscm->substreams_counter == 0)
-		return 0;
-
 	err = snd_tscm_stream_get_rate(tscm, &curr_rate);
 	if (err < 0)
 		return err;
-	if (curr_rate != rate ||
-	    amdtp_streaming_error(&tscm->rx_stream) ||
-	    amdtp_streaming_error(&tscm->tx_stream)) {
-		finish_session(tscm);
 
+	if (tscm->substreams_counter == 0 || rate != curr_rate) {
 		amdtp_stream_stop(&tscm->rx_stream);
 		amdtp_stream_stop(&tscm->tx_stream);
 
+		finish_session(tscm);
+
 		fw_iso_resources_free(&tscm->tx_resources);
 		fw_iso_resources_free(&tscm->rx_resources);
-	}
 
-	if (!amdtp_stream_running(&tscm->rx_stream)) {
+		err = set_clock(tscm, rate, INT_MAX);
+		if (err < 0)
+			return err;
+
 		err = keep_resources(tscm, rate, &tscm->tx_stream);
 		if (err < 0)
-			goto error;
+			return err;
 
 		err = keep_resources(tscm, rate, &tscm->rx_stream);
-		if (err < 0)
-			goto error;
+		if (err < 0) {
+			fw_iso_resources_free(&tscm->tx_resources);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void snd_tscm_stream_release_duplex(struct snd_tscm *tscm)
+{
+	if (tscm->substreams_counter == 0) {
+		fw_iso_resources_free(&tscm->tx_resources);
+		fw_iso_resources_free(&tscm->rx_resources);
+	}
+}
+
+int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
+{
+	int err;
+
+	if (tscm->substreams_counter == 0)
+		return 0;
+
+	if (amdtp_streaming_error(&tscm->rx_stream) ||
+	    amdtp_streaming_error(&tscm->tx_stream)) {
+		amdtp_stream_stop(&tscm->rx_stream);
+		amdtp_stream_stop(&tscm->tx_stream);
 
+		finish_session(tscm);
+	}
+
+	if (!amdtp_stream_running(&tscm->rx_stream)) {
 		err = set_stream_formats(tscm, rate);
 		if (err < 0)
 			goto error;
@@ -422,24 +446,17 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 
 	finish_session(tscm);
 
-	fw_iso_resources_free(&tscm->tx_resources);
-	fw_iso_resources_free(&tscm->rx_resources);
-
 	return err;
 }
 
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm)
 {
-	if (tscm->substreams_counter > 0)
-		return;
-
-	amdtp_stream_stop(&tscm->tx_stream);
-	amdtp_stream_stop(&tscm->rx_stream);
-
-	finish_session(tscm);
+	if (tscm->substreams_counter == 0) {
+		amdtp_stream_stop(&tscm->tx_stream);
+		amdtp_stream_stop(&tscm->rx_stream);
 
-	fw_iso_resources_free(&tscm->tx_resources);
-	fw_iso_resources_free(&tscm->rx_resources);
+		finish_session(tscm);
+	}
 }
 
 void snd_tscm_stream_lock_changed(struct snd_tscm *tscm)
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 6a411ee0dcf1..1cb75c374f11 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -147,6 +147,8 @@ int snd_tscm_stream_get_clock(struct snd_tscm *tscm,
 int snd_tscm_stream_init_duplex(struct snd_tscm *tscm);
 void snd_tscm_stream_update_duplex(struct snd_tscm *tscm);
 void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm);
+int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate);
+void snd_tscm_stream_release_duplex(struct snd_tscm *tscm);
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate);
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm);
 
-- 
2.20.1
