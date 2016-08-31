From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 1/2] ALSA: firewire-tascam: accessing to user space outside spinlock
Date: Wed, 31 Aug 2016 20:15:32 +0900
Message-ID: <1472642133-31576-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1472642133-31576-1-git-send-email-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1472642133-31576-1-git-send-email-o-takashi@sakamocchi.jp>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In hwdep interface of firewire-tascam driver, accessing to user space is
in a critical section with disabled local interrupt. Depending on
architecture, accessing to user space can cause page fault exception. Then
local processor stores machine status and handle the synchronous event. A
handler corresponding to the event can call task scheduler to wait for
preparing pages. In a case of usage of single core processor, the state to
disable local interrupt is worse because it doesn't handle usual interrupts
from hardware.

This commit fixes this bug, by performing the accessing outside spinlock.

Reported-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Cc: stable@vger.kernel.org
Fixes: e5e0c3dd257b('ALSA: firewire-tascam: add hwdep interface')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-hwdep.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 131267c..106406c 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -16,31 +16,14 @@
 
 #include "tascam.h"
 
-static long hwdep_read_locked(struct snd_tscm *tscm, char __user *buf,
-			      long count)
-{
-	union snd_firewire_event event;
-
-	memset(&event, 0, sizeof(event));
-
-	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
-	event.lock_status.status = (tscm->dev_lock_count > 0);
-	tscm->dev_lock_changed = false;
-
-	count = min_t(long, count, sizeof(event.lock_status));
-
-	if (copy_to_user(buf, &event, count))
-		return -EFAULT;
-
-	return count;
-}
-
 static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		       loff_t *offset)
 {
 	struct snd_tscm *tscm = hwdep->private_data;
 	DEFINE_WAIT(wait);
-	union snd_firewire_event event;
+	union snd_firewire_event event = {
+		.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS,
+	};
 
 	spin_lock_irq(&tscm->lock);
 
@@ -54,10 +37,16 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		spin_lock_irq(&tscm->lock);
 	}
 
-	memset(&event, 0, sizeof(event));
-	count = hwdep_read_locked(tscm, buf, count);
+	event.lock_status.status = (tscm->dev_lock_count > 0);
+	tscm->dev_lock_changed = false;
+
 	spin_unlock_irq(&tscm->lock);
 
+	count = min_t(long, count, sizeof(event.lock_status));
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
 	return count;
 }
 
-- 
2.7.4
