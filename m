From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] ad1848 ac loop
Date: Thu, 20 Sep 2007 18:05:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709201419350.27377@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
	<20070919112413.70051500.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709191205330.27377@shell4.speakeasy.net>
	<20070919225521.116d1787.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10]) by alsa0.perex.cz (Postfix) with ESMTP id 8804A24390
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 03:05:30 +0200 (CEST)
In-Reply-To: <20070919225521.116d1787.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Sep 2007, Krzysztof Helt wrote:
> On Wed, 19 Sep 2007 12:50:54 -0700 (PDT)
> Trent Piepho <xyzzy@speakeasy.org> wrote:
> > On Wed, 19 Sep 2007, Krzysztof Helt wrote:
> > >  However, quick test showed that playback is stopped
> > >  from the irq handler if there is no more data (indirect register 9 write).
> >
> > Hmm, I don't see where that happens.  Unless snd_pcm_period_elapsed() is
> > allowed to call the trigger callback?  I know it will call the pointer
> > callback, which doesn't use any indirect registers.
> >
> > I know that trigger, ack, and pointer are called with interrupts disabled and
> > a spinlock held.  But that is not the same as being called from interrupt
> > context.
>
> I do not understand these two sentences so probably you are right.
> I can provide you backtrace how the snd_ad1848_trigger() is called:

You're right, it looks like trigger can be called from the irq handler.  It
looks like this:
irqhander
  snd_pcm_period_elapsed
    snd_pcm_update_hw_ptr_interrupt
      snd_pcm_update_hw_ptr_pos
        substream->ops->pointer(substream)
      snd_pcm_update_hw_ptr_post
        snd_pcm_playback_avail
          snd_pcm_drain_done
            snd_pcm_action_single(&snd_pcm_action_stop)
	      ops->do_action = snd_pcm_do_stop
	        substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP)

> > > > Another CPU could close the substream between the check and the call to
> > > > snd_pcm_period_elapsed().  snd_pcm_period_elapsed() could be called with
> > > > either NULL or a stale substream pointer depending on how the code compiled.
> > > > I'd think creating an irq spinlock would be an easy way to fix this.  The irq
> > > > handler would grab it, and the same with the open() and close() functions
> > > > around the code that sets the substream pointers.  Alternatively, one could
> > > > disabled the irq handler during open and close.
> > >
> > > I would not do this in the driver code. This should be handled in the alsa pcm layer
> > > and probably it is. At least the snd_pcm_period_elapsed() does locking and irq
> > > disabling. Could any alsa guru enlighten us on pcm open/close locking
> > > and interrupt disabling?
> >
> > I don't see how the alsa pcm layer could lock around the interrupt handler.
> > The handler is registered directly to the kernel, not via alsa, so there's no
> > way the alsa pcm layer could know if the irq handler is running, or if one
> > even exists.
>
> The pcm layer may disable interrupts. IMO, this should be enough to stop entering
> any interrupt handler.

The pcm layer can't disable interrupts before calling _any_ of the pcm ops.
When interrupts are disabled, there are things you can't do, like sleep or
call vmalloc.  Only the pointer, trigger, and ack pcm ops have interrupts
disabled.

It's also worth noting that only local interrupts are disabled, not global
interrupts.  Absent a spin-lock, an SMP system can still have an irq
handler run while another thread on another CPU has interupts disabled.

> I am not expert on this but following your reasoning any core kernel code
> (vm, scheduler) could not be interrupt-safe because most of interrupt handlers
> are in drivers and the core has no idea that drivers exist.

None of the variables used by drivers' interrupt handlers are modified by
the core kernel code.  In this case, chip->playback_substream and
chip->record_substream are the relevant variables.  They are used
non-atomically from the irq handler, so any code which modifies them must
be protected from the irq handler.
