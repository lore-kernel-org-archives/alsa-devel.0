From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi driver -> kernel
Date: Thu, 20 Dec 2007 09:42:29 +1300
Message-ID: <47698235.5020403@audioscience.com>
References: <200709051300.35503.linux@audioscience.com>
	<s5hzm01tn8w.wl%tiwai@suse.de> <47141823.4000307@audioscience.com>
	<s5hbqaqrppa.wl%tiwai@suse.de> <47397615.4000201@audioscience.com>
	<475886C3.9070301@audioscience.com> <s5hve71dzqx.wl%tiwai@suse.de>
	<47671166.2050405@audioscience.com> <s5hlk7sxisi.wl%tiwai@suse.de>
	<476832F8.6070001@audioscience.com> <s5h1w9ix0zl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 192CC2463C
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 21:42:35 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JTB0015LDITKH10@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 20 Dec 2007 09:42:32 +1300 (NZDT)
In-reply-to: <s5h1w9ix0zl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks Takashi,

some comments interleaved below.

The spinlock issue is particularly thorny - if anyone can come up with a
better solution I'm all ears.

On the subject of "volatile", I'm looking for some concrete examples of
how to convert the volatile vars to use memory barriers.

The volatiles are all allocated with dma_alloc_consistent, and are
accessed via DMA by our card.  2 scenarios.
1) Write data to variable, interrupt card. How to ensure written data is
visible to card DMA before the card gets interrupt?

2) Wait for card to set a given status in the variable.  ?use smp_rmb()
in the loop?


Takashi Iwai wrote:

>>>> 1) Spinlock wrappers, the comments in the code tell why
>>>> /* The reason for all this evilness is that ALSA calls some of a drivers
>>>>  * operators in atomic context, and some not.  But all our functions channel
>>>>  * through the HPI_Message conduit, so we can't handle the different context
>>>>  * per function
>>>>  */
>>> Then this shouldn't be expressed as a spinlock wrapper.  You cannot
>>> use a single lock for that.  And the way you hack doesn't look correct
>>> for schedulable contexts...
>> AFAIK it works.
> 
> spin_lock_bh() is to protect data for user-context and softirqs...
> 
>>  We can do away with it if you can tell me how to stop
>> alsa midlevel calling HPI functions in both schedulable and
>> non-schedulable contexts.
> 
> Hm?  If you'd like to unify the call, then choose always the
> spin-locked version,
> 
> 	spin_lock_irqsave(&lock, flags);
> 	HPI_something();
> 	spin_unlock_irqrestore(&lock, flags);
> 
> It's fine to do this in user context (unless HPI_somthing() takes too
> long time).

There are some busy-wait loops talking to the HW, we really don't want
IRQs disabled there.

Currently its not structured like you suggest above.

we have
HPI_<object>_<action>() -> creates a HPI message.
   HPI_Message()  /* every message passes thru this gateway */
       some functions access HW, need spinlock
       some functions don't access HW, dont need lock

(E.g. hpi6205.c, the relevant lock is taken in HW_Message by
HpiOs_Dsplock_Lock().  But operations on busmaster streams never get
here, so can run in parallel - correct "good citizen" behaviour.)

Above this is alsa driver layer,  sometimes calling in atomic context,
sometimes not in atomic context.

Our cards dont use HW IRQ at all, so we don't want or need to disable
irq for our lock.

I believe it is wrong to use spin_lock_bh inside (alsa executed)
spin_lock_irqsave.  But because we have timer function (softirq), we
need spinlock_bh when not inside spin_lock_irqsave.

The current solution was arrived at after much wailing and gnashing of
teeth, and I'm loath to change it without very good reason.


Note also that pure HPI driver doesn't have this nasty wrapper, because
it doesn't have anything that disables irqs before calling HPI functions.

======

>>>> 2) LockedMem wrappers.  These provide tracking for the DMA areas
>>>> Need to keep track of all the info about the mem area so it can be freed

> OK, then we can leave as is.

...actually you prompted me to look for a simpler way, it will appear as
a patch some time.

(?the overhead for a slab cache is 4K to start with - right?, I will
exchange this for smaller overheads elsewhere for common usage)

======
>>>> E.g. pci_free_consistent(pMemArea->pdev, pMemArea->size,
>>>> 			pMemArea->cpu_addr, pMemArea->dma_addr);
>>> Use dma_alloc_coherent() / dma_free_coherent() instead.
>>> pci_*_consistent() are obsolete.

ah, ok will change it.

======

> The hwdep device can be set up to emulate (accept) HPI ioctls.  It's a
> matter of device name.

OK.  On this I have to say "show me the (pseudo)code", because I
wouldn't know where to start.

======

>>> struct hpi_handle has bitfields.  I think it's used very commonly in
> This struct is used for data communication between the hardware and
> the driver, no?

No.  It encapsulates up to 3 indices and an object type into 32 bits.
This is generated by hpifunc for say StreamOpen(), then is used again in
*the same compilation unit* by StreamStart() etc.
> Takashi


regards

Eliot
