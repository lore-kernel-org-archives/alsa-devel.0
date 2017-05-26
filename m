From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: pcm: add arrangement for applying
	appl_ptr
Date: Fri, 26 May 2017 09:30:47 +0900
Message-ID: <20170526003047.17721-3-o-takashi@sakamocchi.jp>
References: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 187EE266D49
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 02:30:52 +0200 (CEST)
In-Reply-To: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
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

In callgraphs from below kernel APIs, position of application pointer on
PCM buffer is changes, according to given parameters.

 - snd_pcm_lib_read()
 - snd_pcm_lib_readv()
 - snd_pcm_lib_write()
 - snd_pcm_lib_writev()

This operation corresponds to application of new position to runtime of
PCM substream and callback of driver's implementation for
'struct snd_pcm_ops.ack'.

In a former commit, a new local function is added, 'apply_appl_ptr'. The
above code block can be replaced with this function.

This commit replaces the code block with call of the function. The function
is renamed to be shared by several objects.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c    | 12 ++++++------
 sound/core/pcm_local.h  |  3 +++
 sound/core/pcm_native.c | 11 ++++++-----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index e50548af4004..63a172455e00 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2091,9 +2091,9 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		appl_ptr += frames;
 		if (appl_ptr >= runtime->boundary)
 			appl_ptr -= runtime->boundary;
-		runtime->control->appl_ptr = appl_ptr;
-		if (substream->ops->ack)
-			substream->ops->ack(substream);
+		err = snd_pcm_apply_appl_ptr(substream, appl_ptr);
+		if (err < 0)
+			goto _end_unlock;
 
 		offset += frames;
 		size -= frames;
@@ -2323,9 +2323,9 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		appl_ptr += frames;
 		if (appl_ptr >= runtime->boundary)
 			appl_ptr -= runtime->boundary;
-		runtime->control->appl_ptr = appl_ptr;
-		if (substream->ops->ack)
-			substream->ops->ack(substream);
+		err = snd_pcm_apply_appl_ptr(substream, appl_ptr);
+		if (err < 0)
+			goto _end_unlock;
 
 		offset += frames;
 		size -= frames;
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index 34c66decaaf2..5ac60cd6f4d9 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -48,4 +48,7 @@ static inline void snd_pcm_timer_init(struct snd_pcm_substream *substream) {}
 static inline void snd_pcm_timer_done(struct snd_pcm_substream *substream) {}
 #endif
 
+int snd_pcm_apply_appl_ptr(struct snd_pcm_substream *substream,
+			   snd_pcm_uframes_t appl_ptr);
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bf5d0f2acfb9..514f6707280e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2454,8 +2454,8 @@ static int do_pcm_hwsync(struct snd_pcm_substream *substream)
 /* update to the given appl_ptr and call ack callback if needed;
  * when an error is returned, take back to the original value
  */
-static int apply_appl_ptr(struct snd_pcm_substream *substream,
-			  snd_pcm_uframes_t appl_ptr)
+int snd_pcm_apply_appl_ptr(struct snd_pcm_substream *substream,
+			   snd_pcm_uframes_t appl_ptr)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t old_appl_ptr = runtime->control->appl_ptr;
@@ -2488,7 +2488,7 @@ static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 	appl_ptr = runtime->control->appl_ptr + frames;
 	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
 		appl_ptr -= runtime->boundary;
-	ret = apply_appl_ptr(substream, appl_ptr);
+	ret = snd_pcm_apply_appl_ptr(substream, appl_ptr);
 	return ret < 0 ? ret : frames;
 }
 
@@ -2508,7 +2508,7 @@ static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
 	appl_ptr = runtime->control->appl_ptr - frames;
 	if (appl_ptr < 0)
 		appl_ptr += runtime->boundary;
-	ret = apply_appl_ptr(substream, appl_ptr);
+	ret = snd_pcm_apply_appl_ptr(substream, appl_ptr);
 	return ret < 0 ? ret : frames;
 }
 
@@ -2636,7 +2636,8 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_stream_lock_irq(substream);
 	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
-		err = apply_appl_ptr(substream, sync_ptr.c.control.appl_ptr);
+		err = snd_pcm_apply_appl_ptr(substream,
+					     sync_ptr.c.control.appl_ptr);
 		if (err < 0) {
 			snd_pcm_stream_unlock_irq(substream);
 			return err;
-- 
2.11.0
