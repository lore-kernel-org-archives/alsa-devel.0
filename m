From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: pcm: Split PCM transfer codes
Date: Tue, 23 May 2017 08:11:55 +0200
Message-ID: <20170523061155.1582-5-tiwai@suse.de>
References: <20170523061155.1582-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B9696267062
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 08:12:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 144AAAD49
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 06:12:00 +0000 (UTC)
In-Reply-To: <20170523061155.1582-1-tiwai@suse.de>
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

The read and write transfer codes have the branch for the cases with
and without copy_silence ops.  Split the transfer functions to each of
them and pass the appropriate one before the loop.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 222 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 123 insertions(+), 99 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index dfa6d13ba8bd..a08059f74794 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2007,80 +2007,85 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int snd_pcm_lib_write_via_ops(struct snd_pcm_substream *substream,
+				     unsigned int hwoff,
+				     unsigned long data, unsigned int off,
+				     snd_pcm_uframes_t frames, bool in_kernel)
+{
+	char __user *buf = (char __user *) data +
+		frames_to_bytes(substream->runtime, off);
+
+	return substream->ops->copy_silence(substream, -1, hwoff, buf,
+					    frames, in_kernel);
+}
+
 static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
 				      snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
+	char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
+
+	if (in_kernel)
+		memcpy(hwbuf, (void *)buf, frames_to_bytes(runtime, frames));
+	else if (copy_from_user(hwbuf, buf, frames_to_bytes(runtime, frames)))
+		return -EFAULT;
+	return 0;
+}
 
-	if (substream->ops->copy_silence) {
-		err = substream->ops->copy_silence(substream, -1, hwoff, buf,
-						   frames, in_kernel);
+static int snd_pcm_lib_writev_via_ops(struct snd_pcm_substream *substream,
+				      unsigned int hwoff,
+				      unsigned long data, unsigned int off,
+				      snd_pcm_uframes_t frames, bool in_kernel)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int channels = runtime->channels;
+	void __user **bufs = (void __user **)data;
+	char __user *buf;
+	int c, err;
+
+	for (c = 0; c < channels; ++c, ++bufs) {
+		if (!*bufs)
+			buf = NULL;
+		else
+			buf = *bufs + samples_to_bytes(runtime, off);
+		err = substream->ops->copy_silence(substream, c, hwoff,
+						   buf, frames, in_kernel);
 		if (err < 0)
 			return err;
-	} else {
-		char *hwbuf = runtime->dma_area +
-			frames_to_bytes(runtime, hwoff);
-
-		if (in_kernel)
-			memcpy(hwbuf, (void *)buf,
-			       frames_to_bytes(runtime, frames));
-		else if (copy_from_user(hwbuf, buf,
-					frames_to_bytes(runtime, frames)))
-			return -EFAULT;
 	}
 	return 0;
 }
- 
+
 static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 				       unsigned int hwoff,
 				       unsigned long data, unsigned int off,
 				       snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	void __user **bufs = (void __user **)data;
 	int channels = runtime->channels;
+	size_t dma_csize = runtime->dma_bytes / channels;
+	void __user **bufs = (void __user **)data;
 	char __user *buf;
+	char *hwbuf;
 	int c;
 
-	if (substream->ops->copy_silence) {
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (!*bufs)
-				buf = NULL;
-			else
-				buf = *bufs + samples_to_bytes(runtime, off);
-			err = substream->ops->copy_silence(substream, c, hwoff,
-							   buf, frames,
-							   in_kernel);
-			if (err < 0)
-				return err;
-		}
-	} else {
-		/* default transfer behaviour */
-		size_t dma_csize = runtime->dma_bytes / channels;
-		for (c = 0; c < channels; ++c, ++bufs) {
-			char *hwbuf = runtime->dma_area + (c * dma_csize) +
-				samples_to_bytes(runtime, hwoff);
-
-			if (!*bufs) {
-				snd_pcm_format_set_silence(runtime->format,
-							   hwbuf, frames);
-			} else {
-				char __user *buf = *bufs +
-					samples_to_bytes(runtime, off);
-
-				if (in_kernel)
-					memcpy(hwbuf, (void *)buf,
-					       samples_to_bytes(runtime, frames));
-				else if (copy_from_user(hwbuf, buf,
-							samples_to_bytes(runtime, frames)))
-					return -EFAULT;
-			}
-		}
+	for (c = 0; c < channels; ++c, ++bufs) {
+		hwbuf = runtime->dma_area + (c * dma_csize) +
+			samples_to_bytes(runtime, hwoff);
+		buf = *bufs + samples_to_bytes(runtime, off);
+
+		if (!*bufs)
+			snd_pcm_format_set_silence(runtime->format,
+						   hwbuf, frames);
+		else if (in_kernel)
+			memcpy(hwbuf, (void *)buf,
+			       samples_to_bytes(runtime, frames));
+		else if (copy_from_user(hwbuf, buf,
+					samples_to_bytes(runtime, frames)))
+			return -EFAULT;
 	}
 	return 0;
 }
@@ -2105,11 +2110,17 @@ snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED &&
 		    runtime->channels > 1)
 			return -EINVAL;
-		transfer = snd_pcm_lib_write_transfer;
+		if (substream->ops->copy_silence)
+			transfer = snd_pcm_lib_write_via_ops;
+		else
+			transfer = snd_pcm_lib_write_transfer;
 	} else {
 		if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 			return -EINVAL;
-		transfer = snd_pcm_lib_writev_transfer;
+		if (substream->ops->copy_silence)
+			transfer = snd_pcm_lib_writev_via_ops;
+		else
+			transfer = snd_pcm_lib_writev_transfer;
 	}
 
 	if (size == 0)
@@ -2207,30 +2218,53 @@ snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL(__snd_pcm_lib_write);
 
 
+static int snd_pcm_lib_read_via_ops(struct snd_pcm_substream *substream,
+				    unsigned int hwoff,
+				    unsigned long data, unsigned int off,
+				    snd_pcm_uframes_t frames, bool in_kernel)
+{
+	char __user *buf = (char __user *) data +
+		frames_to_bytes(substream->runtime, off);
+
+	return substream->ops->copy_silence(substream, -1, hwoff, buf,
+					    frames, in_kernel);
+}
+
 static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream, 
 				     unsigned int hwoff,
 				     unsigned long data, unsigned int off,
 				     snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
+	char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
 
-	if (substream->ops->copy_silence) {
-		err = substream->ops->copy_silence(substream, -1, hwoff, buf,
-						   frames, in_kernel);
+	if (in_kernel)
+		memcpy((void *)buf, hwbuf, frames_to_bytes(runtime, frames));
+	else if (copy_to_user(buf, hwbuf, frames_to_bytes(runtime, frames)))
+		return -EFAULT;
+	return 0;
+}
+
+static int snd_pcm_lib_readv_via_ops(struct snd_pcm_substream *substream,
+				     unsigned int hwoff,
+				     unsigned long data, unsigned int off,
+				     snd_pcm_uframes_t frames, bool in_kernel)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int channels = runtime->channels;
+	void __user **bufs = (void __user **)data;
+	char __user *buf;
+	int c, err;
+
+	for (c = 0; c < channels; ++c, ++bufs) {
+		if (!*bufs)
+			continue;
+		buf = *bufs + samples_to_bytes(runtime, off);
+		err = substream->ops->copy_silence(substream, c, hwoff,
+						   buf, frames, in_kernel);
 		if (err < 0)
 			return err;
-	} else {
-		char *hwbuf = runtime->dma_area +
-			frames_to_bytes(runtime, hwoff);
-
-		if (in_kernel)
-			memcpy((void *)buf, hwbuf,
-			       frames_to_bytes(runtime, frames));
-		else if (copy_to_user(buf, hwbuf,
-				      frames_to_bytes(runtime, frames)))
-			return -EFAULT;
 	}
 	return 0;
 }
@@ -2241,41 +2275,25 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 				      snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	void __user **bufs = (void __user **)data;
 	int channels = runtime->channels;
+	snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
+	void __user **bufs = (void __user **)data;
 	char __user *buf;
 	char *hwbuf;
 	int c;
 
-	if (substream->ops->copy_silence) {
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (!*bufs)
-				continue;
-			buf = *bufs + samples_to_bytes(runtime, off);
-			err = substream->ops->copy_silence(substream, c, hwoff,
-							   buf, frames,
-							   in_kernel);
-			if (err < 0)
-				return err;
-		}
-	} else {
-		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
-
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (!*bufs)
-				continue;
-
-			hwbuf = runtime->dma_area + (c * dma_csize) +
-				samples_to_bytes(runtime, hwoff);
-			buf = *bufs + samples_to_bytes(runtime, off);
-			if (in_kernel)
-				memcpy((void *)buf, hwbuf,
-				       samples_to_bytes(runtime, frames));
-			else if (copy_to_user(buf, hwbuf,
-					      samples_to_bytes(runtime, frames)))
-				return -EFAULT;
-		}
+	for (c = 0; c < channels; ++c, ++bufs) {
+		if (!*bufs)
+			continue;
+		hwbuf = runtime->dma_area + (c * dma_csize) +
+			samples_to_bytes(runtime, hwoff);
+		buf = *bufs + samples_to_bytes(runtime, off);
+		if (in_kernel)
+			memcpy((void *)buf, hwbuf,
+			       samples_to_bytes(runtime, frames));
+		else if (copy_to_user(buf, hwbuf,
+				      samples_to_bytes(runtime, frames)))
+			return -EFAULT;
 	}
 	return 0;
 }
@@ -2300,11 +2318,17 @@ snd_pcm_sframes_t __snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED &&
 		    runtime->channels > 1)
 			return -EINVAL;
-		transfer = snd_pcm_lib_read_transfer;
+		if (substream->ops->copy_silence)
+			transfer = snd_pcm_lib_read_via_ops;
+		else
+			transfer = snd_pcm_lib_read_transfer;
 	} else {
 		if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 			return -EINVAL;
-		transfer = snd_pcm_lib_readv_transfer;
+		if (substream->ops->copy_silence)
+			transfer = snd_pcm_lib_readv_via_ops;
+		else
+			transfer = snd_pcm_lib_readv_transfer;
 	}
 
 	if (size == 0)
-- 
2.13.0
