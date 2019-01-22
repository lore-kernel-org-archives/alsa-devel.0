From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: pcm: Make PCM linked list consistent
	while re-grouping
Date: Tue, 22 Jan 2019 17:19:11 +0100
Message-ID: <20190122161915.8445-4-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3455F2674AC
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:18 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6B1D8B07F
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

Make a common helper to re-assign the PCM link using list_move() instead
of open code with manual list_del() and list_add_tail().  This assures
the consistency and we can get rid of snd_pcm_group.count field -- its
purpose is only to check whether the list is singular, and we can know
it by list_is_singular() call now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     |  1 -
 sound/core/pcm_native.c | 34 ++++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index d6bd3caf6878..e1c747c70883 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -439,7 +439,6 @@ struct snd_pcm_group {		/* keep linked substreams */
 	spinlock_t lock;
 	struct mutex mutex;
 	struct list_head substreams;
-	int count;
 };
 
 struct pid;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9e4e289e5703..1a56bb1ad780 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1131,6 +1131,13 @@ static int snd_pcm_action_single(const struct action_ops *ops,
 	return res;
 }
 
+static void snd_pcm_group_assign(struct snd_pcm_substream *substream,
+				 struct snd_pcm_group *new_group)
+{
+	substream->group = new_group;
+	list_move(&substream->link_list, &new_group->substreams);
+}
+
 /*
  *  Note: call with stream lock
  */
@@ -1995,14 +2002,10 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 		goto _end;
 	}
 	if (!snd_pcm_stream_linked(substream)) {
-		substream->group = group;
+		snd_pcm_group_assign(substream, group);
 		group = NULL;
-		list_add_tail(&substream->link_list, &substream->group->substreams);
-		substream->group->count = 1;
 	}
-	list_add_tail(&substream1->link_list, &substream->group->substreams);
-	substream->group->count++;
-	substream1->group = substream->group;
+	snd_pcm_group_assign(substream1, substream->group);
  _end:
 	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
@@ -2015,14 +2018,13 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 
 static void relink_to_local(struct snd_pcm_substream *substream)
 {
-	substream->group = &substream->self_group;
-	INIT_LIST_HEAD(&substream->self_group.substreams);
-	list_add_tail(&substream->link_list, &substream->self_group.substreams);
+	snd_pcm_group_assign(substream, &substream->self_group);
 }
 
 static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_substream *s;
+	struct snd_pcm_group *group;
 	int res = 0;
 
 	down_write_nonfifo(&snd_pcm_link_rwsem);
@@ -2031,16 +2033,20 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 		res = -EALREADY;
 		goto _end;
 	}
-	list_del(&substream->link_list);
-	substream->group->count--;
-	if (substream->group->count == 1) {	/* detach the last stream, too */
+
+	group = substream->group;
+
+	relink_to_local(substream);
+
+	/* detach the last stream, too */
+	if (list_is_singular(&group->substreams)) {
 		snd_pcm_group_for_each_entry(s, substream) {
 			relink_to_local(s);
 			break;
 		}
-		kfree(substream->group);
+		kfree(group);
 	}
-	relink_to_local(substream);
+
        _end:
 	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
-- 
2.16.4
