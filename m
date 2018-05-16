From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: timer: Simplify timer hw resolution
	calls
Date: Thu, 17 May 2018 00:10:47 +0200
Message-ID: <20180516221048.32221-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 52441267332
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 00:10:53 +0200 (CEST)
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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

There multiple open-codes to get the hardware timer resolution.
Make a local helper function snd_timer_hw_resolution() and call it
from all relevant places.

There is no functional change by this, just a preliminary work for the
following timer resolution hardening patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index dc87728c5b74..23b941df9c43 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -427,6 +427,14 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 }
 EXPORT_SYMBOL(snd_timer_close);
 
+static unsigned long snd_timer_hw_resolution(struct snd_timer *timer)
+{
+	if (timer->hw.c_resolution)
+		return timer->hw.c_resolution(timer);
+	else
+		return timer->hw.resolution;
+}
+
 unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 {
 	struct snd_timer * timer;
@@ -434,11 +442,8 @@ unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 	if (timeri == NULL)
 		return 0;
 	timer = timeri->timer;
-	if (timer) {
-		if (timer->hw.c_resolution)
-			return timer->hw.c_resolution(timer);
-		return timer->hw.resolution;
-	}
+	if (timer)
+		return snd_timer_hw_resolution(timer);
 	return 0;
 }
 EXPORT_SYMBOL(snd_timer_resolution);
@@ -771,10 +776,7 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 	spin_lock_irqsave(&timer->lock, flags);
 
 	/* remember the current resolution */
-	if (timer->hw.c_resolution)
-		resolution = timer->hw.c_resolution(timer);
-	else
-		resolution = timer->hw.resolution;
+	resolution = snd_timer_hw_resolution(timer);
 
 	/* loop for all active instances
 	 * Here we cannot use list_for_each_entry because the active_list of a
@@ -1014,12 +1016,8 @@ void snd_timer_notify(struct snd_timer *timer, int event, struct timespec *tstam
 	spin_lock_irqsave(&timer->lock, flags);
 	if (event == SNDRV_TIMER_EVENT_MSTART ||
 	    event == SNDRV_TIMER_EVENT_MCONTINUE ||
-	    event == SNDRV_TIMER_EVENT_MRESUME) {
-		if (timer->hw.c_resolution)
-			resolution = timer->hw.c_resolution(timer);
-		else
-			resolution = timer->hw.resolution;
-	}
+	    event == SNDRV_TIMER_EVENT_MRESUME)
+		resolution = snd_timer_hw_resolution(timer);
 	list_for_each_entry(ti, &timer->active_list_head, active_list) {
 		if (ti->ccallback)
 			ti->ccallback(ti, event, tstamp, resolution);
@@ -1656,10 +1654,7 @@ static int snd_timer_user_gstatus(struct file *file,
 	mutex_lock(&register_mutex);
 	t = snd_timer_find(&tid);
 	if (t != NULL) {
-		if (t->hw.c_resolution)
-			gstatus.resolution = t->hw.c_resolution(t);
-		else
-			gstatus.resolution = t->hw.resolution;
+		gstatus.resolution = snd_timer_hw_resolution(t);
 		if (t->hw.precise_resolution) {
 			t->hw.precise_resolution(t, &gstatus.resolution_num,
 						 &gstatus.resolution_den);
-- 
2.16.3
