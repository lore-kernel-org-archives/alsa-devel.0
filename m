From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Sat, 11 Dec 2004 03:22:14 +0100
Message-ID: <20041211032214.5121a003@mango.fruits.de>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	<1102712509.29919.46.camel@krustophenia.net>
	<20041211015610.1798af34@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041211015610.1798af34@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Dec 2004 01:56:10 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> > With Ingo's patches we actually have 3 levels of IRQ context, they
> > effectively add a level above the traditional "top half" which is just a
> > tiny asm routine to mark the IRQ thread runnable (if threaded) or
> > execute the "real" top half directly if nonthreaded.
> 
> I see. For the best estimate, the timestamp would have to be taken as
> soon as possible after the irq was raised. For this purpose alone it
> would be great if that tiny asm routine actually would do the
> timestamping, but i assume this would introduce some overhead (dunno, if
> 2 or 3 operations, or whatever is needed to read the TSC would really
> count, but with the number of irqs happening, it might be
> significant[??]). Also there would certainly extra code be needed to
> pass this info along to the next irq handler stage..

Oh, i almost forgot: Ingo has already posted a patch adding this to the
threaded irq handlers in recent RP kernels. ALSA could access it. But
making ALSA depend on a kernel feature of an experimental kernel might
be unwise (uneducated guess). 

Also this leaves the question of using a different timer source for the
timestamps in the case that TSC is unreliable open.

Is it sensible to require users of jackd to not use cpu freq scaling
during operation? If so, we could just settle on using the TSC.

Flo

* Ingo Molnar <mingo@elte.hu> wrote:

> the jackd IRQ timestamps are something different. We could record a
> timestamp in the tophalf handler, and let ALSA access it - the patch
> below implements this. [...]

new patch that actually compiles attached.

	Ingo

--- linux/kernel/irq/handle.c.orig	
+++ linux/kernel/irq/handle.c	
@@ -138,6 +138,11 @@ fastcall int handle_IRQ_event(unsigned i
 	return retval;
 }
 
+cycles_t irq_timestamp(unsigned int irq)
+{
+	return irq_desc[irq].timestamp;
+}
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -163,6 +168,7 @@ fastcall notrace unsigned int __do_IRQ(u
 		desc->handler->end(irq);
 		return 1;
 	}
+	desc->timestamp = get_cycles();
 
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
--- linux/include/linux/irq.h.orig	
+++ linux/include/linux/irq.h	
@@ -77,6 +77,7 @@ typedef struct irq_desc {
 	unsigned int irqs_unhandled;
 	struct task_struct *thread;
 	wait_queue_head_t wait_for_handler;
+	cycles_t timestamp;
 	raw_spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
 
@@ -101,6 +102,7 @@ extern int can_request_irq(unsigned int 
 extern void early_init_hardirqs(void);
 extern void init_hardirqs(void);
 extern void init_irq_proc(void);
+extern cycles_t irq_timestamp(unsigned int irq);
 #else
 static inline void early_init_hardirqs(void) { }
 static inline void init_hardirqs(void) { }



-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
