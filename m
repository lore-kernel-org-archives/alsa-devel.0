From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: pcm: Cleanup snd_pcm_stream_lock() &
	co
Date: Tue, 22 Jan 2019 17:19:15 +0100
Message-ID: <20190122161915.8445-8-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BBD62674C9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:20 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A4FFFB083
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 16:19:18 +0000 (UTC)
In-Reply-To: <20190122161915.8445-1-tiwai@suse.de>
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

After the previous code refactoring, the PCM stream locking code
became nothing but the PCM group lock with self_group object.  Use the
existing helper function for simplifying the code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 68 ++++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 52 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f450083eb073..024e32acbc25 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -110,52 +110,6 @@ DEFINE_PCM_GROUP_LOCK(unlock, unlock);
 DEFINE_PCM_GROUP_LOCK(lock_irq, lock);
 DEFINE_PCM_GROUP_LOCK(unlock_irq, unlock);
 
-#define PCM_LOCK_DEFAULT	0
-#define PCM_LOCK_IRQ	1
-#define PCM_LOCK_IRQSAVE	2
-
-static unsigned long __snd_pcm_stream_lock_mode(struct snd_pcm_substream *substream,
-						unsigned int mode)
-{
-	unsigned long flags = 0;
-	if (substream->pcm->nonatomic) {
-		mutex_lock(&substream->self_group.mutex);
-	} else {
-		switch (mode) {
-		case PCM_LOCK_DEFAULT:
-			spin_lock(&substream->self_group.lock);
-			break;
-		case PCM_LOCK_IRQ:
-			spin_lock_irq(&substream->self_group.lock);
-			break;
-		case PCM_LOCK_IRQSAVE:
-			spin_lock_irqsave(&substream->self_group.lock, flags);
-			break;
-		}
-	}
-	return flags;
-}
-
-static void __snd_pcm_stream_unlock_mode(struct snd_pcm_substream *substream,
-					 unsigned int mode, unsigned long flags)
-{
-	if (substream->pcm->nonatomic) {
-		mutex_unlock(&substream->self_group.mutex);
-	} else {
-		switch (mode) {
-		case PCM_LOCK_DEFAULT:
-			spin_unlock(&substream->self_group.lock);
-			break;
-		case PCM_LOCK_IRQ:
-			spin_unlock_irq(&substream->self_group.lock);
-			break;
-		case PCM_LOCK_IRQSAVE:
-			spin_unlock_irqrestore(&substream->self_group.lock, flags);
-			break;
-		}
-	}
-}
-
 /**
  * snd_pcm_stream_lock - Lock the PCM stream
  * @substream: PCM substream
@@ -166,7 +120,7 @@ static void __snd_pcm_stream_unlock_mode(struct snd_pcm_substream *substream,
  */
 void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 {
-	__snd_pcm_stream_lock_mode(substream, PCM_LOCK_DEFAULT);
+	snd_pcm_group_lock(&substream->self_group, substream->pcm->nonatomic);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
 
@@ -178,7 +132,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
  */
 void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
 {
-	__snd_pcm_stream_unlock_mode(substream, PCM_LOCK_DEFAULT, 0);
+	snd_pcm_group_unlock(&substream->self_group, substream->pcm->nonatomic);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
 
@@ -192,7 +146,8 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
  */
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
-	__snd_pcm_stream_lock_mode(substream, PCM_LOCK_IRQ);
+	snd_pcm_group_lock_irq(&substream->self_group,
+			       substream->pcm->nonatomic);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
 
@@ -204,13 +159,19 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
  */
 void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
 {
-	__snd_pcm_stream_unlock_mode(substream, PCM_LOCK_IRQ, 0);
+	snd_pcm_group_unlock_irq(&substream->self_group,
+				 substream->pcm->nonatomic);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irq);
 
 unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream)
 {
-	return __snd_pcm_stream_lock_mode(substream, PCM_LOCK_IRQSAVE);
+	unsigned long flags = 0;
+	if (substream->pcm->nonatomic)
+		mutex_lock(&substream->self_group.mutex);
+	else
+		spin_lock_irqsave(&substream->self_group.lock, flags);
+	return flags;
 }
 EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 
@@ -224,7 +185,10 @@ EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 				      unsigned long flags)
 {
-	__snd_pcm_stream_unlock_mode(substream, PCM_LOCK_IRQSAVE, flags);
+	if (substream->pcm->nonatomic)
+		mutex_unlock(&substream->self_group.mutex);
+	else
+		spin_unlock_irqrestore(&substream->self_group.lock, flags);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
 
-- 
2.16.4
