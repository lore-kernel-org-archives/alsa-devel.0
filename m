From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] ad1848 ac loop
Date: Wed, 19 Sep 2007 12:50:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709191205330.27377@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
	<20070919112413.70051500.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail5.sea5.speakeasy.net (mail5.sea5.speakeasy.net
	[69.17.117.7]) by alsa0.perex.cz (Postfix) with ESMTP id 560F21037FD
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 21:50:56 +0200 (CEST)
In-Reply-To: <20070919112413.70051500.krzysztof.h1@gmail.com>
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
> On Tue, 18 Sep 2007 22:22:42 -0700 (PDT)
> Trent Piepho <xyzzy@speakeasy.org> wrote:
> > I'm not an expert on this chip by any means, but from looking at the code I
> > think there are few things that could be fixed.
> >
> > The reg_lock spinlock isn't acquired from the irq handler, as the handler
> > doesn't use any of the indirect registers.  I think this means that is isn't
> > necessary to use the irq disabling versions of the spin_lock functions with
> > reg_lock.
> >
>
> Normally, this is not true as at least counter registers are reloaded. This is not
> a case for the ad1848. However, quick test showed that playback is stopped
>  from the irq handler if there is no more data (indirect register 9 write).

Hmm, I don't see where that happens.  Unless snd_pcm_period_elapsed() is
allowed to call the trigger callback?  I know it will call the pointer
callback, which doesn't use any indirect registers.

I know that trigger, ack, and pointer are called with interrupts disabled and
a spinlock held.  But that is not the same as being called from interrupt
context.  AFAIK, only pointer via snd_pcm_period_elapsed() will be called from
interrupt context.

> > It does look like there is a different SMP race condition wrt the irq handler.
> > From snd_ad1848_interrupt():
> > 578         if ((chip->mode & AD1848_MODE_PLAY) && chip->playback_substream &&
> > 579             (chip->mode & AD1848_MODE_RUNNING))
> > 580                 snd_pcm_period_elapsed(chip->playback_substream);
> >
> > Another CPU could close the substream between the check and the call to
> > snd_pcm_period_elapsed().  snd_pcm_period_elapsed() could be called with
> > either NULL or a stale substream pointer depending on how the code compiled.
> > I'd think creating an irq spinlock would be an easy way to fix this.  The irq
> > handler would grab it, and the same with the open() and close() functions
> > around the code that sets the substream pointers.  Alternatively, one could
> > disabled the irq handler during open and close.
>
> I would not do this in the driver code. This should be handled in the alsa pcm layer
> and probably it is. At least the snd_pcm_period_elapsed() does locking and irq
> disabling. Could any alsa guru enlighten us on pcm open/close locking
> and interrupt disabling?

I don't see how the alsa pcm layer could lock around the interrupt handler.
The handler is registered directly to the kernel, not via alsa, so there's no
way the alsa pcm layer could know if the irq handler is running, or if one
even exists.
