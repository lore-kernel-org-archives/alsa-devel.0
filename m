From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 1/3] ALSA: pcm: unify codes to operate
	application-side position on PCM buffer
Date: Mon, 12 Jun 2017 09:41:44 +0900
Message-ID: <20170612004146.28835-2-o-takashi@sakamocchi.jp>
References: <20170612004146.28835-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 1410D266D8B
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 02:41:52 +0200 (CEST)
In-Reply-To: <20170612004146.28835-1-o-takashi@sakamocchi.jp>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

In a series of recent work, ALSA PCM core got some arrangements to handle
application-side position on PCM buffer. However, relevant codes still
disperse to two translation units

This commit unifies these codes into a helper function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c    | 27 ++++++++++++++++++++++++---
 sound/core/pcm_local.h  |  2 ++
 sound/core/pcm_native.c | 28 ++++------------------------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9dc7bbfe8853..d82f1437667f 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2101,6 +2101,27 @@ static int pcm_accessible_state(struct snd_pcm_runtime *runtime)
 	}
 }
 
+/* update to the given appl_ptr and call ack callback if needed;
+ * when an error is returned, take back to the original value
+ */
+int pcm_lib_apply_appl_ptr(struct snd_pcm_substream *substream,
+			   snd_pcm_uframes_t appl_ptr)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t old_appl_ptr = runtime->control->appl_ptr;
+	int ret;
+
+	runtime->control->appl_ptr = appl_ptr;
+	if (substream->ops->ack) {
+		ret = substream->ops->ack(substream);
+		if (ret < 0) {
+			runtime->control->appl_ptr = old_appl_ptr;
+			return ret;
+		}
+	}
+	return 0;
+}
+
 /* the common loop for read/write data */
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *data, bool interleaved,
@@ -2220,9 +2241,9 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		appl_ptr += frames;
 		if (appl_ptr >= runtime->boundary)
 			appl_ptr -= runtime->boundary;
-		runtime->control->appl_ptr = appl_ptr;
-		if (substream->ops->ack)
-			substream->ops->ack(substream);
+		err = pcm_lib_apply_appl_ptr(substream, appl_ptr);
+		if (err < 0)
+			goto _end_unlock;
 
 		offset += frames;
 		size -= frames;
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index e4bf2af62b02..16f254732b2a 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -27,6 +27,8 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
 int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime,
 			       snd_pcm_hw_param_t var, u_int32_t mask);
 
+int pcm_lib_apply_appl_ptr(struct snd_pcm_substream *substream,
+			   snd_pcm_uframes_t appl_ptr);
 int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			 struct snd_pcm_runtime *runtime);
 int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 076187ae8859..a597aa7c4b98 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2591,27 +2591,6 @@ static int do_pcm_hwsync(struct snd_pcm_substream *substream)
 	}
 }
 
-/* update to the given appl_ptr and call ack callback if needed;
- * when an error is returned, take back to the original value
- */
-static int apply_appl_ptr(struct snd_pcm_substream *substream,
-			  snd_pcm_uframes_t appl_ptr)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_uframes_t old_appl_ptr = runtime->control->appl_ptr;
-	int ret;
-
-	runtime->control->appl_ptr = appl_ptr;
-	if (substream->ops->ack) {
-		ret = substream->ops->ack(substream);
-		if (ret < 0) {
-			runtime->control->appl_ptr = old_appl_ptr;
-			return ret;
-		}
-	}
-	return 0;
-}
-
 /* increase the appl_ptr; returns the processed frames or a negative error */
 static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 					  snd_pcm_uframes_t frames,
@@ -2628,7 +2607,7 @@ static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 	appl_ptr = runtime->control->appl_ptr + frames;
 	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
 		appl_ptr -= runtime->boundary;
-	ret = apply_appl_ptr(substream, appl_ptr);
+	ret = pcm_lib_apply_appl_ptr(substream, appl_ptr);
 	return ret < 0 ? ret : frames;
 }
 
@@ -2648,7 +2627,7 @@ static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
 	appl_ptr = runtime->control->appl_ptr - frames;
 	if (appl_ptr < 0)
 		appl_ptr += runtime->boundary;
-	ret = apply_appl_ptr(substream, appl_ptr);
+	ret = pcm_lib_apply_appl_ptr(substream, appl_ptr);
 	return ret < 0 ? ret : frames;
 }
 
@@ -2776,7 +2755,8 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_stream_lock_irq(substream);
 	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
-		err = apply_appl_ptr(substream, sync_ptr.c.control.appl_ptr);
+		err = pcm_lib_apply_appl_ptr(substream,
+					     sync_ptr.c.control.appl_ptr);
 		if (err < 0) {
 			snd_pcm_stream_unlock_irq(substream);
 			return err;
-- 
2.11.0
