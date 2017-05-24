From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: remove entry limitation for
	list operation
Date: Wed, 24 May 2017 10:04:30 +0900
Message-ID: <20170524010430.1371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id A5A2D266B78
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 03:04:35 +0200 (CEST)
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

In current implementation of ALSA control core, list operation has
a limitation to handle 16384 entries at once. This seems due to
allocation in kernel space to copy data from user space.

With a commit 53e7bf452584 ("ALSA: control: Simplify snd_ctl_elem_list()
implementation"), for the operation, ALSA control core copies data
into user space directly. No need to care of kernel spaces anymore.

This commit purges the limitation.
---
 sound/core/control.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 47080da8451a..ecd358213b83 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -757,9 +757,7 @@ static int snd_ctl_elem_list(struct snd_card *card,
 		return -EFAULT;
 	offset = list.offset;
 	space = list.space;
-	/* try limit maximum space */
-	if (space > 16384)
-		return -ENOMEM;
+
 	down_read(&card->controls_rwsem);
 	list.count = card->controls_count;
 	list.used = 0;
-- 
2.11.0
