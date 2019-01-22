From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: pcm: Remove down_write() hack for
	snd_pcm_link_rwsem
Date: Tue, 22 Jan 2019 17:19:14 +0100
Message-ID: <20190122161915.8445-7-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B7DD2674C6
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:20 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 99297B082
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

Remove the hackish down_write_nonfifo() that was introduced as a
workaround of rwsem deadlock.

It used to be a problem for non-atomic PCM streams that take the rwsem
for the locking and hit the high lock contention.  Since the current
PCM locking refactoring, we'll no longer hit it as the hot code-paths
don't take global locks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index cbde23fc67a9..f450083eb073 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -87,18 +87,6 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
 
 static DECLARE_RWSEM(snd_pcm_link_rwsem);
 
-/* Writer in rwsem may block readers even during its waiting in queue,
- * and this may lead to a deadlock when the code path takes read sem
- * twice (e.g. one in snd_pcm_action_nonatomic() and another in
- * snd_pcm_stream_lock()).  As a (suboptimal) workaround, let writer to
- * sleep until all the readers are completed without blocking by writer.
- */
-static inline void down_write_nonfifo(struct rw_semaphore *lock)
-{
-	while (!down_write_trylock(lock))
-		msleep(1);
-}
-
 void snd_pcm_group_init(struct snd_pcm_group *group)
 {
 	spin_lock_init(&group->lock);
@@ -2052,7 +2040,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	}
 	snd_pcm_group_init(group);
 
-	down_write_nonfifo(&snd_pcm_link_rwsem);
+	down_write(&snd_pcm_link_rwsem);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
 	    substream->runtime->status->state != substream1->runtime->status->state ||
 	    substream->pcm->nonatomic != substream1->pcm->nonatomic) {
@@ -2100,7 +2088,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	bool do_free = false;
 	int res = 0;
 
-	down_write_nonfifo(&snd_pcm_link_rwsem);
+	down_write(&snd_pcm_link_rwsem);
 
 	if (!snd_pcm_stream_linked(substream)) {
 		res = -EALREADY;
-- 
2.16.4
