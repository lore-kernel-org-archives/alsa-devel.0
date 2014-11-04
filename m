From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: pcm: Simplify
	snd_pcm_action_lock_irq()
Date: Tue,  4 Nov 2014 14:28:12 +0100
Message-ID: <1415107696-17123-2-git-send-email-tiwai@suse.de>
References: <1415107696-17123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DD2C261534
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:28:20 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 656C1AD66
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:28:19 +0000 (UTC)
In-Reply-To: <1415107696-17123-1-git-send-email-tiwai@suse.de>
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

The function snd_pcm_action_lock_irq() can be much simplified by
simply wrapping snd_pcm_action() with the stream lock.  This was
rather the original idea, but later it was open coded for
optimization.  However, looking at the optimization part closely, one
notices that the probability of the optimized path is quite low; in
normal situations, the linked stream action happens only for the
triggered substream, thus the operation becomes identical.  So the
code simplification has a clear win, especially because we have now
doubly codes for both atomic and non-atomic locks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4d5795d8b9f7..b92b605fc784 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -947,28 +947,6 @@ static int snd_pcm_action(struct action_ops *ops,
 	return res;
 }
 
-static int snd_pcm_action_lock_mutex(struct action_ops *ops,
-				     struct snd_pcm_substream *substream,
-				     int state)
-{
-	int res;
-
-	down_read(&snd_pcm_link_rwsem);
-	if (snd_pcm_stream_linked(substream)) {
-		mutex_lock(&substream->group->mutex);
-		mutex_lock(&substream->self_group.mutex);
-		res = snd_pcm_action_group(ops, substream, state, 1);
-		mutex_unlock(&substream->self_group.mutex);
-		mutex_unlock(&substream->group->mutex);
-	} else {
-		mutex_lock(&substream->self_group.mutex);
-		res = snd_pcm_action_single(ops, substream, state);
-		mutex_unlock(&substream->self_group.mutex);
-	}
-	up_read(&snd_pcm_link_rwsem);
-	return res;
-}
-
 /*
  *  Note: don't use any locks before
  */
@@ -978,22 +956,9 @@ static int snd_pcm_action_lock_irq(struct action_ops *ops,
 {
 	int res;
 
-	if (substream->pcm->nonatomic)
-		return snd_pcm_action_lock_mutex(ops, substream, state);
-
-	read_lock_irq(&snd_pcm_link_rwlock);
-	if (snd_pcm_stream_linked(substream)) {
-		spin_lock(&substream->group->lock);
-		spin_lock(&substream->self_group.lock);
-		res = snd_pcm_action_group(ops, substream, state, 1);
-		spin_unlock(&substream->self_group.lock);
-		spin_unlock(&substream->group->lock);
-	} else {
-		spin_lock(&substream->self_group.lock);
-		res = snd_pcm_action_single(ops, substream, state);
-		spin_unlock(&substream->self_group.lock);
-	}
-	read_unlock_irq(&snd_pcm_link_rwlock);
+	snd_pcm_stream_lock_irq(substream);
+	res = snd_pcm_action(ops, substream, state);
+	snd_pcm_stream_unlock_irq(substream);
 	return res;
 }
 
-- 
2.1.3
