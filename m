From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 17/27] ALSA: pcm: Check PCM state by a common helper function
Date: Thu,  1 Jun 2017 22:58:40 +0200
Message-ID: <20170601205850.24993-18-tiwai@suse.de>
References: <20170601205850.24993-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170601205850.24993-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/core/pcm_lib.c | 81 +++++++++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 52 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 0db8d4e0fca2..e4f5c43b6448 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2017,6 +2017,22 @@ typedef int (*transfer_f)(struct snd_pcm_substream *substream, unsigned int hwof
 			  unsigned long data, unsigned int off,
 			  snd_pcm_uframes_t size);
 
+static int pcm_accessible_state(struct snd_pcm_runtime *runtime)
+{
+	switch (runtime->status->state) {
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_RUNNING:
+	case SNDRV_PCM_STATE_PAUSED:
+		return 0;
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
+	case SNDRV_PCM_STATE_SUSPENDED:
+		return -ESTRPIPE;
+	default:
+		return -EBADFD;
+	}
+}
+
 static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream, 
 					    unsigned long data,
 					    snd_pcm_uframes_t size,
@@ -2033,21 +2049,9 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		return 0;
 
 	snd_pcm_stream_lock_irq(substream);
-	switch (runtime->status->state) {
-	case SNDRV_PCM_STATE_PREPARED:
-	case SNDRV_PCM_STATE_RUNNING:
-	case SNDRV_PCM_STATE_PAUSED:
-		break;
-	case SNDRV_PCM_STATE_XRUN:
-		err = -EPIPE;
-		goto _end_unlock;
-	case SNDRV_PCM_STATE_SUSPENDED:
-		err = -ESTRPIPE;
-		goto _end_unlock;
-	default:
-		err = -EBADFD;
+	err = pcm_accessible_state(runtime);
+	if (err < 0)
 		goto _end_unlock;
-	}
 
 	runtime->twake = runtime->control->avail_min ? : 1;
 	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
@@ -2083,16 +2087,9 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
-		switch (runtime->status->state) {
-		case SNDRV_PCM_STATE_XRUN:
-			err = -EPIPE;
-			goto _end_unlock;
-		case SNDRV_PCM_STATE_SUSPENDED:
-			err = -ESTRPIPE;
+		err = pcm_accessible_state(runtime);
+		if (err < 0)
 			goto _end_unlock;
-		default:
-			break;
-		}
 		appl_ptr += frames;
 		if (appl_ptr >= runtime->boundary)
 			appl_ptr -= runtime->boundary;
@@ -2263,27 +2260,14 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		return 0;
 
 	snd_pcm_stream_lock_irq(substream);
-	switch (runtime->status->state) {
-	case SNDRV_PCM_STATE_PREPARED:
-		if (size >= runtime->start_threshold) {
-			err = snd_pcm_start(substream);
-			if (err < 0)
-				goto _end_unlock;
-		}
-		break;
-	case SNDRV_PCM_STATE_DRAINING:
-	case SNDRV_PCM_STATE_RUNNING:
-	case SNDRV_PCM_STATE_PAUSED:
-		break;
-	case SNDRV_PCM_STATE_XRUN:
-		err = -EPIPE;
-		goto _end_unlock;
-	case SNDRV_PCM_STATE_SUSPENDED:
-		err = -ESTRPIPE;
-		goto _end_unlock;
-	default:
-		err = -EBADFD;
+	err = pcm_accessible_state(runtime);
+	if (err < 0)
 		goto _end_unlock;
+	if (runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
+	    size >= runtime->start_threshold) {
+		err = snd_pcm_start(substream);
+		if (err < 0)
+			goto _end_unlock;
 	}
 
 	runtime->twake = runtime->control->avail_min ? : 1;
@@ -2327,16 +2311,9 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
-		switch (runtime->status->state) {
-		case SNDRV_PCM_STATE_XRUN:
-			err = -EPIPE;
-			goto _end_unlock;
-		case SNDRV_PCM_STATE_SUSPENDED:
-			err = -ESTRPIPE;
+		err = pcm_accessible_state(runtime);
+		if (err < 0)
 			goto _end_unlock;
-		default:
-			break;
-		}
 		appl_ptr += frames;
 		if (appl_ptr >= runtime->boundary)
 			appl_ptr -= runtime->boundary;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
