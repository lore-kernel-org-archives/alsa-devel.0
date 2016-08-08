From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/27] ALSA: seq: optimize get/set_queue_tempo
	function to new design
Date: Mon,  8 Aug 2016 23:54:47 +0900
Message-ID: <1470668093-31027-22-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6C20D2671BF
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:03 +0200 (CEST)
In-Reply-To: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
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
 sound/core/seq/seq_clientmgr.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 8a43272..2f10bdd 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1652,31 +1652,26 @@ static int snd_seq_ioctl_get_queue_status(struct snd_seq_client *client,
 
 /* GET_QUEUE_TEMPO ioctl() */
 static int snd_seq_ioctl_get_queue_tempo(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
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
 
@@ -1692,15 +1687,12 @@ int snd_seq_set_queue_tempo(int client, struct snd_seq_queue_tempo *tempo)
 EXPORT_SYMBOL(snd_seq_set_queue_tempo);
 
 static int snd_seq_ioctl_set_queue_tempo(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_queue_tempo *tempo = arg;
 	int result;
-	struct snd_seq_queue_tempo tempo;
-
-	if (copy_from_user(&tempo, arg, sizeof(tempo)))
-		return -EFAULT;
 
-	result = snd_seq_set_queue_tempo(client->number, &tempo);
+	result = snd_seq_set_queue_tempo(client->number, tempo);
 	return result < 0 ? result : 0;
 }
 
-- 
2.7.4
