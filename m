From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opl3: circular locking in the
 snd_opl3_note_on() and snd_opl3_note_off()
Date: Wed, 7 Oct 2009 22:51:34 +0200
Message-ID: <20091007225134.003bc0e7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 7059E103881
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 22:35:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix following circular locking in the opl3 driver.

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.32-rc3 #87
-------------------------------------------------------
swapper/0 is trying to acquire lock:
 (&opl3->voice_lock){..-...}, at: [<cca748fe>] snd_opl3_note_off+0x1e/0xe0 [snd_opl3_synth]

but task is already holding lock:
 (&opl3->sys_timer_lock){..-...}, at: [<cca75169>] snd_opl3_timer_func+0x19/0xc0 [snd_opl3_synth]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&opl3->sys_timer_lock){..-...}:
       [<c02461d5>] validate_chain+0xa25/0x1040
       [<c0246aca>] __lock_acquire+0x2da/0xab0
       [<c024731a>] lock_acquire+0x7a/0xa0
       [<c044c300>] _spin_lock_irqsave+0x40/0x60
       [<cca75046>] snd_opl3_note_on+0x686/0x790 [snd_opl3_synth]
       [<cca68912>] snd_midi_process_event+0x322/0x590 [snd_seq_midi_emul]
       [<cca74245>] snd_opl3_synth_event_input+0x15/0x20 [snd_opl3_synth]
       [<cca4dcc0>] snd_seq_deliver_single_event+0x100/0x200 [snd_seq]
       [<cca4de07>] snd_seq_deliver_event+0x47/0x1f0 [snd_seq]
       [<cca4e50b>] snd_seq_dispatch_event+0x3b/0x140 [snd_seq]
       [<cca5008c>] snd_seq_check_queue+0x10c/0x120 [snd_seq]
       [<cca5037b>] snd_seq_enqueue_event+0x6b/0xe0 [snd_seq]
       [<cca4e0fd>] snd_seq_client_enqueue_event+0xdd/0x100 [snd_seq]
       [<cca4eb7a>] snd_seq_write+0xea/0x190 [snd_seq]
       [<c02827b6>] vfs_write+0x96/0x160
       [<c0282c9d>] sys_write+0x3d/0x70
       [<c0202c45>] syscall_call+0x7/0xb

-> #0 (&opl3->voice_lock){..-...}:
       [<c02467e6>] validate_chain+0x1036/0x1040
       [<c0246aca>] __lock_acquire+0x2da/0xab0
       [<c024731a>] lock_acquire+0x7a/0xa0
       [<c044c300>] _spin_lock_irqsave+0x40/0x60
       [<cca748fe>] snd_opl3_note_off+0x1e/0xe0 [snd_opl3_synth]
       [<cca751f0>] snd_opl3_timer_func+0xa0/0xc0 [snd_opl3_synth]
       [<c022ac46>] run_timer_softirq+0x166/0x1e0
       [<c02269e8>] __do_softirq+0x78/0x110
       [<c0226ac6>] do_softirq+0x46/0x50
       [<c0226e26>] irq_exit+0x36/0x40
       [<c0204bd2>] do_IRQ+0x42/0xb0
       [<c020328e>] common_interrupt+0x2e/0x40
       [<c021092f>] apm_cpu_idle+0x10f/0x290
       [<c0201b11>] cpu_idle+0x21/0x40
       [<c04443cd>] rest_init+0x4d/0x60
       [<c055c835>] start_kernel+0x235/0x280
       [<c055c066>] i386_start_kernel+0x66/0x70

other info that might help us debug this:

2 locks held by swapper/0:
 #0:  (&opl3->tlist){+.-...}, at: [<c022abd0>] run_timer_softirq+0xf0/0x1e0
 #1:  (&opl3->sys_timer_lock){..-...}, at: [<cca75169>] snd_opl3_timer_func+0x19/0xc0 [snd_opl3_synth]

stack backtrace:
Pid: 0, comm: swapper Not tainted 2.6.32-rc3 #87
Call Trace:
 [<c0245188>] print_circular_bug+0xc8/0xd0
 [<c02467e6>] validate_chain+0x1036/0x1040
 [<c0247f14>] ? check_usage_forwards+0x54/0xd0
 [<c0246aca>] __lock_acquire+0x2da/0xab0
 [<c024731a>] lock_acquire+0x7a/0xa0
 [<cca748fe>] ? snd_opl3_note_off+0x1e/0xe0 [snd_opl3_synth]
 [<c044c300>] _spin_lock_irqsave+0x40/0x60
 [<cca748fe>] ? snd_opl3_note_off+0x1e/0xe0 [snd_opl3_synth]
 [<cca748fe>] snd_opl3_note_off+0x1e/0xe0 [snd_opl3_synth]
 [<c044c307>] ? _spin_lock_irqsave+0x47/0x60
 [<cca751f0>] snd_opl3_timer_func+0xa0/0xc0 [snd_opl3_synth]
 [<c022ac46>] run_timer_softirq+0x166/0x1e0
 [<c022abd0>] ? run_timer_softirq+0xf0/0x1e0
 [<cca75150>] ? snd_opl3_timer_func+0x0/0xc0 [snd_opl3_synth]
 [<c02269e8>] __do_softirq+0x78/0x110
 [<c044c0fd>] ? _spin_unlock+0x1d/0x20
 [<c025915f>] ? handle_level_irq+0xaf/0xe0
 [<c0226ac6>] do_softirq+0x46/0x50
 [<c0226e26>] irq_exit+0x36/0x40
 [<c0204bd2>] do_IRQ+0x42/0xb0
 [<c024463c>] ? trace_hardirqs_on_caller+0x12c/0x180
 [<c020328e>] common_interrupt+0x2e/0x40
 [<c0208d88>] ? default_idle+0x38/0x50
 [<c021092f>] apm_cpu_idle+0x10f/0x290
 [<c0201b11>] cpu_idle+0x21/0x40
 [<c04443cd>] rest_init+0x4d/0x60
 [<c055c835>] start_kernel+0x235/0x280
 [<c055c210>] ? unknown_bootoption+0x0/0x210
 [<c055c066>] i386_start_kernel+0x66/0x70

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
I am not sure if this is the only possible way to fix my the problem.
My idea is to change locking in the snd_opl3_timer_func() so the opl3 voices' part
is locked with voice_lock and the timer's part is locked with sys_timer_lock.

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 6e7d09a..1e76f7b 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -29,6 +29,8 @@ extern char snd_opl3_regmap[MAX_OPL2_VOICES][4];
 
 extern int use_internal_drums;
 
+static void snd_opl3_note_off_unsafe(void *p, int note, int vel,
+				     struct snd_midi_channel *chan);
 /*
  * The next table looks magical, but it certainly is not. Its values have
  * been calculated as table[i]=8*log(i/64)/log(2) with an obvious exception
@@ -242,16 +244,20 @@ void snd_opl3_timer_func(unsigned long data)
 	int again = 0;
 	int i;
 
-	spin_lock_irqsave(&opl3->sys_timer_lock, flags);
+	spin_lock_irqsave(&opl3->voice_lock, flags);
 	for (i = 0; i < opl3->max_voices; i++) {
 		struct snd_opl3_voice *vp = &opl3->voices[i];
 		if (vp->state > 0 && vp->note_off_check) {
 			if (vp->note_off == jiffies)
-				snd_opl3_note_off(opl3, vp->note, 0, vp->chan);
+				snd_opl3_note_off_unsafe(opl3, vp->note, 0,
+							 vp->chan);
 			else
 				again++;
 		}
 	}
+	spin_unlock_irqrestore(&opl3->voice_lock, flags);
+
+	spin_lock_irqsave(&opl3->sys_timer_lock, flags);
 	if (again) {
 		opl3->tlist.expires = jiffies + 1;	/* invoke again */
 		add_timer(&opl3->tlist);
@@ -658,28 +664,22 @@ static void snd_opl3_kill_voice(struct snd_opl3 *opl3, int voice)
 /*
  * Release a note in response to a midi note off.
  */
-void snd_opl3_note_off(void *p, int note, int vel, struct snd_midi_channel *chan)
+static void snd_opl3_note_off_unsafe(void *p, int note, int vel,
+				     struct snd_midi_channel *chan)
 {
-  	struct snd_opl3 *opl3;
-
 	int voice;
 	struct snd_opl3_voice *vp;
 
-	unsigned long flags;
-
-	opl3 = p;
+  	struct snd_opl3 *opl3 = p;
 
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "Note off, ch %i, inst %i, note %i\n",
 		   chan->number, chan->midi_program, note);
 #endif
 
-	spin_lock_irqsave(&opl3->voice_lock, flags);
-
 	if (opl3->synth_mode == SNDRV_OPL3_MODE_SEQ) {
 		if (chan->drum_channel && use_internal_drums) {
 			snd_opl3_drum_switch(opl3, note, vel, 0, chan);
-			spin_unlock_irqrestore(&opl3->voice_lock, flags);
 			return;
 		}
 		/* this loop will hopefully kill all extra voices, because
@@ -697,6 +697,16 @@ void snd_opl3_note_off(void *p, int note, int vel, struct snd_midi_channel *chan
 			snd_opl3_kill_voice(opl3, voice);
 		}
 	}
+}
+
+void snd_opl3_note_off(void *p, int note, int vel,
+		       struct snd_midi_channel *chan)
+{
+  	struct snd_opl3 *opl3 = p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&opl3->voice_lock, flags);
+	snd_opl3_note_off_unsafe(p, note, vel, chan);
 	spin_unlock_irqrestore(&opl3->voice_lock, flags);
 }
 
@@ -867,3 +877,4 @@ void snd_opl3_sysex(void *p, unsigned char *buf, int len,
 	snd_printk(KERN_DEBUG "SYSEX\n");
 #endif
 }
+


----------------------------------------------------------------------
Nie wiesz ktory bank wybrac?
Sprawdz ranking >>> http://link.interia.pl/f23b5
