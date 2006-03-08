From: karsten wiese <annabellesgarden@yahoo.de>
Subject: RE: [Alsa-devel] Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Date: Wed, 8 Mar 2006 02:29:11 +0100 (CET)
Message-ID: <20060308012911.21985.qmail@web26501.mail.ukl.yahoo.com>
References: <20060307220628.GA27536@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-714349146-1141781351=:15006"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964874AbWCHB3T@vger.kernel.org>
In-Reply-To: <20060307220628.GA27536@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

--0-714349146-1141781351=:15006
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline


--- Ingo Molnar <mingo@elte.hu> schrieb:

> 
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> wrote:
> 
> > The symptoms are as follows:
> >   - start jack using qjackctl
> >   - start qsynth (gui front end for fluidsynth, a
> synth)
> >   - start rosegarden (midi sequencer and audio
> recorder)
> >   - load a midi file into rosegarden
> >   - midi file plays successfully
> >   - close rosegarden
> > at this point one of the threads of rosegarden fails to
> exit and stays
> > forever in the process list, in a ps axuw it shows as:
> > 
> > nando 5484 0.0 0.0 0 0 pts/1    D    13:32   0:00
> [rosegardenseque]
> > 
> > Anything else that I try to stop that touches the alsa
> sequencer never
> > dies (qjackctl, vkeybd, qsynth, etc). Anything I try to
> start that tries
> > to use it does not start. This happened with two widely
> different
> 
> could you get a tasklist-dump? It's either SysRq-T, or:
> 
> 	echo t > /proc/sysrq-trigger
> 
> that should dump all tasks and their backtraces -
> including the hung 
> rosegardensequencer task.
> 
I had similar symptoms here (FC4) and cured them with
attached patch against linux/2.6.15/rt18/kernel/softirq.c.
Its in rt19 and ++ i think.

      Karsten


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
--0-714349146-1141781351=:15006
Content-Type: text/x-diff; name="patch_rt-18___tasklet_common_schedule.diff"
Content-Description: 2951293989-patch_rt-18___tasklet_common_schedule.diff
Content-Disposition: inline; filename="patch_rt-18___tasklet_common_schedule.diff"

--- /tmp/softirq.c~	2006-02-28 20:17:03.000000000 +0100
+++ /tmp/softirq.c	2006-02-28 20:17:03.000000000 +0100
@@ -351,13 +351,13 @@
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
 
 static void inline
-__tasklet_common_schedule(struct tasklet_struct *t, struct tasklet_head *head)
+__tasklet_common_schedule(struct tasklet_struct *t, struct tasklet_head *head, unsigned int nr)
 {
 	if (tasklet_trylock(t)) {
 		WARN_ON(t->next != NULL);
 		t->next = head->list;
 		head->list = t;
-		raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		raise_softirq_irqoff(nr);
 		tasklet_unlock(t);
 	}
 }
@@ -367,7 +367,7 @@
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_vec));
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_vec), TASKLET_SOFTIRQ);
 	raw_local_irq_restore(flags);
 }
 
@@ -378,7 +378,7 @@
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_hi_vec));
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_hi_vec), HI_SOFTIRQ);
 	raw_local_irq_restore(flags);
 }
 

--0-714349146-1141781351=:15006--
