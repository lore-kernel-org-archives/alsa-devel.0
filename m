From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: fireworks: accessing to user space
	outside spinlock
Date: Sat, 27 Aug 2016 05:50:08 +0900
Message-ID: <1472244609-31830-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E488C266626
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

In hwdep interface of fireworks driver, accessing to user space is in a
critical section with disabled local interrupt. Depending on architecture,
accessing to user space can cause page fault exception. Then local
processor stores machine status and handles the synchronous event. A
handler corresponding to the event can call task scheduler to wait for
preparing pages. In a case of usage of single core processor, the state to
disable local interrupt is worse because it don't handle usual interrupts
from hardware.

This commit fixes this bug, performing the accessing outside spinlock.

Reported-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Cc: stable@vger.kernel.org
Fixes: 555e8a8f7f14('ALSA: fireworks: Add command/response functionality into hwdep interface')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_hwdep.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
index 33df865..b4c3f57 100644
--- a/sound/firewire/fireworks/fireworks_hwdep.c
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -38,6 +38,7 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
 	buf += sizeof(type);
 
 	/* write into buffer as many responses as possible */
+	spin_lock_irq(&efw->lock);
 	while (efw->resp_queues > 0) {
 		t = (struct snd_efw_transaction *)(efw->pull_ptr);
 		length = be32_to_cpu(t->length) * sizeof(__be32);
@@ -52,9 +53,13 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
 				(unsigned int)(efw->pull_ptr - efw->resp_buf);
 			till_end = min_t(unsigned int, length, till_end);
 
+			spin_unlock_irq(&efw->lock);
+
 			if (copy_to_user(buf, efw->pull_ptr, till_end))
 				return -EFAULT;
 
+			spin_lock_irq(&efw->lock);
+
 			efw->pull_ptr += till_end;
 			if (efw->pull_ptr >= efw->resp_buf +
 					     snd_efw_resp_buf_size)
@@ -69,6 +74,8 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
 		efw->resp_queues--;
 	}
 
+	spin_unlock_irq(&efw->lock);
+
 	return count;
 }
 
@@ -76,14 +83,17 @@ static long
 hwdep_read_locked(struct snd_efw *efw, char __user *buf, long count,
 		  loff_t *offset)
 {
-	union snd_firewire_event event;
-
-	memset(&event, 0, sizeof(event));
+	union snd_firewire_event event = {0};
 
 	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+
+	spin_lock_irq(&efw->lock);
+
 	event.lock_status.status = (efw->dev_lock_count > 0);
 	efw->dev_lock_changed = false;
 
+	spin_unlock_irq(&efw->lock);
+
 	count = min_t(long, count, sizeof(event.lock_status));
 
 	if (copy_to_user(buf, &event, count))
@@ -111,13 +121,13 @@ hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		spin_lock_irq(&efw->lock);
 	}
 
+	spin_unlock_irq(&efw->lock);
+
 	if (efw->dev_lock_changed)
 		count = hwdep_read_locked(efw, buf, count, offset);
 	else if (efw->resp_queues > 0)
 		count = hwdep_read_resp_buf(efw, buf, count, offset);
 
-	spin_unlock_irq(&efw->lock);
-
 	return count;
 }
 
-- 
2.7.4
