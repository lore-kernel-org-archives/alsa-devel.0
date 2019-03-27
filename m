From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: timer: Check ack_list emptiness
	instead of bit flag
Date: Wed, 27 Mar 2019 17:52:16 +0100
Message-ID: <20190327165217.4240-4-tiwai@suse.de>
References: <20190327165217.4240-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5566BF801D8
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 17:52:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1171CAFAC
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 16:52:19 +0000 (UTC)
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

For checking the pending timer instance that is still left on the
timer object that is being closed, we set/clear a bit flag
SNDRV_TIMER_IFLG_CALLBACK around the call of callbacks.  This can be
simplified by replace with the list_empty() call for ti->ack_list.
This covers the existence more comprehensively and safely.

A gratis bonus is that we can get rid of SNDRV_TIMER_IFLG_CALLBACK bit
flag definition as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/timer.h |  1 -
 sound/core/timer.c    | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/sound/timer.h b/include/sound/timer.h
index 7ae226ab6990..bcfee20ea226 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -43,7 +43,6 @@
 #define SNDRV_TIMER_IFLG_START	  0x00000004
 #define SNDRV_TIMER_IFLG_AUTO	  0x00000008	/* auto restart */
 #define SNDRV_TIMER_IFLG_FAST	  0x00000010	/* fast callback (do not use tasklet) */
-#define SNDRV_TIMER_IFLG_CALLBACK 0x00000020	/* timer callback is active */
 #define SNDRV_TIMER_IFLG_EXCLUSIVE 0x00000040	/* exclusive owner - no more instances */
 #define SNDRV_TIMER_IFLG_EARLY_EVENT 0x00000080	/* write early event to the poll queue */
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 107d8ebeeb2e..e343de0e4f9e 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -366,7 +366,7 @@ static int snd_timer_close_locked(struct snd_timer_instance *timeri)
 		timer->num_instances--;
 		/* wait, until the active callback is finished */
 		spin_lock_irq(&timer->lock);
-		while (timeri->flags & SNDRV_TIMER_IFLG_CALLBACK) {
+		while (!list_empty(&timeri->ack_list)) {
 			spin_unlock_irq(&timer->lock);
 			udelay(10);
 			spin_lock_irq(&timer->lock);
@@ -731,19 +731,17 @@ static void snd_timer_process_callbacks(struct snd_timer *timer,
 		ti = list_first_entry(head, struct snd_timer_instance,
 				      ack_list);
 
-		/* remove from ack_list and make empty */
-		list_del_init(&ti->ack_list);
-
 		ticks = ti->pticks;
 		ti->pticks = 0;
 		resolution = ti->resolution;
 
-		ti->flags |= SNDRV_TIMER_IFLG_CALLBACK;
 		spin_unlock(&timer->lock);
 		if (ti->callback)
 			ti->callback(ti, resolution, ticks);
 		spin_lock(&timer->lock);
-		ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
+
+		/* remove from ack_list and make empty */
+		list_del_init(&ti->ack_list);
 	}
 }
 
-- 
2.16.4
