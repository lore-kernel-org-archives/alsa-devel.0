From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] pcm: fix missing return value of
	snd_pcm_status()
Date: Wed, 13 Jul 2016 23:15:12 +0900
Message-ID: <1468419312-15413-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6420426680C
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 16:15:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In former commits for thread-safe PCM APIs, snd_pcm_status() lost its
return value.

This commit regain it.

Fixes: 54931e5a5455('pcm: Add thread-safety to PCM API')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index a66e8af..6c34719 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -953,6 +953,8 @@ int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
 	snd_pcm_lock(pcm);
 	err = pcm->fast_ops->status(pcm->fast_op_arg, status);
 	snd_pcm_unlock(pcm);
+
+	return err;
 }
 
 /**
-- 
2.7.4
