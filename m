From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 10/26] ALSA: pcm: Introduce copy_silence
	PCM ops
Date: Thu, 11 May 2017 23:09:09 +0200
Message-ID: <20170511210925.18208-11-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB29C266FED
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:31 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8CDA8AEC8
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

For supporting the explicit in-kernel copy, and also for reducing the
redundant codes for both copy and silence callbacks, a new ops,
copy_silence is introduced in this patch.  This is supposed to serve
for both copy and silence.  The silence operation is distinguished by
NULL buffer passed (required only in playback direction).

Also, the callback receives a new flag, in_kernel, which indicates
that the callback gets called for copying the data from/to the kernel
buffer instead of the user-space buffer.  The in_kernel flag will be
used mainly in PCM OSS code for the on-the-fly conversion.
Currently, only in_kernel=false is passed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h  |  3 +++
 sound/core/pcm_lib.c | 74 +++++++++++++++++++++++++++++++++++++++++-----------
 sound/soc/soc-pcm.c  |  1 +
 3 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 361749e60799..065ea81904b0 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -83,6 +83,9 @@ struct snd_pcm_ops {
 		    void __user *buf, snd_pcm_uframes_t count);
 	int (*silence)(struct snd_pcm_substream *substream, int channel, 
 		       snd_pcm_uframes_t pos, snd_pcm_uframes_t count);
+	int (*copy_silence)(struct snd_pcm_substream *substream, int channel,
+			    snd_pcm_uframes_t pos, void __user *buf,
+			    snd_pcm_uframes_t count, bool in_kernel);
 	struct page *(*page)(struct snd_pcm_substream *substream,
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 5088d4b8db22..ed2002bfea6a 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -55,6 +55,8 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t frames, ofs, transfer;
+	char *hwbuf;
+	int err;
 
 	if (runtime->silence_size < runtime->boundary) {
 		snd_pcm_sframes_t noise_dist, n;
@@ -109,27 +111,35 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
 		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			if (substream->ops->silence) {
-				int err;
+			if (substream->ops->copy_silence) {
+				err = substream->ops->copy_silence(substream,
+					-1, ofs, NULL, transfer, false);
+				snd_BUG_ON(err < 0);
+			} else if (substream->ops->silence) {
 				err = substream->ops->silence(substream, -1, ofs, transfer);
 				snd_BUG_ON(err < 0);
 			} else {
-				char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
+				hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
 				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
 			}
 		} else {
 			unsigned int c;
 			unsigned int channels = runtime->channels;
-			if (substream->ops->silence) {
+			if (substream->ops->copy_silence) {
+				for (c = 0; c < channels; ++c) {
+					err = substream->ops->copy_silence(substream,
+						c, ofs, NULL, transfer, false);
+					snd_BUG_ON(err < 0);
+				}
+			} else if (substream->ops->silence) {
 				for (c = 0; c < channels; ++c) {
-					int err;
 					err = substream->ops->silence(substream, c, ofs, transfer);
 					snd_BUG_ON(err < 0);
 				}
 			} else {
 				size_t dma_csize = runtime->dma_bytes / channels;
 				for (c = 0; c < channels; ++c) {
-					char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
+					hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
 					snd_pcm_format_set_silence(runtime->format, hwbuf, transfer);
 				}
 			}
@@ -1993,7 +2003,12 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
-	if (substream->ops->copy) {
+	if (substream->ops->copy_silence) {
+		err = substream->ops->copy_silence(substream, -1, hwoff, buf,
+						   frames, false);
+		if (err < 0)
+			return err;
+	} else if (substream->ops->copy) {
 		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
 			return err;
 	} else {
@@ -2117,7 +2132,8 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy && !runtime->dma_area))
+	if (snd_BUG_ON(!substream->ops->copy_silence && !substream->ops->copy
+		       && !runtime->dma_area))
 		return -EINVAL;
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
@@ -2154,8 +2170,21 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 	int err;
 	void __user **bufs = (void __user **)data;
 	int channels = runtime->channels;
+	char __user *buf;
 	int c;
-	if (substream->ops->copy) {
+
+	if (substream->ops->copy_silence) {
+		for (c = 0; c < channels; ++c, ++bufs) {
+			if (!*bufs)
+				buf = NULL;
+			else
+				buf = *bufs + samples_to_bytes(runtime, off);
+			err = substream->ops->copy_silence(substream, c, hwoff,
+							   buf, frames, false);
+			if (err < 0)
+				return err;
+		}
+	} else if (substream->ops->copy) {
 		if (snd_BUG_ON(!substream->ops->silence))
 			return -EINVAL;
 		for (c = 0; c < channels; ++c, ++bufs) {
@@ -2163,7 +2192,7 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 				if ((err = substream->ops->silence(substream, c, hwoff, frames)) < 0)
 					return err;
 			} else {
-				char __user *buf = *bufs + samples_to_bytes(runtime, off);
+				buf = *bufs + samples_to_bytes(runtime, off);
 				if ((err = substream->ops->copy(substream, c, hwoff, buf, frames)) < 0)
 					return err;
 			}
@@ -2215,7 +2244,12 @@ static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
-	if (substream->ops->copy) {
+	if (substream->ops->copy_silence) {
+		err = substream->ops->copy_silence(substream, -1, hwoff, buf,
+						   frames, false);
+		if (err < 0)
+			return err;
+	} else if (substream->ops->copy) {
 		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
 			return err;
 	} else {
@@ -2363,10 +2397,22 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 	int err;
 	void __user **bufs = (void __user **)data;
 	int channels = runtime->channels;
+	char __user *buf;
+	char *hwbuf;
 	int c;
-	if (substream->ops->copy) {
+
+	if (substream->ops->copy_silence) {
+		for (c = 0; c < channels; ++c, ++bufs) {
+			if (!*bufs)
+				continue;
+			buf = *bufs + samples_to_bytes(runtime, off);
+			err = substream->ops->copy_silence(substream, c, hwoff,
+							   buf, frames, false);
+			if (err < 0)
+				return err;
+		}
+	} else if (substream->ops->copy) {
 		for (c = 0; c < channels; ++c, ++bufs) {
-			char __user *buf;
 			if (*bufs == NULL)
 				continue;
 			buf = *bufs + samples_to_bytes(runtime, off);
@@ -2376,8 +2422,6 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 	} else {
 		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
 		for (c = 0; c < channels; ++c, ++bufs) {
-			char *hwbuf;
-			char __user *buf;
 			if (*bufs == NULL)
 				continue;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index efc5831f205d..3cfb9aa1203b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2743,6 +2743,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 	if (platform->driver->ops) {
 		rtd->ops.ack		= platform->driver->ops->ack;
+		rtd->ops.copy_silence	= platform->driver->ops->copy_silence;
 		rtd->ops.copy		= platform->driver->ops->copy;
 		rtd->ops.silence	= platform->driver->ops->silence;
 		rtd->ops.page		= platform->driver->ops->page;
-- 
2.12.2
