From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 03/11] ALSA: pcm: refactoring silence
	operation
Date: Wed, 24 May 2017 09:52:47 +0900
Message-ID: <20170524005255.31223-4-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 629AA2671A6
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

In a former commit, a new alias of function prototype is added. This
alias is good to refactoring existent codes.

As a second step, this commit applies refactoring for data transmission
of silent PCM frames. Two helper functions are added to handle in both
cases of interleaved and non-interleaved frame alignment. They're
independent, thus easy to read and understand.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c | 96 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index db0246c94874..f06d9f4f9574 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,6 +42,53 @@
 #define trace_hw_ptr_error(substream, reason)
 #endif
 
+static int writei_silence(struct snd_pcm_substream *substream,
+			  unsigned int hwoff, unsigned long data,
+			  unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char *hwbuf;
+
+	if (substream->ops->silence)
+		return substream->ops->silence(substream, -1, hwoff, count);
+
+	hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
+	snd_pcm_format_set_silence(runtime->format, hwbuf,
+				   count * runtime->channels);
+
+	return 0;
+}
+
+static int writen_silence(struct snd_pcm_substream *substream,
+			  unsigned int hwoff, unsigned long data,
+			  unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int channels = runtime->channels;
+	snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
+	char *hwbuf;
+	int c;
+	int err;
+
+	if (substream->ops->silence) {
+		for (c = 0; c < channels; ++c) {
+			err = substream->ops->silence(substream, c, hwoff,
+						      count);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		for (c = 0; c < channels; ++c) {
+			hwbuf = runtime->dma_area + (c * dma_csize) +
+					samples_to_bytes(runtime, hwoff);
+			snd_pcm_format_set_silence(runtime->format, hwbuf,
+						   count);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * fill ring buffer with silence
  * runtime->silence_start: starting pointer to silence area
@@ -51,10 +98,13 @@
  *
  * when runtime->silence_size >= runtime->boundary - fill processed area with silence immediately
  */
-void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_uframes_t new_hw_ptr)
+void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
+			      snd_pcm_uframes_t new_hw_ptr)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t frames, ofs, transfer;
+	snd_pcm_copy_frames_t copy_frames;
+	int err;
 
 	if (runtime->silence_size < runtime->boundary) {
 		snd_pcm_sframes_t noise_dist, n;
@@ -104,36 +154,24 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 		return;
 	if (frames == 0)
 		return;
+
+	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED)
+		copy_frames = writei_silence;
+	else
+		copy_frames = writen_silence;
+
 	ofs = runtime->silence_start % runtime->buffer_size;
 	while (frames > 0) {
-		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
-		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			if (substream->ops->silence) {
-				int err;
-				err = substream->ops->silence(substream, -1, ofs, transfer);
-				snd_BUG_ON(err < 0);
-			} else {
-				char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
-				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
-			}
-		} else {
-			unsigned int c;
-			unsigned int channels = runtime->channels;
-			if (substream->ops->silence) {
-				for (c = 0; c < channels; ++c) {
-					int err;
-					err = substream->ops->silence(substream, c, ofs, transfer);
-					snd_BUG_ON(err < 0);
-				}
-			} else {
-				size_t dma_csize = runtime->dma_bytes / channels;
-				for (c = 0; c < channels; ++c) {
-					char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
-					snd_pcm_format_set_silence(runtime->format, hwbuf, transfer);
-				}
-			}
-		}
+		if (ofs + frames > runtime->buffer_size)
+			transfer = runtime->buffer_size - ofs;
+		else
+			transfer = frames;
+
+		err = copy_frames(substream, ofs, (unsigned long)NULL, 0,
+				  transfer);
+		snd_BUG_ON(err < 0);
+
 		runtime->silence_filled += transfer;
 		frames -= transfer;
 		ofs = 0;
-- 
2.11.0
