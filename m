From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: bebob: move mutex from function
	callee to callers
Date: Sat, 20 Feb 2016 16:18:57 +0900
Message-ID: <1455952739-17044-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1455952739-17044-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C90AE26145B
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

Currently, critical section is protected by mutex in functions of
fireworks_stream.c. Callers increments/decrements substreams counter
before calling the functions. Moving mutex to the callers code allows
to change type of the substream counter from atomic_t to unsigned int.

This commit is a preparation for obsoleting usage of atomic_t for
substream counter.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_midi.c   |  8 ++++++++
 sound/firewire/bebob/bebob_pcm.c    | 20 ++++++++++++++++----
 sound/firewire/bebob/bebob_stream.c |  7 -------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 90d95be..cb1b385 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -17,8 +17,10 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	if (err < 0)
 		goto end;
 
+	mutex_lock(&bebob->mutex);
 	atomic_inc(&bebob->substreams_counter);
 	err = snd_bebob_stream_start_duplex(bebob, 0);
+	mutex_unlock(&bebob->mutex);
 	if (err < 0)
 		snd_bebob_stream_lock_release(bebob);
 end:
@@ -34,8 +36,10 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	if (err < 0)
 		goto end;
 
+	mutex_lock(&bebob->mutex);
 	atomic_inc(&bebob->substreams_counter);
 	err = snd_bebob_stream_start_duplex(bebob, 0);
+	mutex_unlock(&bebob->mutex);
 	if (err < 0)
 		snd_bebob_stream_lock_release(bebob);
 end:
@@ -46,8 +50,10 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
+	mutex_lock(&bebob->mutex);
 	atomic_dec(&bebob->substreams_counter);
 	snd_bebob_stream_stop_duplex(bebob);
+	mutex_unlock(&bebob->mutex);
 
 	snd_bebob_stream_lock_release(bebob);
 	return 0;
@@ -57,8 +63,10 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
+	mutex_lock(&bebob->mutex);
 	atomic_dec(&bebob->substreams_counter);
 	snd_bebob_stream_stop_duplex(bebob);
+	mutex_unlock(&bebob->mutex);
 
 	snd_bebob_stream_lock_release(bebob);
 	return 0;
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index ef224d6..2053d31 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -218,8 +218,11 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&bebob->mutex);
 		atomic_inc(&bebob->substreams_counter);
+		mutex_unlock(&bebob->mutex);
+	}
 
 	amdtp_am824_set_pcm_format(&bebob->tx_stream, params_format(hw_params));
 
@@ -237,8 +240,11 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&bebob->mutex);
 		atomic_inc(&bebob->substreams_counter);
+		mutex_unlock(&bebob->mutex);
+	}
 
 	amdtp_am824_set_pcm_format(&bebob->rx_stream, params_format(hw_params));
 
@@ -250,8 +256,11 @@ pcm_capture_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&bebob->mutex);
 		atomic_dec(&bebob->substreams_counter);
+		mutex_unlock(&bebob->mutex);
+	}
 
 	snd_bebob_stream_stop_duplex(bebob);
 
@@ -262,8 +271,11 @@ pcm_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&bebob->mutex);
 		atomic_dec(&bebob->substreams_counter);
+		mutex_unlock(&bebob->mutex);
+	}
 
 	snd_bebob_stream_stop_duplex(bebob);
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 073ad6d..6809913 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -589,8 +589,6 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	unsigned int curr_rate;
 	int err = 0;
 
-	mutex_lock(&bebob->mutex);
-
 	/* Need no substreams */
 	if (atomic_read(&bebob->substreams_counter) == 0)
 		goto end;
@@ -722,7 +720,6 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 		}
 	}
 end:
-	mutex_unlock(&bebob->mutex);
 	return err;
 }
 
@@ -738,8 +735,6 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 		master = &bebob->tx_stream;
 	}
 
-	mutex_lock(&bebob->mutex);
-
 	if (atomic_read(&bebob->substreams_counter) == 0) {
 		amdtp_stream_pcm_abort(master);
 		amdtp_stream_stop(master);
@@ -749,8 +744,6 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 
 		break_both_connections(bebob);
 	}
-
-	mutex_unlock(&bebob->mutex);
 }
 
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
-- 
2.5.0
