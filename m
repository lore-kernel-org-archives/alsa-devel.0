From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: pcm: Provide read/write helpers for
	in-kernel buffer transfer
Date: Tue, 23 May 2017 08:11:54 +0200
Message-ID: <20170523061155.1582-4-tiwai@suse.de>
References: <20170523061155.1582-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD3C1267063
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 08:12:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0DC40AD45
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

Thanks to the conversion to copy_silence PCM ops, now we can copy
from/to the kernel-space buffer directly via in_kernel parameter
without set_fs() hack in all places.  This patch extends the existing
helper functions for buffer copy to handle in-kernel buffer
transfers, too.

Also, the similar API functions for in-kernel buffer transfer are
provided as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h  | 50 +++++++++++++++++++++++++++----
 sound/core/pcm_lib.c | 83 ++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 102 insertions(+), 31 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 339ae4f77766..1c9107af7385 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1086,37 +1086,75 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
 				      unsigned long data, bool interleaved,
-				      snd_pcm_uframes_t size);
+				      snd_pcm_uframes_t size, bool in_kernel);
 snd_pcm_sframes_t __snd_pcm_lib_read(struct snd_pcm_substream *substream,
 				     unsigned long data, bool interleaved,
-				     snd_pcm_uframes_t size);
+				     snd_pcm_uframes_t size, bool in_kernel);
 
+/* copy from/to user-space buffer */
 static inline snd_pcm_sframes_t
 snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		  const void __user *buf, snd_pcm_uframes_t size)
 {
-	return __snd_pcm_lib_write(substream, (unsigned long)buf, true, size);
+	return __snd_pcm_lib_write(substream, (unsigned long)buf, true, size,
+				   false);
 }
 
 static inline snd_pcm_sframes_t
 snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 		   void __user **bufs, snd_pcm_uframes_t size)
 {
-	return __snd_pcm_lib_write(substream, (unsigned long)bufs, false, size);
+	return __snd_pcm_lib_write(substream, (unsigned long)bufs, false, size,
+				   false);
 }
 
 static inline snd_pcm_sframes_t
 snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		 void __user *buf, snd_pcm_uframes_t size)
 {
-	return __snd_pcm_lib_read(substream, (unsigned long)buf, true, size);
+	return __snd_pcm_lib_read(substream, (unsigned long)buf, true, size,
+				  false);
 }
 
 static inline snd_pcm_sframes_t
 snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 		  void __user **bufs, snd_pcm_uframes_t size)
 {
-	return __snd_pcm_lib_read(substream, (unsigned long)bufs, false, size);
+	return __snd_pcm_lib_read(substream, (unsigned long)bufs, false, size,
+				  false);
+}
+
+/* copy from/to kernel-space buffer */
+static inline snd_pcm_sframes_t
+snd_pcm_kernel_write(struct snd_pcm_substream *substream,
+		     const void *buf, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_write(substream, (unsigned long)buf, true, size,
+				   true);
+}
+
+static inline snd_pcm_sframes_t
+snd_pcm_kernel_writev(struct snd_pcm_substream *substream,
+		      void **bufs, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_write(substream, (unsigned long)bufs, false, size,
+				   true);
+}
+
+static inline snd_pcm_sframes_t
+snd_pcm_kernel_read(struct snd_pcm_substream *substream,
+		    void *buf, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_read(substream, (unsigned long)buf, true, size,
+				  true);
+}
+
+static inline snd_pcm_sframes_t
+snd_pcm_kernel_readv(struct snd_pcm_substream *substream,
+		     void **bufs, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_read(substream, (unsigned long)bufs, false, size,
+				  true);
 }
 
 extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 02a154c1908f..dfa6d13ba8bd 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1991,7 +1991,7 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 	
 typedef int (*transfer_f)(struct snd_pcm_substream *substream, unsigned int hwoff,
 			  unsigned long data, unsigned int off,
-			  snd_pcm_uframes_t size);
+			  snd_pcm_uframes_t size, bool in_kernel);
 
 /* sanity-check for read/write methods */
 static int pcm_sanity_check(struct snd_pcm_substream *substream)
@@ -2010,19 +2010,26 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
+				      snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
+
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
@@ -2031,7 +2038,7 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 				       unsigned int hwoff,
 				       unsigned long data, unsigned int off,
-				       snd_pcm_uframes_t frames)
+				       snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2047,7 +2054,8 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 			else
 				buf = *bufs + samples_to_bytes(runtime, off);
 			err = substream->ops->copy_silence(substream, c, hwoff,
-							   buf, frames, false);
+							   buf, frames,
+							   in_kernel);
 			if (err < 0)
 				return err;
 		}
@@ -2055,12 +2063,21 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
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
@@ -2070,7 +2087,7 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 
 snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
 				      unsigned long data, bool interleaved,
-				      snd_pcm_uframes_t size)
+				      snd_pcm_uframes_t size, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
@@ -2147,7 +2164,8 @@ snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		appl_ptr = runtime->control->appl_ptr;
 		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
-		err = transfer(substream, appl_ofs, data, offset, frames);
+		err = transfer(substream, appl_ofs, data, offset, frames,
+			       in_kernel);
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
@@ -2192,19 +2210,26 @@ EXPORT_SYMBOL(__snd_pcm_lib_write);
 static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream, 
 				     unsigned int hwoff,
 				     unsigned long data, unsigned int off,
-				     snd_pcm_uframes_t frames)
+				     snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	char __user *buf = (char __user *) data + frames_to_bytes(runtime, off);
+
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
@@ -2213,7 +2238,7 @@ static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream,
 static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 				      unsigned int hwoff,
 				      unsigned long data, unsigned int off,
-				      snd_pcm_uframes_t frames)
+				      snd_pcm_uframes_t frames, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2229,19 +2254,26 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
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
+
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
@@ -2250,7 +2282,7 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 
 snd_pcm_sframes_t __snd_pcm_lib_read(struct snd_pcm_substream *substream,
 				     unsigned long data, bool interleaved,
-				     snd_pcm_uframes_t size)
+				     snd_pcm_uframes_t size, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
@@ -2341,7 +2373,8 @@ snd_pcm_sframes_t __snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		appl_ptr = runtime->control->appl_ptr;
 		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
-		err = transfer(substream, appl_ofs, data, offset, frames);
+		err = transfer(substream, appl_ofs, data, offset, frames,
+			       in_kernel);
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
-- 
2.13.0
