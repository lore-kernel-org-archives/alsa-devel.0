From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] sound/core: merge list_del()/list_add_tail() to
 list_move_tail()
Date: Wed, 16 Mar 2011 17:10:11 +0100
Message-ID: <20110316171011.5070ecb2@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Merge list_del() + list_add_tail() to list_move_tail().

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 sound/core/timer.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index ed01632..7c1cbf0 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -186,9 +186,8 @@ static void snd_timer_check_slave(struct snd_timer_instance *slave)
 		list_for_each_entry(master, &timer->open_list_head, open_list) {
 			if (slave->slave_class == master->slave_class &&
 			    slave->slave_id == master->slave_id) {
-				list_del(&slave->open_list);
-				list_add_tail(&slave->open_list,
-					      &master->slave_list_head);
+				list_move_tail(&slave->open_list,
+					       &master->slave_list_head);
 				spin_lock_irq(&slave_active_lock);
 				slave->master = master;
 				slave->timer = master->timer;
@@ -414,8 +413,7 @@ static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 static int snd_timer_start1(struct snd_timer *timer, struct snd_timer_instance *timeri,
 			    unsigned long sticks)
 {
-	list_del(&timeri->active_list);
-	list_add_tail(&timeri->active_list, &timer->active_list_head);
+	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			goto __start_now;
-- 
1.7.3.4
