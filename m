From: <twischer@de.adit-jv.com>
Subject: [PATCH 04/10] ALSA: aloop: Use always spin_lock_irqsave() for cable->lock
Date: Mon, 25 Mar 2019 17:00:38 +0100
Message-ID: <1553529644-5654-5-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

to allow the usage of timer callbacks from interrupt context.
For example the sound timer.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 11e8ed6..c6217c4 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -272,6 +272,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
 	int err = 0, stream = 1 << substream->stream;
+	unsigned long flags;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -281,39 +282,39 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		dpcm->last_jiffies = jiffies;
 		dpcm->pcm_rate_shift = 0;
 		dpcm->last_drift = 0;
-		spin_lock(&cable->lock);	
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->running |= stream;
 		cable->pause &= ~stream;
 		err = loopback_timer_start(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		spin_lock(&cable->lock);	
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->running &= ~stream;
 		cable->pause &= ~stream;
 		err = loopback_timer_stop(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		spin_lock(&cable->lock);	
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->pause |= stream;
 		err = loopback_timer_stop(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		spin_lock(&cable->lock);
+		spin_lock_irqsave(&cable->lock, flags);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
 		err = loopback_timer_start(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
@@ -557,12 +558,13 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback_pcm *dpcm = runtime->private_data;
+	unsigned long flags;
 	snd_pcm_uframes_t pos;
 
-	spin_lock(&dpcm->cable->lock);
+	spin_lock_irqsave(&dpcm->cable->lock, flags);
 	loopback_pos_update(dpcm->cable);
 	pos = dpcm->buf_pos;
-	spin_unlock(&dpcm->cable->lock);
+	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
 	return bytes_to_frames(runtime, pos);
 }
 
@@ -679,10 +681,12 @@ static void free_cable(struct snd_pcm_substream *substream)
 	if (!cable)
 		return;
 	if (cable->streams[!substream->stream]) {
+		unsigned long flags;
+
 		/* other stream is still alive */
-		spin_lock_irq(&cable->lock);
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->streams[substream->stream] = NULL;
-		spin_unlock_irq(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -698,6 +702,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	struct loopback_cable *cable = NULL;
 	int err = 0;
 	int dev = get_cable_index(substream);
+	unsigned long flags;
 
 	mutex_lock(&loopback->cable_lock);
 	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
@@ -753,9 +758,9 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	else
 		runtime->hw = cable->hw;
 
-	spin_lock_irq(&cable->lock);
+	spin_lock_irqsave(&cable->lock, flags);
 	cable->streams[substream->stream] = dpcm;
-	spin_unlock_irq(&cable->lock);
+	spin_unlock_irqrestore(&cable->lock, flags);
 
  unlock:
 	if (err < 0) {
-- 
2.7.4
