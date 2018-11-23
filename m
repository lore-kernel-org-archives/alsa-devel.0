From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: firewire-tascam: apply small
	refactoring to handle several type of event for hwdep interface
Date: Fri, 23 Nov 2018 13:13:06 +0900
Message-ID: <20181123041307.22980-5-o-takashi@sakamocchi.jp>
References: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 29BE3267A81
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 05:13:39 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id h3so2767450pfg.1
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 20:13:39 -0800 (PST)
In-Reply-To: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
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
Cc: sbahling@suse.com, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In later commits, ALSA firewire-tascam driver will allow userspace
applications to receive notifications about changes of device state,
transferred in tx isochronous packet. At present, all of drivers in ALSA
firewire stack have mechanism to notify change of status of packet
streaming, thus it needs to distinguish these two types of notification.

This commit is a preparation for the above.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-hwdep.c | 38 +++++++++++++++++++---------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 9afa827af05d..8f34cede2e9f 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -16,14 +16,30 @@
 
 #include "tascam.h"
 
+static long tscm_hwdep_read_locked(struct snd_tscm *tscm, char __user *buf,
+				   long count, loff_t *offset)
+{
+	struct snd_firewire_event_lock_status event = {
+		.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS,
+	};
+
+	event.status = (tscm->dev_lock_count > 0);
+	tscm->dev_lock_changed = false;
+	count = min_t(long, count, sizeof(event));
+
+	spin_unlock_irq(&tscm->lock);
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
+	return count;
+}
+
 static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		       loff_t *offset)
 {
 	struct snd_tscm *tscm = hwdep->private_data;
 	DEFINE_WAIT(wait);
-	union snd_firewire_event event = {
-		.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS,
-	};
 
 	spin_lock_irq(&tscm->lock);
 
@@ -37,15 +53,13 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		spin_lock_irq(&tscm->lock);
 	}
 
-	event.lock_status.status = (tscm->dev_lock_count > 0);
-	tscm->dev_lock_changed = false;
-
-	spin_unlock_irq(&tscm->lock);
-
-	count = min_t(long, count, sizeof(event.lock_status));
-
-	if (copy_to_user(buf, &event, count))
-		return -EFAULT;
+	// NOTE: The acquired lock should be released in callee side.
+	if (tscm->dev_lock_changed) {
+		count = tscm_hwdep_read_locked(tscm, buf, count, offset);
+	} else {
+		spin_unlock_irq(&tscm->lock);
+		count = 0;
+	}
 
 	return count;
 }
-- 
2.19.1
