From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 26/26] ALSA: pcm: Kill set_fs() usage in
	OSS layer and USB gadget
Date: Thu, 11 May 2017 23:09:25 +0200
Message-ID: <20170511210925.18208-27-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 02D11266FFF
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:33 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C1832AEED
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

Along with the conversion to copy_silence PCM ops, the direct call of
the callback from/to the kernel-space buffer is supported without
set_fs() hack in all places.  Now let's kill the last-standing
set_fs() usage in the OSS layer and USB gadget driver.

This patch adds the in_kernel argument to each read/write PCM helper
function, and the flag is passed through to the copy_silence ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/u_uac1.c |   8 +--
 include/sound/pcm.h                  |  11 ++--
 sound/core/oss/pcm_oss.c             |  62 ++++---------------
 sound/core/pcm_compat.c              |  10 +--
 sound/core/pcm_lib.c                 | 114 ++++++++++++++++++++++++-----------
 sound/core/pcm_native.c              |  20 +++---
 6 files changed, 118 insertions(+), 107 deletions(-)

diff --git a/drivers/usb/gadget/function/u_uac1.c b/drivers/usb/gadget/function/u_uac1.c
index c78c84138a28..d73654407730 100644
--- a/drivers/usb/gadget/function/u_uac1.c
+++ b/drivers/usb/gadget/function/u_uac1.c
@@ -157,7 +157,6 @@ size_t u_audio_playback(struct gaudio *card, void *buf, size_t count)
 	struct gaudio_snd_dev	*snd = &card->playback;
 	struct snd_pcm_substream *substream = snd->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	mm_segment_t old_fs;
 	ssize_t result;
 	snd_pcm_sframes_t frames;
 
@@ -174,15 +173,12 @@ size_t u_audio_playback(struct gaudio *card, void *buf, size_t count)
 	}
 
 	frames = bytes_to_frames(runtime, count);
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	result = snd_pcm_lib_write(snd->substream, (void __user *)buf, frames);
+	result = snd_pcm_lib_write(snd->substream, (void __user *)buf, frames,
+				   true);
 	if (result != frames) {
 		ERROR(card, "Playback error: %d\n", (int)result);
-		set_fs(old_fs);
 		goto try_again;
 	}
-	set_fs(old_fs);
 
 	return 0;
 }
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 67ba55c1062b..06e6e0125f36 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1085,13 +1085,16 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 				    const void __user *buf,
-				    snd_pcm_uframes_t frames);
+				    snd_pcm_uframes_t frames, bool in_kernel);
 snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
-				   void __user *buf, snd_pcm_uframes_t frames);
+				   void __user *buf, snd_pcm_uframes_t frames,
+				   bool in_kernel);
 snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
-				     void __user **bufs, snd_pcm_uframes_t frames);
+				     void __user **bufs, snd_pcm_uframes_t frames,
+				     bool in_kernel);
 snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
-				    void __user **bufs, snd_pcm_uframes_t frames);
+				    void __user **bufs, snd_pcm_uframes_t frames,
+				    bool in_kernel);
 
 extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
 
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 36baf962f9b0..8598acb79d07 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -67,18 +67,6 @@ static int snd_pcm_oss_get_rate(struct snd_pcm_oss_file *pcm_oss_file);
 static int snd_pcm_oss_get_channels(struct snd_pcm_oss_file *pcm_oss_file);
 static int snd_pcm_oss_get_format(struct snd_pcm_oss_file *pcm_oss_file);
 
-static inline mm_segment_t snd_enter_user(void)
-{
-	mm_segment_t fs = get_fs();
-	set_fs(get_ds());
-	return fs;
-}
-
-static inline void snd_leave_user(mm_segment_t fs)
-{
-	set_fs(fs);
-}
-
 /*
  * helper functions to process hw_params
  */
@@ -1191,14 +1179,8 @@ snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream, const
 			if (ret < 0)
 				break;
 		}
-		if (in_kernel) {
-			mm_segment_t fs;
-			fs = snd_enter_user();
-			ret = snd_pcm_lib_write(substream, (void __force __user *)ptr, frames);
-			snd_leave_user(fs);
-		} else {
-			ret = snd_pcm_lib_write(substream, (void __force __user *)ptr, frames);
-		}
+		ret = snd_pcm_lib_write(substream, (void __force __user *)ptr,
+					frames, in_kernel);
 		if (ret != -EPIPE && ret != -ESTRPIPE)
 			break;
 		/* test, if we can't store new data, because the stream */
@@ -1234,14 +1216,8 @@ snd_pcm_sframes_t snd_pcm_oss_read3(struct snd_pcm_substream *substream, char *p
 		ret = snd_pcm_oss_capture_position_fixup(substream, &delay);
 		if (ret < 0)
 			break;
-		if (in_kernel) {
-			mm_segment_t fs;
-			fs = snd_enter_user();
-			ret = snd_pcm_lib_read(substream, (void __force __user *)ptr, frames);
-			snd_leave_user(fs);
-		} else {
-			ret = snd_pcm_lib_read(substream, (void __force __user *)ptr, frames);
-		}
+		ret = snd_pcm_lib_read(substream, (void __force __user *)ptr,
+				       frames, in_kernel);
 		if (ret == -EPIPE) {
 			if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
 				ret = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
@@ -1273,14 +1249,8 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void
 			if (ret < 0)
 				break;
 		}
-		if (in_kernel) {
-			mm_segment_t fs;
-			fs = snd_enter_user();
-			ret = snd_pcm_lib_writev(substream, (void __user **)bufs, frames);
-			snd_leave_user(fs);
-		} else {
-			ret = snd_pcm_lib_writev(substream, (void __user **)bufs, frames);
-		}
+		ret = snd_pcm_lib_writev(substream, (void __user **)bufs,
+					 frames, in_kernel);
 		if (ret != -EPIPE && ret != -ESTRPIPE)
 			break;
 
@@ -1313,14 +1283,8 @@ snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream, void *
 			if (ret < 0)
 				break;
 		}
-		if (in_kernel) {
-			mm_segment_t fs;
-			fs = snd_enter_user();
-			ret = snd_pcm_lib_readv(substream, (void __user **)bufs, frames);
-			snd_leave_user(fs);
-		} else {
-			ret = snd_pcm_lib_readv(substream, (void __user **)bufs, frames);
-		}
+		ret = snd_pcm_lib_readv(substream, (void __user **)bufs,
+					frames, in_kernel);
 		if (ret != -EPIPE && ret != -ESTRPIPE)
 			break;
 	}
@@ -1653,7 +1617,6 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file *pcm_oss_file)
 			if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED) {
 				size = (runtime->frame_bits * size) / 8;
 				while (size > 0) {
-					mm_segment_t fs;
 					size_t size1 = size < runtime->oss.period_bytes ? size : runtime->oss.period_bytes;
 					size -= size1;
 					size1 *= 8;
@@ -1662,14 +1625,15 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file *pcm_oss_file)
 								   runtime->oss.buffer,
 								   size1);
 					size1 /= runtime->channels; /* frames */
-					fs = snd_enter_user();
-					snd_pcm_lib_write(substream, (void __force __user *)runtime->oss.buffer, size1);
-					snd_leave_user(fs);
+					snd_pcm_lib_write(substream,
+							  (void __force __user *)runtime->oss.buffer,
+							  size1, true);
 				}
 			} else if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED) {
 				void __user *buffers[runtime->channels];
 				memset(buffers, 0, runtime->channels * sizeof(void *));
-				snd_pcm_lib_writev(substream, buffers, size);
+				snd_pcm_lib_writev(substream, buffers, size,
+						   false);
 			}
 		}
 		mutex_unlock(&runtime->oss.params_lock);
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 8a0f8d51e95d..6f2a50a53d94 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -384,9 +384,11 @@ static int snd_pcm_ioctl_xferi_compat(struct snd_pcm_substream *substream,
 		return -EFAULT;
 
 	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		err = snd_pcm_lib_write(substream, compat_ptr(buf), frames);
+		err = snd_pcm_lib_write(substream, compat_ptr(buf), frames,
+					false);
 	else
-		err = snd_pcm_lib_read(substream, compat_ptr(buf), frames);
+		err = snd_pcm_lib_read(substream, compat_ptr(buf), frames,
+				       false);
 	if (err < 0)
 		return err;
 	/* copy the result */
@@ -442,9 +444,9 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 		bufptr++;
 	}
 	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		err = snd_pcm_lib_writev(substream, bufs, frames);
+		err = snd_pcm_lib_writev(substream, bufs, frames, false);
 	else
-		err = snd_pcm_lib_readv(substream, bufs, frames);
+		err = snd_pcm_lib_readv(substream, bufs, frames, false);
 	if (err >= 0) {
 		if (put_user(err, &data32->result))
 			err = -EFAULT;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a2f796c8f39e..2820205416d6 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1990,19 +1990,26 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
+				      snd_pcm_uframes_t frames,
+				      bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
 	if (substream->ops->copy_silence) {
 		err = substream->ops->copy_silence(substream, -1, hwoff, buf,
-						   frames, false);
+						   frames, in_kernel);
 		if (err < 0)
 			return err;
 	} else {
-		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
-		if (copy_from_user(hwbuf, buf, frames_to_bytes(runtime, frames)))
+		char *hwbuf = runtime->dma_area +
+			frames_to_bytes(runtime, hwoff);
+
+		if (in_kernel)
+			memcpy(hwbuf, (void *)buf,
+			       frames_to_bytes(runtime, frames));
+		else if (copy_from_user(hwbuf, buf,
+					frames_to_bytes(runtime, frames)))
 			return -EFAULT;
 	}
 	return 0;
@@ -2010,13 +2017,14 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
  
 typedef int (*transfer_f)(struct snd_pcm_substream *substream, unsigned int hwoff,
 			  unsigned long data, unsigned int off,
-			  snd_pcm_uframes_t size);
+			  snd_pcm_uframes_t size, bool in_kernel);
 
 static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream, 
 					    unsigned long data,
 					    snd_pcm_uframes_t size,
 					    int nonblock,
-					    transfer_f transfer)
+					    transfer_f transfer,
+					    bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
@@ -2074,7 +2082,8 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		appl_ptr = runtime->control->appl_ptr;
 		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
-		err = transfer(substream, appl_ofs, data, offset, frames);
+		err = transfer(substream, appl_ofs, data, offset, frames,
+			       in_kernel);
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
@@ -2128,7 +2137,9 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const void __user *buf, snd_pcm_uframes_t size)
+snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
+				    const void __user *buf,
+				    snd_pcm_uframes_t size, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
@@ -2144,15 +2155,15 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const v
 	    runtime->channels > 1)
 		return -EINVAL;
 	return snd_pcm_lib_write1(substream, (unsigned long)buf, size, nonblock,
-				  snd_pcm_lib_write_transfer);
+				  snd_pcm_lib_write_transfer, in_kernel);
 }
-
 EXPORT_SYMBOL(snd_pcm_lib_write);
 
 static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 				       unsigned int hwoff,
 				       unsigned long data, unsigned int off,
-				       snd_pcm_uframes_t frames)
+				       snd_pcm_uframes_t frames,
+				       bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2168,7 +2179,8 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 			else
 				buf = *bufs + samples_to_bytes(runtime, off);
 			err = substream->ops->copy_silence(substream, c, hwoff,
-							   buf, frames, false);
+							   buf, frames,
+							   in_kernel);
 			if (err < 0)
 				return err;
 		}
@@ -2176,12 +2188,21 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 		/* default transfer behaviour */
 		size_t dma_csize = runtime->dma_bytes / channels;
 		for (c = 0; c < channels; ++c, ++bufs) {
-			char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
-			if (*bufs == NULL) {
-				snd_pcm_format_set_silence(runtime->format, hwbuf, frames);
+			char *hwbuf = runtime->dma_area + (c * dma_csize) +
+				samples_to_bytes(runtime, hwoff);
+
+			if (!*bufs) {
+				snd_pcm_format_set_silence(runtime->format,
+							   hwbuf, frames);
 			} else {
-				char __user *buf = *bufs + samples_to_bytes(runtime, off);
-				if (copy_from_user(hwbuf, buf, samples_to_bytes(runtime, frames)))
+				char __user *buf = *bufs +
+					samples_to_bytes(runtime, off);
+
+				if (in_kernel)
+					memcpy(hwbuf, (void *)buf,
+					       samples_to_bytes(runtime, frames));
+				else if (copy_from_user(hwbuf, buf,
+							samples_to_bytes(runtime, frames)))
 					return -EFAULT;
 			}
 		}
@@ -2191,7 +2212,8 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
  
 snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 				     void __user **bufs,
-				     snd_pcm_uframes_t frames)
+				     snd_pcm_uframes_t frames,
+				     bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
@@ -2206,27 +2228,34 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 	return snd_pcm_lib_write1(substream, (unsigned long)bufs, frames,
-				  nonblock, snd_pcm_lib_writev_transfer);
+				  nonblock, snd_pcm_lib_writev_transfer,
+				  in_kernel);
 }
-
 EXPORT_SYMBOL(snd_pcm_lib_writev);
 
 static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream, 
 				     unsigned int hwoff,
 				     unsigned long data, unsigned int off,
-				     snd_pcm_uframes_t frames)
+				     snd_pcm_uframes_t frames,
+				     bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
 	if (substream->ops->copy_silence) {
 		err = substream->ops->copy_silence(substream, -1, hwoff, buf,
-						   frames, false);
+						   frames, in_kernel);
 		if (err < 0)
 			return err;
 	} else {
-		char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, hwoff);
-		if (copy_to_user(buf, hwbuf, frames_to_bytes(runtime, frames)))
+		char *hwbuf = runtime->dma_area +
+			frames_to_bytes(runtime, hwoff);
+
+		if (in_kernel)
+			memcpy((void *)buf, hwbuf,
+			       frames_to_bytes(runtime, frames));
+		else if (copy_to_user(buf, hwbuf,
+				      frames_to_bytes(runtime, frames)))
 			return -EFAULT;
 	}
 	return 0;
@@ -2236,7 +2265,8 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 					   unsigned long data,
 					   snd_pcm_uframes_t size,
 					   int nonblock,
-					   transfer_f transfer)
+					   transfer_f transfer,
+					   bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
@@ -2308,7 +2338,8 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		appl_ptr = runtime->control->appl_ptr;
 		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
-		err = transfer(substream, appl_ofs, data, offset, frames);
+		err = transfer(substream, appl_ofs, data, offset, frames,
+			       in_kernel);
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
@@ -2342,7 +2373,9 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
 
-snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream, void __user *buf, snd_pcm_uframes_t size)
+snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
+				   void __user *buf, snd_pcm_uframes_t size,
+				   bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
@@ -2355,7 +2388,8 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream, void __u
 	nonblock = !!(substream->f_flags & O_NONBLOCK);
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
 		return -EINVAL;
-	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock, snd_pcm_lib_read_transfer);
+	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock,
+				 snd_pcm_lib_read_transfer, in_kernel);
 }
 
 EXPORT_SYMBOL(snd_pcm_lib_read);
@@ -2363,7 +2397,8 @@ EXPORT_SYMBOL(snd_pcm_lib_read);
 static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
+				      snd_pcm_uframes_t frames,
+				      bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2379,19 +2414,25 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 				continue;
 			buf = *bufs + samples_to_bytes(runtime, off);
 			err = substream->ops->copy_silence(substream, c, hwoff,
-							   buf, frames, false);
+							   buf, frames,
+							   in_kernel);
 			if (err < 0)
 				return err;
 		}
 	} else {
 		snd_pcm_uframes_t dma_csize = runtime->dma_bytes / channels;
 		for (c = 0; c < channels; ++c, ++bufs) {
-			if (*bufs == NULL)
+			if (!*bufs)
 				continue;
 
-			hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, hwoff);
+			hwbuf = runtime->dma_area + (c * dma_csize) +
+				samples_to_bytes(runtime, hwoff);
 			buf = *bufs + samples_to_bytes(runtime, off);
-			if (copy_to_user(buf, hwbuf, samples_to_bytes(runtime, frames)))
+			if (in_kernel)
+				memcpy((void *)buf, hwbuf,
+				       samples_to_bytes(runtime, frames));
+			else if (copy_to_user(buf, hwbuf,
+					      samples_to_bytes(runtime, frames)))
 				return -EFAULT;
 		}
 	}
@@ -2400,7 +2441,7 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
  
 snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 				    void __user **bufs,
-				    snd_pcm_uframes_t frames)
+				    snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
@@ -2416,9 +2457,10 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 	nonblock = !!(substream->f_flags & O_NONBLOCK);
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
-	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames, nonblock, snd_pcm_lib_readv_transfer);
+	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames,
+				 nonblock, snd_pcm_lib_readv_transfer,
+				 in_kernel);
 }
-
 EXPORT_SYMBOL(snd_pcm_lib_readv);
 
 /*
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f9bd56958cad..6397fd1e414d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2839,7 +2839,8 @@ static int snd_pcm_playback_ioctl1(struct file *file,
 			return -EFAULT;
 		if (copy_from_user(&xferi, _xferi, sizeof(xferi)))
 			return -EFAULT;
-		result = snd_pcm_lib_write(substream, xferi.buf, xferi.frames);
+		result = snd_pcm_lib_write(substream, xferi.buf, xferi.frames,
+					   false);
 		__put_user(result, &_xferi->result);
 		return result < 0 ? result : 0;
 	}
@@ -2863,7 +2864,8 @@ static int snd_pcm_playback_ioctl1(struct file *file,
 				   sizeof(void *) * runtime->channels);
 		if (IS_ERR(bufs))
 			return PTR_ERR(bufs);
-		result = snd_pcm_lib_writev(substream, bufs, xfern.frames);
+		result = snd_pcm_lib_writev(substream, bufs, xfern.frames,
+					    false);
 		kfree(bufs);
 		__put_user(result, &_xfern->result);
 		return result < 0 ? result : 0;
@@ -2919,7 +2921,8 @@ static int snd_pcm_capture_ioctl1(struct file *file,
 			return -EFAULT;
 		if (copy_from_user(&xferi, _xferi, sizeof(xferi)))
 			return -EFAULT;
-		result = snd_pcm_lib_read(substream, xferi.buf, xferi.frames);
+		result = snd_pcm_lib_read(substream, xferi.buf, xferi.frames,
+					  false);
 		__put_user(result, &_xferi->result);
 		return result < 0 ? result : 0;
 	}
@@ -2943,7 +2946,8 @@ static int snd_pcm_capture_ioctl1(struct file *file,
 				   sizeof(void *) * runtime->channels);
 		if (IS_ERR(bufs))
 			return PTR_ERR(bufs);
-		result = snd_pcm_lib_readv(substream, bufs, xfern.frames);
+		result = snd_pcm_lib_readv(substream, bufs, xfern.frames,
+					   false);
 		kfree(bufs);
 		__put_user(result, &_xfern->result);
 		return result < 0 ? result : 0;
@@ -3075,7 +3079,7 @@ static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count,
 	if (!frame_aligned(runtime, count))
 		return -EINVAL;
 	count = bytes_to_frames(runtime, count);
-	result = snd_pcm_lib_read(substream, buf, count);
+	result = snd_pcm_lib_read(substream, buf, count, false);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
 	return result;
@@ -3099,7 +3103,7 @@ static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
 	if (!frame_aligned(runtime, count))
 		return -EINVAL;
 	count = bytes_to_frames(runtime, count);
-	result = snd_pcm_lib_write(substream, buf, count);
+	result = snd_pcm_lib_write(substream, buf, count, false);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
 	return result;
@@ -3134,7 +3138,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 		return -ENOMEM;
 	for (i = 0; i < to->nr_segs; ++i)
 		bufs[i] = to->iov[i].iov_base;
-	result = snd_pcm_lib_readv(substream, bufs, frames);
+	result = snd_pcm_lib_readv(substream, bufs, frames, false);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
 	kfree(bufs);
@@ -3169,7 +3173,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 		return -ENOMEM;
 	for (i = 0; i < from->nr_segs; ++i)
 		bufs[i] = from->iov[i].iov_base;
-	result = snd_pcm_lib_writev(substream, bufs, frames);
+	result = snd_pcm_lib_writev(substream, bufs, frames, false);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
 	kfree(bufs);
-- 
2.12.2
