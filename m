From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 02/11] ALSA: pcm: use new function alias
	instead of local one
Date: Wed, 24 May 2017 09:52:46 +0900
Message-ID: <20170524005255.31223-3-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 618862671A3
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

In a previous commit, a new alias of function prototype is added. This
alias is good to refactoring existent codes.

As a first step, this commit applies refactoring to kernel APIs for
data transmission. The alias is the same as helper functions innner
'pcm_lib.c'. For followed commits, the helper functions are once assigned
to function local variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ab4b1d1e44ee..db0246c94874 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2006,15 +2006,11 @@ static int snd_pcm_lib_write_transfer(struct snd_pcm_substream *substream,
 	return 0;
 }
  
-typedef int (*transfer_f)(struct snd_pcm_substream *substream, unsigned int hwoff,
-			  unsigned long data, unsigned int off,
-			  snd_pcm_uframes_t size);
-
 static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream, 
 					    unsigned long data,
 					    snd_pcm_uframes_t size,
 					    int nonblock,
-					    transfer_f transfer)
+					    snd_pcm_copy_frames_t copy_frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
@@ -2072,7 +2068,7 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		appl_ptr = runtime->control->appl_ptr;
 		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
-		err = transfer(substream, appl_ofs, data, offset, frames);
+		err = copy_frames(substream, appl_ofs, data, offset, frames);
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
@@ -2126,10 +2122,12 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const void __user *buf, snd_pcm_uframes_t size)
+snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
+				const void __user *buf, snd_pcm_uframes_t size)
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
+	snd_pcm_copy_frames_t copy_frames;
 	int err;
 
 	err = pcm_sanity_check(substream);
@@ -2141,10 +2139,12 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream, const v
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED &&
 	    runtime->channels > 1)
 		return -EINVAL;
+
+	copy_frames = snd_pcm_lib_write_transfer;
+
 	return snd_pcm_lib_write1(substream, (unsigned long)buf, size, nonblock,
-				  snd_pcm_lib_write_transfer);
+				  copy_frames);
 }
-
 EXPORT_SYMBOL(snd_pcm_lib_write);
 
 static int snd_pcm_lib_writev_transfer(struct snd_pcm_substream *substream,
@@ -2193,6 +2193,7 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
+	snd_pcm_copy_frames_t copy_frames;
 	int err;
 
 	err = pcm_sanity_check(substream);
@@ -2203,10 +2204,12 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
+
+	copy_frames = snd_pcm_lib_writev_transfer;
+
 	return snd_pcm_lib_write1(substream, (unsigned long)bufs, frames,
-				  nonblock, snd_pcm_lib_writev_transfer);
+				  nonblock, copy_frames);
 }
-
 EXPORT_SYMBOL(snd_pcm_lib_writev);
 
 static int snd_pcm_lib_read_transfer(struct snd_pcm_substream *substream, 
@@ -2232,7 +2235,7 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 					   unsigned long data,
 					   snd_pcm_uframes_t size,
 					   int nonblock,
-					   transfer_f transfer)
+					   snd_pcm_copy_frames_t copy_frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
@@ -2304,7 +2307,7 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		appl_ptr = runtime->control->appl_ptr;
 		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
-		err = transfer(substream, appl_ofs, data, offset, frames);
+		err = copy_frames(substream, appl_ofs, data, offset, frames);
 		snd_pcm_stream_lock_irq(substream);
 		if (err < 0)
 			goto _end_unlock;
@@ -2338,10 +2341,12 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
 
-snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream, void __user *buf, snd_pcm_uframes_t size)
+snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
+				void __user *buf, snd_pcm_uframes_t size)
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
+	snd_pcm_copy_frames_t copy_frames;
 	int err;
 	
 	err = pcm_sanity_check(substream);
@@ -2351,9 +2356,12 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream, void __u
 	nonblock = !!(substream->f_flags & O_NONBLOCK);
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
 		return -EINVAL;
-	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock, snd_pcm_lib_read_transfer);
-}
 
+	copy_frames = snd_pcm_lib_read_transfer;
+
+	return snd_pcm_lib_read1(substream, (unsigned long)buf, size, nonblock,
+				 copy_frames);
+}
 EXPORT_SYMBOL(snd_pcm_lib_read);
 
 static int snd_pcm_lib_readv_transfer(struct snd_pcm_substream *substream,
@@ -2398,6 +2406,7 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime;
 	int nonblock;
+	snd_pcm_copy_frames_t copy_frames;
 	int err;
 
 	err = pcm_sanity_check(substream);
@@ -2410,9 +2419,12 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 	nonblock = !!(substream->f_flags & O_NONBLOCK);
 	if (runtime->access != SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
-	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames, nonblock, snd_pcm_lib_readv_transfer);
-}
 
+	copy_frames = snd_pcm_lib_readv_transfer;
+
+	return snd_pcm_lib_read1(substream, (unsigned long)bufs, frames,
+				 nonblock, copy_frames);
+}
 EXPORT_SYMBOL(snd_pcm_lib_readv);
 
 /*
-- 
2.11.0
