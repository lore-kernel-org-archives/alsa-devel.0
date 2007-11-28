From: Dave Dillow <dave@thedillows.org>
Subject: [PATCH][RFC] pcm: add exclusion between hw_params and
	prepare	callbacks
Date: Wed, 28 Nov 2007 02:19:48 -0500
Message-ID: <1196234388.7017.33.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (unknown [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 415EC24B1A
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 08:19:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

While working on the locking in the sis7019 driver, and as also noted by
Trent Piepho, there is a race between threads calling into the driver's
hw_params callback and its prepare callback. This can lead to
incorrect/inconsistent data being programmed into the audio device, and
lead to unexpected results, if not a possible system crash. While it is
arguably a bug in the user space program, we should protect the system
and provide some assurance to the driver code about concurrency between
these two callbacks.

The attached patch adds a mutex to the two paths to provide the locking
without giving up the ability for those calls to schedule, as documented
in the API. It just to get a discussion going, as the code to be
restructured a bit to clean up the error exit paths. It is also likely
there are other callbacks that should be excluded when either of these
are executing as well.

This applies to the base kernel tree.

Dave
---
 include/sound/pcm.h     |    2 ++
 sound/core/pcm.c        |    1 +
 sound/core/pcm_native.c |   20 +++++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 73334e0..989e84f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -388,6 +388,8 @@ struct snd_pcm_substream {
 	struct snd_info_entry *proc_prealloc_entry;
 	struct snd_info_entry *proc_prealloc_max_entry;
 #endif
+	/* -- hw_param/prepare exclusion -- */
+	struct mutex hw_param_mutex;
 	/* misc flags */
 	unsigned int hw_opened: 1;
 };
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 2743414..d728594 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -651,6 +651,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 		list_add_tail(&substream->link_list, &substream->self_group.substreams);
 		spin_lock_init(&substream->timer_lock);
 		atomic_set(&substream->mmap_count, 0);
+		mutex_init(&substream->hw_param_mutex);
 		prev = substream;
 	}
 	return 0;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 59b29cd..638d78a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -373,6 +373,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_assert(substream != NULL, return -ENXIO);
 	runtime = substream->runtime;
 	snd_assert(runtime != NULL, return -ENXIO);
+	mutex_lock(&substream->hw_param_mutex);
 	snd_pcm_stream_lock_irq(substream);
 	switch (runtime->status->state) {
 	case SNDRV_PCM_STATE_OPEN:
@@ -380,6 +381,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_STATE_PREPARED:
 		break;
 	default:
+		mutex_unlock(&substream->hw_param_mutex);
 		snd_pcm_stream_unlock_irq(substream);
 		return -EBADFD;
 	}
@@ -387,8 +389,10 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	if (!substream->oss.oss)
 #endif
-		if (atomic_read(&substream->mmap_count))
+		if (atomic_read(&substream->mmap_count)) {
+			mutex_unlock(&substream->hw_param_mutex);
 			return -EBADFD;
+		}
 
 	params->rmask = ~0U;
 	err = snd_pcm_hw_refine(substream, params);
@@ -450,6 +454,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	remove_acceptable_latency(substream->latency_id);
 	if ((usecs = period_to_usecs(runtime)) >= 0)
 		set_acceptable_latency(substream->latency_id, usecs);
+	mutex_unlock(&substream->hw_param_mutex);
 	return 0;
  _error:
 	/* hardware might be unuseable from this time,
@@ -458,6 +463,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->status->state = SNDRV_PCM_STATE_OPEN;
 	if (substream->ops->hw_free != NULL)
 		substream->ops->hw_free(substream);
+	mutex_unlock(&substream->hw_param_mutex);
 	return err;
 }
 
@@ -1345,9 +1351,10 @@ static struct action_ops snd_pcm_action_prepare = {
 static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 			   struct file *file)
 {
-	int res;
 	struct snd_card *card = substream->pcm->card;
+	struct snd_pcm_substream *s;
 	int f_flags;
+	int res;
 
 	if (file)
 		f_flags = file->f_flags;
@@ -1355,9 +1362,16 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 		f_flags = substream->f_flags;
 
 	snd_power_lock(card);
-	if ((res = snd_power_wait(card, SNDRV_CTL_POWER_D0)) >= 0)
+	if ((res = snd_power_wait(card, SNDRV_CTL_POWER_D0)) >= 0) {
+		down_read(&snd_pcm_link_rwsem);
+		snd_pcm_group_for_each_entry(s, substream)
+			mutex_lock(&s->hw_param_mutex);
 		res = snd_pcm_action_nonatomic(&snd_pcm_action_prepare,
 					       substream, f_flags);
+		snd_pcm_group_for_each_entry(s, substream)
+			mutex_unlock(&s->hw_param_mutex);
+		up_read(&snd_pcm_link_rwsem);
+	}
 	snd_power_unlock(card);
 	return res;
 }
