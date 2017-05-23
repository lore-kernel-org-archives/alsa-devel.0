From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: pcm: Call directly the common
	read/write helpers
Date: Tue, 23 May 2017 08:11:53 +0200
Message-ID: <20170523061155.1582-3-tiwai@suse.de>
References: <20170523061155.1582-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B56E22664EB
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 08:12:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 05704AD41
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

Make snd_pcm_lib_read() and *_write() static inline functions that
call the common helper functions directly.  This reduces a slight
amount of codes, and at the same time, it's a preparation for the
further cleanups / fixes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h  |  43 ++++++++++++----
 sound/core/pcm_lib.c | 143 +++++++++++++++++----------------------------------
 2 files changed, 82 insertions(+), 104 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 4243c02c3f11..339ae4f77766 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1084,15 +1084,40 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream);
 void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_uframes_t new_hw_ptr);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
-snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
-				    const void __user *buf,
-				    snd_pcm_uframes_t frames);
-snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
-				   void __user *buf, snd_pcm_uframes_t frames);
-snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
-				     void __user **bufs, snd_pcm_uframes_t frames);
-snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
-				    void __user **bufs, snd_pcm_uframes_t frames);
+snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
+				      unsigned long data, bool interleaved,
+				      snd_pcm_uframes_t size);
+snd_pcm_sframes_t __snd_pcm_lib_read(struct snd_pcm_substream *substream,
+				     unsigned long data, bool interleaved,
+				     snd_pcm_uframes_t size);
+
+static inline snd_pcm_sframes_t
+snd_pcm_lib_write(struct snd_pcm_substream *substream,
+		  const void __user *buf, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_write(substream, (unsigned long)buf, true, size);
+}
+
+static inline snd_pcm_sframes_t
+snd_pcm_lib_writev(struct snd_pcm_substream *substream,
+		   void __user **bufs, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_write(substream, (unsigned long)bufs, false, size);
+}
+
+static inline snd_pcm_sframes_t
+snd_pcm_lib_read(struct snd_pcm_substream *substream,
+		 void __user *buf, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_read(substream, (unsigned long)buf, true, size);
+}
+
+static inline snd_pcm_sframes_t
+snd_pcm_lib_readv(struct snd_pcm_substream *substream,
+		  void __user **bufs, snd_pcm_uframes_t size)
+{
+	return __snd_pcm_lib_read(substream, (unsigned long)bufs, false, size);
+}
 
 extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
 
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 2593412091dc..02a154c1908f 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2068,21 +2068,38 @@ static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream, 
-					    unsigned long data,
-					    snd_pcm_uframes_t size,
-					    int nonblock,
-					    transfer_f transfer)
+snd_pcm_sframes_t __snd_pcm_lib_write(struct snd_pcm_substream *substream,
+				      unsigned long data, bool interleaved,
+				      snd_pcm_uframes_t size)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_uframes_t avail;
-	int err = 0;
+	transfer_f transfer;
+	bool nonblock;
+	int err;
+
+	err = pcm_sanity_check(substream);
+	if (err < 0)
+		return err;
+
+	if (interleaved) {
+		if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED &&
+		    runtime->channels > 1)
+			return -EINVAL;
+		transfer = snd_pcm_lib_write_transfer;
+	} else {
+		if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
+			return -EINVAL;
+		transfer = snd_pcm_lib_writev_transfer;
+	}
 
 	if (size == 0)
 		return 0;
 
+	nonblock = !!(substream->f_flags & O_NONBLOCK);
+
 	snd_pcm_stream_lock_irq(substream);
 	switch (runtime->status->state) {
 	case SNDRV_PCM_STATE_PREPARED:
@@ -2169,49 +2186,8 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 	snd_pcm_stream_unlock_irq(substream);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
+EXPORT_SYMBOL(__snd_pcm_lib_write);
 
-snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const void __user *buf, snd_pcm_uframes_t size)
-{
-	struct snd_pcm_runtime *runtime;
-	int nonblock;
-	int err;
-
-	err = pcm_sanity_check(substream);
-	if (err < 0)
-		return err;
-	runtime = substream->runtime;
-	nonblock = !!(substream->f_flags & O_NONBLOCK);
-
-	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED &&
-	    runtime->channels > 1)
-		return -EINVAL;
-	return snd_pcm_lib_write1(substream, (unsigned long)buf, size, nonblock,
-				  snd_pcm_lib_write_transfer);
-}
-
-EXPORT_SYMBOL(snd_pcm_lib_write);
-
-snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
-				     void __user **bufs,
-				     snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime;
-	int nonblock;
-	int err;
-
-	err = pcm_sanity_check(substream);
-	if (err < 0)
-		return err;
-	runtime = substream->runtime;
-	nonblock = !!(substream->f_flags & O_NONBLOCK);
-
-	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
-		return -EINVAL;
-	return snd_pcm_lib_write1(substream, (unsigned long)bufs, frames,
-				  nonblock, snd_pcm_lib_writev_transfer);
-}
-
-EXPORT_SYMBOL(snd_pcm_lib_writev);
 
 static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream, 
 				     unsigned int hwoff,
@@ -2272,21 +2248,38 @@ static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
-					   unsigned long data,
-					   snd_pcm_uframes_t size,
-					   int nonblock,
-					   transfer_f transfer)
+snd_pcm_sframes_t __snd_pcm_lib_read(struct snd_pcm_substream *substream,
+				     unsigned long data, bool interleaved,
+				     snd_pcm_uframes_t size)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_uframes_t avail;
-	int err = 0;
+	transfer_f transfer;
+	bool nonblock;
+	int err;
+
+	err = pcm_sanity_check(substream);
+	if (err < 0)
+		return err;
+
+	if (interleaved) {
+		if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED &&
+		    runtime->channels > 1)
+			return -EINVAL;
+		transfer = snd_pcm_lib_read_transfer;
+	} else {
+		if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
+			return -EINVAL;
+		transfer = snd_pcm_lib_readv_transfer;
+	}
 
 	if (size == 0)
 		return 0;
 
+	nonblock = !!(substream->f_flags & O_NONBLOCK);
+
 	snd_pcm_stream_lock_irq(substream);
 	switch (runtime->status->state) {
 	case SNDRV_PCM_STATE_PREPARED:
@@ -2381,47 +2374,7 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 	snd_pcm_stream_unlock_irq(substream);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
-
-snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream, void __user *buf, snd_pcm_uframes_t size)
-{
-	struct snd_pcm_runtime *runtime;
-	int nonblock;
-	int err;
-	
-	err = pcm_sanity_check(substream);
-	if (err < 0)
-		return err;
-	runtime = substream->runtime;
-	nonblock = !!(substream->f_flags & O_NONBLOCK);
-	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
-		return -EINVAL;
-	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock, snd_pcm_lib_read_transfer);
-}
-
-EXPORT_SYMBOL(snd_pcm_lib_read);
-
-snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
-				    void __user **bufs,
-				    snd_pcm_uframes_t frames)
-{
-	struct snd_pcm_runtime *runtime;
-	int nonblock;
-	int err;
-
-	err = pcm_sanity_check(substream);
-	if (err < 0)
-		return err;
-	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
-		return -EBADFD;
-
-	nonblock = !!(substream->f_flags & O_NONBLOCK);
-	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
-		return -EINVAL;
-	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames, nonblock, snd_pcm_lib_readv_transfer);
-}
-
-EXPORT_SYMBOL(snd_pcm_lib_readv);
+EXPORT_SYMBOL(__snd_pcm_lib_read);
 
 /*
  * standard channel mapping helpers
-- 
2.13.0
