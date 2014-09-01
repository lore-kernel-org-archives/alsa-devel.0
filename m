From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: pcm: Uninline snd_pcm_stream_lock()
	and _unlock()
Date: Mon,  1 Sep 2014 14:00:32 +0200
Message-ID: <1409572832-32553-3-git-send-email-tiwai@suse.de>
References: <1409572832-32553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E0127264F3A
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:00:44 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FF46AD2C
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 12:00:42 +0000 (UTC)
In-Reply-To: <1409572832-32553-1-git-send-email-tiwai@suse.de>
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

The previous commit for the non-atomic PCM ops added more codes to
snd_pcm_stream_lock() and its variants.  Since they are inlined
functions, it resulted in a significant code size bloat.  For reducing
the size bloat, this patch changes the inline functions to the normal
function calls.  The export of rwlock and rwsem are removed as well,
since they are referred only in pcm_native.c now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     | 83 ++++++++++---------------------------------------
 sound/core/pcm_native.c | 45 ++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 70 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index bc79962f4aa6..3e6453dc8ae0 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -494,9 +494,6 @@ int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree);
  *  Native I/O
  */
 
-extern rwlock_t snd_pcm_link_rwlock;
-extern struct rw_semaphore snd_pcm_link_rwsem;
-
 int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info);
 int snd_pcm_info_user(struct snd_pcm_substream *substream,
 		      struct snd_pcm_info __user *info);
@@ -540,71 +537,25 @@ static inline int snd_pcm_stream_linked(struct snd_pcm_substream *substream)
 	return substream->group != &substream->self_group;
 }
 
-static inline void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
-{
-	if (substream->pcm->nonatomic) {
-		down_read(&snd_pcm_link_rwsem);
-		mutex_lock(&substream->self_group.mutex);
-	} else {
-		read_lock(&snd_pcm_link_rwlock);
-		spin_lock(&substream->self_group.lock);
-	}
-}
-
-static inline void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
-{
-	if (substream->pcm->nonatomic) {
-		mutex_unlock(&substream->self_group.mutex);
-		up_read(&snd_pcm_link_rwsem);
-	} else {
-		spin_unlock(&substream->self_group.lock);
-		read_unlock(&snd_pcm_link_rwlock);
-	}
-}
-
-static inline void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
-{
-	if (substream->pcm->nonatomic) {
-		down_read(&snd_pcm_link_rwsem);
-		mutex_lock(&substream->self_group.mutex);
-	} else {
-		read_lock_irq(&snd_pcm_link_rwlock);
-		spin_lock(&substream->self_group.lock);
-	}
-}
-
-static inline void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
-{
-	if (substream->pcm->nonatomic) {
-		mutex_unlock(&substream->self_group.mutex);
-		up_read(&snd_pcm_link_rwsem);
-	} else {
-		spin_unlock(&substream->self_group.lock);
-		read_unlock_irq(&snd_pcm_link_rwlock);
-	}
-}
-
-#define snd_pcm_stream_lock_irqsave(substream, flags) \
-do { \
-	if ((substream)->pcm->nonatomic) {			  \
-		(flags) = 0; /* XXX for avoid warning */	  \
-		down_read(&snd_pcm_link_rwsem);			  \
-		mutex_lock(&(substream)->self_group.mutex);	  \
-	} else {						  \
-		read_lock_irqsave(&snd_pcm_link_rwlock, (flags)); \
-		spin_lock(&(substream)->self_group.lock);	  \
-	}							  \
+void snd_pcm_stream_lock(struct snd_pcm_substream *substream);
+void snd_pcm_stream_unlock(struct snd_pcm_substream *substream);
+void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream);
+void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream);
+
+#define snd_pcm_stream_lock_irqsave(substream, flags)		\
+do {								\
+	if ((substream)->pcm->nonatomic)			\
+		(flags) = 0; /* XXX for avoid warning */	\
+	else							\
+		local_irq_save(flags);				\
+	snd_pcm_stream_lock(substream);				\
 } while (0)
 
-#define snd_pcm_stream_unlock_irqrestore(substream, flags) \
-do { \
-	if ((substream)->pcm->nonatomic) {			       \
-		mutex_unlock(&(substream)->self_group.mutex);	       \
-		up_read(&snd_pcm_link_rwsem);			       \
-	} else {						       \
-		spin_unlock(&(substream)->self_group.lock);	       \
-		read_unlock_irqrestore(&snd_pcm_link_rwlock, (flags)); \
-	}							       \
+#define snd_pcm_stream_unlock_irqrestore(substream, flags)	\
+do {								\
+	snd_pcm_stream_unlock(substream);			\
+	if (!(substream)->pcm->nonatomic)			\
+		local_irq_restore(flags);			\
 } while (0)
 
 #define snd_pcm_group_for_each_entry(s, substream) \
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b2621aa6494c..487d8ec9d43b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -74,11 +74,48 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
  *
  */
 
-DEFINE_RWLOCK(snd_pcm_link_rwlock);
-EXPORT_SYMBOL(snd_pcm_link_rwlock);
+static DEFINE_RWLOCK(snd_pcm_link_rwlock);
+static DECLARE_RWSEM(snd_pcm_link_rwsem);
 
-DECLARE_RWSEM(snd_pcm_link_rwsem);
-EXPORT_SYMBOL(snd_pcm_link_rwsem);
+void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (substream->pcm->nonatomic) {
+		down_read(&snd_pcm_link_rwsem);
+		mutex_lock(&substream->self_group.mutex);
+	} else {
+		read_lock(&snd_pcm_link_rwlock);
+		spin_lock(&substream->self_group.lock);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
+
+void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
+{
+	if (substream->pcm->nonatomic) {
+		mutex_unlock(&substream->self_group.mutex);
+		up_read(&snd_pcm_link_rwsem);
+	} else {
+		spin_unlock(&substream->self_group.lock);
+		read_unlock(&snd_pcm_link_rwlock);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
+
+void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
+{
+	if (!substream->pcm->nonatomic)
+		local_irq_disable();
+	snd_pcm_stream_lock(substream);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
+
+void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
+{
+	snd_pcm_stream_unlock(substream);
+	if (!substream->pcm->nonatomic)
+		local_irq_enable();
+}
+EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irq);
 
 static inline mm_segment_t snd_enter_user(void)
 {
-- 
2.1.0
