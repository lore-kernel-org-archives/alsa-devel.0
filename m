From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/15] ALSA: fireface: reserve/release
	isochronous resources in pcm.hw_params/hw_free callbacks
Date: Sun,  2 Jun 2019 16:12:56 +0900
Message-ID: <20190602071259.21622-13-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37EF2F89744
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:24 +0200 (CEST)
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
 sound/firewire/fireface/ff-pcm.c    | 18 ++++++--
 sound/firewire/fireface/ff-stream.c | 67 ++++++++++++++++++-----------
 sound/firewire/fireface/ff.h        |  2 +
 3 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index 5adf04b95c04..53477404a58f 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -211,8 +211,12 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&ff->mutex);
-		ff->substreams_counter++;
+		err = snd_ff_stream_reserve_duplex(ff, rate);
+		if (err >= 0)
+			++ff->substreams_counter;
 		mutex_unlock(&ff->mutex);
 	}
 
@@ -231,8 +235,12 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&ff->mutex);
-		ff->substreams_counter++;
+		err = snd_ff_stream_reserve_duplex(ff, rate);
+		if (err >= 0)
+			++ff->substreams_counter;
 		mutex_unlock(&ff->mutex);
 	}
 
@@ -246,9 +254,10 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&ff->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		ff->substreams_counter--;
+		--ff->substreams_counter;
 
 	snd_ff_stream_stop_duplex(ff);
+	snd_ff_stream_release_duplex(ff);
 
 	mutex_unlock(&ff->mutex);
 
@@ -262,9 +271,10 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&ff->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		ff->substreams_counter--;
+		--ff->substreams_counter;
 
 	snd_ff_stream_stop_duplex(ff);
+	snd_ff_stream_release_duplex(ff);
 
 	mutex_unlock(&ff->mutex);
 
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 740963e4e1c9..d9d1b469a8e9 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -31,12 +31,6 @@ int snd_ff_stream_get_multiplier_mode(enum cip_sfc sfc,
 	return 0;
 }
 
-static void release_resources(struct snd_ff *ff)
-{
-	fw_iso_resources_free(&ff->tx_resources);
-	fw_iso_resources_free(&ff->rx_resources);
-}
-
 static inline void finish_session(struct snd_ff *ff)
 {
 	ff->spec->protocol->finish_session(ff);
@@ -104,36 +98,27 @@ void snd_ff_stream_destroy_duplex(struct snd_ff *ff)
 	destroy_stream(ff, AMDTP_OUT_STREAM);
 }
 
-int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
+int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate)
 {
 	unsigned int curr_rate;
 	enum snd_ff_clock_src src;
 	int err;
 
-	if (ff->substreams_counter == 0)
-		return 0;
-
 	err = ff->spec->protocol->get_clock(ff, &curr_rate, &src);
 	if (err < 0)
 		return err;
-	if (curr_rate != rate ||
-	    amdtp_streaming_error(&ff->tx_stream) ||
-	    amdtp_streaming_error(&ff->rx_stream)) {
-		finish_session(ff);
+
+	if (ff->substreams_counter == 0 || curr_rate != rate) {
+		enum snd_ff_stream_mode mode;
+		int i;
 
 		amdtp_stream_stop(&ff->tx_stream);
 		amdtp_stream_stop(&ff->rx_stream);
 
-		release_resources(ff);
-	}
+		finish_session(ff);
 
-	/*
-	 * Regardless of current source of clock signal, drivers transfer some
-	 * packets. Then, the device transfers packets.
-	 */
-	if (!amdtp_stream_running(&ff->rx_stream)) {
-		enum snd_ff_stream_mode mode;
-		int i;
+		fw_iso_resources_free(&ff->tx_resources);
+		fw_iso_resources_free(&ff->rx_resources);
 
 		for (i = 0; i < CIP_SFC_COUNT; ++i) {
 			if (amdtp_rate_table[i] == rate)
@@ -158,8 +143,40 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 
 		err = ff->spec->protocol->allocate_resources(ff, rate);
 		if (err < 0)
-			goto error;
+			return err;
+	}
+
+	return 0;
+}
+
+void snd_ff_stream_release_duplex(struct snd_ff *ff)
+{
+	if (ff->substreams_counter == 0) {
+		fw_iso_resources_free(&ff->tx_resources);
+		fw_iso_resources_free(&ff->rx_resources);
+	}
+}
+
+int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
+{
+	int err;
+
+	if (ff->substreams_counter == 0)
+		return 0;
 
+	if (amdtp_streaming_error(&ff->tx_stream) ||
+	    amdtp_streaming_error(&ff->rx_stream)) {
+		amdtp_stream_stop(&ff->tx_stream);
+		amdtp_stream_stop(&ff->rx_stream);
+
+		finish_session(ff);
+	}
+
+	/*
+	 * Regardless of current source of clock signal, drivers transfer some
+	 * packets. Then, the device transfers packets.
+	 */
+	if (!amdtp_stream_running(&ff->rx_stream)) {
 		err = ff->spec->protocol->begin_session(ff, rate);
 		if (err < 0)
 			goto error;
@@ -201,7 +218,6 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 	amdtp_stream_stop(&ff->rx_stream);
 
 	finish_session(ff);
-	release_resources(ff);
 
 	return err;
 }
@@ -214,7 +230,6 @@ void snd_ff_stream_stop_duplex(struct snd_ff *ff)
 	amdtp_stream_stop(&ff->tx_stream);
 	amdtp_stream_stop(&ff->rx_stream);
 	finish_session(ff);
-	release_resources(ff);
 }
 
 void snd_ff_stream_update_duplex(struct snd_ff *ff)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index c478103388a2..fe5739ee1c88 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -138,6 +138,8 @@ int snd_ff_stream_get_multiplier_mode(enum cip_sfc sfc,
 				      enum snd_ff_stream_mode *mode);
 int snd_ff_stream_init_duplex(struct snd_ff *ff);
 void snd_ff_stream_destroy_duplex(struct snd_ff *ff);
+int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate);
+void snd_ff_stream_release_duplex(struct snd_ff *ff);
 int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate);
 void snd_ff_stream_stop_duplex(struct snd_ff *ff);
 void snd_ff_stream_update_duplex(struct snd_ff *ff);
-- 
2.20.1
