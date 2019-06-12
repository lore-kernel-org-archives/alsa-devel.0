From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/19] ALSA: bebob: configure sampling transfer
	frequency in pcm.hw_params callback
Date: Wed, 12 Jun 2019 17:44:04 +0900
Message-ID: <20190612084422.5344-2-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05856F80794
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:30 +0200 (CEST)
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
 sound/firewire/bebob/bebob.h        |   3 +-
 sound/firewire/bebob/bebob_midi.c   |  22 +--
 sound/firewire/bebob/bebob_pcm.c    |  22 +--
 sound/firewire/bebob/bebob_stream.c | 212 ++++++++++++++--------------
 4 files changed, 136 insertions(+), 123 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index df1b1e94c43c..c30ed44aced9 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -218,7 +218,8 @@ int snd_bebob_stream_get_clock_src(struct snd_bebob *bebob,
 				   enum snd_bebob_clock_type *src);
 int snd_bebob_stream_discover(struct snd_bebob *bebob);
 int snd_bebob_stream_init_duplex(struct snd_bebob *bebob);
-int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate);
+int snd_bebob_stream_reserve_duplex(struct snd_bebob *bebob, unsigned int rate);
+int snd_bebob_stream_start_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 3befa3eca6ef..e2d3cad39d28 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -15,15 +15,18 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	err = snd_bebob_stream_lock_try(bebob);
 	if (err < 0)
-		goto end;
+		return err;
 
 	mutex_lock(&bebob->mutex);
-	bebob->substreams_counter++;
-	err = snd_bebob_stream_start_duplex(bebob, 0);
+	err = snd_bebob_stream_reserve_duplex(bebob, 0);
+	if (err >= 0) {
+		++bebob->substreams_counter;
+		err = snd_bebob_stream_start_duplex(bebob);
+	}
 	mutex_unlock(&bebob->mutex);
 	if (err < 0)
 		snd_bebob_stream_lock_release(bebob);
-end:
+
 	return err;
 }
 
@@ -34,15 +37,18 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	err = snd_bebob_stream_lock_try(bebob);
 	if (err < 0)
-		goto end;
+		return err;
 
 	mutex_lock(&bebob->mutex);
-	bebob->substreams_counter++;
-	err = snd_bebob_stream_start_duplex(bebob, 0);
+	err = snd_bebob_stream_reserve_duplex(bebob, 0);
+	if (err >= 0) {
+		++bebob->substreams_counter;
+		err = snd_bebob_stream_start_duplex(bebob);
+	}
 	mutex_unlock(&bebob->mutex);
 	if (err < 0)
 		snd_bebob_stream_lock_release(bebob);
-end:
+
 	return err;
 }
 
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index ea9b86450580..71b6ede31bb2 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -198,12 +198,16 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&bebob->mutex);
-		bebob->substreams_counter++;
+		err = snd_bebob_stream_reserve_duplex(bebob, rate);
+		if (err >= 0)
+			++bebob->substreams_counter;
 		mutex_unlock(&bebob->mutex);
 	}
 
-	return 0;
+	return err;
 }
 static int
 pcm_playback_hw_params(struct snd_pcm_substream *substream,
@@ -218,12 +222,16 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		unsigned int rate = params_rate(hw_params);
+
 		mutex_lock(&bebob->mutex);
-		bebob->substreams_counter++;
+		err = snd_bebob_stream_reserve_duplex(bebob, rate);
+		if (err >= 0)
+			++bebob->substreams_counter;
 		mutex_unlock(&bebob->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int
@@ -261,10 +269,9 @@ static int
 pcm_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	err = snd_bebob_stream_start_duplex(bebob, runtime->rate);
+	err = snd_bebob_stream_start_duplex(bebob);
 	if (err >= 0)
 		amdtp_stream_pcm_prepare(&bebob->tx_stream);
 
@@ -274,10 +281,9 @@ static int
 pcm_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	err = snd_bebob_stream_start_duplex(bebob, runtime->rate);
+	err = snd_bebob_stream_start_duplex(bebob);
 	if (err >= 0)
 		amdtp_stream_pcm_prepare(&bebob->rx_stream);
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 4d3034a68bdf..fcc93156d0b7 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -418,49 +418,28 @@ check_connection_used_by_others(struct snd_bebob *bebob, struct amdtp_stream *s)
 	return err;
 }
 
-static int
-make_both_connections(struct snd_bebob *bebob, unsigned int rate)
+static int make_both_connections(struct snd_bebob *bebob)
 {
-	int index, pcm_channels, midi_channels, err = 0;
+	int err = 0;
 
 	if (bebob->connected)
-		goto end;
-
-	/* confirm params for both streams */
-	err = get_formation_index(rate, &index);
-	if (err < 0)
-		goto end;
-	pcm_channels = bebob->tx_stream_formations[index].pcm;
-	midi_channels = bebob->tx_stream_formations[index].midi;
-	err = amdtp_am824_set_parameters(&bebob->tx_stream, rate,
-					 pcm_channels, midi_channels * 8,
-					 false);
-	if (err < 0)
-		goto end;
-
-	pcm_channels = bebob->rx_stream_formations[index].pcm;
-	midi_channels = bebob->rx_stream_formations[index].midi;
-	err = amdtp_am824_set_parameters(&bebob->rx_stream, rate,
-					 pcm_channels, midi_channels * 8,
-					 false);
-	if (err < 0)
-		goto end;
+		return 0;
 
-	/* establish connections for both streams */
 	err = cmp_connection_establish(&bebob->out_conn,
 			amdtp_stream_get_max_payload(&bebob->tx_stream));
 	if (err < 0)
-		goto end;
+		return err;
+
 	err = cmp_connection_establish(&bebob->in_conn,
 			amdtp_stream_get_max_payload(&bebob->rx_stream));
 	if (err < 0) {
 		cmp_connection_break(&bebob->out_conn);
-		goto end;
+		return err;
 	}
 
 	bebob->connected = true;
-end:
-	return err;
+
+	return 0;
 }
 
 static void
@@ -484,8 +463,7 @@ destroy_both_connections(struct snd_bebob *bebob)
 }
 
 static int
-start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream,
-	     unsigned int rate)
+start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
 {
 	struct cmp_connection *conn;
 	int err = 0;
@@ -555,132 +533,154 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	return err;
 }
 
-int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
+static int keep_resources(struct snd_bebob *bebob, struct amdtp_stream *stream,
+			  unsigned int rate, unsigned int index)
 {
-	const struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
-	unsigned int curr_rate;
-	int err = 0;
+	struct snd_bebob_stream_formation *formation;
 
-	/* Need no substreams */
-	if (bebob->substreams_counter == 0)
-		goto end;
+	if (stream == &bebob->tx_stream)
+		formation = bebob->tx_stream_formations + index;
+	else
+		formation = bebob->rx_stream_formations + index;
 
-	/*
-	 * Considering JACK/FFADO streaming:
-	 * TODO: This can be removed hwdep functionality becomes popular.
-	 */
+	return amdtp_am824_set_parameters(stream, rate, formation->pcm,
+					  formation->midi, false);
+}
+
+int snd_bebob_stream_reserve_duplex(struct snd_bebob *bebob, unsigned int rate)
+{
+	unsigned int curr_rate;
+	int err;
+
+	// Considering JACK/FFADO streaming:
+	// TODO: This can be removed hwdep functionality becomes popular.
 	err = check_connection_used_by_others(bebob, &bebob->rx_stream);
 	if (err < 0)
-		goto end;
+		return err;
 
-	/*
-	 * packet queueing error or detecting discontinuity
-	 *
-	 * At bus reset, connections should not be broken here. So streams need
-	 * to be re-started. This is a reason to use SKIP_INIT_DBC_CHECK flag.
-	 */
-	if (amdtp_streaming_error(&bebob->rx_stream))
-		amdtp_stream_stop(&bebob->rx_stream);
-	if (amdtp_streaming_error(&bebob->tx_stream))
+	err = bebob->spec->rate->get(bebob, &curr_rate);
+	if (err < 0)
+		return err;
+	if (rate == 0)
+		rate = curr_rate;
+	if (curr_rate != rate) {
 		amdtp_stream_stop(&bebob->tx_stream);
-	if (!amdtp_stream_running(&bebob->rx_stream) &&
-	    !amdtp_stream_running(&bebob->tx_stream))
+		amdtp_stream_stop(&bebob->rx_stream);
+
 		break_both_connections(bebob);
+	}
 
-	/* stop streams if rate is different */
-	err = rate_spec->get(bebob, &curr_rate);
-	if (err < 0) {
-		dev_err(&bebob->unit->device,
-			"fail to get sampling rate: %d\n", err);
-		goto end;
+	if (bebob->substreams_counter == 0 || curr_rate != rate) {
+		unsigned int index;
+
+		// NOTE:
+		// If establishing connections at first, Yamaha GO46
+		// (and maybe Terratec X24) don't generate sound.
+		//
+		// For firmware customized by M-Audio, refer to next NOTE.
+		err = bebob->spec->rate->set(bebob, rate);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to set sampling rate: %d\n",
+				err);
+			return err;
+		}
+
+		err = get_formation_index(rate, &index);
+		if (err < 0)
+			return err;
+
+		err = keep_resources(bebob, &bebob->tx_stream, rate, index);
+		if (err < 0)
+			return err;
+
+		err = keep_resources(bebob, &bebob->rx_stream, rate, index);
+		if (err < 0)
+			return err;
 	}
-	if (rate == 0)
-		rate = curr_rate;
-	if (rate != curr_rate) {
+
+	return 0;
+}
+
+int snd_bebob_stream_start_duplex(struct snd_bebob *bebob)
+{
+	int err;
+
+	// Need no substreams.
+	if (bebob->substreams_counter == 0)
+		return -EIO;
+
+	// packet queueing error or detecting discontinuity
+	if (amdtp_streaming_error(&bebob->rx_stream) ||
+	    amdtp_streaming_error(&bebob->tx_stream)) {
 		amdtp_stream_stop(&bebob->rx_stream);
 		amdtp_stream_stop(&bebob->tx_stream);
+
 		break_both_connections(bebob);
 	}
 
-	/* master should be always running */
 	if (!amdtp_stream_running(&bebob->rx_stream)) {
-		/*
-		 * NOTE:
-		 * If establishing connections at first, Yamaha GO46
-		 * (and maybe Terratec X24) don't generate sound.
-		 *
-		 * For firmware customized by M-Audio, refer to next NOTE.
-		 */
-		if (bebob->maudio_special_quirk == NULL) {
-			err = rate_spec->set(bebob, rate);
-			if (err < 0) {
-				dev_err(&bebob->unit->device,
-					"fail to set sampling rate: %d\n",
-					err);
-				goto end;
-			}
+		unsigned int curr_rate;
+
+		if (bebob->maudio_special_quirk) {
+			err = bebob->spec->rate->get(bebob, &curr_rate);
+			if (err < 0)
+				return err;
 		}
 
-		err = make_both_connections(bebob, rate);
+		err = make_both_connections(bebob);
 		if (err < 0)
-			goto end;
+			return err;
 
-		err = start_stream(bebob, &bebob->rx_stream, rate);
+		err = start_stream(bebob, &bebob->rx_stream);
 		if (err < 0) {
 			dev_err(&bebob->unit->device,
 				"fail to run AMDTP master stream:%d\n", err);
-			break_both_connections(bebob);
-			goto end;
+			goto error;
 		}
 
-		/*
-		 * NOTE:
-		 * The firmware customized by M-Audio uses these commands to
-		 * start transmitting stream. This is not usual way.
-		 */
-		if (bebob->maudio_special_quirk != NULL) {
-			err = rate_spec->set(bebob, rate);
+		// NOTE:
+		// The firmware customized by M-Audio uses these commands to
+		// start transmitting stream. This is not usual way.
+		if (bebob->maudio_special_quirk) {
+			err = bebob->spec->rate->set(bebob, curr_rate);
 			if (err < 0) {
 				dev_err(&bebob->unit->device,
 					"fail to ensure sampling rate: %d\n",
 					err);
-				amdtp_stream_stop(&bebob->rx_stream);
-				break_both_connections(bebob);
-				goto end;
+				goto error;
 			}
 		}
 
-		/* wait first callback */
 		if (!amdtp_stream_wait_callback(&bebob->rx_stream,
 						CALLBACK_TIMEOUT)) {
 			amdtp_stream_stop(&bebob->rx_stream);
 			break_both_connections(bebob);
 			err = -ETIMEDOUT;
-			goto end;
+			goto error;
 		}
 	}
 
-	/* start slave if needed */
 	if (!amdtp_stream_running(&bebob->tx_stream)) {
-		err = start_stream(bebob, &bebob->tx_stream, rate);
+		err = start_stream(bebob, &bebob->tx_stream);
 		if (err < 0) {
 			dev_err(&bebob->unit->device,
 				"fail to run AMDTP slave stream:%d\n", err);
-			amdtp_stream_stop(&bebob->rx_stream);
-			break_both_connections(bebob);
-			goto end;
+			goto error;
 		}
 
-		/* wait first callback */
 		if (!amdtp_stream_wait_callback(&bebob->tx_stream,
 						CALLBACK_TIMEOUT)) {
-			amdtp_stream_stop(&bebob->tx_stream);
-			amdtp_stream_stop(&bebob->rx_stream);
-			break_both_connections(bebob);
 			err = -ETIMEDOUT;
+			goto error;
 		}
 	}
-end:
+
+	return 0;
+error:
+	amdtp_stream_stop(&bebob->tx_stream);
+	amdtp_stream_stop(&bebob->rx_stream);
+	break_both_connections(bebob);
 	return err;
 }
 
-- 
2.20.1
