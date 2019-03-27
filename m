From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: timer: Make sure to clear pending
	ack list
Date: Wed, 27 Mar 2019 17:52:15 +0100
Message-ID: <20190327165217.4240-3-tiwai@suse.de>
References: <20190327165217.4240-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86DB4F89618
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 17:52:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id ECF7BAF8A
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 16:52:18 +0000 (UTC)
In-Reply-To: <20190327165217.4240-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When a card is under disconnection, we bail out immediately at each
timer interrupt or tasklet.  This might leave some items left in ack
list.  For a better integration of the upcoming change to check
ack_list emptiness, clear out the whole list upon the emergency exit
route.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index fdcddfb756b4..107d8ebeeb2e 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -747,6 +747,18 @@ static void snd_timer_process_callbacks(struct snd_timer *timer,
 	}
 }
 
+/* clear pending instances from ack list */
+static void snd_timer_clear_callbacks(struct snd_timer *timer,
+				      struct list_head *head)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer->lock, flags);
+	while (!list_empty(head))
+		list_del_init(head->next);
+	spin_unlock_irqrestore(&timer->lock, flags);
+}
+
 /*
  * timer tasklet
  *
@@ -756,8 +768,10 @@ static void snd_timer_tasklet(unsigned long arg)
 	struct snd_timer *timer = (struct snd_timer *) arg;
 	unsigned long flags;
 
-	if (timer->card && timer->card->shutdown)
+	if (timer->card && timer->card->shutdown) {
+		snd_timer_clear_callbacks(timer, &timer->sack_list_head);
 		return;
+	}
 
 	spin_lock_irqsave(&timer->lock, flags);
 	snd_timer_process_callbacks(timer, &timer->sack_list_head);
@@ -781,8 +795,10 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 	if (timer == NULL)
 		return;
 
-	if (timer->card && timer->card->shutdown)
+	if (timer->card && timer->card->shutdown) {
+		snd_timer_clear_callbacks(timer, &timer->ack_list_head);
 		return;
+	}
 
 	spin_lock_irqsave(&timer->lock, flags);
 
-- 
2.16.4
