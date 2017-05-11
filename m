From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 25/26] ALSA: pcm: Drop the old copy and
	silence ops
Date: Thu, 11 May 2017 23:09:24 +0200
Message-ID: <20170511210925.18208-26-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 040F3267000
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:33 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BCD65AEEB
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

Now that all users of old copy and silence ops have been converted to
the new copy_silence ops, the old stuff can be retired and go away.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h  |  5 -----
 sound/core/pcm_lib.c | 38 +-------------------------------------
 sound/soc/soc-pcm.c  |  2 --
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 065ea81904b0..67ba55c1062b 100644
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
 	int (*copy_silence)(struct snd_pcm_substream *substream, int channel,
 			    snd_pcm_uframes_t pos, void __user *buf,
 			    snd_pcm_uframes_t count, bool in_kernel);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ed2002bfea6a..a2f796c8f39e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -115,9 +115,6 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 				err = substream->ops->copy_silence(substream,
 					-1, ofs, NULL, transfer, false);
 				snd_BUG_ON(err < 0);
-			} else if (substream->ops->silence) {
-				err = substream->ops->silence(substream, -1, ofs, transfer);
-				snd_BUG_ON(err < 0);
 			} else {
 				hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
 				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
@@ -131,11 +128,6 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 						c, ofs, NULL, transfer, false);
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
@@ -2008,9 +2000,6 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 						   frames, false);
 		if (err < 0)
 			return err;
-	} else if (substream->ops->copy) {
-		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
-			return err;
 	} else {
 		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
 		if (copy_from_user(hwbuf, buf, frames_to_bytes(runtime, frames)))
@@ -2132,8 +2121,7 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy_silence && !substream->ops->copy
-		       && !runtime->dma_area))
+	if (snd_BUG_ON(!substream->ops->copy_silence && !runtime->dma_area))
 		return -EINVAL;
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
@@ -2184,19 +2172,6 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
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
@@ -2249,9 +2224,6 @@ static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream,
 						   frames, false);
 		if (err < 0)
 			return err;
-	} else if (substream->ops->copy) {
-		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
-			return err;
 	} else {
 		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
 		if (copy_to_user(buf, hwbuf, frames_to_bytes(runtime, frames)))
@@ -2411,14 +2383,6 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
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
index 3cfb9aa1203b..5d58d8434971 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2744,8 +2744,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (platform->driver->ops) {
 		rtd->ops.ack		= platform->driver->ops->ack;
 		rtd->ops.copy_silence	= platform->driver->ops->copy_silence;
-		rtd->ops.copy		= platform->driver->ops->copy;
-		rtd->ops.silence	= platform->driver->ops->silence;
 		rtd->ops.page		= platform->driver->ops->page;
 		rtd->ops.mmap		= platform->driver->ops->mmap;
 	}
-- 
2.12.2
