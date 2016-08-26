From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: firewire-tascam: accessing to user
	space outside spinlock
Date: Sat, 27 Aug 2016 05:50:09 +0900
Message-ID: <1472244609-31830-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E206226656F
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 22:50:14 +0200 (CEST)
In-Reply-To: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: vaishali.thakkar@oracle.com, alsa-devel@alsa-project.org, stable@vger.kernel.org, ffado-devel@lists.sf.net
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
 sound/firewire/tascam/tascam-hwdep.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 131267c..edf20c7 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -16,31 +16,12 @@
 
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
+	union snd_firewire_event event = {0};
 
 	spin_lock_irq(&tscm->lock);
 
@@ -54,10 +35,17 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		spin_lock_irq(&tscm->lock);
 	}
 
-	memset(&event, 0, sizeof(event));
-	count = hwdep_read_locked(tscm, buf, count);
+	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
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
