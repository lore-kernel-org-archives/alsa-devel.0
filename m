From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 05/11] ALSA: core: remove duplicated codes
	to handle PCM frames
Date: Wed, 24 May 2017 09:52:49 +0900
Message-ID: <20170524005255.31223-6-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D12CD2671AE
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:04 +0200 (CEST)
In-Reply-To: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a previous commit, common data copying operation is passed to each
of specific helper functions.

This commit removes duplicated codes in old implementations. As a result,
such old functions becomes wrappers of driver-side implementation of
'struct snd_pcm_ops.silence' and 'struct snd_pcm_ops.copy'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c | 159 ++++++++++++++++++---------------------------------
 1 file changed, 57 insertions(+), 102 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 38baa91fd0f6..8dfe964e8931 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -140,17 +140,7 @@ static int writei_silence(struct snd_pcm_substream *substream,
 			  unsigned int hwoff, unsigned long data,
 			  unsigned int off, snd_pcm_uframes_t count)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	char *hwbuf;
-
-	if (substream->ops->silence)
-		return substream->ops->silence(substream, -1, hwoff, count);
-
-	hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
-	snd_pcm_format_set_silence(runtime->format, hwbuf,
-				   count * runtime->channels);
-
-	return 0;
+	return substream->ops->silence(substream, -1, hwoff, count);
 }
 
 static int writen_silence(struct snd_pcm_substream *substream,
@@ -159,25 +149,13 @@ static int writen_silence(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int channels = runtime->channels;
-	snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
-	char *hwbuf;
 	int c;
 	int err;
 
-	if (substream->ops->silence) {
-		for (c = 0; c < channels; ++c) {
-			err = substream->ops->silence(substream, c, hwoff,
-						      count);
-			if (err < 0)
-				return err;
-		}
-	} else {
-		for (c = 0; c < channels; ++c) {
-			hwbuf = runtime->dma_area + (c * dma_csize) +
-					samples_to_bytes(runtime, hwoff);
-			snd_pcm_format_set_silence(runtime->format, hwbuf,
-						   count);
-		}
+	for (c = 0; c < channels; ++c) {
+		err = substream->ops->silence(substream, c, hwoff, count);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
@@ -2129,20 +2107,16 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
+				      snd_pcm_uframes_t count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
-	if (substream->ops->copy) {
-		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
-			return err;
-	} else {
-		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
-		if (copy_from_user(hwbuf, buf, frames_to_bytes(runtime, frames)))
-			return -EFAULT;
-	}
-	return 0;
+	char __user *buf = (char __user *) data;
+
+	if (buf == NULL && substream->ops->silence)
+		return substream->ops->silence(substream, -1, hwoff, count);
+
+	buf += frames_to_bytes(runtime, off);
+	return substream->ops->copy(substream, -1, hwoff, buf, count);
 }
  
 static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream, 
@@ -2295,37 +2269,30 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 				       snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	void __user **bufs = (void __user **)data;
+	char __user **bufs = (char __user **)data;
+	char __user *buf;
 	int channels = runtime->channels;
 	int c;
-	if (substream->ops->copy) {
-		if (snd_BUG_ON(!substream->ops->silence))
-			return -EINVAL;
-		for (c = 0; c < channels; ++c, ++bufs) {
-			if (*bufs == NULL) {
-				if ((err = substream->ops->silence(substream, c, hwoff, frames)) < 0)
-					return err;
-			} else {
-				char __user *buf = *bufs + samples_to_bytes(runtime, off);
-				if ((err = substream->ops->copy(substream, c, hwoff, buf, frames)) < 0)
-					return err;
-			}
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
+	int err;
+
+	if (snd_BUG_ON(!substream->ops->silence))
+		return -EINVAL;
+
+	for (c = 0; c < channels; ++c) {
+		if (bufs == NULL || bufs[c] == NULL) {
+			err = substream->ops->silence(substream, c, hwoff,
+						      frames);
+			if (err < 0)
+				return err;
+		} else {
+			buf = bufs[c] + samples_to_bytes(runtime, off);
+			err = substream->ops->copy(substream, c, hwoff, buf,
+						   frames);
+			if (err < 0)
+				return err;
 		}
 	}
+
 	return 0;
 }
  
@@ -2363,17 +2330,13 @@ static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream,
 				     snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
-	if (substream->ops->copy) {
-		if ((err = substream->ops->copy(substream, -1, hwoff, buf, frames)) < 0)
-			return err;
-	} else {
-		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
-		if (copy_to_user(buf, hwbuf, frames_to_bytes(runtime, frames)))
-			return -EFAULT;
-	}
-	return 0;
+	char __user *buf = (char __user *)data;
+
+	if (buf == NULL)
+		return -EINVAL;
+
+	buf += frames_to_bytes(runtime, off);
+	return substream->ops->copy(substream, -1, hwoff, buf, frames);
 }
 
 static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
@@ -2518,33 +2481,25 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 				      snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-	void __user **bufs = (void __user **)data;
-	int channels = runtime->channels;
+	char __user **bufs = (char __user **)data;
+	char __user *buf;
+	unsigned int channels = runtime->channels;
 	int c;
-	if (substream->ops->copy) {
-		for (c = 0; c < channels; ++c, ++bufs) {
-			char __user *buf;
-			if (*bufs == NULL)
-				continue;
-			buf = *bufs + samples_to_bytes(runtime, off);
-			if ((err = substream->ops->copy(substream, c, hwoff, buf, frames)) < 0)
-				return err;
-		}
-	} else {
-		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
-		for (c = 0; c < channels; ++c, ++bufs) {
-			char *hwbuf;
-			char __user *buf;
-			if (*bufs == NULL)
-				continue;
-
-			hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
-			buf = *bufs + samples_to_bytes(runtime, off);
-			if (copy_to_user(buf, hwbuf, samples_to_bytes(runtime, frames)))
-				return -EFAULT;
-		}
+	int err;
+
+	if (bufs == NULL)
+		return -EINVAL;
+
+	for (c = 0; c < channels; ++c) {
+		if (bufs[c] == NULL)
+			continue;
+
+		buf = bufs[c] + samples_to_bytes(runtime, off);
+		err = substream->ops->copy(substream, c, hwoff, buf, frames);
+		if (err < 0)
+			return err;
 	}
+
 	return 0;
 }
  
-- 
2.11.0
