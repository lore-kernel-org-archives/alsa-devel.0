From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] ALSA: timer: remove legacy rtctimer
Date: Sat, 23 Apr 2016 02:58:05 +0200
Message-ID: <1461373085-16679-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

There are no users of rtctimer left. Remove its code as this is the
in-kernel user of the legacy PC RTC driver that will hopefully be removed
at some point.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Note that I've kept the definition of SNDRV_TIMER_GLOBAL_RTC as it is exposed to
userspace. USerspace will still properly get -ENODEV when trying to use it (as
if it was compiled out of the kernel anyway).

 include/uapi/sound/asound.h |   2 +-
 sound/core/Kconfig          |  29 -------
 sound/core/Makefile         |   1 -
 sound/core/rtctimer.c       | 187 --------------------------------------------
 sound/core/seq/seq.c        |   2 -
 sound/core/timer.c          |   2 -
 6 files changed, 1 insertion(+), 222 deletions(-)
 delete mode 100644 sound/core/rtctimer.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 67bf49d8c944..609cadb8739d 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -672,7 +672,7 @@ enum {
 
 /* global timers (device member) */
 #define SNDRV_TIMER_GLOBAL_SYSTEM	0
-#define SNDRV_TIMER_GLOBAL_RTC		1
+#define SNDRV_TIMER_GLOBAL_RTC		1	/* unused */
 #define SNDRV_TIMER_GLOBAL_HPET		2
 #define SNDRV_TIMER_GLOBAL_HRTIMER	3
 
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 6d12ca9bcb80..9749f9e8b45c 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -141,35 +141,6 @@ config SND_SEQ_HRTIMER_DEFAULT
 	  Say Y here to use the HR-timer backend as the default sequencer
 	  timer.
 
-config SND_RTCTIMER
-	tristate "RTC Timer support"
-	depends on RTC
-	select SND_TIMER
-	help
-	  Say Y here to enable RTC timer support for ALSA.  ALSA uses
-	  the RTC timer as a precise timing source and maps the RTC
-	  timer to ALSA's timer interface.  The ALSA sequencer code also
-	  can use this timing source.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-rtctimer.
-
-	  Note that this option is exclusive with the new RTC drivers
-	  (CONFIG_RTC_CLASS) since this requires the old API.
-
-config SND_SEQ_RTCTIMER_DEFAULT
-	bool "Use RTC as default sequencer timer"
-	depends on SND_RTCTIMER && SND_SEQUENCER
-	depends on !SND_SEQ_HRTIMER_DEFAULT
-	default y
-	help
-	  Say Y here to use the RTC timer as the default sequencer
-	  timer.  This is strongly recommended because it ensures
-	  precise MIDI timing even when the system timer runs at less
-	  than 1000 Hz.
-
-	  If in doubt, say Y.
-
 config SND_DYNAMIC_MINORS
 	bool "Dynamic device file minor numbers"
 	help
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 48ab4b8f8279..e85d9dd12c2d 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_SND) 		+= snd.o
 obj-$(CONFIG_SND_HWDEP)		+= snd-hwdep.o
 obj-$(CONFIG_SND_TIMER)		+= snd-timer.o
 obj-$(CONFIG_SND_HRTIMER)	+= snd-hrtimer.o
-obj-$(CONFIG_SND_RTCTIMER)	+= snd-rtctimer.o
 obj-$(CONFIG_SND_PCM)		+= snd-pcm.o
 obj-$(CONFIG_SND_DMAENGINE_PCM)	+= snd-pcm-dmaengine.o
 obj-$(CONFIG_SND_RAWMIDI)	+= snd-rawmidi.o
diff --git a/sound/core/rtctimer.c b/sound/core/rtctimer.c
deleted file mode 100644
index f3420d11a12f..000000000000
--- a/sound/core/rtctimer.c
+++ /dev/null
@@ -1,187 +0,0 @@
-/*
- *  RTC based high-frequency timer
- *
- *  Copyright (C) 2000 Takashi Iwai
- *	based on rtctimer.c by Steve Ratcliffe
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/log2.h>
-#include <sound/core.h>
-#include <sound/timer.h>
-
-#if IS_ENABLED(CONFIG_RTC)
-
-#include <linux/mc146818rtc.h>
-
-#define RTC_FREQ	1024		/* default frequency */
-#define NANO_SEC	1000000000L	/* 10^9 in sec */
-
-/*
- * prototypes
- */
-static int rtctimer_open(struct snd_timer *t);
-static int rtctimer_close(struct snd_timer *t);
-static int rtctimer_start(struct snd_timer *t);
-static int rtctimer_stop(struct snd_timer *t);
-
-
-/*
- * The hardware dependent description for this timer.
- */
-static struct snd_timer_hardware rtc_hw = {
-	.flags =	SNDRV_TIMER_HW_AUTO |
-			SNDRV_TIMER_HW_FIRST |
-			SNDRV_TIMER_HW_TASKLET,
-	.ticks =	100000000L,		/* FIXME: XXX */
-	.open =		rtctimer_open,
-	.close =	rtctimer_close,
-	.start =	rtctimer_start,
-	.stop =		rtctimer_stop,
-};
-
-static int rtctimer_freq = RTC_FREQ;		/* frequency */
-static struct snd_timer *rtctimer;
-static struct tasklet_struct rtc_tasklet;
-static rtc_task_t rtc_task;
-
-
-static int
-rtctimer_open(struct snd_timer *t)
-{
-	int err;
-
-	err = rtc_register(&rtc_task);
-	if (err < 0)
-		return err;
-	t->private_data = &rtc_task;
-	return 0;
-}
-
-static int
-rtctimer_close(struct snd_timer *t)
-{
-	rtc_task_t *rtc = t->private_data;
-	if (rtc) {
-		rtc_unregister(rtc);
-		tasklet_kill(&rtc_tasklet);
-		t->private_data = NULL;
-	}
-	return 0;
-}
-
-static int
-rtctimer_start(struct snd_timer *timer)
-{
-	rtc_task_t *rtc = timer->private_data;
-	if (snd_BUG_ON(!rtc))
-		return -EINVAL;
-	rtc_control(rtc, RTC_IRQP_SET, rtctimer_freq);
-	rtc_control(rtc, RTC_PIE_ON, 0);
-	return 0;
-}
-
-static int
-rtctimer_stop(struct snd_timer *timer)
-{
-	rtc_task_t *rtc = timer->private_data;
-	if (snd_BUG_ON(!rtc))
-		return -EINVAL;
-	rtc_control(rtc, RTC_PIE_OFF, 0);
-	return 0;
-}
-
-static void rtctimer_tasklet(unsigned long data)
-{
-	snd_timer_interrupt((struct snd_timer *)data, 1);
-}
-
-/*
- * interrupt
- */
-static void rtctimer_interrupt(void *private_data)
-{
-	tasklet_schedule(private_data);
-}
-
-
-/*
- *  ENTRY functions
- */
-static int __init rtctimer_init(void)
-{
-	int err;
-	struct snd_timer *timer;
-
-	if (rtctimer_freq < 2 || rtctimer_freq > 8192 ||
-	    !is_power_of_2(rtctimer_freq)) {
-		pr_err("ALSA: rtctimer: invalid frequency %d\n", rtctimer_freq);
-		return -EINVAL;
-	}
-
-	/* Create a new timer and set up the fields */
-	err = snd_timer_global_new("rtc", SNDRV_TIMER_GLOBAL_RTC, &timer);
-	if (err < 0)
-		return err;
-
-	timer->module = THIS_MODULE;
-	strcpy(timer->name, "RTC timer");
-	timer->hw = rtc_hw;
-	timer->hw.resolution = NANO_SEC / rtctimer_freq;
-
-	tasklet_init(&rtc_tasklet, rtctimer_tasklet, (unsigned long)timer);
-
-	/* set up RTC callback */
-	rtc_task.func = rtctimer_interrupt;
-	rtc_task.private_data = &rtc_tasklet;
-
-	err = snd_timer_global_register(timer);
-	if (err < 0) {
-		snd_timer_global_free(timer);
-		return err;
-	}
-	rtctimer = timer; /* remember this */
-
-	return 0;
-}
-
-static void __exit rtctimer_exit(void)
-{
-	if (rtctimer) {
-		snd_timer_global_free(rtctimer);
-		rtctimer = NULL;
-	}
-}
-
-
-/*
- * exported stuff
- */
-module_init(rtctimer_init)
-module_exit(rtctimer_exit)
-
-module_param(rtctimer_freq, int, 0444);
-MODULE_PARM_DESC(rtctimer_freq, "timer frequency in Hz");
-
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS("snd-timer-" __stringify(SNDRV_TIMER_GLOBAL_RTC));
-
-#endif /* IS_ENABLED(CONFIG_RTC) */
diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index 7e0aabb808a6..639544b4fb04 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -47,8 +47,6 @@ int seq_default_timer_card = -1;
 int seq_default_timer_device =
 #ifdef CONFIG_SND_SEQ_HRTIMER_DEFAULT
 	SNDRV_TIMER_GLOBAL_HRTIMER
-#elif defined(CONFIG_SND_SEQ_RTCTIMER_DEFAULT)
-	SNDRV_TIMER_GLOBAL_RTC
 #else
 	SNDRV_TIMER_GLOBAL_SYSTEM
 #endif
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6469bedda2f3..0cfc028c1193 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -37,8 +37,6 @@
 
 #if IS_ENABLED(CONFIG_SND_HRTIMER)
 #define DEFAULT_TIMER_LIMIT 4
-#elif IS_ENABLED(CONFIG_SND_RTCTIMER)
-#define DEFAULT_TIMER_LIMIT 2
 #else
 #define DEFAULT_TIMER_LIMIT 1
 #endif
-- 
2.8.0.rc3
