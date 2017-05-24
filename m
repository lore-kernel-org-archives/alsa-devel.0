From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 09/11] ALSA: pcm: remove copy and silence
	callbacks
Date: Wed, 24 May 2017 09:52:53 +0900
Message-ID: <20170524005255.31223-10-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 111382671B2
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

A new operation, copy_frames, can replaces the copy and silence callbacks.
This commit purge them involving driver-side implementations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h      |   5 --
 sound/core/pcm_lib.c     | 136 ++---------------------------------------------
 sound/isa/gus/gus_pcm.c  |  64 ----------------------
 sound/pci/rme9652/hdsp.c |  50 -----------------
 4 files changed, 3 insertions(+), 252 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 07e5469a0b55..cf97e478b664 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -83,11 +83,6 @@ struct snd_pcm_ops {
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
 	snd_pcm_copy_frames_t copy_frames;
-	int (*copy)(struct snd_pcm_substream *substream, int channel,
-		    snd_pcm_uframes_t pos,
-		    void __user *buf, snd_pcm_uframes_t count);
-	int (*silence)(struct snd_pcm_substream *substream, int channel, 
-		       snd_pcm_uframes_t pos, snd_pcm_uframes_t count);
 	struct page *(*page)(struct snd_pcm_substream *substream,
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 13a0c44f5cd1..7b8d35823de6 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -136,31 +136,6 @@ static int readn_to_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int writei_silence(struct snd_pcm_substream *substream,
-			  unsigned int hwoff, unsigned long data,
-			  unsigned int off, snd_pcm_uframes_t count)
-{
-	return substream->ops->silence(substream, -1, hwoff, count);
-}
-
-static int writen_silence(struct snd_pcm_substream *substream,
-			  unsigned int hwoff, unsigned long data,
-			  unsigned int off, snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int channels = runtime->channels;
-	int c;
-	int err;
-
-	for (c = 0; c < channels; ++c) {
-		err = substream->ops->silence(substream, c, hwoff, count);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
 /*
  * fill ring buffer with silence
  * runtime->silence_start: starting pointer to silence area
@@ -232,15 +207,9 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
 	} else {
 		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			if (substream->ops->silence)
-				copy_frames = writei_silence;
-			else
-				copy_frames = writei_from_space1;
+			copy_frames = writei_from_space1;
 		} else {
-			if (substream->ops->silence)
-				copy_frames = writen_silence;
-			else
-				copy_frames = writen_from_space1;
+			copy_frames = writen_from_space1;
 		}
 	}
 
@@ -2108,21 +2077,6 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 	return err;
 }
 	
-static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
-				      unsigned int hwoff,
-				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	char __user *buf = (char __user *) data;
-
-	if (buf == NULL && substream->ops->silence)
-		return substream->ops->silence(substream, -1, hwoff, count);
-
-	buf += frames_to_bytes(runtime, off);
-	return substream->ops->copy(substream, -1, hwoff, buf, count);
-}
- 
 static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream, 
 					    unsigned long data,
 					    snd_pcm_uframes_t size,
@@ -2232,7 +2186,7 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy && !runtime->dma_area))
+	if (snd_BUG_ON(!substream->ops->copy_frames && !runtime->dma_area))
 		return -EINVAL;
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
@@ -2259,8 +2213,6 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 
 	if (substream->ops->copy_frames)
 		copy_frames = substream->ops->copy_frames;
-	else if (substream->ops->copy)
-		copy_frames = snd_pcm_lib_write_transfer;
 	else
 		copy_frames = writei_from_space1;
 
@@ -2269,39 +2221,6 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL(snd_pcm_lib_write);
 
-static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
-				       unsigned int hwoff,
-				       unsigned long data, unsigned int off,
-				       snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	char __user **bufs = (char __user **)data;
-	char __user *buf;
-	int channels = runtime->channels;
-	int c;
-	int err;
-
-	if (snd_BUG_ON(!substream->ops->silence))
-		return -EINVAL;
-
-	for (c = 0; c < channels; ++c) {
-		if (bufs == NULL || bufs[c] == NULL) {
-			err = substream->ops->silence(substream, c, hwoff,
-						      frames);
-			if (err < 0)
-				return err;
-		} else {
-			buf = bufs[c] + samples_to_bytes(runtime, off);
-			err = substream->ops->copy(substream, c, hwoff, buf,
-						   frames);
-			if (err < 0)
-				return err;
-		}
-	}
-
-	return 0;
-}
- 
 snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 				     void __user **bufs,
 				     snd_pcm_uframes_t frames)
@@ -2322,8 +2241,6 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 
 	if (substream->ops->copy_frames)
 		copy_frames = substream->ops->copy_frames;
-	else if (substream->ops->copy)
-		copy_frames = snd_pcm_lib_writev_transfer;
 	else
 		copy_frames = writen_from_space1;
 
@@ -2332,21 +2249,6 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL(snd_pcm_lib_writev);
 
-static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream, 
-				     unsigned int hwoff,
-				     unsigned long data, unsigned int off,
-				     snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	char __user *buf = (char __user *)data;
-
-	if (buf == NULL)
-		return -EINVAL;
-
-	buf += frames_to_bytes(runtime, off);
-	return substream->ops->copy(substream, -1, hwoff, buf, frames);
-}
-
 static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 					   unsigned long data,
 					   snd_pcm_uframes_t size,
@@ -2475,8 +2377,6 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
 
 	if (substream->ops->copy_frames)
 		copy_frames = substream->ops->copy_frames;
-	else if (substream->ops->copy)
-		copy_frames = snd_pcm_lib_read_transfer;
 	else
 		copy_frames = readi_to_space1;
 
@@ -2485,34 +2385,6 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL(snd_pcm_lib_read);
 
-static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
-				      unsigned int hwoff,
-				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	char __user **bufs = (char __user **)data;
-	char __user *buf;
-	unsigned int channels = runtime->channels;
-	int c;
-	int err;
-
-	if (bufs == NULL)
-		return -EINVAL;
-
-	for (c = 0; c < channels; ++c) {
-		if (bufs[c] == NULL)
-			continue;
-
-		buf = bufs[c] + samples_to_bytes(runtime, off);
-		err = substream->ops->copy(substream, c, hwoff, buf, frames);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
- 
 snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 				    void __user **bufs,
 				    snd_pcm_uframes_t frames)
@@ -2535,8 +2407,6 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 
 	if (substream->ops->copy_frames)
 		copy_frames = substream->ops->copy_frames;
-	else if (substream->ops->copy)
-		copy_frames = snd_pcm_lib_readv_transfer;
 	else
 		copy_frames = readn_to_space1;
 
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 08bc1f9931a2..48bef91f46ef 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -355,68 +355,6 @@ static int snd_gf1_pcm_poke_block(struct snd_gus_card *gus, unsigned char *buf,
 	return 0;
 }
 
-static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
-				     int voice,
-				     snd_pcm_uframes_t pos,
-				     void __user *src,
-				     snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct gus_pcm_private *pcmp = runtime->private_data;
-	unsigned int bpos, len;
-	
-	bpos = samples_to_bytes(runtime, pos) + (voice * (pcmp->dma_size / 2));
-	len = samples_to_bytes(runtime, count);
-	if (snd_BUG_ON(bpos > pcmp->dma_size))
-		return -EIO;
-	if (snd_BUG_ON(bpos + len > pcmp->dma_size))
-		return -EIO;
-	if (copy_from_user(runtime->dma_area + bpos, src, len))
-		return -EFAULT;
-	if (snd_gf1_pcm_use_dma && len > 32) {
-		return snd_gf1_pcm_block_change(substream, bpos, pcmp->memory + bpos, len);
-	} else {
-		struct snd_gus_card *gus = pcmp->gus;
-		int err, w16, invert;
-
-		w16 = (snd_pcm_format_width(runtime->format) == 16);
-		invert = snd_pcm_format_unsigned(runtime->format);
-		if ((err = snd_gf1_pcm_poke_block(gus, runtime->dma_area + bpos, pcmp->memory + bpos, len, w16, invert)) < 0)
-			return err;
-	}
-	return 0;
-}
-
-static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
-					int voice,
-					snd_pcm_uframes_t pos,
-					snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct gus_pcm_private *pcmp = runtime->private_data;
-	unsigned int bpos, len;
-	
-	bpos = samples_to_bytes(runtime, pos) + (voice * (pcmp->dma_size / 2));
-	len = samples_to_bytes(runtime, count);
-	if (snd_BUG_ON(bpos > pcmp->dma_size))
-		return -EIO;
-	if (snd_BUG_ON(bpos + len > pcmp->dma_size))
-		return -EIO;
-	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + bpos, count);
-	if (snd_gf1_pcm_use_dma && len > 32) {
-		return snd_gf1_pcm_block_change(substream, bpos, pcmp->memory + bpos, len);
-	} else {
-		struct snd_gus_card *gus = pcmp->gus;
-		int err, w16, invert;
-
-		w16 = (snd_pcm_format_width(runtime->format) == 16);
-		invert = snd_pcm_format_unsigned(runtime->format);
-		if ((err = snd_gf1_pcm_poke_block(gus, runtime->dma_area + bpos, pcmp->memory + bpos, len, w16, invert)) < 0)
-			return err;
-	}
-	return 0;
-}
-
 static int playback_copy_frames(struct snd_pcm_substream *substream,
 				unsigned int hwoff, unsigned long data,
 				unsigned int off, snd_pcm_uframes_t count)
@@ -893,8 +831,6 @@ static struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
 	.prepare =	snd_gf1_pcm_playback_prepare,
 	.trigger =	snd_gf1_pcm_playback_trigger,
 	.pointer =	snd_gf1_pcm_playback_pointer,
-	.copy =		snd_gf1_pcm_playback_copy,
-	.silence =	snd_gf1_pcm_playback_silence,
 	.copy_frames =	playback_copy_frames,
 };
 
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 430c6cbcb5f6..d1a86b16444b 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3913,23 +3913,6 @@ static char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 		return hdsp->playback_buffer + (mapped_channel * HDSP_CHANNEL_BUFFER_BYTES);
 }
 
-static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream, int channel,
-				  snd_pcm_uframes_t pos, void __user *src, snd_pcm_uframes_t count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
-
-	if (snd_BUG_ON(pos + count > HDSP_CHANNEL_BUFFER_BYTES / 4))
-		return -EINVAL;
-
-	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	if (copy_from_user(channel_buf + pos * 4, src, count * 4))
-		return -EFAULT;
-	return count;
-}
-
 static int playback_copy_frames(struct snd_pcm_substream *substream,
 				unsigned int hwoff, unsigned long data,
 				unsigned int off, snd_pcm_uframes_t count)
@@ -3955,23 +3938,6 @@ static int playback_copy_frames(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream, int channel,
-				 snd_pcm_uframes_t pos, void __user *dst, snd_pcm_uframes_t count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
-
-	if (snd_BUG_ON(pos + count > HDSP_CHANNEL_BUFFER_BYTES / 4))
-		return -EINVAL;
-
-	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	if (copy_to_user(dst, channel_buf + pos * 4, count * 4))
-		return -EFAULT;
-	return count;
-}
-
 static int capture_copy_frames(struct snd_pcm_substream *substream,
 			       unsigned int hwoff, unsigned long data,
 			       unsigned int off, snd_pcm_uframes_t count)
@@ -3992,19 +3958,6 @@ static int capture_copy_frames(struct snd_pcm_substream *substream,
 	return count;
 }
 
-static int snd_hdsp_hw_silence(struct snd_pcm_substream *substream, int channel,
-				  snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
-
-	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memset(channel_buf + pos * 4, 0, count * 4);
-	return count;
-}
-
 static int snd_hdsp_reset(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -4914,8 +4867,6 @@ static const struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy =		snd_hdsp_playback_copy,
-	.silence =	snd_hdsp_hw_silence,
 	.copy_frames =	playback_copy_frames,
 };
 
@@ -4927,7 +4878,6 @@ static const struct snd_pcm_ops snd_hdsp_capture_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy =		snd_hdsp_capture_copy,
 	.copy_frames =	capture_copy_frames,
 };
 
-- 
2.11.0
