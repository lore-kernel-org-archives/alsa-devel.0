From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 27/39] ALSA: seq: optimize get_queue_tempo
	function to new design
Date: Sun,  7 Aug 2016 18:49:03 +0900
Message-ID: <1470563355-18368-28-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 01410265D05
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:39 +0200 (CEST)
In-Reply-To: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In former commit, actual operations of each ioctl command get argument
in kernel space. Copying from/to user space is performed outside of
the function.

This commit optimizes to the new design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 40346f2..2338468 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1643,32 +1643,26 @@ static int seq_ioctl_get_queue_status(struct snd_seq_client *client, void *arg)
 
 
 /* GET_QUEUE_TEMPO ioctl() */
-static int seq_ioctl_get_queue_tempo(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_get_queue_tempo(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_tempo tempo;
+	struct snd_seq_queue_tempo *tempo = arg;
 	struct snd_seq_queue *queue;
 	struct snd_seq_timer *tmr;
 
-	if (copy_from_user(&tempo, arg, sizeof(tempo)))
-		return -EFAULT;
-
-	queue = queueptr(tempo.queue);
+	queue = queueptr(tempo->queue);
 	if (queue == NULL)
 		return -EINVAL;
-	memset(&tempo, 0, sizeof(tempo));
-	tempo.queue = queue->queue;
+	memset(tempo, 0, sizeof(*tempo));
+	tempo->queue = queue->queue;
 	
 	tmr = queue->timer;
 
-	tempo.tempo = tmr->tempo;
-	tempo.ppq = tmr->ppq;
-	tempo.skew_value = tmr->skew;
-	tempo.skew_base = tmr->skew_base;
+	tempo->tempo = tmr->tempo;
+	tempo->ppq = tmr->ppq;
+	tempo->skew_value = tmr->skew;
+	tempo->skew_base = tmr->skew_base;
 	queuefree(queue);
 
-	if (copy_to_user(arg, &tempo, sizeof(tempo)))
-		return -EFAULT;
 	return 0;
 }
 
-- 
2.7.4
