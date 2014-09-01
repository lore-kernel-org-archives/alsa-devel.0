From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: pcm: Allow nonatomic trigger
	operations
Date: Mon,  1 Sep 2014 14:00:31 +0200
Message-ID: <1409572832-32553-2-git-send-email-tiwai@suse.de>
References: <1409572832-32553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE2A8264F1D
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:00:44 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FE4EAD23
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

Currently, many PCM operations are performed in a critical section
protected by spinlock, typically the trigger and pointer callbacks are
assumed to be atomic.  This is basically because some trigger action
(e.g. PCM stop after drain or xrun) is done in the interrupt handler.
If a driver runs in a threaded irq, however, this doesn't have to be
atomic.  And many devices want to handle trigger in a non-atomic
context due to lengthy communications.

This patch tries all PCM calls operational in non-atomic context.
What it does is very simple: replaces the substream spinlock with the
corresponding substream mutex when pcm->nonatomic flag is set.  The
driver that wants to use the non-atomic PCM ops just needs to set the
flag and keep the reset as is.  (Of course, it must not handle any PCM
ops in irq context.)

Note that the code doesn't check whether it's atomic-safe or not, but
trust in 100% that the driver sets pcm->nonatomic correctly.

One possible problem is the case where linked PCM substreams have
inconsistent nonatomic states.  For avoiding this, snd_pcm_link()
returns an error if one tries to link an inconsistent PCM substream.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     | 58 +++++++++++++++++++++++++++++--------
 sound/core/pcm.c        |  1 +
 sound/core/pcm_native.c | 76 ++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 6f3e10ca0e32..bc79962f4aa6 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -365,6 +365,7 @@ struct snd_pcm_runtime {
 
 struct snd_pcm_group {		/* keep linked substreams */
 	spinlock_t lock;
+	struct mutex mutex;
 	struct list_head substreams;
 	int count;
 };
@@ -460,6 +461,7 @@ struct snd_pcm {
 	void (*private_free) (struct snd_pcm *pcm);
 	struct device *dev; /* actual hw device this belongs to */
 	bool internal; /* pcm is for internal use only */
+	bool nonatomic; /* whole PCM operations are in non-atomic context */
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	struct snd_pcm_oss oss;
 #endif
@@ -493,6 +495,7 @@ int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree);
  */
 
 extern rwlock_t snd_pcm_link_rwlock;
+extern struct rw_semaphore snd_pcm_link_rwsem;
 
 int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info);
 int snd_pcm_info_user(struct snd_pcm_substream *substream,
@@ -539,38 +542,69 @@ static inline int snd_pcm_stream_linked(struct snd_pcm_substream *substream)
 
 static inline void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 {
-	read_lock(&snd_pcm_link_rwlock);
-	spin_lock(&substream->self_group.lock);
+	if (substream->pcm->nonatomic) {
+		down_read(&snd_pcm_link_rwsem);
+		mutex_lock(&substream->self_group.mutex);
+	} else {
+		read_lock(&snd_pcm_link_rwlock);
+		spin_lock(&substream->self_group.lock);
+	}
 }
 
 static inline void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
 {
-	spin_unlock(&substream->self_group.lock);
-	read_unlock(&snd_pcm_link_rwlock);
+	if (substream->pcm->nonatomic) {
+		mutex_unlock(&substream->self_group.mutex);
+		up_read(&snd_pcm_link_rwsem);
+	} else {
+		spin_unlock(&substream->self_group.lock);
+		read_unlock(&snd_pcm_link_rwlock);
+	}
 }
 
 static inline void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
-	read_lock_irq(&snd_pcm_link_rwlock);
-	spin_lock(&substream->self_group.lock);
+	if (substream->pcm->nonatomic) {
+		down_read(&snd_pcm_link_rwsem);
+		mutex_lock(&substream->self_group.mutex);
+	} else {
+		read_lock_irq(&snd_pcm_link_rwlock);
+		spin_lock(&substream->self_group.lock);
+	}
 }
 
 static inline void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
 {
-	spin_unlock(&substream->self_group.lock);
-	read_unlock_irq(&snd_pcm_link_rwlock);
+	if (substream->pcm->nonatomic) {
+		mutex_unlock(&substream->self_group.mutex);
+		up_read(&snd_pcm_link_rwsem);
+	} else {
+		spin_unlock(&substream->self_group.lock);
+		read_unlock_irq(&snd_pcm_link_rwlock);
+	}
 }
 
 #define snd_pcm_stream_lock_irqsave(substream, flags) \
 do { \
-	read_lock_irqsave(&snd_pcm_link_rwlock, (flags)); \
-	spin_lock(&substream->self_group.lock); \
+	if ((substream)->pcm->nonatomic) {			  \
+		(flags) = 0; /* XXX for avoid warning */	  \
+		down_read(&snd_pcm_link_rwsem);			  \
+		mutex_lock(&(substream)->self_group.mutex);	  \
+	} else {						  \
+		read_lock_irqsave(&snd_pcm_link_rwlock, (flags)); \
+		spin_lock(&(substream)->self_group.lock);	  \
+	}							  \
 } while (0)
 
 #define snd_pcm_stream_unlock_irqrestore(substream, flags) \
 do { \
-	spin_unlock(&substream->self_group.lock); \
-	read_unlock_irqrestore(&snd_pcm_link_rwlock, (flags)); \
+	if ((substream)->pcm->nonatomic) {			       \
+		mutex_unlock(&(substream)->self_group.mutex);	       \
+		up_read(&snd_pcm_link_rwsem);			       \
+	} else {						       \
+		spin_unlock(&(substream)->self_group.lock);	       \
+		read_unlock_irqrestore(&snd_pcm_link_rwlock, (flags)); \
+	}							       \
 } while (0)
 
 #define snd_pcm_group_for_each_entry(s, substream) \
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 43932e8dce66..afccdc553ef9 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -698,6 +698,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 		}
 		substream->group = &substream->self_group;
 		spin_lock_init(&substream->self_group.lock);
+		mutex_init(&substream->self_group.mutex);
 		INIT_LIST_HEAD(&substream->self_group.substreams);
 		list_add_tail(&substream->link_list, &substream->self_group.substreams);
 		atomic_set(&substream->mmap_count, 0);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8cd2f930ad0b..b2621aa6494c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -77,7 +77,8 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
 DEFINE_RWLOCK(snd_pcm_link_rwlock);
 EXPORT_SYMBOL(snd_pcm_link_rwlock);
 
-static DECLARE_RWSEM(snd_pcm_link_rwsem);
+DECLARE_RWSEM(snd_pcm_link_rwsem);
+EXPORT_SYMBOL(snd_pcm_link_rwsem);
 
 static inline mm_segment_t snd_enter_user(void)
 {
@@ -727,9 +728,14 @@ static int snd_pcm_action_group(struct action_ops *ops,
 	int res = 0;
 
 	snd_pcm_group_for_each_entry(s, substream) {
-		if (do_lock && s != substream)
-			spin_lock_nested(&s->self_group.lock,
-					 SINGLE_DEPTH_NESTING);
+		if (do_lock && s != substream) {
+			if (s->pcm->nonatomic)
+				mutex_lock_nested(&s->self_group.mutex,
+						  SINGLE_DEPTH_NESTING);
+			else
+				spin_lock_nested(&s->self_group.lock,
+						 SINGLE_DEPTH_NESTING);
+		}
 		res = ops->pre_action(s, state);
 		if (res < 0)
 			goto _unlock;
@@ -755,8 +761,12 @@ static int snd_pcm_action_group(struct action_ops *ops,
 	if (do_lock) {
 		/* unlock streams */
 		snd_pcm_group_for_each_entry(s1, substream) {
-			if (s1 != substream)
-				spin_unlock(&s1->self_group.lock);
+			if (s1 != substream) {
+				if (s->pcm->nonatomic)
+					mutex_unlock(&s1->self_group.mutex);
+				else
+					spin_unlock(&s1->self_group.lock);
+			}
 			if (s1 == s)	/* end */
 				break;
 		}
@@ -784,6 +794,27 @@ static int snd_pcm_action_single(struct action_ops *ops,
 	return res;
 }
 
+/* call in mutex-protected context */
+static int snd_pcm_action_mutex(struct action_ops *ops,
+				struct snd_pcm_substream *substream,
+				int state)
+{
+	int res;
+
+	if (snd_pcm_stream_linked(substream)) {
+		if (!mutex_trylock(&substream->self_group.mutex)) {
+			mutex_unlock(&substream->self_group.mutex);
+			mutex_lock(&substream->group->mutex);
+			mutex_lock(&substream->self_group.mutex);
+		}
+		res = snd_pcm_action_group(ops, substream, state, 1);
+		mutex_unlock(&substream->group->mutex);
+	} else {
+		res = snd_pcm_action_single(ops, substream, state);
+	}
+	return res;
+}
+
 /*
  *  Note: call with stream lock
  */
@@ -793,6 +824,9 @@ static int snd_pcm_action(struct action_ops *ops,
 {
 	int res;
 
+	if (substream->pcm->nonatomic)
+		return snd_pcm_action_mutex(ops, substream, state);
+
 	if (snd_pcm_stream_linked(substream)) {
 		if (!spin_trylock(&substream->group->lock)) {
 			spin_unlock(&substream->self_group.lock);
@@ -807,6 +841,29 @@ static int snd_pcm_action(struct action_ops *ops,
 	return res;
 }
 
+static int snd_pcm_action_lock_mutex(struct action_ops *ops,
+				     struct snd_pcm_substream *substream,
+				     int state)
+{
+	int res;
+
+	down_read(&snd_pcm_link_rwsem);
+	if (snd_pcm_stream_linked(substream)) {
+		mutex_lock(&substream->group->mutex);
+		mutex_lock_nested(&substream->self_group.mutex,
+				  SINGLE_DEPTH_NESTING);
+		res = snd_pcm_action_group(ops, substream, state, 1);
+		mutex_unlock(&substream->self_group.mutex);
+		mutex_unlock(&substream->group->mutex);
+	} else {
+		mutex_lock(&substream->self_group.mutex);
+		res = snd_pcm_action_single(ops, substream, state);
+		mutex_unlock(&substream->self_group.mutex);
+	}
+	up_read(&snd_pcm_link_rwsem);
+	return res;
+}
+
 /*
  *  Note: don't use any locks before
  */
@@ -816,6 +873,9 @@ static int snd_pcm_action_lock_irq(struct action_ops *ops,
 {
 	int res;
 
+	if (substream->pcm->nonatomic)
+		return snd_pcm_action_lock_mutex(ops, substream, state);
+
 	read_lock_irq(&snd_pcm_link_rwlock);
 	if (snd_pcm_stream_linked(substream)) {
 		spin_lock(&substream->group->lock);
@@ -1634,7 +1694,8 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	down_write(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    substream->runtime->status->state != substream1->runtime->status->state) {
+	    substream->runtime->status->state != substream1->runtime->status->state ||
+	    substream->pcm->nonatomic != substream1->pcm->nonatomic) {
 		res = -EBADFD;
 		goto _end;
 	}
@@ -1646,6 +1707,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 		substream->group = group;
 		group = NULL;
 		spin_lock_init(&substream->group->lock);
+		mutex_init(&substream->group->mutex);
 		INIT_LIST_HEAD(&substream->group->substreams);
 		list_add_tail(&substream->link_list, &substream->group->substreams);
 		substream->group->count = 1;
-- 
2.1.0
