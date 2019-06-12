From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/19] ALSA: oxfw: configure packet format in
	pcm.hw_params callback
Date: Wed, 12 Jun 2019 17:44:21 +0900
Message-ID: <20190612084422.5344-19-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 826AAF89754
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:56 +0200 (CEST)
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
set packet format in pcm.hw_params callback.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c   | 14 +++++++---
 sound/firewire/oxfw/oxfw-pcm.c    | 26 +++++++++++-------
 sound/firewire/oxfw/oxfw-stream.c | 44 ++++++++++++++++++++++---------
 sound/firewire/oxfw/oxfw.h        |  7 ++---
 4 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 092493497f1a..9ba62778add2 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -19,8 +19,11 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	++oxfw->substreams_count;
-	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream, 0, 0);
+	err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream, 0, 0);
+	if (err >= 0) {
+		++oxfw->substreams_count;
+		err = snd_oxfw_stream_start_duplex(oxfw);
+	}
 
 	mutex_unlock(&oxfw->mutex);
 
@@ -41,8 +44,11 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	++oxfw->substreams_count;
-	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream, 0, 0);
+	err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->rx_stream, 0, 0);
+	if (err >= 0) {
+		++oxfw->substreams_count;
+		err = snd_oxfw_stream_start_duplex(oxfw);
+	}
 
 	mutex_unlock(&oxfw->mutex);
 
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 79c8e514bed9..b08b850d53ea 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -219,12 +219,18 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+		unsigned int channels = params_channels(hw_params);
+
 		mutex_lock(&oxfw->mutex);
-		++oxfw->substreams_count;
+		err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream,
+						     rate, channels);
+		if (err >= 0)
+			++oxfw->substreams_count;
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	return 0;
+	return err;
 }
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *hw_params)
@@ -238,8 +244,14 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+		unsigned int channels = params_channels(hw_params);
+
 		mutex_lock(&oxfw->mutex);
-		++oxfw->substreams_count;
+		err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream,
+						     rate, channels);
+		if (err >= 0)
+			++oxfw->substreams_count;
 		mutex_unlock(&oxfw->mutex);
 	}
 
@@ -280,12 +292,10 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream,
-					   runtime->rate, runtime->channels);
+	err = snd_oxfw_stream_start_duplex(oxfw);
 	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
@@ -297,12 +307,10 @@ static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 static int pcm_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream,
-					   runtime->rate, runtime->channels);
+	err = snd_oxfw_stream_start_duplex(oxfw);
 	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index ebfe0777773b..373154d8ee0e 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -236,16 +236,13 @@ static int init_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	return 0;
 }
 
-int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
-				 struct amdtp_stream *stream,
-				 unsigned int rate, unsigned int pcm_channels)
+int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
+				   struct amdtp_stream *stream,
+				   unsigned int rate, unsigned int pcm_channels)
 {
 	struct snd_oxfw_stream_formation formation;
 	enum avc_general_plug_dir dir;
-	int err = 0;
-
-	if (oxfw->substreams_count == 0)
-		return -EIO;
+	int err;
 
 	// Considering JACK/FFADO streaming:
 	// TODO: This can be removed hwdep functionality becomes popular.
@@ -266,14 +263,11 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
 	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
 	if (err < 0)
 		return err;
-	if (rate == 0)
+	if (rate == 0) {
 		rate = formation.rate;
-	if (pcm_channels == 0)
 		pcm_channels = formation.pcm;
-
-	if (formation.rate != rate || formation.pcm != pcm_channels ||
-	    amdtp_streaming_error(&oxfw->rx_stream) ||
-	    amdtp_streaming_error(&oxfw->tx_stream)) {
+	}
+	if (formation.rate != rate || formation.pcm != pcm_channels) {
 		amdtp_stream_stop(&oxfw->rx_stream);
 		cmp_connection_break(&oxfw->in_conn);
 
@@ -281,7 +275,10 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
 			amdtp_stream_stop(&oxfw->tx_stream);
 			cmp_connection_break(&oxfw->out_conn);
 		}
+	}
 
+	if (oxfw->substreams_count == 0 ||
+	    formation.rate != rate || formation.pcm != pcm_channels) {
 		err = set_stream_format(oxfw, stream, rate, pcm_channels);
 		if (err < 0) {
 			dev_err(&oxfw->unit->device,
@@ -290,6 +287,27 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
 		}
 	}
 
+	return 0;
+}
+
+int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	if (oxfw->substreams_count == 0)
+		return -EIO;
+
+	if (amdtp_streaming_error(&oxfw->rx_stream) ||
+	    amdtp_streaming_error(&oxfw->tx_stream)) {
+		amdtp_stream_stop(&oxfw->rx_stream);
+		cmp_connection_break(&oxfw->in_conn);
+
+		if (oxfw->has_output) {
+			amdtp_stream_stop(&oxfw->tx_stream);
+			cmp_connection_break(&oxfw->out_conn);
+		}
+	}
+
 	if (!amdtp_stream_running(&oxfw->rx_stream)) {
 		err = start_stream(oxfw, &oxfw->rx_stream);
 		if (err < 0) {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index e0c825288a24..d4d4926c28cf 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -99,9 +99,10 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 				unsigned short pid);
 
 int snd_oxfw_stream_init_duplex(struct snd_oxfw *oxfw);
-int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw,
-				  struct amdtp_stream *stream,
-				  unsigned int rate, unsigned int pcm_channels);
+int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
+				   struct amdtp_stream *stream,
+				   unsigned int rate, unsigned int pcm_channels);
+int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_update_duplex(struct snd_oxfw *oxfw);
-- 
2.20.1
