From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/14] ALSA: pcm: Drop the old copy and silence
	ops
Date: Thu, 25 May 2017 21:17:25 +0200
Message-ID: <20170525191735.13787-5-tiwai@suse.de>
References: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA082668BF
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 21:17:40 +0200 (CEST)
In-Reply-To: <20170525191735.13787-1-tiwai@suse.de>
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Now that all users of old copy and silence ops have been converted to
the new PCM ops, the old stuff can be retired and go away.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h  |  5 -----
 sound/core/pcm_lib.c | 38 +-------------------------------------
 sound/soc/soc-pcm.c  |  2 --
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index a065415191d8..953ebfc83184 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -78,11 +78,6 @@ struct snd_pcm_ops {
 			struct timespec *system_ts, struct timespec *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
-	int (*copy)(struct snd_pcm_substream *substream, int channel,
-		    snd_pcm_uframes_t pos,
-		    void __user *buf, snd_pcm_uframes_t count);
-	int (*silence)(struct snd_pcm_substream *substream, int channel, 
-		       snd_pcm_uframes_t pos, snd_pcm_uframes_t count);
 	int (*fill_silence)(struct snd_pcm_substream *substream, int channel,
 			    unsigned long pos, unsigned long bytes);
 	int (*copy_user)(struct snd_pcm_substream *substream, int channel,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9334fc2c20c8..0db8d4e0fca2 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -116,9 +116,6 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 								   frames_to_bytes(runtime, ofs),
 								   frames_to_bytes(runtime, transfer));
 				snd_BUG_ON(err < 0);
-			} else if (substream->ops->silence) {
-				err = substream->ops->silence(substream, -1, ofs, transfer);
-				snd_BUG_ON(err < 0);
 			} else {
 				hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
 				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
@@ -133,11 +130,6 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 									   samples_to_bytes(runtime, transfer));
 					snd_BUG_ON(err < 0);
 				}
-			} else if (substream->ops->silence) {
-				for (c = 0; c < channels; ++c) {
-					err = substream->ops->silence(substream, c, ofs, transfer);
-					snd_BUG_ON(err < 0);
-				}
 			} else {
 				size_t dma_csize = runtime->dma_bytes / channels;
 				for (c = 0; c < channels; ++c) {
@@ -2013,9 +2005,6 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 		err = substream->ops->copy_user(substream, 0, hwoff, buf, frames);
 		if (err < 0)
 			return err;
-	} else if (substream->ops->copy) {
-		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
-			return err;
 	} else {
 		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
 		if (copy_from_user(hwbuf, buf, frames_to_bytes(runtime, frames)))
@@ -2137,8 +2126,7 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy_user && !substream->ops->copy
-		       && !runtime->dma_area))
+	if (snd_BUG_ON(!substream->ops->copy_user && !runtime->dma_area))
 		return -EINVAL;
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
@@ -2198,19 +2186,6 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 			if (err < 0)
 				return err;
 		}
-	} else if (substream->ops->copy) {
-		if (snd_BUG_ON(!substream->ops->silence))
-			return -EINVAL;
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (*bufs == NULL) {
-				if ((err = substream->ops->silence(substream, c, hwoff, frames)) < 0)
-					return err;
-			} else {
-				buf = *bufs + samples_to_bytes(runtime, off);
-				if ((err = substream->ops->copy(substream, c, hwoff, buf, frames)) < 0)
-					return err;
-			}
-		}
 	} else {
 		/* default transfer behaviour */
 		size_t dma_csize = runtime->dma_bytes / channels;
@@ -2264,9 +2239,6 @@ static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream,
 		err = substream->ops->copy_user(substream, 0, hwoff, buf, frames);
 		if (err < 0)
 			return err;
-	} else if (substream->ops->copy) {
-		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
-			return err;
 	} else {
 		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
 		if (copy_to_user(buf, hwbuf, frames_to_bytes(runtime, frames)))
@@ -2428,14 +2400,6 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 			if (err < 0)
 				return err;
 		}
-	} else if (substream->ops->copy) {
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (*bufs == NULL)
-				continue;
-			buf = *bufs + samples_to_bytes(runtime, off);
-			if ((err = substream->ops->copy(substream, c, hwoff, buf, frames)) < 0)
-				return err;
-		}
 	} else {
 		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
 		for (c = 0; c < channels; ++c, ++bufs) {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8867ed9e5f56..dcc5ece08668 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2746,8 +2746,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		rtd->ops.copy_user	= platform->driver->ops->copy_user;
 		rtd->ops.copy_kernel	= platform->driver->ops->copy_kernel;
 		rtd->ops.fill_silence	= platform->driver->ops->fill_silence;
-		rtd->ops.copy		= platform->driver->ops->copy;
-		rtd->ops.silence	= platform->driver->ops->silence;
 		rtd->ops.page		= platform->driver->ops->page;
 		rtd->ops.mmap		= platform->driver->ops->mmap;
 	}
-- 
2.13.0
