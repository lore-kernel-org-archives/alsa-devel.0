From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: pcm: More fine-grained PCM link
	locking
Date: Tue, 22 Jan 2019 17:19:13 +0100
Message-ID: <20190122161915.8445-6-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D792674C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:20 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 88D6AB081
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

We have currently two global locks, a rwlock and a rwsem, that are
used for managing linking the PCM streams.  Due to these global locks,
once when a linked stream is used, the lock granularity suffers a
lot.

This patch attempts to eliminate the former global lock for atomic
ops.  The latter rwsem needs remaining because of the loosy way of the
loop calls in snd_pcm_action_nonatomic(), as well as for avoiding the
deadlock at linking.  However, these are used far rarely, actually
only by two actions (prepare and  reset), where both are no timing
critical ones.  So this can be still seen as a good improvement.

The basic strategy to eliminate the rwlock is to assure group->lock at
linking and unlinking.  Since we already takes the group lock whenever
taking the all substream locks under the group, this shouldn't be a
big problem.  But there is one pitfall: snd_pcm_action() does
re-locking for avoiding ABBA deadlocks, and this opens a small race
window for dereferencing the substream group object.  This includes
the unlink of group during that window, too.

For addressing these corner cases, two new tricks are introduced:
- After re-locking, the group assigned to the stream is checked again;
  if the group is changed, we retry the whole procedure.
- Introduce a refcount to snd_pcm_group object, so that it's freed
  only when it's empty and really no one refers to it.

Along with these changes, there are a significant amount of code
refactoring.  The complex group re-lock & ref code is factored out to
snd_pcm_stream_group_ref() function, for example.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     |   2 +
 sound/core/pcm_native.c | 166 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 124 insertions(+), 44 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e1c747c70883..3bde24575a99 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/bitops.h>
 #include <linux/pm_qos.h>
+#include <linux/refcount.h>
 
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
 #define snd_pcm_chip(pcm) ((pcm)->private_data)
@@ -439,6 +440,7 @@ struct snd_pcm_group {		/* keep linked substreams */
 	spinlock_t lock;
 	struct mutex mutex;
 	struct list_head substreams;
+	refcount_t refs;
 };
 
 struct pid;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index fb45386270d5..cbde23fc67a9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -85,7 +85,6 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
  *
  */
 
-static DEFINE_RWLOCK(snd_pcm_link_rwlock);
 static DECLARE_RWSEM(snd_pcm_link_rwsem);
 
 /* Writer in rwsem may block readers even during its waiting in queue,
@@ -105,8 +104,24 @@ void snd_pcm_group_init(struct snd_pcm_group *group)
 	spin_lock_init(&group->lock);
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->substreams);
+	refcount_set(&group->refs, 0);
 }
 
+/* define group lock helpers */
+#define DEFINE_PCM_GROUP_LOCK(action, mutex_action) \
+static void snd_pcm_group_ ## action(struct snd_pcm_group *group, bool nonatomic) \
+{ \
+	if (nonatomic) \
+		mutex_ ## mutex_action(&group->mutex); \
+	else \
+		spin_ ## action(&group->lock); \
+}
+
+DEFINE_PCM_GROUP_LOCK(lock, lock);
+DEFINE_PCM_GROUP_LOCK(unlock, unlock);
+DEFINE_PCM_GROUP_LOCK(lock_irq, lock);
+DEFINE_PCM_GROUP_LOCK(unlock_irq, unlock);
+
 #define PCM_LOCK_DEFAULT	0
 #define PCM_LOCK_IRQ	1
 #define PCM_LOCK_IRQSAVE	2
@@ -116,21 +131,19 @@ static unsigned long __snd_pcm_stream_lock_mode(struct snd_pcm_substream *substr
 {
 	unsigned long flags = 0;
 	if (substream->pcm->nonatomic) {
-		down_read_nested(&snd_pcm_link_rwsem, SINGLE_DEPTH_NESTING);
 		mutex_lock(&substream->self_group.mutex);
 	} else {
 		switch (mode) {
 		case PCM_LOCK_DEFAULT:
-			read_lock(&snd_pcm_link_rwlock);
+			spin_lock(&substream->self_group.lock);
 			break;
 		case PCM_LOCK_IRQ:
-			read_lock_irq(&snd_pcm_link_rwlock);
+			spin_lock_irq(&substream->self_group.lock);
 			break;
 		case PCM_LOCK_IRQSAVE:
-			read_lock_irqsave(&snd_pcm_link_rwlock, flags);
+			spin_lock_irqsave(&substream->self_group.lock, flags);
 			break;
 		}
-		spin_lock(&substream->self_group.lock);
 	}
 	return flags;
 }
@@ -140,19 +153,16 @@ static void __snd_pcm_stream_unlock_mode(struct snd_pcm_substream *substream,
 {
 	if (substream->pcm->nonatomic) {
 		mutex_unlock(&substream->self_group.mutex);
-		up_read(&snd_pcm_link_rwsem);
 	} else {
-		spin_unlock(&substream->self_group.lock);
-
 		switch (mode) {
 		case PCM_LOCK_DEFAULT:
-			read_unlock(&snd_pcm_link_rwlock);
+			spin_unlock(&substream->self_group.lock);
 			break;
 		case PCM_LOCK_IRQ:
-			read_unlock_irq(&snd_pcm_link_rwlock);
+			spin_unlock_irq(&substream->self_group.lock);
 			break;
 		case PCM_LOCK_IRQSAVE:
-			read_unlock_irqrestore(&snd_pcm_link_rwlock, flags);
+			spin_unlock_irqrestore(&substream->self_group.lock, flags);
 			break;
 		}
 	}
@@ -1138,6 +1148,61 @@ static void snd_pcm_group_assign(struct snd_pcm_substream *substream,
 	list_move(&substream->link_list, &new_group->substreams);
 }
 
+/*
+ * Unref and unlock the group, but keep the stream lock;
+ * when the group becomes empty and no longer referred, destroy itself
+ */
+static void snd_pcm_group_unref(struct snd_pcm_group *group,
+				struct snd_pcm_substream *substream)
+{
+	bool do_free;
+
+	if (!group)
+		return;
+	do_free = refcount_dec_and_test(&group->refs) &&
+		list_empty(&group->substreams);
+	snd_pcm_group_unlock(group, substream->pcm->nonatomic);
+	if (do_free)
+		kfree(group);
+}
+
+/*
+ * Lock the group inside a stream lock and reference it;
+ * return the locked group object, or NULL if not linked
+ */
+static struct snd_pcm_group *
+snd_pcm_stream_group_ref(struct snd_pcm_substream *substream)
+{
+	bool nonatomic = substream->pcm->nonatomic;
+	struct snd_pcm_group *group;
+	bool trylock;
+
+	for (;;) {
+		if (!snd_pcm_stream_linked(substream))
+			return NULL;
+		group = substream->group;
+		/* block freeing the group object */
+		refcount_inc(&group->refs);
+
+		trylock = nonatomic ? mutex_trylock(&group->mutex) :
+			spin_trylock(&group->lock);
+		if (trylock)
+			break; /* OK */
+
+		/* re-lock for avoiding ABBA deadlock */
+		snd_pcm_stream_unlock(substream);
+		snd_pcm_group_lock(group, nonatomic);
+		snd_pcm_stream_lock(substream);
+
+		/* check the group again; the above opens a small race window */
+		if (substream->group == group)
+			break; /* OK */
+		/* group changed, try again */
+		snd_pcm_group_unref(group, substream);
+	}
+	return group;
+}
+
 /*
  *  Note: call with stream lock
  */
@@ -1145,28 +1210,15 @@ static int snd_pcm_action(const struct action_ops *ops,
 			  struct snd_pcm_substream *substream,
 			  int state)
 {
+	struct snd_pcm_group *group;
 	int res;
 
-	if (!snd_pcm_stream_linked(substream))
-		return snd_pcm_action_single(ops, substream, state);
-
-	if (substream->pcm->nonatomic) {
-		if (!mutex_trylock(&substream->group->mutex)) {
-			mutex_unlock(&substream->self_group.mutex);
-			mutex_lock(&substream->group->mutex);
-			mutex_lock(&substream->self_group.mutex);
-		}
+	group = snd_pcm_stream_group_ref(substream);
+	if (group)
 		res = snd_pcm_action_group(ops, substream, state, 1);
-		mutex_unlock(&substream->group->mutex);
-	} else {
-		if (!spin_trylock(&substream->group->lock)) {
-			spin_unlock(&substream->self_group.lock);
-			spin_lock(&substream->group->lock);
-			spin_lock(&substream->self_group.lock);
-		}
-		res = snd_pcm_action_group(ops, substream, state, 1);
-		spin_unlock(&substream->group->lock);
-	}
+	else
+		res = snd_pcm_action_single(ops, substream, state);
+	snd_pcm_group_unref(group, substream);
 	return res;
 }
 
@@ -1193,6 +1245,7 @@ static int snd_pcm_action_nonatomic(const struct action_ops *ops,
 {
 	int res;
 
+	/* Guarantee the group members won't change during non-atomic action */
 	down_read(&snd_pcm_link_rwsem);
 	if (snd_pcm_stream_linked(substream))
 		res = snd_pcm_action_group(ops, substream, state, 0);
@@ -1821,6 +1874,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	struct snd_card *card;
 	struct snd_pcm_runtime *runtime;
 	struct snd_pcm_substream *s;
+	struct snd_pcm_group *group;
 	wait_queue_entry_t wait;
 	int result = 0;
 	int nonblock = 0;
@@ -1837,7 +1891,6 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	} else if (substream->f_flags & O_NONBLOCK)
 		nonblock = 1;
 
-	down_read(&snd_pcm_link_rwsem);
 	snd_pcm_stream_lock_irq(substream);
 	/* resume pause */
 	if (runtime->status->state == SNDRV_PCM_STATE_PAUSED)
@@ -1862,6 +1915,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		}
 		/* find a substream to drain */
 		to_check = NULL;
+		group = snd_pcm_stream_group_ref(substream);
 		snd_pcm_group_for_each_entry(s, substream) {
 			if (s->stream != SNDRV_PCM_STREAM_PLAYBACK)
 				continue;
@@ -1871,12 +1925,12 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 				break;
 			}
 		}
+		snd_pcm_group_unref(group, substream);
 		if (!to_check)
 			break; /* all drained */
 		init_waitqueue_entry(&wait, current);
 		add_wait_queue(&to_check->sleep, &wait);
 		snd_pcm_stream_unlock_irq(substream);
-		up_read(&snd_pcm_link_rwsem);
 		if (runtime->no_period_wakeup)
 			tout = MAX_SCHEDULE_TIMEOUT;
 		else {
@@ -1888,9 +1942,17 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 			tout = msecs_to_jiffies(tout * 1000);
 		}
 		tout = schedule_timeout_interruptible(tout);
-		down_read(&snd_pcm_link_rwsem);
+
 		snd_pcm_stream_lock_irq(substream);
-		remove_wait_queue(&to_check->sleep, &wait);
+		group = snd_pcm_stream_group_ref(substream);
+		snd_pcm_group_for_each_entry(s, substream) {
+			if (s->runtime == to_check) {
+				remove_wait_queue(&to_check->sleep, &wait);
+				break;
+			}
+		}
+		snd_pcm_group_unref(group, substream);
+
 		if (card->shutdown) {
 			result = -ENODEV;
 			break;
@@ -1910,7 +1972,6 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 
  unlock:
 	snd_pcm_stream_unlock_irq(substream);
-	up_read(&snd_pcm_link_rwsem);
 
 	return result;
 }
@@ -1972,7 +2033,8 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	int res = 0;
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream1;
-	struct snd_pcm_group *group;
+	struct snd_pcm_group *group, *target_group;
+	bool nonatomic = substream->pcm->nonatomic;
 	struct fd f = fdget(fd);
 
 	if (!f.file)
@@ -1989,8 +2051,8 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 		goto _nolock;
 	}
 	snd_pcm_group_init(group);
+
 	down_write_nonfifo(&snd_pcm_link_rwsem);
-	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
 	    substream->runtime->status->state != substream1->runtime->status->state ||
 	    substream->pcm->nonatomic != substream1->pcm->nonatomic) {
@@ -2001,13 +2063,21 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 		res = -EALREADY;
 		goto _end;
 	}
+
+	snd_pcm_stream_lock_irq(substream);
 	if (!snd_pcm_stream_linked(substream)) {
 		snd_pcm_group_assign(substream, group);
-		group = NULL;
+		group = NULL; /* assigned, don't free this one below */
 	}
-	snd_pcm_group_assign(substream1, substream->group);
+	target_group = substream->group;
+	snd_pcm_stream_unlock_irq(substream);
+
+	snd_pcm_group_lock_irq(target_group, nonatomic);
+	snd_pcm_stream_lock(substream1);
+	snd_pcm_group_assign(substream1, target_group);
+	snd_pcm_stream_unlock(substream1);
+	snd_pcm_group_unlock_irq(target_group, nonatomic);
  _end:
-	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
  _nolock:
 	kfree(group);
@@ -2018,22 +2088,27 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 
 static void relink_to_local(struct snd_pcm_substream *substream)
 {
+	snd_pcm_stream_lock(substream);
 	snd_pcm_group_assign(substream, &substream->self_group);
+	snd_pcm_stream_unlock(substream);
 }
 
 static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_group *group;
+	bool nonatomic = substream->pcm->nonatomic;
+	bool do_free = false;
 	int res = 0;
 
 	down_write_nonfifo(&snd_pcm_link_rwsem);
-	write_lock_irq(&snd_pcm_link_rwlock);
+
 	if (!snd_pcm_stream_linked(substream)) {
 		res = -EALREADY;
 		goto _end;
 	}
 
 	group = substream->group;
+	snd_pcm_group_lock_irq(group, nonatomic);
 
 	relink_to_local(substream);
 
@@ -2042,11 +2117,14 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 		relink_to_local(list_first_entry(&group->substreams,
 						 struct snd_pcm_substream,
 						 link_list));
-		kfree(group);
+		do_free = !refcount_read(&group->refs);
 	}
 
+	snd_pcm_group_unlock_irq(group, nonatomic);
+	if (do_free)
+		kfree(group);
+
        _end:
-	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
 	return res;
 }
-- 
2.16.4
