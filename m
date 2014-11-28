From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/30] ALSA: dice: suppress checkpatch.pl
	warnings
Date: Sat, 29 Nov 2014 00:59:10 +0900
Message-ID: <1417190379-4172-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E53C26048B
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:48 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The checkpatch.pl generates some warnings due to:
 - C99 comment
 - a line over 80 characters
 - min() for parameters with different types

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index e3a04d6..72af110 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -133,7 +133,7 @@ static inline u64 global_address(struct dice *dice, unsigned int offset)
 	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
 }
 
-// TODO: rx index
+/* TODO: rx index */
 static inline u64 rx_address(struct dice *dice, unsigned int offset)
 {
 	return DICE_PRIVATE_SPACE + dice->rx_offset + offset;
@@ -721,13 +721,14 @@ static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
 		event.lock_status.status = dice->dev_lock_count > 0;
 		dice->dev_lock_changed = false;
 
-		count = min(count, (long)sizeof(event.lock_status));
+		count = min_t(long, count, sizeof(event.lock_status));
 	} else {
-		event.dice_notification.type = SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
+		event.dice_notification.type =
+					SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
 		event.dice_notification.notification = dice->notification_bits;
 		dice->notification_bits = 0;
 
-		count = min(count, (long)sizeof(event.dice_notification));
+		count = min_t(long, count, sizeof(event.dice_notification));
 	}
 
 	spin_unlock_irq(&dice->lock);
-- 
2.1.0
