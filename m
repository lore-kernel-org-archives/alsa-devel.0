From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: timer: Follow standard
	EXPORT_SYMBOL() declarations
Date: Fri, 16 Jun 2017 17:56:38 +0200
Message-ID: <20170616155639.5427-4-tiwai@suse.de>
References: <20170616155639.5427-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD6C0266CED
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 17:56:43 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2AC09ADE5
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 15:56:43 +0000 (UTC)
In-Reply-To: <20170616155639.5427-1-tiwai@suse.de>
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

Just a tidy up to follow the standard EXPORT_SYMBOL*() declarations
in order to improve grep-ability.

- Move EXPORT_SYMBOL*() to the position right after its definition

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 148290ace756..4888203b2dbc 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -319,6 +319,7 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	*ti = timeri;
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_open);
 
 /*
  * close a timer instance
@@ -384,6 +385,7 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 	mutex_unlock(&register_mutex);
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_close);
 
 unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 {
@@ -398,6 +400,7 @@ unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_resolution);
 
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
@@ -589,6 +592,7 @@ int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
 	else
 		return snd_timer_start1(timeri, true, ticks);
 }
+EXPORT_SYMBOL(snd_timer_start);
 
 /*
  * stop the timer instance.
@@ -602,6 +606,7 @@ int snd_timer_stop(struct snd_timer_instance *timeri)
 	else
 		return snd_timer_stop1(timeri, true);
 }
+EXPORT_SYMBOL(snd_timer_stop);
 
 /*
  * start again..  the tick is kept.
@@ -617,6 +622,7 @@ int snd_timer_continue(struct snd_timer_instance *timeri)
 	else
 		return snd_timer_start1(timeri, false, 0);
 }
+EXPORT_SYMBOL(snd_timer_continue);
 
 /*
  * pause.. remember the ticks left
@@ -628,6 +634,7 @@ int snd_timer_pause(struct snd_timer_instance * timeri)
 	else
 		return snd_timer_stop1(timeri, false);
 }
+EXPORT_SYMBOL(snd_timer_pause);
 
 /*
  * reschedule the timer
@@ -809,6 +816,7 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 	if (use_tasklet)
 		tasklet_schedule(&timer->task_queue);
 }
+EXPORT_SYMBOL(snd_timer_interrupt);
 
 /*
 
@@ -859,6 +867,7 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 		*rtimer = timer;
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_new);
 
 static int snd_timer_free(struct snd_timer *timer)
 {
@@ -978,6 +987,7 @@ void snd_timer_notify(struct snd_timer *timer, int event, struct timespec *tstam
 	}
 	spin_unlock_irqrestore(&timer->lock, flags);
 }
+EXPORT_SYMBOL(snd_timer_notify);
 
 /*
  * exported functions for global timers
@@ -993,11 +1003,13 @@ int snd_timer_global_new(char *id, int device, struct snd_timer **rtimer)
 	tid.subdevice = 0;
 	return snd_timer_new(NULL, id, &tid, rtimer);
 }
+EXPORT_SYMBOL(snd_timer_global_new);
 
 int snd_timer_global_free(struct snd_timer *timer)
 {
 	return snd_timer_free(timer);
 }
+EXPORT_SYMBOL(snd_timer_global_free);
 
 int snd_timer_global_register(struct snd_timer *timer)
 {
@@ -1007,6 +1019,7 @@ int snd_timer_global_register(struct snd_timer *timer)
 	dev.device_data = timer;
 	return snd_timer_dev_register(&dev);
 }
+EXPORT_SYMBOL(snd_timer_global_register);
 
 /*
  *  System timer
@@ -2113,17 +2126,3 @@ static void __exit alsa_timer_exit(void)
 
 module_init(alsa_timer_init)
 module_exit(alsa_timer_exit)
-
-EXPORT_SYMBOL(snd_timer_open);
-EXPORT_SYMBOL(snd_timer_close);
-EXPORT_SYMBOL(snd_timer_resolution);
-EXPORT_SYMBOL(snd_timer_start);
-EXPORT_SYMBOL(snd_timer_stop);
-EXPORT_SYMBOL(snd_timer_continue);
-EXPORT_SYMBOL(snd_timer_pause);
-EXPORT_SYMBOL(snd_timer_new);
-EXPORT_SYMBOL(snd_timer_notify);
-EXPORT_SYMBOL(snd_timer_global_new);
-EXPORT_SYMBOL(snd_timer_global_free);
-EXPORT_SYMBOL(snd_timer_global_register);
-EXPORT_SYMBOL(snd_timer_interrupt);
-- 
2.13.1
