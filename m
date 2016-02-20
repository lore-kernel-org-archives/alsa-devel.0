From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: bebob: change type of substream
	counter from atomic_t to unsigned int
Date: Sat, 20 Feb 2016 16:18:58 +0900
Message-ID: <1455952739-17044-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1455952739-17044-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C5121261298
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 08:19:04 +0100 (CET)
In-Reply-To: <1455952739-17044-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

The counter is incremented/decremented in critical section protected with
mutex. Therefore, no need to use atomic_t.

This commit changes the type to unsigned int.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h        | 2 +-
 sound/firewire/bebob/bebob_midi.c   | 8 ++++----
 sound/firewire/bebob/bebob_pcm.c    | 8 ++++----
 sound/firewire/bebob/bebob_stream.c | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index c2e885c..4fe58e4 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -95,7 +95,7 @@ struct snd_bebob {
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
-	atomic_t substreams_counter;
+	unsigned int substreams_counter;
 
 	struct snd_bebob_stream_formation
 		tx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index cb1b385..868eb0d 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -18,7 +18,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&bebob->mutex);
-	atomic_inc(&bebob->substreams_counter);
+	bebob->substreams_counter++;
 	err = snd_bebob_stream_start_duplex(bebob, 0);
 	mutex_unlock(&bebob->mutex);
 	if (err < 0)
@@ -37,7 +37,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 		goto end;
 
 	mutex_lock(&bebob->mutex);
-	atomic_inc(&bebob->substreams_counter);
+	bebob->substreams_counter++;
 	err = snd_bebob_stream_start_duplex(bebob, 0);
 	mutex_unlock(&bebob->mutex);
 	if (err < 0)
@@ -51,7 +51,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
 	mutex_lock(&bebob->mutex);
-	atomic_dec(&bebob->substreams_counter);
+	bebob->substreams_counter--;
 	snd_bebob_stream_stop_duplex(bebob);
 	mutex_unlock(&bebob->mutex);
 
@@ -64,7 +64,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
 	mutex_lock(&bebob->mutex);
-	atomic_dec(&bebob->substreams_counter);
+	bebob->substreams_counter--;
 	snd_bebob_stream_stop_duplex(bebob);
 	mutex_unlock(&bebob->mutex);
 
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 2053d31..5d7b934 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -220,7 +220,7 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&bebob->mutex);
-		atomic_inc(&bebob->substreams_counter);
+		bebob->substreams_counter++;
 		mutex_unlock(&bebob->mutex);
 	}
 
@@ -242,7 +242,7 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&bebob->mutex);
-		atomic_inc(&bebob->substreams_counter);
+		bebob->substreams_counter++;
 		mutex_unlock(&bebob->mutex);
 	}
 
@@ -258,7 +258,7 @@ pcm_capture_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&bebob->mutex);
-		atomic_dec(&bebob->substreams_counter);
+		bebob->substreams_counter--;
 		mutex_unlock(&bebob->mutex);
 	}
 
@@ -273,7 +273,7 @@ pcm_playback_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
 		mutex_lock(&bebob->mutex);
-		atomic_dec(&bebob->substreams_counter);
+		bebob->substreams_counter--;
 		mutex_unlock(&bebob->mutex);
 	}
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 6809913..8c68745 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -590,7 +590,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	int err = 0;
 
 	/* Need no substreams */
-	if (atomic_read(&bebob->substreams_counter) == 0)
+	if (bebob->substreams_counter == 0)
 		goto end;
 
 	err = get_sync_mode(bebob, &sync_mode);
@@ -735,7 +735,7 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 		master = &bebob->tx_stream;
 	}
 
-	if (atomic_read(&bebob->substreams_counter) == 0) {
+	if (bebob->substreams_counter == 0) {
 		amdtp_stream_pcm_abort(master);
 		amdtp_stream_stop(master);
 
-- 
2.5.0
