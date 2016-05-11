From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib] pcm: dmix: Fix doubly resume of slave
	PCM
Date: Wed, 11 May 2016 13:55:15 +0200
Message-ID: <1462967715-15862-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 85706266CD2
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 13:55:17 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D339DAC24
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 11:55:16 +0000 (UTC)
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

The dmix plugin and co may trigger the resume for each instance in
snd_pcm_direct_resume().  It means that the slave PCM gets resumed or
re-prepared/started by each opened dmix stream, and this may end up
with the doubly triggers even though the slave PCM has been already
resumed by another dmix stream.

For avoiding this conflicts, check the slave PCM state and resume only
when it's still in the suspended state.  Meanwhile we keep the shadow
state updated no matter whether the slave was triggered or not.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index e28738b0de96..ac082f1a73b2 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -841,6 +841,12 @@ int snd_pcm_direct_resume(snd_pcm_t *pcm)
 	int err;
 	
 	snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
+	/* resume only when the slave PCM is still in suspended state */
+	if (snd_pcm_state(dmix->spcm) != SND_PCM_STATE_SUSPENDED) {
+		err = 0;
+		goto out;
+	}
+
 	err = snd_pcm_resume(dmix->spcm);
 	if (err == -ENOSYS) {
 		/* FIXME: error handling? */
@@ -848,6 +854,7 @@ int snd_pcm_direct_resume(snd_pcm_t *pcm)
 		snd_pcm_start(dmix->spcm);
 		err = 0;
 	}
+ out:
 	dmix->state = snd_pcm_state(dmix->spcm);
 	snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
 	return err;
-- 
2.8.2
