From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: fireworks: change type of substream
	counter from atomic_t to unsigned int
Date: Sat, 14 Nov 2015 16:54:51 +0900
Message-ID: <1447487691-26037-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1447487691-26037-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E2198261498
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 08:54:56 +0100 (CET)
In-Reply-To: <1447487691-26037-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The counter is incremented/decremented in critical section protected with
mutex. Therefore, no need to use atomic_t.

This commit changes the type to unsigned int.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.h        |  4 ++--
 sound/firewire/fireworks/fireworks_midi.c   |  8 ++++----
 sound/firewire/fireworks/fireworks_pcm.c    |  8 ++++----
 sound/firewire/fireworks/fireworks_stream.c | 25 ++++++++++++-------------
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index c7cb7de..96c4e0c 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -86,8 +86,8 @@ struct snd_efw {
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
-	atomic_t capture_substreams;
-	atomic_t playback_substreams;
+	unsigned int capture_substreams;
+	unsigned int playback_substreams;
 
 	/* hardware metering parameters */
 	unsigned int phys_out;
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index 38232dc..3e8c4cf 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -18,7 +18,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&efw->mutex);
-	atomic_inc(&efw->capture_substreams);
+	efw->capture_substreams++;
 	err = snd_efw_stream_start_duplex(efw, 0);
 	mutex_unlock(&efw->mutex);
 	if (err < 0)
@@ -38,7 +38,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&efw->mutex);
-	atomic_inc(&efw->playback_substreams);
+	efw->playback_substreams++;
 	err = snd_efw_stream_start_duplex(efw, 0);
 	mutex_unlock(&efw->mutex);
 	if (err < 0)
@@ -52,7 +52,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 	struct snd_efw *efw = substream->rmidi->private_data;
 
 	mutex_lock(&efw->mutex);
-	atomic_dec(&efw->capture_substreams);
+	efw->capture_substreams--;
 	snd_efw_stream_stop_duplex(efw);
 	mutex_unlock(&efw->mutex);
 
@@ -65,7 +65,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	struct snd_efw *efw = substream->rmidi->private_data;
 
 	mutex_lock(&efw->mutex);
-	atomic_dec(&efw->playback_substreams);
+	efw->playback_substreams--;
 	snd_efw_stream_stop_duplex(efw);
 	mutex_unlock(&efw->mutex);
 
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 69f15a6..f4fbf75 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -253,7 +253,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		atomic_inc(&efw->capture_substreams);
+		efw->capture_substreams++;
 		mutex_unlock(&efw->mutex);
 	}
 
@@ -274,7 +274,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		atomic_inc(&efw->playback_substreams);
+		efw->playback_substreams++;
 		mutex_unlock(&efw->mutex);
 	}
 
@@ -289,7 +289,7 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		atomic_dec(&efw->capture_substreams);
+		efw->capture_substreams--;
 		mutex_unlock(&efw->mutex);
 	}
 
@@ -303,7 +303,7 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&efw->mutex);
-		atomic_dec(&efw->playback_substreams);
+		efw->playback_substreams--;
 		mutex_unlock(&efw->mutex);
 	}
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 6930745..968a40a 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -209,14 +209,13 @@ end:
 int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 {
 	struct amdtp_stream *master, *slave;
-	atomic_t *slave_substreams;
+	unsigned int slave_substreams;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
 	int err = 0;
 
 	/* Need no substreams */
-	if ((atomic_read(&efw->playback_substreams) == 0) &&
-	    (atomic_read(&efw->capture_substreams)  == 0))
+	if (efw->playback_substreams == 0 && efw->capture_substreams  == 0)
 		goto end;
 
 	err = get_sync_mode(efw, &sync_mode);
@@ -225,11 +224,11 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	if (sync_mode == CIP_SYNC_TO_DEVICE) {
 		master = &efw->tx_stream;
 		slave  = &efw->rx_stream;
-		slave_substreams  = &efw->playback_substreams;
+		slave_substreams  = efw->playback_substreams;
 	} else {
 		master = &efw->rx_stream;
 		slave  = &efw->tx_stream;
-		slave_substreams = &efw->capture_substreams;
+		slave_substreams = efw->capture_substreams;
 	}
 
 	/*
@@ -275,7 +274,7 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	}
 
 	/* start slave if needed */
-	if (atomic_read(slave_substreams) > 0 && !amdtp_stream_running(slave)) {
+	if (slave_substreams > 0 && !amdtp_stream_running(slave)) {
 		err = start_stream(efw, slave, rate);
 		if (err < 0) {
 			dev_err(&efw->unit->device,
@@ -290,24 +289,24 @@ end:
 void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 {
 	struct amdtp_stream *master, *slave;
-	atomic_t *master_substreams, *slave_substreams;
+	unsigned int master_substreams, slave_substreams;
 
 	if (efw->master == &efw->rx_stream) {
 		slave  = &efw->tx_stream;
 		master = &efw->rx_stream;
-		slave_substreams  = &efw->capture_substreams;
-		master_substreams = &efw->playback_substreams;
+		slave_substreams  = efw->capture_substreams;
+		master_substreams = efw->playback_substreams;
 	} else {
 		slave  = &efw->rx_stream;
 		master = &efw->tx_stream;
-		slave_substreams  = &efw->playback_substreams;
-		master_substreams = &efw->capture_substreams;
+		slave_substreams  = efw->playback_substreams;
+		master_substreams = efw->capture_substreams;
 	}
 
-	if (atomic_read(slave_substreams) == 0) {
+	if (slave_substreams == 0) {
 		stop_stream(efw, slave);
 
-		if (atomic_read(master_substreams) == 0)
+		if (master_substreams == 0)
 			stop_stream(efw, master);
 	}
 }
-- 
2.5.0
