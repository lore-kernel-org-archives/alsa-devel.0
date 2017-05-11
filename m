From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 14/26] ALSA: korg1212: Convert to
	copy_silence ops
Date: Thu, 11 May 2017 23:09:13 +0200
Message-ID: <20170511210925.18208-15-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB974266FEE
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:31 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 919FEAECE
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

Replace the copy and the silence ops with the new merged ops.
The redundant function calls are reduced and the copy/silence are
handled directly in callback functions now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/korg1212/korg1212.c | 128 ++++++++++++------------------------------
 1 file changed, 36 insertions(+), 92 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 1e25095fd144..865ff553dc87 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1273,43 +1273,24 @@ static struct snd_pcm_hardware snd_korg1212_capture_info =
         .fifo_size =          0,
 };
 
-static int snd_korg1212_silence(struct snd_korg1212 *korg1212, int pos, int count, int offset, int size)
-{
-	struct KorgAudioFrame * dst =  korg1212->playDataBufsPtr[0].bufferData + pos;
-	int i;
-
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_silence pos=%d offset=%d size=%d count=%d\n",
-				   pos, offset, size, count);
-	if (snd_BUG_ON(pos + count > K1212_MAX_SAMPLES))
-		return -EINVAL;
-
-	for (i=0; i < count; i++) {
-#if K1212_DEBUG_LEVEL > 0
-		if ( (void *) dst < (void *) korg1212->playDataBufsPtr ||
-		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData ) {
-			printk(KERN_DEBUG "K1212_DEBUG: snd_korg1212_silence KERNEL EFAULT dst=%p iter=%d\n",
-			       dst, i);
-			return -EFAULT;
-		}
-#endif
-		memset((void*) dst + offset, 0, size);
-		dst++;
-	}
-
-	return 0;
-}
-
-static int snd_korg1212_copy_to(struct snd_korg1212 *korg1212, void __user *dst, int pos, int count, int offset, int size)
+static int snd_korg1212_capture_copy(struct snd_pcm_substream *substream,
+				     int channel,
+				     snd_pcm_uframes_t pos,
+				     void __user *dst,
+				     snd_pcm_uframes_t count,
+				     bool in_kernel)
 {
+	struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
 	struct KorgAudioFrame * src =  korg1212->recordDataBufsPtr[0].bufferData + pos;
-	int i, rc;
+	int size, i;
 
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_copy_to pos=%d offset=%d size=%d\n",
-				   pos, offset, size);
+	size = korg1212->channels * 2;
+	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_copy_to pos=%ld size=%d\n",
+				   pos, size);
 	if (snd_BUG_ON(pos + count > K1212_MAX_SAMPLES))
 		return -EINVAL;
 
-	for (i=0; i < count; i++) {
+	for (i = 0; i < count; i++) {
 #if K1212_DEBUG_LEVEL > 0
 		if ( (void *) src < (void *) korg1212->recordDataBufsPtr ||
 		     (void *) src > (void *) korg1212->recordDataBufsPtr[8].bufferData ) {
@@ -1317,11 +1298,10 @@ static int snd_korg1212_copy_to(struct snd_korg1212 *korg1212, void __user *dst,
 			return -EFAULT;
 		}
 #endif
-		rc = copy_to_user(dst + offset, src, size);
-		if (rc) {
-			K1212_DEBUG_PRINTK("K1212_DEBUG: snd_korg1212_copy_to USER EFAULT src=%p dst=%p iter=%d\n", src, dst, i);
+		if (in_kernel)
+			memcpy((char *)dst, src, size);
+		else if (copy_to_user(dst, src, size))
 			return -EFAULT;
-		}
 		src++;
 		dst += size;
 	}
@@ -1329,18 +1309,25 @@ static int snd_korg1212_copy_to(struct snd_korg1212 *korg1212, void __user *dst,
 	return 0;
 }
 
-static int snd_korg1212_copy_from(struct snd_korg1212 *korg1212, void __user *src, int pos, int count, int offset, int size)
+static int snd_korg1212_playback_copy(struct snd_pcm_substream *substream,
+				      int channel,
+				      snd_pcm_uframes_t pos,
+				      void __user *src,
+				      snd_pcm_uframes_t count,
+				      bool in_kernel)
 {
+	struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
 	struct KorgAudioFrame * dst =  korg1212->playDataBufsPtr[0].bufferData + pos;
-	int i, rc;
+	int size, i;
 
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_copy_from pos=%d offset=%d size=%d count=%d\n",
-				   pos, offset, size, count);
+	size = korg1212->channels * 2;
+	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_copy_from pos=%ld size=%d count=%ld\n",
+				   pos, size, count);
 
 	if (snd_BUG_ON(pos + count > K1212_MAX_SAMPLES))
 		return -EINVAL;
 
-	for (i=0; i < count; i++) {
+	for (i = 0; i < count; i++) {
 #if K1212_DEBUG_LEVEL > 0
 		if ( (void *) dst < (void *) korg1212->playDataBufsPtr ||
 		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData ) {
@@ -1348,13 +1335,15 @@ static int snd_korg1212_copy_from(struct snd_korg1212 *korg1212, void __user *sr
 			return -EFAULT;
 		}
 #endif
-		rc = copy_from_user((void*) dst + offset, src, size);
-		if (rc) {
-			K1212_DEBUG_PRINTK("K1212_DEBUG: snd_korg1212_copy_from USER EFAULT src=%p dst=%p iter=%d\n", src, dst, i);
+		if (!src)
+			memset((void *)dst, 0, size);
+		else if (in_kernel)
+			memcpy((void *)dst, src, size);
+		else if (copy_from_user((void *)dst, src, size))
 			return -EFAULT;
-		}
 		dst++;
-		src += size;
+		if (src)
+			src += size;
 	}
 
 	return 0;
@@ -1437,8 +1426,6 @@ static int snd_korg1212_playback_close(struct snd_pcm_substream *substream)
 	K1212_DEBUG_PRINTK("K1212_DEBUG: snd_korg1212_playback_close [%s]\n",
 			   stateName[korg1212->cardState]);
 
-	snd_korg1212_silence(korg1212, 0, K1212_MAX_SAMPLES, 0, korg1212->channels * 2);
-
         spin_lock_irqsave(&korg1212->lock, flags);
 
 	korg1212->playback_pid = -1;
@@ -1639,48 +1626,6 @@ static snd_pcm_uframes_t snd_korg1212_capture_pointer(struct snd_pcm_substream *
         return pos;
 }
 
-static int snd_korg1212_playback_copy(struct snd_pcm_substream *substream,
-                        int channel, /* not used (interleaved data) */
-                        snd_pcm_uframes_t pos,
-                        void __user *src,
-                        snd_pcm_uframes_t count)
-{
-        struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
-
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_playback_copy [%s] %ld %ld\n",
-				   stateName[korg1212->cardState], pos, count);
- 
-	return snd_korg1212_copy_from(korg1212, src, pos, count, 0, korg1212->channels * 2);
-
-}
-
-static int snd_korg1212_playback_silence(struct snd_pcm_substream *substream,
-                           int channel, /* not used (interleaved data) */
-                           snd_pcm_uframes_t pos,
-                           snd_pcm_uframes_t count)
-{
-        struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
-
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_playback_silence [%s]\n",
-				   stateName[korg1212->cardState]);
-
-	return snd_korg1212_silence(korg1212, pos, count, 0, korg1212->channels * 2);
-}
-
-static int snd_korg1212_capture_copy(struct snd_pcm_substream *substream,
-                        int channel, /* not used (interleaved data) */
-                        snd_pcm_uframes_t pos,
-                        void __user *dst,
-                        snd_pcm_uframes_t count)
-{
-        struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
-
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_capture_copy [%s] %ld %ld\n",
-				   stateName[korg1212->cardState], pos, count);
-
-	return snd_korg1212_copy_to(korg1212, dst, pos, count, 0, korg1212->channels * 2);
-}
-
 static const struct snd_pcm_ops snd_korg1212_playback_ops = {
         .open =		snd_korg1212_playback_open,
         .close =	snd_korg1212_playback_close,
@@ -1689,8 +1634,7 @@ static const struct snd_pcm_ops snd_korg1212_playback_ops = {
         .prepare =	snd_korg1212_prepare,
         .trigger =	snd_korg1212_trigger,
         .pointer =	snd_korg1212_playback_pointer,
-        .copy =		snd_korg1212_playback_copy,
-        .silence =	snd_korg1212_playback_silence,
+	.copy_silence =	snd_korg1212_playback_copy,
 };
 
 static const struct snd_pcm_ops snd_korg1212_capture_ops = {
@@ -1701,7 +1645,7 @@ static const struct snd_pcm_ops snd_korg1212_capture_ops = {
 	.prepare =	snd_korg1212_prepare,
 	.trigger =	snd_korg1212_trigger,
 	.pointer =	snd_korg1212_capture_pointer,
-	.copy =		snd_korg1212_capture_copy,
+	.copy_silence =	snd_korg1212_capture_copy,
 };
 
 /*
-- 
2.12.2
