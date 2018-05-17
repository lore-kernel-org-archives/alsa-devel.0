From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH] ALSA: timer: Fix pause event notification
Date: Thu, 17 May 2018 22:34:39 +0100
Message-ID: <20180517213439.umbmvoo2jla5zkuq@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit f65e0d299807 ("ALSA: timer: Call notifier in the same spinlock")
combined the start/continue and stop/pause functions, and in doing so
changed the event code for the pause case to SNDRV_TIMER_EVENT_CONTINUE.
Change it back to SNDRV_TIMER_EVENT_PAUSE.

Fixes: f65e0d299807 ("ALSA: timer: Call notifier in the same spinlock")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: stable@vger.kernel.org
---
 sound/core/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index dc87728c5b74..0ddcae495838 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -592,7 +592,7 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 	else
 		timeri->flags |= SNDRV_TIMER_IFLG_PAUSED;
 	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
-			  SNDRV_TIMER_EVENT_CONTINUE);
+			  SNDRV_TIMER_EVENT_PAUSE);
  unlock:
 	spin_unlock_irqrestore(&timer->lock, flags);
 	return result;
@@ -614,7 +614,7 @@ static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
 		list_del_init(&timeri->ack_list);
 		list_del_init(&timeri->active_list);
 		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
-				  SNDRV_TIMER_EVENT_CONTINUE);
+				  SNDRV_TIMER_EVENT_PAUSE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
-- 
2.11.0
