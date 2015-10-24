From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: fireworks: move mutex from function
	callees to callers
Date: Sat, 24 Oct 2015 11:28:31 +0900
Message-ID: <1445653712-14234-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1445653712-14234-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D9F8265680
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 04:28:41 +0200 (CEST)
In-Reply-To: <1445653712-14234-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, critical section is protected by mutex in functions of
fireworks_stream.c. Callers increments/decrements substreams counter
before calling the functions. Moving mutex to the callers side allows
to change type of the substeram counter from atomic_t to unsigned int.

This commit is a preparation for obsoleting the usage of atomic_t for
substream counter.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_midi.c   |  8 ++++++++
 sound/firewire/fireworks/fireworks_pcm.c    | 20 ++++++++++++++++----
 sound/firewire/fireworks/fireworks_stream.c |  7 -------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index fba01bb..38232dc 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -17,8 +17,10 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	if (err < 0)
 		goto end;
 
+	mutex_lock(&efw->mutex);
 	atomic_inc(&efw->capture_substreams);
 	err = snd_efw_stream_start_duplex(efw, 0);
+	mutex_unlock(&efw->mutex);
 	if (err < 0)
 		snd_efw_stream_lock_release(efw);
 
@@ -35,8 +37,10 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	if (err < 0)
 		goto end;
 
+	mutex_lock(&efw->mutex);
 	atomic_inc(&efw->playback_substreams);
 	err = snd_efw_stream_start_duplex(efw, 0);
+	mutex_unlock(&efw->mutex);
 	if (err < 0)
 		snd_efw_stream_lock_release(efw);
 end:
@@ -47,8 +51,10 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_efw *efw = substream->rmidi->private_data;
 
+	mutex_lock(&efw->mutex);
 	atomic_dec(&efw->capture_substreams);
 	snd_efw_stream_stop_duplex(efw);
+	mutex_unlock(&efw->mutex);
 
 	snd_efw_stream_lock_release(efw);
 	return 0;
@@ -58,8 +64,10 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_efw *efw = substream->rmidi->private_data;
 
+	mutex_lock(&efw->mutex);
 	atomic_dec(&efw->playback_substreams);
 	snd_efw_stream_stop_duplex(efw);
+	mutex_unlock(&efw->mutex);
 
 	snd_efw_stream_lock_release(efw);
 	return 0;
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index d27135b..69f15a6 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -251,8 +251,11 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&efw->mutex);
 		atomic_inc(&efw->capture_substreams);
+		mutex_unlock(&efw->mutex);
+	}
 
 	amdtp_am824_set_pcm_format(&efw->tx_stream, params_format(hw_params));
 
@@ -269,8 +272,11 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&efw->mutex);
 		atomic_inc(&efw->playback_substreams);
+		mutex_unlock(&efw->mutex);
+	}
 
 	amdtp_am824_set_pcm_format(&efw->rx_stream, params_format(hw_params));
 
@@ -281,8 +287,11 @@ static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&efw->mutex);
 		atomic_dec(&efw->capture_substreams);
+		mutex_unlock(&efw->mutex);
+	}
 
 	snd_efw_stream_stop_duplex(efw);
 
@@ -292,8 +301,11 @@ static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&efw->mutex);
 		atomic_dec(&efw->playback_substreams);
+		mutex_unlock(&efw->mutex);
+	}
 
 	snd_efw_stream_stop_duplex(efw);
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 759f6e3..6930745 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -214,8 +214,6 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	unsigned int curr_rate;
 	int err = 0;
 
-	mutex_lock(&efw->mutex);
-
 	/* Need no substreams */
 	if ((atomic_read(&efw->playback_substreams) == 0) &&
 	    (atomic_read(&efw->capture_substreams)  == 0))
@@ -286,7 +284,6 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 		}
 	}
 end:
-	mutex_unlock(&efw->mutex);
 	return err;
 }
 
@@ -307,16 +304,12 @@ void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 		master_substreams = &efw->capture_substreams;
 	}
 
-	mutex_lock(&efw->mutex);
-
 	if (atomic_read(slave_substreams) == 0) {
 		stop_stream(efw, slave);
 
 		if (atomic_read(master_substreams) == 0)
 			stop_stream(efw, master);
 	}
-
-	mutex_unlock(&efw->mutex);
 }
 
 void snd_efw_stream_update_duplex(struct snd_efw *efw)
-- 
2.1.4
