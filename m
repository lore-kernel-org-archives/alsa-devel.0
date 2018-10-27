From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: fix to wait for releases of all
	ALSA character devices
Date: Sat, 27 Oct 2018 17:13:31 +0900
Message-ID: <20181027081331.13345-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id A76192679C6
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2018 10:13:41 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so965240plp.2
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2018 01:13:41 -0700 (PDT)
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

In a development period for Linux kernel v4.20, drivers in ALSA firewire
stack were changed to wait for releases of all ALSA character devices at
.remove callback of bus driver. However, ALSA dice driver is partly out
of this change. This bug can bring fault to user process which holds
the last of character device in unplugging.

This commit fixes the driver to wait in the callback.

Fixes: 61ccc6f6b27c ('ALSA: firewire: block .remove callback of bus driver till all of ALSA character devices are released')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 0f6dbcffe711..ed50b222d36e 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -240,8 +240,8 @@ static void dice_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&dice->dwork);
 
 	if (dice->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(dice->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(dice->card);
 	}
 
 	mutex_destroy(&dice->mutex);
-- 
2.19.1
