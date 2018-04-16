From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: pcm: Unify playback and capture poll
	callbacks
Date: Mon, 16 Apr 2018 14:14:16 +0200
Message-ID: <20180416121417.27452-3-tiwai@suse.de>
References: <20180416121417.27452-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 69199267217
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 14:14:19 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0036AE1B
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 12:14:18 +0000 (UTC)
In-Reply-To: <20180416121417.27452-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The poll callbacks for playback and capture directions are doing
fairly similar but with a slight difference.  This patch unifies the
two functions into a single callback.  The advantage of this
refactoring is that the direction-specific procedures become clearer.

There should be no functional change but only the code cleanup.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 74 +++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 55 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f69d89c907b9..eddb0cd6d1eb 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3095,82 +3095,46 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	return result;
 }
 
-static __poll_t snd_pcm_playback_poll(struct file *file, poll_table * wait)
+static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-        __poll_t mask;
+	__poll_t mask, ok;
 	snd_pcm_uframes_t avail;
 
 	pcm_file = file->private_data;
 
 	substream = pcm_file->substream;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ok = EPOLLOUT | EPOLLWRNORM;
+	else
+		ok = EPOLLIN | EPOLLRDNORM;
 	if (PCM_RUNTIME_CHECK(substream))
-		return EPOLLOUT | EPOLLWRNORM | EPOLLERR;
-	runtime = substream->runtime;
-
-	poll_wait(file, &runtime->sleep, wait);
-
-	snd_pcm_stream_lock_irq(substream);
-	avail = snd_pcm_playback_avail(runtime);
-	switch (runtime->status->state) {
-	case SNDRV_PCM_STATE_RUNNING:
-	case SNDRV_PCM_STATE_PREPARED:
-	case SNDRV_PCM_STATE_PAUSED:
-		if (avail >= runtime->control->avail_min) {
-			mask = EPOLLOUT | EPOLLWRNORM;
-			break;
-		}
-		/* Fall through */
-	case SNDRV_PCM_STATE_DRAINING:
-		mask = 0;
-		break;
-	default:
-		mask = EPOLLOUT | EPOLLWRNORM | EPOLLERR;
-		break;
-	}
-	snd_pcm_stream_unlock_irq(substream);
-	return mask;
-}
-
-static __poll_t snd_pcm_capture_poll(struct file *file, poll_table * wait)
-{
-	struct snd_pcm_file *pcm_file;
-	struct snd_pcm_substream *substream;
-	struct snd_pcm_runtime *runtime;
-        __poll_t mask;
-	snd_pcm_uframes_t avail;
+		return ok | EPOLLERR;
 
-	pcm_file = file->private_data;
-
-	substream = pcm_file->substream;
-	if (PCM_RUNTIME_CHECK(substream))
-		return EPOLLIN | EPOLLRDNORM | EPOLLERR;
 	runtime = substream->runtime;
-
 	poll_wait(file, &runtime->sleep, wait);
 
+	mask = 0;
 	snd_pcm_stream_lock_irq(substream);
-	avail = snd_pcm_capture_avail(runtime);
+	avail = snd_pcm_avail(substream);
 	switch (runtime->status->state) {
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_PAUSED:
-		if (avail >= runtime->control->avail_min) {
-			mask = EPOLLIN | EPOLLRDNORM;
-			break;
-		}
-		mask = 0;
+		if (avail >= runtime->control->avail_min)
+			mask = ok;
 		break;
 	case SNDRV_PCM_STATE_DRAINING:
-		if (avail > 0) {
-			mask = EPOLLIN | EPOLLRDNORM;
-			break;
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+			mask = ok;
+			if (!avail)
+				mask |= EPOLLERR;
 		}
-		/* Fall through */
+		break;
 	default:
-		mask = EPOLLIN | EPOLLRDNORM | EPOLLERR;
+		mask = ok | EPOLLERR;
 		break;
 	}
 	snd_pcm_stream_unlock_irq(substream);
@@ -3662,7 +3626,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.open =			snd_pcm_playback_open,
 		.release =		snd_pcm_release,
 		.llseek =		no_llseek,
-		.poll =			snd_pcm_playback_poll,
+		.poll =			snd_pcm_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
@@ -3676,7 +3640,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.open =			snd_pcm_capture_open,
 		.release =		snd_pcm_release,
 		.llseek =		no_llseek,
-		.poll =			snd_pcm_capture_poll,
+		.poll =			snd_pcm_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
-- 
2.16.3
