From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/29] ALSA: dice: Move file to its own
	directory
Date: Sun, 26 Oct 2014 22:03:03 +0900
Message-ID: <1414328610-12729-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DC312606B0
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 14:03:45 +0100 (CET)
In-Reply-To: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
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

In followed commits, dice driver is split into several files. For easily
managing these files, this commit adds subdirectory and move file into
the directory.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile                    |  3 +--
 sound/firewire/dice/Makefile               |  2 ++
 sound/firewire/{ => dice}/dice-interface.h |  0
 sound/firewire/{ => dice}/dice.c           | 19 ++++++++++---------
 4 files changed, 13 insertions(+), 11 deletions(-)
 create mode 100644 sound/firewire/dice/Makefile
 rename sound/firewire/{ => dice}/dice-interface.h (100%)
 rename sound/firewire/{ => dice}/dice.c (99%)

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index fad8d49..c50761c 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,12 +1,11 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp.o
-snd-dice-objs := dice.o
 snd-firewire-speakers-objs := speakers.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
 
 obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
-obj-$(CONFIG_SND_DICE) += snd-dice.o
+obj-$(CONFIG_SND_DICE) += dice/
 obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
new file mode 100644
index 0000000..af05d7e
--- /dev/null
+++ b/sound/firewire/dice/Makefile
@@ -0,0 +1,2 @@
+snd-dice-objs := dice.o
+obj-m += snd-dice.o
diff --git a/sound/firewire/dice-interface.h b/sound/firewire/dice/dice-interface.h
similarity index 100%
rename from sound/firewire/dice-interface.h
rename to sound/firewire/dice/dice-interface.h
diff --git a/sound/firewire/dice.c b/sound/firewire/dice/dice.c
similarity index 99%
rename from sound/firewire/dice.c
rename to sound/firewire/dice/dice.c
index c7c8495..2c3158f 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -26,9 +26,9 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include "amdtp.h"
-#include "iso-resources.h"
-#include "lib.h"
+#include "../amdtp.h"
+#include "../iso-resources.h"
+#include "../lib.h"
 #include "dice-interface.h"
 
 
@@ -133,7 +133,7 @@ static inline u64 global_address(struct snd_dice *dice, unsigned int offset)
 	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
 }
 
-// TODO: rx index
+/* TODO: rx index */
 static inline u64 rx_address(struct snd_dice *dice, unsigned int offset)
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
@@ -1448,7 +1449,7 @@ static void dice_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(dice->card);
 }
 
-static void dice_bus_reset(struct fw_unit *unit)
+static void dice_update(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
@@ -1492,7 +1493,7 @@ static struct fw_driver dice_driver = {
 		.bus	= &fw_bus_type,
 	},
 	.probe    = dice_probe,
-	.update   = dice_bus_reset,
+	.update   = dice_update,
 	.remove   = dice_remove,
 	.id_table = dice_id_table,
 };
-- 
1.9.1
