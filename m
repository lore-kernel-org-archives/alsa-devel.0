From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] pcm: fix return value of
	snd_pcm_ioplug_sw_params()
Date: Wed, 13 Jul 2016 23:15:23 +0900
Message-ID: <1468419323-15511-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 79FD126680D
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 16:15:28 +0200 (CEST)
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

In former commits for thread-safe PCM APIs, snd_pcm_ioplug_sw_params() got
0 as its return value, against the original implementation.

This commit fixes it.

Fixes: 54931e5a5455('pcm: Add thread-safety to PCM API')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_ioplug.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 115d89b..1dc198e 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -434,14 +434,16 @@ static int snd_pcm_ioplug_hw_free(snd_pcm_t *pcm)
 static int snd_pcm_ioplug_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 {
 	ioplug_priv_t *io = pcm->private_data;
-	int err = 0;
+	int err;
 
-	if (io->data->callback->sw_params) {
-		snd_pcm_unlock(pcm); /* to avoid deadlock */
-		err = io->data->callback->sw_params(io->data, params);
-		snd_pcm_lock(pcm);
-	}
-	return 0;
+	if (!io->data->callback->sw_params)
+		return 0;
+
+	snd_pcm_unlock(pcm); /* to avoid deadlock */
+	err = io->data->callback->sw_params(io->data, params);
+	snd_pcm_lock(pcm);
+
+	return err;
 }
 
 
-- 
2.7.4
