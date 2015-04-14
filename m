From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 04/39] sound: Use hrtimer_resolution instead of
 hrtimer_get_res()
Date: Tue, 14 Apr 2015 21:08:30 -0000
Message-ID: <20150414203500.799133359@linutronix.de>
References: <20150414203303.702062272@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 by alsa0.perex.cz (Postfix) with ESMTP id B0B97265497
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 23:08:21 +0200 (CEST)
Content-Disposition: inline; filename=sound-use-hrtimer-resolution.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Marcelo Tosatti <mtosatt@redhat.com>, Takashi Iwai <tiwai@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: alsa-devel@alsa-project.org

No point in converting a timespec now that the value is directly
accessible. Get rid of the null check while at it. Resolution is
guaranteed to be > 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/core/hrtimer.c      |    9 +--------
 sound/drivers/pcsp/pcsp.c |   15 ++++++---------
 2 files changed, 7 insertions(+), 17 deletions(-)

Index: tip/sound/core/hrtimer.c
===================================================================
--- tip.orig/sound/core/hrtimer.c
+++ tip/sound/core/hrtimer.c
@@ -121,16 +121,9 @@ static struct snd_timer *mytimer;
 static int __init snd_hrtimer_init(void)
 {
 	struct snd_timer *timer;
-	struct timespec tp;
 	int err;
 
-	hrtimer_get_res(CLOCK_MONOTONIC, &tp);
-	if (tp.tv_sec > 0 || !tp.tv_nsec) {
-		pr_err("snd-hrtimer: Invalid resolution %u.%09u",
-			   (unsigned)tp.tv_sec, (unsigned)tp.tv_nsec);
-		return -EINVAL;
-	}
-	resolution = tp.tv_nsec;
+	resolution = hrtimer_resolution;
 
 	/* Create a new timer and set up the fields */
 	err = snd_timer_global_new("hrtimer", SNDRV_TIMER_GLOBAL_HRTIMER,
Index: tip/sound/drivers/pcsp/pcsp.c
===================================================================
--- tip.orig/sound/drivers/pcsp/pcsp.c
+++ tip/sound/drivers/pcsp/pcsp.c
@@ -42,16 +42,13 @@ struct snd_pcsp pcsp_chip;
 static int snd_pcsp_create(struct snd_card *card)
 {
 	static struct snd_device_ops ops = { };
-	struct timespec tp;
-	int err;
-	int div, min_div, order;
-
-	hrtimer_get_res(CLOCK_MONOTONIC, &tp);
+	unsigned int resolution = hrtimer_resolution;
+	int err, div, min_div, order;
 
 	if (!nopcm) {
-		if (tp.tv_sec || tp.tv_nsec > PCSP_MAX_PERIOD_NS) {
+		if (resolution > PCSP_MAX_PERIOD_NS) {
 			printk(KERN_ERR "PCSP: Timer resolution is not sufficient "
-				"(%linS)\n", tp.tv_nsec);
+				"(%linS)\n", resolution);
 			printk(KERN_ERR "PCSP: Make sure you have HPET and ACPI "
 				"enabled.\n");
 			printk(KERN_ERR "PCSP: Turned into nopcm mode.\n");
@@ -59,13 +56,13 @@ static int snd_pcsp_create(struct snd_ca
 		}
 	}
 
-	if (loops_per_jiffy >= PCSP_MIN_LPJ && tp.tv_nsec <= PCSP_MIN_PERIOD_NS)
+	if (loops_per_jiffy >= PCSP_MIN_LPJ && resolution <= PCSP_MIN_PERIOD_NS)
 		min_div = MIN_DIV;
 	else
 		min_div = MAX_DIV;
 #if PCSP_DEBUG
 	printk(KERN_DEBUG "PCSP: lpj=%li, min_div=%i, res=%li\n",
-	       loops_per_jiffy, min_div, tp.tv_nsec);
+	       loops_per_jiffy, min_div, resolution);
 #endif
 
 	div = MAX_DIV / min_div;
