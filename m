From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 06/11] ALSA: pcm: add new operation;
	copy_frames
Date: Wed, 24 May 2017 09:52:50 +0900
Message-ID: <20170524005255.31223-7-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C97272671A9
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

In former commits, I introduced an alias for copy operation to PCM
frames. As a result, ALSA PCM core has wrapper functions for
driver implementation of 'struct snd_pcm_ops.silence' and
'struct snd_pcm_ops.copy'. Some helper functions in ALSA PCM core declares
that these two operations can be unified.

In this concept, this commit adds new operation; copy_frames. This is
callbacked directly without the wrappers for efficiency. Especially,
drivers for non-interleaved frames alignment can execute loop in its
own and reduce the number of function calls.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h  |  1 +
 sound/core/pcm_lib.c | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 6cb8df081787..07e5469a0b55 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -82,6 +82,7 @@ struct snd_pcm_ops {
 			struct timespec *system_ts, struct timespec *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
+	snd_pcm_copy_frames_t copy_frames;
 	int (*copy)(struct snd_pcm_substream *substream, int channel,
 		    snd_pcm_uframes_t pos,
 		    void __user *buf, snd_pcm_uframes_t count);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8dfe964e8931..13a0c44f5cd1 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -227,17 +227,21 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
 	if (frames == 0)
 		return;
 
-	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-		if (substream->ops->silence)
-			copy_frames = writei_silence;
-		else
-			copy_frames = writei_from_space1;
+	if (substream->ops->copy_frames) {
+		copy_frames = substream->ops->copy_frames;
 	} else {
-		if (substream->ops->silence)
-			copy_frames = writen_silence;
-		else
-			copy_frames = writen_from_space1;
+		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
+		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
+			if (substream->ops->silence)
+				copy_frames = writei_silence;
+			else
+				copy_frames = writei_from_space1;
+		} else {
+			if (substream->ops->silence)
+				copy_frames = writen_silence;
+			else
+				copy_frames = writen_from_space1;
+		}
 	}
 
 	ofs = runtime->silence_start % runtime->buffer_size;
@@ -2253,7 +2257,9 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 	    runtime->channels > 1)
 		return -EINVAL;
 
-	if (substream->ops->copy)
+	if (substream->ops->copy_frames)
+		copy_frames = substream->ops->copy_frames;
+	else if (substream->ops->copy)
 		copy_frames = snd_pcm_lib_write_transfer;
 	else
 		copy_frames = writei_from_space1;
@@ -2314,7 +2320,9 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 
-	if (substream->ops->copy)
+	if (substream->ops->copy_frames)
+		copy_frames = substream->ops->copy_frames;
+	else if (substream->ops->copy)
 		copy_frames = snd_pcm_lib_writev_transfer;
 	else
 		copy_frames = writen_from_space1;
@@ -2465,7 +2473,9 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
 		return -EINVAL;
 
-	if (substream->ops->copy)
+	if (substream->ops->copy_frames)
+		copy_frames = substream->ops->copy_frames;
+	else if (substream->ops->copy)
 		copy_frames = snd_pcm_lib_read_transfer;
 	else
 		copy_frames = readi_to_space1;
@@ -2523,7 +2533,9 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 
-	if (substream->ops->copy)
+	if (substream->ops->copy_frames)
+		copy_frames = substream->ops->copy_frames;
+	else if (substream->ops->copy)
 		copy_frames = snd_pcm_lib_readv_transfer;
 	else
 		copy_frames = readn_to_space1;
-- 
2.11.0
