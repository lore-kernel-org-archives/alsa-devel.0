From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/10] ALSA: firewire-motu: unify the count of
	subscriber for packet streaming
Date: Mon, 17 Jun 2019 17:15:01 +0900
Message-ID: <20190617081510.11025-2-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78241F89693
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:18 +0200 (CEST)
In-Reply-To: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
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

Two counters are used to maintain isochronous packet streaming for both
directions. However, like the other drivers, they can be replaced with
one counter. This commit unifies them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-midi.c   |  8 ++++----
 sound/firewire/motu/motu-pcm.c    |  8 ++++----
 sound/firewire/motu/motu-stream.c | 17 ++++++-----------
 sound/firewire/motu/motu.h        |  3 +--
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
index e55cab6d79c7..b2d339a8ef3f 100644
--- a/sound/firewire/motu/motu-midi.c
+++ b/sound/firewire/motu/motu-midi.c
@@ -18,7 +18,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&motu->mutex);
 
-	motu->capture_substreams++;
+	motu->substreams_counter++;
 	err = snd_motu_stream_start_duplex(motu, 0);
 
 	mutex_unlock(&motu->mutex);
@@ -40,7 +40,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&motu->mutex);
 
-	motu->playback_substreams++;
+	motu->substreams_counter++;
 	err = snd_motu_stream_start_duplex(motu, 0);
 
 	mutex_unlock(&motu->mutex);
@@ -57,7 +57,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&motu->mutex);
 
-	motu->capture_substreams--;
+	motu->substreams_counter--;
 	snd_motu_stream_stop_duplex(motu);
 
 	mutex_unlock(&motu->mutex);
@@ -72,7 +72,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&motu->mutex);
 
-	motu->playback_substreams--;
+	motu->substreams_counter--;
 	snd_motu_stream_stop_duplex(motu);
 
 	mutex_unlock(&motu->mutex);
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index ab69d7e6ac05..b0e5ebf05bec 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -203,7 +203,7 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&motu->mutex);
-		motu->capture_substreams++;
+		motu->substreams_counter++;
 		mutex_unlock(&motu->mutex);
 	}
 
@@ -222,7 +222,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&motu->mutex);
-		motu->playback_substreams++;
+		motu->substreams_counter++;
 		mutex_unlock(&motu->mutex);
 	}
 
@@ -236,7 +236,7 @@ static int capture_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&motu->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		motu->capture_substreams--;
+		motu->substreams_counter--;
 
 	snd_motu_stream_stop_duplex(motu);
 
@@ -252,7 +252,7 @@ static int playback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&motu->mutex);
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		motu->playback_substreams--;
+		motu->substreams_counter--;
 
 	snd_motu_stream_stop_duplex(motu);
 
diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 73e7a5e527fc..c136d7f8c49c 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -207,7 +207,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 	unsigned int curr_rate;
 	int err = 0;
 
-	if (motu->capture_substreams == 0 && motu->playback_substreams == 0)
+	if (motu->substreams_counter == 0)
 		return 0;
 
 	/* Some packet queueing errors. */
@@ -271,8 +271,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 		}
 	}
 
-	if (!amdtp_stream_running(&motu->tx_stream) &&
-	    motu->capture_substreams > 0) {
+	if (!amdtp_stream_running(&motu->tx_stream)) {
 		err = start_isoc_ctx(motu, &motu->tx_stream);
 		if (err < 0) {
 			dev_err(&motu->unit->device,
@@ -291,15 +290,12 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 
 void snd_motu_stream_stop_duplex(struct snd_motu *motu)
 {
-	if (motu->capture_substreams == 0) {
+	if (motu->substreams_counter == 0) {
 		if (amdtp_stream_running(&motu->tx_stream))
 			stop_isoc_ctx(motu, &motu->tx_stream);
 
-		if (motu->playback_substreams == 0) {
-			if (amdtp_stream_running(&motu->rx_stream))
-				stop_isoc_ctx(motu, &motu->rx_stream);
-			stop_both_streams(motu);
-		}
+		if (amdtp_stream_running(&motu->rx_stream))
+			stop_isoc_ctx(motu, &motu->rx_stream);
 	}
 }
 
@@ -372,8 +368,7 @@ void snd_motu_stream_destroy_duplex(struct snd_motu *motu)
 	destroy_stream(motu, AMDTP_IN_STREAM);
 	destroy_stream(motu, AMDTP_OUT_STREAM);
 
-	motu->playback_substreams = 0;
-	motu->capture_substreams = 0;
+	motu->substreams_counter = 0;
 }
 
 static void motu_lock_changed(struct snd_motu *motu)
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 1cd112be7dad..ae4b37cdfade 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -60,8 +60,7 @@ struct snd_motu {
 	struct amdtp_stream rx_stream;
 	struct fw_iso_resources tx_resources;
 	struct fw_iso_resources rx_resources;
-	unsigned int capture_substreams;
-	unsigned int playback_substreams;
+	unsigned int substreams_counter;
 
 	/* For notification. */
 	struct fw_address_handler async_handler;
-- 
2.20.1
