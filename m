From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ALSA Control Questions
Date: Thu, 3 Dec 2009 20:50:18 +0100
Message-ID: <20091203195018.GK14091@buzzloop.caiaq.de>
References: <4B1803CE.3080501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D983310388A
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 20:50:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B1803CE.3080501@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Schneider <tobsnyder@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 03, 2009 at 07:30:38PM +0100, Tobias Schneider wrote:
> 2. The more interesting question: as written in "Writing an alsa driver" 
> callbacks are basically not atomic, but I am getting  BUG: scheduling 
> while atomic: amixer/0x00000001/430 Call Trace: .[..] in "put" 
> callback?? So what is meant with "basically not atomic"?? What is 
> allowed and what is not allowed, am I able to get hardware interrupts in 
> this context?

That message basically means that you called a scheduling function while
you have preemption switched off. One common pitfall is to let the CPU
reschedule from an interrupt handler or while holding a spinlock.

The basic problem is that if you hold a spinlock and let the CPU do
something else, some other execution path (on the same CPU) could
also try to access the same lock which then deadlocks your system.

It all boils down to: from interrupt handlers or while you hold a
spinlock, you must never call any function that will sleep (and thereby
reschedule). Some functions such like kmalloc have a flag that you can
pass depending on whether you want it to allow to sleep (GFP_KERNEL)
or not (GFP_ATOMIC). If you necessarily _have_ to sleep from atomic
context, you must postpone your work using a work_struct or something
similar.

You should post your code so people can have a look.

HTH,
Daniel
