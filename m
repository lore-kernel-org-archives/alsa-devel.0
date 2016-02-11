From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: dice: change notification mask to
	detect lock status change
Date: Thu, 11 Feb 2016 20:18:37 +0900
Message-ID: <1455189518-29261-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1455189518-29261-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D15426068F
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 12:18:44 +0100 (CET)
In-Reply-To: <1455189518-29261-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

With former patchset, ALSA dice driver doesn't change clock parameters
anymore, while the driver still touch clock configuration for phase lock.

Although the locking status is in Dice notification, the driver doesn't
detect it. Usually, this causes no issues because in most case
NOTIFY_LOCK_CHG notification transfers after NOTIFY_CLOCK_ACCEPTED
notification, while it's better to detect locking status.

This commit changes notification mask just to detect lock status change.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index 76f9f72..0f03503 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -156,7 +156,7 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 
-	if (bits & NOTIFY_CLOCK_ACCEPTED)
+	if (bits & NOTIFY_LOCK_CHG)
 		complete(&dice->clock_accepted);
 	wake_up(&dice->hwdep_wait);
 }
-- 
2.5.0
