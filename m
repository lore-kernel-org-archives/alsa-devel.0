From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/19] ALSA: fireworks: unify substream counter
Date: Wed, 12 Jun 2019 17:44:08 +0900
Message-ID: <20190612084422.5344-6-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A050F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:36 +0200 (CEST)
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

It's inconvenient to handle two isochronous context separately
each other. This commit unifies the counters to handle the two
at the same time.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.h        |  3 +--
 sound/firewire/fireworks/fireworks_midi.c   |  8 +++---
 sound/firewire/fireworks/fireworks_pcm.c    |  8 +++---
 sound/firewire/fireworks/fireworks_stream.c | 27 ++++++++-------------
 4 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 9b19c7f05d57..42a73038ba4d 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -89,8 +89,7 @@ struct snd_efw {
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
-	unsigned int capture_substreams;
-	unsigned int playback_substreams;
+	unsigned int substreams_counter;
 
 	/* hardware metering parameters */
 	unsigned int phys_out;
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index f5da2cd4ce42..7e78cdfe699e 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -18,7 +18,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&efw->mutex);
-	efw->capture_substreams++;
+	++efw->substreams_counter;
 	err = snd_efw_stream_start_duplex(efw, 0);
 	mutex_unlock(&efw->mutex);
 	if (err < 0)
@@ -38,7 +38,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&efw->mutex);
-	efw->playback_substreams++;
+	++efw->substreams_counter;
 	err = snd_efw_stream_start_duplex(efw, 0);
 	mutex_unlock(&efw->mutex);
 	if (err < 0)
@@ -52,7 +52,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 	struct snd_efw *efw = substream->rmidi->private_data;
 
 	mutex_lock(&efw->mutex);
-	efw->capture_substreams--;
+	--efw->substreams_counter;
 	snd_efw_stream_stop_duplex(efw);
 	mutex_unlock(&efw->mutex);
 
@@ -65,7 +65,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	struct snd_efw *efw = substream->rmidi->private_data;
 
 	mutex_lock(&efw->mutex);
-	efw->playback_substreams--;
+	--efw->substreams_counter;
 	snd_efw_stream_stop_duplex(efw);
 	mutex_unlock(&efw->mutex);
 
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index aed566d82726..a66f6a381dac 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -232,7 +232,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		efw->capture_substreams++;
+		++efw->substreams_counter;
 		mutex_unlock(&efw->mutex);
 	}
 
@@ -251,7 +251,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		efw->playback_substreams++;
+		++efw->substreams_counter;
 		mutex_unlock(&efw->mutex);
 	}
 
@@ -264,7 +264,7 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		efw->capture_substreams--;
+		--efw->substreams_counter;
 		mutex_unlock(&efw->mutex);
 	}
 
@@ -278,7 +278,7 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		efw->playback_substreams--;
+		--efw->substreams_counter;
 		mutex_unlock(&efw->mutex);
 	}
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 74e122e6e68a..2df39befcde0 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -194,9 +194,9 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	unsigned int curr_rate;
 	int err = 0;
 
-	/* Need no substreams */
-	if (efw->playback_substreams == 0 && efw->capture_substreams  == 0)
-		goto end;
+	// Need no substreams.
+	if (efw->substreams_counter == 0)
+		return -EIO;
 
 	/*
 	 * Considering JACK/FFADO streaming:
@@ -206,19 +206,15 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	if (err < 0)
 		goto end;
 
-	/* packet queueing error */
-	if (amdtp_streaming_error(&efw->tx_stream))
-		stop_stream(efw, &efw->tx_stream);
-	if (amdtp_streaming_error(&efw->rx_stream))
-		stop_stream(efw, &efw->rx_stream);
-
 	/* stop streams if rate is different */
 	err = snd_efw_command_get_sampling_rate(efw, &curr_rate);
 	if (err < 0)
 		goto end;
 	if (rate == 0)
 		rate = curr_rate;
-	if (rate != curr_rate) {
+	if (rate != curr_rate ||
+	    amdtp_streaming_error(&efw->tx_stream) ||
+	    amdtp_streaming_error(&efw->rx_stream)) {
 		stop_stream(efw, &efw->tx_stream);
 		stop_stream(efw, &efw->rx_stream);
 	}
@@ -237,13 +233,12 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 		}
 	}
 
-	/* start slave if needed */
-	if (efw->capture_substreams > 0 &&
-	    !amdtp_stream_running(&efw->tx_stream)) {
+	if (!amdtp_stream_running(&efw->tx_stream)) {
 		err = start_stream(efw, &efw->tx_stream, rate);
 		if (err < 0) {
 			dev_err(&efw->unit->device,
 				"fail to start AMDTP slave stream:%d\n", err);
+			stop_stream(efw, &efw->tx_stream);
 			stop_stream(efw, &efw->rx_stream);
 		}
 	}
@@ -253,11 +248,9 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 
 void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 {
-	if (efw->capture_substreams == 0) {
+	if (efw->substreams_counter == 0) {
 		stop_stream(efw, &efw->tx_stream);
-
-		if (efw->playback_substreams == 0)
-			stop_stream(efw, &efw->rx_stream);
+		stop_stream(efw, &efw->rx_stream);
 	}
 }
 
-- 
2.20.1
