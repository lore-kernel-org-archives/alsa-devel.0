From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 04/11] ALSA: pcm: add alternative calls
Date: Wed, 24 May 2017 09:52:48 +0900
Message-ID: <20170524005255.31223-5-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 607362671A2
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:01 +0200 (CEST)
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

When investigating current implementation for data copy between
kernel/user spaces, helper functions includes much conditional processing.
This brings lack of lucidity. Furthermore, this is not good in a point
of hit ratio of i-cache.

This commit adds some helper functions for each cases to transfer PCM
frames; to read and write, for interleaved and non-interleaved frame
alignments. These helper functions also performs to transfer silent PCM
frames when source buffer is NULL.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f06d9f4f9574..38baa91fd0f6 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,6 +42,100 @@
 #define trace_hw_ptr_error(substream, reason)
 #endif
 
+static int writei_from_space1(struct snd_pcm_substream *substream,
+			      unsigned int hwoff, unsigned long data,
+			      unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char __user *buf = (char __user *)data;
+	char *dst = runtime->dma_area + frames_to_bytes(runtime, hwoff);
+
+	if (buf == NULL) {
+		snd_pcm_format_set_silence(runtime->format, dst,
+					   count * runtime->channels);
+	} else {
+		if (copy_from_user(dst, buf, frames_to_bytes(runtime, count)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int writen_from_space1(struct snd_pcm_substream *substream,
+			      unsigned int hwoff, unsigned long data,
+			      unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char __user **bufs = (char __user **)data;
+	char __user *buf;
+	char *dst;
+	int channels = runtime->channels;
+	snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
+	int c;
+
+	for (c = 0; c < channels; ++c) {
+		dst = runtime->dma_area + (c * dma_csize) +
+					samples_to_bytes(runtime, hwoff);
+
+		if (bufs == NULL || bufs[c] == NULL) {
+			snd_pcm_format_set_silence(runtime->format, dst, count);
+			continue;
+		}
+		buf = bufs[c] + samples_to_bytes(runtime, off);
+
+		dst = runtime->dma_area + (c * dma_csize) +
+					samples_to_bytes(runtime, hwoff);
+		if (copy_from_user(dst, buf, samples_to_bytes(runtime, count)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int readi_to_space1(struct snd_pcm_substream *substream,
+			   unsigned int hwoff, unsigned long data,
+			   unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char __user *buf = (char __user *)data;
+	char *src = runtime->dma_area + frames_to_bytes(runtime, hwoff);
+
+	if (buf == NULL)
+		return -EINVAL;
+	buf += frames_to_bytes(runtime, off);
+
+	if (copy_to_user(buf, src, frames_to_bytes(runtime, count)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int readn_to_space1(struct snd_pcm_substream *substream,
+			   unsigned int hwoff, unsigned long data,
+			   unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char __user **bufs = (char __user **)data;
+	char __user *buf;
+	char *src;
+	unsigned int channels = runtime->channels;
+	snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
+	int c;
+
+	for (c = 0; c < channels; ++c) {
+		if (bufs == NULL || bufs[c] == NULL)
+			continue;
+		buf = bufs[c] + samples_to_bytes(runtime, off);
+
+		src = runtime->dma_area + (c * dma_csize) +
+					samples_to_bytes(runtime, hwoff);
+		if (copy_to_user(buf, src, samples_to_bytes(runtime, count)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int writei_silence(struct snd_pcm_substream *substream,
 			  unsigned int hwoff, unsigned long data,
 			  unsigned int off, snd_pcm_uframes_t count)
@@ -156,10 +250,17 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
 		return;
 
 	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED)
-		copy_frames = writei_silence;
-	else
-		copy_frames = writen_silence;
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
+		if (substream->ops->silence)
+			copy_frames = writei_silence;
+		else
+			copy_frames = writei_from_space1;
+	} else {
+		if (substream->ops->silence)
+			copy_frames = writen_silence;
+		else
+			copy_frames = writen_from_space1;
+	}
 
 	ofs = runtime->silence_start % runtime->buffer_size;
 	while (frames > 0) {
@@ -2178,7 +2279,10 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 	    runtime->channels > 1)
 		return -EINVAL;
 
-	copy_frames = snd_pcm_lib_write_transfer;
+	if (substream->ops->copy)
+		copy_frames = snd_pcm_lib_write_transfer;
+	else
+		copy_frames = writei_from_space1;
 
 	return snd_pcm_lib_write1(substream, (unsigned long)buf, size, nonblock,
 				  copy_frames);
@@ -2243,7 +2347,10 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 
-	copy_frames = snd_pcm_lib_writev_transfer;
+	if (substream->ops->copy)
+		copy_frames = snd_pcm_lib_writev_transfer;
+	else
+		copy_frames = writen_from_space1;
 
 	return snd_pcm_lib_write1(substream, (unsigned long)bufs, frames,
 				  nonblock, copy_frames);
@@ -2395,7 +2502,10 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
 		return -EINVAL;
 
-	copy_frames = snd_pcm_lib_read_transfer;
+	if (substream->ops->copy)
+		copy_frames = snd_pcm_lib_read_transfer;
+	else
+		copy_frames = readi_to_space1;
 
 	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock,
 				 copy_frames);
@@ -2458,7 +2568,10 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 
-	copy_frames = snd_pcm_lib_readv_transfer;
+	if (substream->ops->copy)
+		copy_frames = snd_pcm_lib_readv_transfer;
+	else
+		copy_frames = readn_to_space1;
 
 	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames,
 				 nonblock, copy_frames);
-- 
2.11.0
