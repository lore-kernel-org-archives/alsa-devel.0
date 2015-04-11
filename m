From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: seq: fill client ID in return value of
	pool operation
Date: Sat, 11 Apr 2015 13:24:47 +0900
Message-ID: <1428726287-4062-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FAA1260719
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 06:24:53 +0200 (CEST)
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

The returned value of 'get/seq client pool' operation has zeroed value
for its client ID, against requested client ID.

This commit fix the bug by filling it with index value of referred
client object.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 4828765..edbdab8 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1879,6 +1879,7 @@ static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
 	if (cptr == NULL)
 		return -ENOENT;
 	memset(&info, 0, sizeof(info));
+	info.client = cptr->number;
 	info.output_pool = cptr->pool->size;
 	info.output_room = cptr->pool->room;
 	info.output_free = info.output_pool;
-- 
2.1.0
