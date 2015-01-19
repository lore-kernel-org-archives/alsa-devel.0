From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/18] ALSA: opl3: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:18 +0100
Message-ID: <1421665891-14475-6-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DA0D260413
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:36 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E33AAAD81
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
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
 sound/drivers/opl3/opl3_midi.c | 11 ++++-------
 sound/drivers/opl3/opl3_seq.c  |  4 +---
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 6c6d09a51f42..f62780ed64ad 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -258,12 +258,10 @@ void snd_opl3_timer_func(unsigned long data)
 	spin_unlock_irqrestore(&opl3->voice_lock, flags);
 
 	spin_lock_irqsave(&opl3->sys_timer_lock, flags);
-	if (again) {
-		opl3->tlist.expires = jiffies + 1;	/* invoke again */
-		add_timer(&opl3->tlist);
-	} else {
+	if (again)
+		mod_timer(&opl3->tlist, jiffies + 1);	/* invoke again */
+	else
 		opl3->sys_timer_status = 0;
-	}
 	spin_unlock_irqrestore(&opl3->sys_timer_lock, flags);
 }
 
@@ -275,8 +273,7 @@ static void snd_opl3_start_timer(struct snd_opl3 *opl3)
 	unsigned long flags;
 	spin_lock_irqsave(&opl3->sys_timer_lock, flags);
 	if (! opl3->sys_timer_status) {
-		opl3->tlist.expires = jiffies + 1;
-		add_timer(&opl3->tlist);
+		mod_timer(&opl3->tlist, jiffies + 1);
 		opl3->sys_timer_status = 1;
 	}
 	spin_unlock_irqrestore(&opl3->sys_timer_lock, flags);
diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index 68399538e435..a9f618e06a22 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -247,9 +247,7 @@ static int snd_opl3_seq_new_device(struct snd_seq_device *dev)
 	}
 
 	/* setup system timer */
-	init_timer(&opl3->tlist);
-	opl3->tlist.function = snd_opl3_timer_func;
-	opl3->tlist.data = (unsigned long) opl3;
+	setup_timer(&opl3->tlist, snd_opl3_timer_func, (unsigned long) opl3);
 	spin_lock_init(&opl3->sys_timer_lock);
 	opl3->sys_timer_status = 0;
 
-- 
2.2.1
