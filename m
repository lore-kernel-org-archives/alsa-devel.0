From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/11] ALSA: bebob: keep duplex streams always
	to keep internal multiplexer properly
Date: Mon,  8 Jun 2015 23:31:07 +0900
Message-ID: <1433773868-17505-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F352604D5
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 16:31:17 +0200 (CEST)
In-Reply-To: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Behringer FCA610 transmits packets with periodic noisy PCM samples
when receiving no streams, and generates a bit noisy sound.

ALSA BeBoB driver is programmed to establish both in/out connections
when starting streaming, then transfers packets as userspace applications
requested. This means that there's a case that one of incoming/outgoing
streams is running, to save CPU and bandwidth usage. Although, it's natural
to start transferring packets in both direction.

This commit makes this driver to keeps duplex streams always.

Tested-by: Kim Tore Jensen <kim@incendio.no>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h        |  3 +--
 sound/firewire/bebob/bebob_midi.c   |  8 ++++----
 sound/firewire/bebob/bebob_pcm.c    |  8 ++++----
 sound/firewire/bebob/bebob_stream.c | 24 +++++++-----------------
 4 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 6359fb0..d9a8ab8 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -97,8 +97,7 @@ struct snd_bebob {
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
-	atomic_t capture_substreams;
-	atomic_t playback_substreams;
+	atomic_t substreams_counter;
 
 	struct snd_bebob_stream_formation
 		tx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 63343d5..5681143 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -17,7 +17,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	if (err < 0)
 		goto end;
 
-	atomic_inc(&bebob->capture_substreams);
+	atomic_inc(&bebob->substreams_counter);
 	err = snd_bebob_stream_start_duplex(bebob, 0);
 	if (err < 0)
 		snd_bebob_stream_lock_release(bebob);
@@ -34,7 +34,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	if (err < 0)
 		goto end;
 
-	atomic_inc(&bebob->playback_substreams);
+	atomic_inc(&bebob->substreams_counter);
 	err = snd_bebob_stream_start_duplex(bebob, 0);
 	if (err < 0)
 		snd_bebob_stream_lock_release(bebob);
@@ -46,7 +46,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
-	atomic_dec(&bebob->capture_substreams);
+	atomic_dec(&bebob->substreams_counter);
 	snd_bebob_stream_stop_duplex(bebob);
 
 	snd_bebob_stream_lock_release(bebob);
@@ -57,7 +57,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
-	atomic_dec(&bebob->playback_substreams);
+	atomic_dec(&bebob->substreams_counter);
 	snd_bebob_stream_stop_duplex(bebob);
 
 	snd_bebob_stream_lock_release(bebob);
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index e0a6b06..7a2c1f5 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -213,7 +213,7 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	struct snd_bebob *bebob = substream->private_data;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
-		atomic_inc(&bebob->capture_substreams);
+		atomic_inc(&bebob->substreams_counter);
 	amdtp_stream_set_pcm_format(&bebob->tx_stream,
 				    params_format(hw_params));
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -226,7 +226,7 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	struct snd_bebob *bebob = substream->private_data;
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
-		atomic_inc(&bebob->playback_substreams);
+		atomic_inc(&bebob->substreams_counter);
 	amdtp_stream_set_pcm_format(&bebob->rx_stream,
 				    params_format(hw_params));
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -239,7 +239,7 @@ pcm_capture_hw_free(struct snd_pcm_substream *substream)
 	struct snd_bebob *bebob = substream->private_data;
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		atomic_dec(&bebob->capture_substreams);
+		atomic_dec(&bebob->substreams_counter);
 
 	snd_bebob_stream_stop_duplex(bebob);
 
@@ -251,7 +251,7 @@ pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	struct snd_bebob *bebob = substream->private_data;
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-		atomic_dec(&bebob->playback_substreams);
+		atomic_dec(&bebob->substreams_counter);
 
 	snd_bebob_stream_stop_duplex(bebob);
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index d0df6c1..5be5242 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -574,7 +574,6 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 {
 	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
 	struct amdtp_stream *master, *slave;
-	atomic_t *slave_substreams;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
 	bool updated = false;
@@ -599,8 +598,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	mutex_lock(&bebob->mutex);
 
 	/* Need no substreams */
-	if (atomic_read(&bebob->playback_substreams) == 0 &&
-	    atomic_read(&bebob->capture_substreams)  == 0)
+	if (atomic_read(&bebob->substreams_counter) == 0)
 		goto end;
 
 	err = get_sync_mode(bebob, &sync_mode);
@@ -609,11 +607,9 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	if (sync_mode == CIP_SYNC_TO_DEVICE) {
 		master = &bebob->tx_stream;
 		slave  = &bebob->rx_stream;
-		slave_substreams = &bebob->playback_substreams;
 	} else {
 		master = &bebob->rx_stream;
 		slave  = &bebob->tx_stream;
-		slave_substreams = &bebob->capture_substreams;
 	}
 
 	/*
@@ -714,7 +710,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	}
 
 	/* start slave if needed */
-	if (atomic_read(slave_substreams) > 0 && !amdtp_stream_running(slave)) {
+	if (!amdtp_stream_running(slave)) {
 		err = start_stream(bebob, slave, rate);
 		if (err < 0) {
 			dev_err(&bebob->unit->device,
@@ -740,31 +736,25 @@ end:
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 {
 	struct amdtp_stream *master, *slave;
-	atomic_t *master_substreams, *slave_substreams;
 
 	if (bebob->master == &bebob->rx_stream) {
 		slave  = &bebob->tx_stream;
 		master = &bebob->rx_stream;
-		slave_substreams  = &bebob->capture_substreams;
-		master_substreams = &bebob->playback_substreams;
 	} else {
 		slave  = &bebob->rx_stream;
 		master = &bebob->tx_stream;
-		slave_substreams  = &bebob->playback_substreams;
-		master_substreams = &bebob->capture_substreams;
 	}
 
 	mutex_lock(&bebob->mutex);
 
-	if (atomic_read(slave_substreams) == 0) {
+	if (atomic_read(&bebob->substreams_counter) == 0) {
+		amdtp_stream_pcm_abort(master);
+		amdtp_stream_stop(master);
+
 		amdtp_stream_pcm_abort(slave);
 		amdtp_stream_stop(slave);
 
-		if (atomic_read(master_substreams) == 0) {
-			amdtp_stream_pcm_abort(master);
-			amdtp_stream_stop(master);
-			break_both_connections(bebob);
-		}
+		break_both_connections(bebob);
 	}
 
 	mutex_unlock(&bebob->mutex);
-- 
2.1.4
