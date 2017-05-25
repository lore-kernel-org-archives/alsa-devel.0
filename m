From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/14] ALSA: pcm: Shuffle codes
Date: Thu, 25 May 2017 21:17:27 +0200
Message-ID: <20170525191735.13787-7-tiwai@suse.de>
References: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EE79266D6B
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 21:17:41 +0200 (CEST)
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

Just shuffle the codes, without any change otherwise.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 210 +++++++++++++++++++++++++--------------------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index e4f5c43b6448..5db086748515 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1991,6 +1991,10 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 	return err;
 }
 	
+typedef int (*transfer_f)(struct snd_pcm_substream *substream, unsigned int hwoff,
+			  unsigned long data, unsigned int off,
+			  snd_pcm_uframes_t size);
+
 static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
@@ -2013,9 +2017,67 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 	return 0;
 }
  
-typedef int (*transfer_f)(struct snd_pcm_substream *substream, unsigned int hwoff,
-			  unsigned long data, unsigned int off,
-			  snd_pcm_uframes_t size);
+static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
+				       unsigned int hwoff,
+				       unsigned long data, unsigned int off,
+				       snd_pcm_uframes_t frames)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+	void __user **bufs = (void __user **)data;
+	int channels = runtime->channels;
+	char __user *buf;
+	int c;
+
+	if (substream->ops->copy_user) {
+		hwoff = samples_to_bytes(runtime, hwoff);
+		off = samples_to_bytes(runtime, off);
+		frames = samples_to_bytes(runtime, frames);
+		for (c = 0; c < channels; ++c, ++bufs) {
+			buf = *bufs + off;
+			if (!*bufs) {
+				if (snd_BUG_ON(!substream->ops->fill_silence))
+					return -EINVAL;
+				err = substream->ops->fill_silence(substream, c,
+								   hwoff,
+								   frames);
+			} else {
+				err = substream->ops->copy_user(substream, c,
+								hwoff, buf,
+								frames);
+			}
+			if (err < 0)
+				return err;
+		}
+	} else {
+		/* default transfer behaviour */
+		size_t dma_csize = runtime->dma_bytes / channels;
+		for (c = 0; c < channels; ++c, ++bufs) {
+			char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
+			if (*bufs == NULL) {
+				snd_pcm_format_set_silence(runtime->format, hwbuf, frames);
+			} else {
+				char __user *buf = *bufs + samples_to_bytes(runtime, off);
+				if (copy_from_user(hwbuf, buf, samples_to_bytes(runtime, frames)))
+					return -EFAULT;
+			}
+		}
+	}
+	return 0;
+}
+
+static int pcm_sanity_check(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	if (PCM_RUNTIME_CHECK(substream))
+		return -ENXIO;
+	runtime = substream->runtime;
+	if (snd_BUG_ON(!substream->ops->copy_user && !runtime->dma_area))
+		return -EINVAL;
+	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
+	return 0;
+}
 
 static int pcm_accessible_state(struct snd_pcm_runtime *runtime)
 {
@@ -2117,19 +2179,6 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 }
 
 /* sanity-check for read/write methods */
-static int pcm_sanity_check(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime;
-	if (PCM_RUNTIME_CHECK(substream))
-		return -ENXIO;
-	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy_user && !runtime->dma_area))
-		return -EINVAL;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
-		return -EBADFD;
-	return 0;
-}
-
 snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const void __user *buf, snd_pcm_uframes_t size)
 {
 	struct snd_pcm_runtime *runtime;
@@ -2151,55 +2200,6 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const v
 
 EXPORT_SYMBOL(snd_pcm_lib_write);
 
-static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
-				       unsigned int hwoff,
-				       unsigned long data, unsigned int off,
-				       snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	void __user **bufs = (void __user **)data;
-	int channels = runtime->channels;
-	char __user *buf;
-	int c;
-
-	if (substream->ops->copy_user) {
-		hwoff = samples_to_bytes(runtime, hwoff);
-		off = samples_to_bytes(runtime, off);
-		frames = samples_to_bytes(runtime, frames);
-		for (c = 0; c < channels; ++c, ++bufs) {
-			buf = *bufs + off;
-			if (!*bufs) {
-				if (snd_BUG_ON(!substream->ops->fill_silence))
-					return -EINVAL;
-				err = substream->ops->fill_silence(substream, c,
-								   hwoff,
-								   frames);
-			} else {
-				err = substream->ops->copy_user(substream, c,
-								hwoff, buf,
-								frames);
-			}
-			if (err < 0)
-				return err;
-		}
-	} else {
-		/* default transfer behaviour */
-		size_t dma_csize = runtime->dma_bytes / channels;
-		for (c = 0; c < channels; ++c, ++bufs) {
-			char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
-			if (*bufs == NULL) {
-				snd_pcm_format_set_silence(runtime->format, hwbuf, frames);
-			} else {
-				char __user *buf = *bufs + samples_to_bytes(runtime, off);
-				if (copy_from_user(hwbuf, buf, samples_to_bytes(runtime, frames)))
-					return -EFAULT;
-			}
-		}
-	}
-	return 0;
-}
- 
 snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 				     void __user **bufs,
 				     snd_pcm_uframes_t frames)
@@ -2244,6 +2244,46 @@ static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
+				      unsigned int hwoff,
+				      unsigned long data, unsigned int off,
+				      snd_pcm_uframes_t frames)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+	void __user **bufs = (void __user **)data;
+	int channels = runtime->channels;
+	char __user *buf;
+	char *hwbuf;
+	int c;
+
+	if (substream->ops->copy_user) {
+		hwoff = samples_to_bytes(runtime, hwoff);
+		off = samples_to_bytes(runtime, off);
+		frames = samples_to_bytes(runtime, frames);
+		for (c = 0; c < channels; ++c, ++bufs) {
+			if (!*bufs)
+				continue;
+			err = substream->ops->copy_user(substream, c, hwoff,
+							*bufs + off, frames);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
+		for (c = 0; c < channels; ++c, ++bufs) {
+			if (*bufs == NULL)
+				continue;
+
+			hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
+			buf = *bufs + samples_to_bytes(runtime, off);
+			if (copy_to_user(buf, hwbuf, samples_to_bytes(runtime, frames)))
+				return -EFAULT;
+		}
+	}
+	return 0;
+}
+
 static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 					   unsigned long data,
 					   snd_pcm_uframes_t size,
@@ -2352,46 +2392,6 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream, void __u
 
 EXPORT_SYMBOL(snd_pcm_lib_read);
 
-static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
-				      unsigned int hwoff,
-				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	void __user **bufs = (void __user **)data;
-	int channels = runtime->channels;
-	char __user *buf;
-	char *hwbuf;
-	int c;
-
-	if (substream->ops->copy_user) {
-		hwoff = samples_to_bytes(runtime, hwoff);
-		off = samples_to_bytes(runtime, off);
-		frames = samples_to_bytes(runtime, frames);
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (!*bufs)
-				continue;
-			err = substream->ops->copy_user(substream, c, hwoff,
-							*bufs + off, frames);
-			if (err < 0)
-				return err;
-		}
-	} else {
-		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (*bufs == NULL)
-				continue;
-
-			hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
-			buf = *bufs + samples_to_bytes(runtime, off);
-			if (copy_to_user(buf, hwbuf, samples_to_bytes(runtime, frames)))
-				return -EFAULT;
-		}
-	}
-	return 0;
-}
- 
 snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 				    void __user **bufs,
 				    snd_pcm_uframes_t frames)
-- 
2.13.0
