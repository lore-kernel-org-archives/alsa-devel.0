From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] pcm: Avoid lock for snd_pcm_nonblock()
Date: Thu,  9 Feb 2017 20:30:50 +0100
Message-ID: <20170209193051.14713-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D6D6026680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 20:30:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7B2B4ABD9
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 19:30:53 +0000 (UTC)
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

snd_pcm_nonblock() is called as snd_pcm_abort().  Since
snd_pcm_abort() is called often from a signal handler to clean things
up (e.g. aplay does it), we may face a deadlock if the signal is
raised during the locked operation.

There can be some way to check the deadlock state, but they would cost
much.  Since the race condition of snd_pcm_nonblock() is quite small,
let's just drop the locking inside snd_pcm_nonblock() as a
workaround.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 0cf740f854a9..c136d5579320 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -759,7 +759,10 @@ int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
 	int err = 0;
 
 	assert(pcm);
-	__snd_pcm_lock(pcm); /* forced lock due to pcm field change */
+	/* FIXME: __snd_pcm_lock() call below is commented out because of the
+	 * the possible deadlock in signal handler calling snd_pcm_abort()
+	 */
+	/* __snd_pcm_lock(pcm); */ /* forced lock due to pcm field change */
 	if ((err = pcm->ops->nonblock(pcm->op_arg, nonblock)) < 0)
 		goto unlock;
 	if (nonblock == 2) {
@@ -775,7 +778,7 @@ int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
 			pcm->mode &= ~SND_PCM_NONBLOCK;
 	}
  unlock:
-	__snd_pcm_unlock(pcm);
+	/* __snd_pcm_unlock(pcm); */ /* FIXME: see above */
 	return err;
 }
 
-- 
2.11.0
