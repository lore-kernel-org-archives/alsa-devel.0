From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: pcm: Unify snd_pcm_group
	initialization
Date: Tue, 22 Jan 2019 17:19:10 +0100
Message-ID: <20190122161915.8445-3-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DE752674A8
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:18 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 618E1B07D
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

There are multiple open codes that initialize the same object.
Create a common helper function instead.

Also, use kzalloc() to be safer at creating a group object, and move
the initialization out of the critical section.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c        |  4 +---
 sound/core/pcm_local.h  |  1 +
 sound/core/pcm_native.c | 13 +++++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 01b9d62eef14..88a2998f4f9b 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -753,9 +753,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 			}
 		}
 		substream->group = &substream->self_group;
-		spin_lock_init(&substream->self_group.lock);
-		mutex_init(&substream->self_group.mutex);
-		INIT_LIST_HEAD(&substream->self_group.substreams);
+		snd_pcm_group_init(&substream->self_group);
 		list_add_tail(&substream->link_list, &substream->self_group.substreams);
 		atomic_set(&substream->mmap_count, 0);
 		prev = substream;
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index c515612969a4..0b4b5dfaec18 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -66,5 +66,6 @@ static inline void snd_pcm_timer_done(struct snd_pcm_substream *substream) {}
 #endif
 
 void __snd_pcm_xrun(struct snd_pcm_substream *substream);
+void snd_pcm_group_init(struct snd_pcm_group *group);
 
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c72dfd1fc1ed..9e4e289e5703 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -100,6 +100,13 @@ static inline void down_write_nonfifo(struct rw_semaphore *lock)
 		msleep(1);
 }
 
+void snd_pcm_group_init(struct snd_pcm_group *group)
+{
+	spin_lock_init(&group->lock);
+	mutex_init(&group->mutex);
+	INIT_LIST_HEAD(&group->substreams);
+}
+
 #define PCM_LOCK_DEFAULT	0
 #define PCM_LOCK_IRQ	1
 #define PCM_LOCK_IRQSAVE	2
@@ -1969,11 +1976,12 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	}
 	pcm_file = f.file->private_data;
 	substream1 = pcm_file->substream;
-	group = kmalloc(sizeof(*group), GFP_KERNEL);
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group) {
 		res = -ENOMEM;
 		goto _nolock;
 	}
+	snd_pcm_group_init(group);
 	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
@@ -1989,9 +1997,6 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	if (!snd_pcm_stream_linked(substream)) {
 		substream->group = group;
 		group = NULL;
-		spin_lock_init(&substream->group->lock);
-		mutex_init(&substream->group->mutex);
-		INIT_LIST_HEAD(&substream->group->substreams);
 		list_add_tail(&substream->link_list, &substream->group->substreams);
 		substream->group->count = 1;
 	}
-- 
2.16.4
