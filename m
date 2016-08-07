From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 28/39] ALSA: seq: optimize set_queue_tempo
	function to new design
Date: Sun,  7 Aug 2016 18:49:04 +0900
Message-ID: <1470563355-18368-29-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 82C3C265D9E
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
 sound/core/seq/seq_clientmgr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2338468..a90a4a3 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1677,16 +1677,12 @@ int snd_seq_set_queue_tempo(int client, struct snd_seq_queue_tempo *tempo)
 
 EXPORT_SYMBOL(snd_seq_set_queue_tempo);
 
-static int seq_ioctl_set_queue_tempo(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_set_queue_tempo(struct snd_seq_client *client, void *arg)
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
