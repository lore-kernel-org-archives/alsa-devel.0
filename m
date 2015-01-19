From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/18] ALSA: korg1212: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:25 +0100
Message-ID: <1421665891-14475-13-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E5A2606FC
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B9E8ADB0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:36 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/korg1212/korg1212.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 59d21c9401d2..bd569e580277 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -585,8 +585,7 @@ static void snd_korg1212_SendStop(struct snd_korg1212 *korg1212)
 		korg1212->sharedBufferPtr->cardCommand = 0xffffffff;
 		/* program the timer */
 		korg1212->stop_pending_cnt = HZ;
-		korg1212->timer.expires = jiffies + 1;
-		add_timer(&korg1212->timer);
+		mod_timer(&korg1212->timer, jiffies + 1);
 	}
 }
 
@@ -617,8 +616,7 @@ static void snd_korg1212_timer_func(unsigned long data)
 	} else {
 		if (--korg1212->stop_pending_cnt > 0) {
 			/* reprogram timer */
-			korg1212->timer.expires = jiffies + 1;
-			add_timer(&korg1212->timer);
+			mod_timer(&korg1212->timer, jiffies + 1);
 		} else {
 			snd_printd("korg1212_timer_func timeout\n");
 			korg1212->sharedBufferPtr->cardCommand = 0;
@@ -2172,9 +2170,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
         init_waitqueue_head(&korg1212->wait);
         spin_lock_init(&korg1212->lock);
 	mutex_init(&korg1212->open_mutex);
-	init_timer(&korg1212->timer);
-	korg1212->timer.function = snd_korg1212_timer_func;
-	korg1212->timer.data = (unsigned long)korg1212;
+	setup_timer(&korg1212->timer, snd_korg1212_timer_func,
+		    (unsigned long)korg1212);
 
         korg1212->irq = -1;
         korg1212->clkSource = K1212_CLKIDX_Local;
-- 
2.2.1
