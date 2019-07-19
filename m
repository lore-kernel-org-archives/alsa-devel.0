From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix refcount_inc() on zero usage
Date: Fri, 19 Jul 2019 15:48:27 +0200
Message-ID: <20190719134827.23092-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2219F800B2
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 15:48:30 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Duncan Overbruck <kernel@duncano.de>
List-Id: alsa-devel@alsa-project.org

The recent rewrite of PCM link lock management introduced the refcount
in snd_pcm_group object, managed by the kernel refcount_t API.  This
caused unexpected kernel warnings when the kernel is built with
CONFIG_REFCOUNT_FULL=y.  As the warning line indicates, the problem is
obviously that we start with refcount=0 and do refcount_inc() for
adding each PCM link, while refcount_t API doesn't like refcount_inc()
performed on zero.

For adapting the proper refcount_t usage, this patch changes the logic
slightly:
- The initial refcount is 1, assuming the single list entry
- The refcount is incremented / decremented at each PCM link addition
  and deletion
- ... which allows us concentrating only on the refcount as a release
  condition

Fixes: f57f3df03a8e ("ALSA: pcm: More fine-grained PCM link locking")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204221
Reported-and-tested-by: Duncan Overbruck <kernel@duncano.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 860543a4c840..12dd9b318db1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -77,7 +77,7 @@ void snd_pcm_group_init(struct snd_pcm_group *group)
 	spin_lock_init(&group->lock);
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->substreams);
-	refcount_set(&group->refs, 0);
+	refcount_set(&group->refs, 1);
 }
 
 /* define group lock helpers */
@@ -1096,8 +1096,7 @@ static void snd_pcm_group_unref(struct snd_pcm_group *group,
 
 	if (!group)
 		return;
-	do_free = refcount_dec_and_test(&group->refs) &&
-		list_empty(&group->substreams);
+	do_free = refcount_dec_and_test(&group->refs);
 	snd_pcm_group_unlock(group, substream->pcm->nonatomic);
 	if (do_free)
 		kfree(group);
@@ -2020,6 +2019,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	snd_pcm_group_lock_irq(target_group, nonatomic);
 	snd_pcm_stream_lock(substream1);
 	snd_pcm_group_assign(substream1, target_group);
+	refcount_inc(&target_group->refs);
 	snd_pcm_stream_unlock(substream1);
 	snd_pcm_group_unlock_irq(target_group, nonatomic);
  _end:
@@ -2056,13 +2056,14 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	snd_pcm_group_lock_irq(group, nonatomic);
 
 	relink_to_local(substream);
+	refcount_dec(&group->refs);
 
 	/* detach the last stream, too */
 	if (list_is_singular(&group->substreams)) {
 		relink_to_local(list_first_entry(&group->substreams,
 						 struct snd_pcm_substream,
 						 link_list));
-		do_free = !refcount_read(&group->refs);
+		do_free = refcount_dec_and_test(&group->refs);
 	}
 
 	snd_pcm_group_unlock_irq(group, nonatomic);
-- 
2.16.4
