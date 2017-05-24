From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 10/11] ALSA: pcm: add client_space
	parameter to runtime of PCM substream for PCM proxy drivers
Date: Wed, 24 May 2017 09:52:54 +0900
Message-ID: <20170524005255.31223-11-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3906F2671B9
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:05 +0200 (CEST)
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

In current design of ALSA PCM core, copying PCM frames is performed between
user/kernel spaces. However, some in-kernel drivers wish to copy between
kernel/kernel spaces. I call such drivers as 'proxy' drivers.

This commit adds a infrastructure to assist the proxy drivers. New
helper functions are added to copy innner kernel space. A new member,
'client_space', is added into runtime of PCM substream to utilize these
helper functions. Usually, this member has 1 to represent target PCM frames
on user space. When this member is 0, typical copying functions are
executed between kernel/kernel space.

Reference: http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120542.html
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h     |   1 +
 sound/core/pcm_lib.c    | 147 +++++++++++++++++++++++++++++++++++++++++++-----
 sound/core/pcm_native.c |   8 +++
 3 files changed, 141 insertions(+), 15 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index cf97e478b664..ffd21fe0b284 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -387,6 +387,7 @@ struct snd_pcm_runtime {
 	/* -- mmap -- */
 	struct snd_pcm_mmap_status *status;
 	struct snd_pcm_mmap_control *control;
+	int client_space;	/* Where the client puts PCM frames. Usually, 1 means user space. */
 
 	/* -- locking / scheduling -- */
 	snd_pcm_uframes_t twake; 	/* do transfer (!poll) wakeup if non-zero */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7b8d35823de6..7700be3bb0c8 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,6 +42,22 @@
 #define trace_hw_ptr_error(substream, reason)
 #endif
 
+static int writei_from_space0(struct snd_pcm_substream *substream,
+				unsigned int hwoff, unsigned long data,
+				unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char *buf = (char *)data;
+	char *dst = runtime->dma_area + frames_to_bytes(runtime, hwoff);
+
+	if (buf != NULL)
+		snd_pcm_format_set_silence(runtime->format, dst, count);
+	else
+		memcpy(dst, buf, frames_to_bytes(runtime, count));
+
+	return 0;
+}
+
 static int writei_from_space1(struct snd_pcm_substream *substream,
 			      unsigned int hwoff, unsigned long data,
 			      unsigned int off, snd_pcm_uframes_t count)
@@ -61,6 +77,36 @@ static int writei_from_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int writen_from_space0(struct snd_pcm_substream *substream,
+				unsigned int hwoff, unsigned long data,
+				unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char **bufs = (char **)data;
+	char *buf;
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
+		memcpy(dst, buf, samples_to_bytes(runtime, count));
+	}
+
+	return 0;
+}
+
 static int writen_from_space1(struct snd_pcm_substream *substream,
 			      unsigned int hwoff, unsigned long data,
 			      unsigned int off, snd_pcm_uframes_t count)
@@ -92,6 +138,19 @@ static int writen_from_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int readi_to_space0(struct snd_pcm_substream *substream,
+				unsigned int hwoff, unsigned long data,
+				unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char *buf = (char *)data + frames_to_bytes(runtime, off);
+	char *src = runtime->dma_area + frames_to_bytes(runtime, hwoff);
+
+	memcpy(buf, src, frames_to_bytes(runtime, count));
+
+	return 0;
+}
+
 static int readi_to_space1(struct snd_pcm_substream *substream,
 			   unsigned int hwoff, unsigned long data,
 			   unsigned int off, snd_pcm_uframes_t count)
@@ -110,6 +169,31 @@ static int readi_to_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int readn_to_space0(struct snd_pcm_substream *substream,
+				unsigned int hwoff, unsigned long data,
+				unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char **bufs = (char **)data;
+	char *buf;
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
+		memcpy(buf, src, samples_to_bytes(runtime, count));
+	}
+
+	return 0;
+}
+
 static int readn_to_space1(struct snd_pcm_substream *substream,
 			   unsigned int hwoff, unsigned long data,
 			   unsigned int off, snd_pcm_uframes_t count)
@@ -203,13 +287,21 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
 		return;
 
 	if (substream->ops->copy_frames) {
+		if (runtime->client_space == 0)
+			return;
 		copy_frames = substream->ops->copy_frames;
 	} else {
 		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			copy_frames = writei_from_space1;
+			if (runtime->client_space == 0)
+				copy_frames = writei_from_space0;
+			else
+				copy_frames = writei_from_space1;
 		} else {
-			copy_frames = writen_from_space1;
+			if (rnutime->client-space == 0)
+				copy_frames = writen_from_space0;
+			else
+				copy_frames = writen_from_space1;
 		}
 	}
 
@@ -2211,10 +2303,16 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 	    runtime->channels > 1)
 		return -EINVAL;
 
-	if (substream->ops->copy_frames)
+	if (substream->ops->copy_frames) {
+		if (runtime->client_space == 0)
+			return -ENXIO;
 		copy_frames = substream->ops->copy_frames;
-	else
-		copy_frames = writei_from_space1;
+	} else {
+		if (runtime->client_space == 0)
+			copy_frames = writei_from_space0;
+		else
+			copy_frames = writei_from_space1;
+	}
 
 	return snd_pcm_lib_write1(substream, (unsigned long)buf, size, nonblock,
 				  copy_frames);
@@ -2239,10 +2337,17 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 
-	if (substream->ops->copy_frames)
-		copy_frames = substream->ops->copy_frames;
-	else
-		copy_frames = writen_from_space1;
+	if (substream->ops->copy_frames) {
+		if (runtime->client_space == 0)
+			return -ENXIO;
+		else
+			copy_frames = substream->ops->copy_frames;
+	} else {
+		if (runtime->client_space == 0)
+			copy_frames = writen_from_space0;
+		else
+			copy_frames = writen_from_space1;
+	}
 
 	return snd_pcm_lib_write1(substream, (unsigned long)bufs, frames,
 				  nonblock, copy_frames);
@@ -2375,10 +2480,16 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
 		return -EINVAL;
 
-	if (substream->ops->copy_frames)
+	if (substream->ops->copy_frames) {
+		if (runtime->client_space == 0)
+			return -ENXIO;
 		copy_frames = substream->ops->copy_frames;
-	else
-		copy_frames = readi_to_space1;
+	} else {
+		if (runtime->client_space == 0)
+			copy_frames = readi_to_space0;
+		else
+			copy_frames = readi_to_space1;
+	}
 
 	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock,
 				 copy_frames);
@@ -2405,10 +2516,16 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 
-	if (substream->ops->copy_frames)
+	if (substream->ops->copy_frames) {
+		if (runtime->client_space == 0)
+			return -ENXIO;
 		copy_frames = substream->ops->copy_frames;
-	else
-		copy_frames = readn_to_space1;
+	} else {
+		if (runtime->client_space == 0)
+			copy_frames = readn_to_space0;
+		else
+			copy_frames = readn_to_space1;
+	}
 
 	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames,
 				 nonblock, copy_frames);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ecde57afa45a..3428583ac0d7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -599,6 +599,14 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	if ((usecs = period_to_usecs(runtime)) >= 0)
 		pm_qos_add_request(&substream->latency_pm_qos_req,
 				   PM_QOS_CPU_DMA_LATENCY, usecs);
+
+	/*
+	 * Usual client puts PCM frames on user space, on the other
+	 * hand PCM proxy drivers puts on kernel space. This is a
+	 * switch handlers for PCM frames in different spaces.
+	 */
+	runtime->client_space = 1;
+
 	return 0;
  _error:
 	/* hardware might be unusable from this time,
-- 
2.11.0
