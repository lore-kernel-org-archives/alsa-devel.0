From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: add interval timer support
Date: Fri, 17 Sep 2004 03:19:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095405566.19045.35.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: perex@suse.cz, tiwai@suse.cz
List-Id: alsa-devel@alsa-project.org

This patch adds the necessary functions to support the emu10k1's
interval timer.  The interval timer is the mechanism used by every other
known emu10k1 driver to generate the period interrupts for playback. 
These are ported from the OSS driver.

The card record, emu, maintains a linked list of timers, each containing
a pointer to a playback substream.  The open callback would install a
timer and the prepare callback would enable it; when the timer interrupt
fires, we walk the list of timers and call snd_pcm_period_elapsed for
any substreams whose timer has expired.  Supported intervals are 4-1024
sample periods.  The timer's tick rate is fixed at one sample period at
48KHZ, so you have to correct if using a different sample rate.

This patch does *not* change the behavior of the driver; it just adds
the necessary functions to install, uninstall, enable, disable, and set
the timer.  This is the first step to eliminating the extra voice; that
will be posted separately when it has been fully tested.

Lee

--

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.45
diff -u -r1.45 emu10k1.h
--- alsa/alsa-kernel/include/emu10k1.h	30 Jul 2004 12:57:24 -0000	1.45
+++ alsa-rlr/alsa-kernel/include/emu10k1.h	17 Sep 2004 06:47:36 -0000
@@ -779,6 +779,7 @@
 typedef struct _snd_emu10k1 emu10k1_t;
 typedef struct _snd_emu10k1_voice emu10k1_voice_t;
 typedef struct _snd_emu10k1_pcm emu10k1_pcm_t;
+typedef struct _snd_emu10k1_timer emu10k1_timer_t;
 
 typedef enum {
 	EMU10K1_PCM,
@@ -811,6 +812,7 @@
 	snd_pcm_substream_t *substream;
 	emu10k1_voice_t *voices[2];
 	emu10k1_voice_t *extra;
+	emu10k1_timer_t *timer;
 	unsigned short running;
 	unsigned short first_ptr;
 	snd_util_memblk_t *memblk;
@@ -1004,6 +1006,21 @@
 	emu10k1_midi_t midi2; /* for audigy */
 
 	unsigned int efx_voices_mask[2];
+
+	struct list_head	timers;
+	unsigned short		timer_delay;
+	spinlock_t		timer_lock;
+
+};
+
+struct _snd_emu10k1_timer 
+{
+	struct list_head list;
+	snd_pcm_substream_t *substream;
+	unsigned char state; 
+	unsigned short count;		/* current number of interrupts */
+	unsigned short count_max;	/* number of interrupts needed to call snd_pcm_period_elapsed */
+	unsigned short delay;           /* timer delay */
 };
 
 int snd_emu10k1_create(snd_card_t * card,
@@ -1077,6 +1095,18 @@
 int snd_emu10k1_fx8010_unregister_irq_handler(emu10k1_t *emu,
 					      snd_emu10k1_fx8010_irq_t *irq);
 
+/* interval timer */
+void snd_emu10k1_timer_install(emu10k1_t *emu, emu10k1_timer_t *timer, unsigned short delay);
+void snd_emu10k1_timer_uninstall(emu10k1_t *emu, emu10k1_timer_t *timer);
+void snd_emu10k1_timer_enable(emu10k1_t *emu, emu10k1_timer_t *timer);
+void snd_emu10k1_timer_disable(emu10k1_t *emu, emu10k1_timer_t *timer);
+void snd_emu10k1_timer_set(emu10k1_t *emu, unsigned short delay);
+
+#define TIMER_STOPPED 			0xffff 
+#define TIMER_STATE_INSTALLED 		0x01
+#define TIMER_STATE_ACTIVE		0x02
+#define TIMER_STATE_UNINSTALLED 	0x04
+
 #endif /* __KERNEL__ */
 
 /*
Index: alsa/alsa-kernel/pci/emu10k1/io.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/io.c,v
retrieving revision 1.7
diff -u -r1.7 io.c
--- alsa/alsa-kernel/pci/emu10k1/io.c	29 Jun 2004 16:10:33 -0000	1.7
+++ alsa-rlr/alsa-kernel/pci/emu10k1/io.c	17 Sep 2004 06:47:37 -0000
@@ -338,3 +338,153 @@
 
 	return (unsigned char) ans;
 }
+
+void emu10k1_timer_irqhandler(emu10k1_t *emu)
+{
+	emu10k1_timer_t *t;
+	struct list_head *entry;
+
+	spin_lock(&emu->timer_lock);
+
+	list_for_each(entry, &emu->timers) {
+		t = list_entry(entry, emu10k1_timer_t, list);
+
+		if (t->state & TIMER_STATE_ACTIVE) {
+			t->count++;
+			if (t->count == t->count_max) {
+				t->count = 0;
+				snd_pcm_period_elapsed(t->substream);
+			}
+		}
+	}
+
+	spin_unlock(&emu->timer_lock);
+
+	return;
+}
+
+void snd_emu10k1_timer_install(emu10k1_t *emu, emu10k1_timer_t *timer, unsigned short delay)
+{
+	emu10k1_timer_t *t;
+	struct list_head *entry;
+	unsigned long flags;
+
+	if (delay < 5)
+		delay = 5;
+
+	timer->delay = delay;
+	timer->state = TIMER_STATE_INSTALLED;
+
+	spin_lock_irqsave(&emu->timer_lock, flags);
+
+	timer->count_max = timer->delay / (emu->timer_delay < 1024 ? emu->timer_delay : 1024);
+	timer->count = timer->count_max - 1;
+
+	list_add(&timer->list, &emu->timers);
+
+	if (emu->timer_delay > delay) {
+		if (emu->timer_delay == TIMER_STOPPED)
+			snd_emu10k1_intr_enable(emu, INTE_INTERVALTIMERENB);
+
+		emu->timer_delay = delay;
+		delay = (delay < 1024 ? delay : 1024);
+
+		snd_emu10k1_timer_set(emu, delay);
+
+		list_for_each(entry, &emu->timers) {
+			t = list_entry(entry, emu10k1_timer_t, list);
+
+			t->count_max = t->delay / delay;
+			/* don't want to think much, just force scheduling 
+			   on the next interrupt */
+			t->count = t->count_max - 1;
+		}
+
+		printk("timer rate --> %u\n", delay);
+	}
+
+	spin_unlock_irqrestore(&emu->timer_lock, flags);
+
+	return;
+}
+
+void snd_emu10k1_timer_uninstall(emu10k1_t *emu, emu10k1_timer_t *timer)
+{
+	emu10k1_timer_t *t;
+	struct list_head *entry;
+	unsigned short delay = TIMER_STOPPED;
+	unsigned long flags;
+
+	if (timer->state == TIMER_STATE_UNINSTALLED)
+		return;
+
+	spin_lock_irqsave(&emu->timer_lock, flags);
+
+	list_del(&timer->list);
+
+	list_for_each(entry, &emu->timers) {
+		t = list_entry(entry, emu10k1_timer_t, list);
+
+		if (t->delay < delay)
+			delay = t->delay;
+	}
+
+	if (emu->timer_delay != delay) {
+		emu->timer_delay = delay;
+
+		if (delay == TIMER_STOPPED)
+			snd_emu10k1_intr_disable(emu, INTE_INTERVALTIMERENB);
+		else {
+			delay = (delay < 1024 ? delay : 1024);
+
+			snd_emu10k1_timer_set(emu, delay);
+
+			list_for_each(entry, &emu->timers) {
+				t = list_entry(entry, emu10k1_timer_t, list);
+
+				t->count_max = t->delay / delay;
+				t->count = t->count_max - 1;
+			}
+		}
+
+		printk("timer rate --> %u\n", delay);
+	}
+
+	spin_unlock_irqrestore(&emu->timer_lock, flags);
+
+	timer->state = TIMER_STATE_UNINSTALLED;
+
+	return;
+}
+
+void snd_emu10k1_timer_enable(emu10k1_t *emu, emu10k1_timer_t *timer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&emu->timer_lock, flags);
+	timer->state |= TIMER_STATE_ACTIVE;
+	spin_unlock_irqrestore(&emu->timer_lock, flags);
+
+	return;
+}
+
+void snd_emu10k1_timer_disable(emu10k1_t *emu, emu10k1_timer_t *timer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&emu->timer_lock, flags);
+	timer->state &= ~TIMER_STATE_ACTIVE;
+	spin_unlock_irqrestore(&emu->timer_lock, flags);
+
+	return;
+}
+
+void snd_emu10k1_timer_set(emu10k1_t *emu, unsigned short delay)
+{
+	/* Creative's driver locks and unlocks the card spinlock here; 
+	 * the ALSA driver does not have this lock. 
+	 * Callers already should have the timer_lock so this should 
+	 * not be needed */
+	outw(delay & TIMER_RATE_MASK, emu->port + TIMER);
+}
+




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
