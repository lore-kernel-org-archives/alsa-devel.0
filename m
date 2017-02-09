From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] pcm: Disable locking in async mode
Date: Thu,  9 Feb 2017 20:30:51 +0100
Message-ID: <20170209193051.14713-2-tiwai@suse.de>
References: <20170209193051.14713-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D72EB266C40
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 20:30:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 821BBAC5B
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 19:30:53 +0000 (UTC)
In-Reply-To: <20170209193051.14713-1-tiwai@suse.de>
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

When PCM is operated in async mode and an async handler calls some PCM
functions with lock during other PCM operations, we may hit a
deadlock.

Although async mode is rarely used, it's still a possible use case.
Disable the locking when the stream is opened in async mode or it's
set to async mode via snd_pcm_async().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index c136d5579320..493e9039b508 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -799,6 +799,8 @@ int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
 		sig = SIGIO;
 	if (pid == 0)
 		pid = getpid();
+	/* async handler may lead to a deadlock; suppose no multi thread */
+	pcm->lock_enabled = 0;
 	return pcm->ops->async(pcm->op_arg, sig, pid);
 }
 #endif
@@ -2597,7 +2599,10 @@ int snd_pcm_new(snd_pcm_t **pcmp, snd_pcm_type_t type, const char *name,
 	 * each plugin may suppress this in its open call
 	 */
 	pcm->need_lock = 1;
-	{
+	if (mode & SND_PCM_ASYNC) {
+		/* async handler may lead to a deadlock; suppose no MT */
+		pcm->lock_enabled = 0;
+	} else {
 		/* set lock_enabled field depending on $LIBASOUND_THREAD_SAFE */
 		static int do_lock_enable = -1; /* uninitialized */
 
-- 
2.11.0
