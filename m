From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/10] ALSA: timer: Use standard printk helpers
Date: Wed, 12 Feb 2014 12:33:10 +0100
Message-ID: <1392204792-12655-9-git-send-email-tiwai@suse.de>
References: <1392204792-12655-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E070265292
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:33:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EEC38AC7C
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:33:17 +0000 (UTC)
In-Reply-To: <1392204792-12655-1-git-send-email-tiwai@suse.de>
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

Use the standard pr_xxx() helpers instead of home-baked snd_print*().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/hrtimer.c  |  3 +--
 sound/core/rtctimer.c |  3 +--
 sound/core/timer.c    | 13 ++++++-------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index b8b31c433d64..886be7da989d 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -126,8 +126,7 @@ static int __init snd_hrtimer_init(void)
 
 	hrtimer_get_res(CLOCK_MONOTONIC, &tp);
 	if (tp.tv_sec > 0 || !tp.tv_nsec) {
-		snd_printk(KERN_ERR
-			   "snd-hrtimer: Invalid resolution %u.%09u",
+		pr_err("snd-hrtimer: Invalid resolution %u.%09u",
 			   (unsigned)tp.tv_sec, (unsigned)tp.tv_nsec);
 		return -EINVAL;
 	}
diff --git a/sound/core/rtctimer.c b/sound/core/rtctimer.c
index b27223746b0e..f3420d11a12f 100644
--- a/sound/core/rtctimer.c
+++ b/sound/core/rtctimer.c
@@ -132,8 +132,7 @@ static int __init rtctimer_init(void)
 
 	if (rtctimer_freq < 2 || rtctimer_freq > 8192 ||
 	    !is_power_of_2(rtctimer_freq)) {
-		snd_printk(KERN_ERR "rtctimer: invalid frequency %d\n",
-			   rtctimer_freq);
+		pr_err("ALSA: rtctimer: invalid frequency %d\n", rtctimer_freq);
 		return -EINVAL;
 	}
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index cbec51464c5b..cfd455a8ac1a 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -240,7 +240,8 @@ int snd_timer_open(struct snd_timer_instance **ti,
 		/* open a slave instance */
 		if (tid->dev_sclass <= SNDRV_TIMER_SCLASS_NONE ||
 		    tid->dev_sclass > SNDRV_TIMER_SCLASS_OSS_SEQUENCER) {
-			snd_printd("invalid slave class %i\n", tid->dev_sclass);
+			pr_debug("ALSA: timer: invalid slave class %i\n",
+				 tid->dev_sclass);
 			return -EINVAL;
 		}
 		mutex_lock(&register_mutex);
@@ -774,7 +775,7 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 		*rtimer = NULL;
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
 	if (timer == NULL) {
-		snd_printk(KERN_ERR "timer: cannot allocate\n");
+		pr_err("ALSA: timer: cannot allocate\n");
 		return -ENOMEM;
 	}
 	timer->tmr_class = tid->dev_class;
@@ -813,7 +814,7 @@ static int snd_timer_free(struct snd_timer *timer)
 	if (! list_empty(&timer->open_list_head)) {
 		struct list_head *p, *n;
 		struct snd_timer_instance *ti;
-		snd_printk(KERN_WARNING "timer %p is busy?\n", timer);
+		pr_warn("ALSA: timer %p is busy?\n", timer);
 		list_for_each_safe(p, n, &timer->open_list_head) {
 			list_del_init(p);
 			ti = list_entry(p, struct snd_timer_instance, open_list);
@@ -1955,12 +1956,10 @@ static int __init alsa_timer_init(void)
 #endif
 
 	if ((err = snd_timer_register_system()) < 0)
-		snd_printk(KERN_ERR "unable to register system timer (%i)\n",
-			   err);
+		pr_err("ALSA: unable to register system timer (%i)\n", err);
 	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
 				       &snd_timer_f_ops, NULL, "timer")) < 0)
-		snd_printk(KERN_ERR "unable to register timer device (%i)\n",
-			   err);
+		pr_err("ALSA: unable to register timer device (%i)\n", err);
 	snd_timer_proc_init();
 	return 0;
 }
-- 
1.8.5.2
