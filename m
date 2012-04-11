From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Wed, 11 Apr 2012 20:41:07 +0200
Message-ID: <4F85D043.2030905@ladisch.de>
References: <4F6769A9.6090200@citrix.com> <4F6881B6.2020903@ladisch.de>
	<4F69AA8B.3080409@citrix.com> <4F69D9B4.9000909@ladisch.de>
	<4F6B0B86.20603@citrix.com> <4F6B1665.6070402@ladisch.de>
	<4F85BA8E.3080805@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8B6F6248DB
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 20:41:22 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5D72F212C3
	for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2012 14:41:21 -0400 (EDT)
In-Reply-To: <4F85BA8E.3080805@citrix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefano Panella <stefano.panella@citrix.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stefano Panella wrote:
> To make echo cancellation work in the guest the guest needs to know
> exactly which sample in the buffer is going in and out, right?

Yes.  (Although many drivers don't bother to report the delay, and Skype
works anyway, but that's probably because the delay isn't too big anyway.)

> How can I design my alsa backend userspace program and the pv alsa
> kernel driver for the guest to do this?

Report the correct delay, i.e., in the pv pointer callback, call
snd_pcm_status() in the backend to get both DMA position and delay, and
compute from these the delay to set in runtime->delay.

(Well, I don't know if Skype actually uses the delay value ...)

> Is there any echo cancellation test program

None that I know of.

> What would be very critical in the guest pv alsa driver?
> - Should the first audio sample be played/captured right after the
>   trigger or it can happen at later time

In your pv trigger callback, you should ultimately call the backend
trigger, i.e., snd_pcm_start() etc.

How fast the first sample is played depends on the host sound driver
(and the latency of your pv->dom0 call).

> (runtime->delay maybe could be setted)?

You do not know if there is a constant delay or if it can change (as
with, e.g., the USB driver), so you should recompute the delay in the
pointer callback.

> - should the pointer callback reflect the sample being currently
>   played/captured?

No, it's the DMA position, i.e., the position in the buffer where the
application can read or write data.

> - what should the pointer callback return in case of a fixed delay in
>   playback and capture?

The callback's return value doesn't depend on the delay.  However, if
the delay changes, it must adjust runtime->delay.

> - do I need an interrupt every period triggered from the backend or
>   can I use the hrtimer as in the dummy sound card example?

The interrupts (i.e., the snd_pcm_period_elapsed() calls) must be
synchronized with the sample clock.  A period trigger is a guarantee
from the driver to the ALSA framework that
1) (at least) one period has elapsed since the last call, and
2) all the data in the period has been played, so the application
   can overwrite it with new data (i.e., the return value of the
   pointer callback is now at least at the end of the period).

The dummy driver uses a timer because there is no other clock, and what
is in the buffer doesn't actually matter for it.

You must ensure that a period_elapsed call in the pv driver does not
happen earlier than the corresponding period interrupt in the backend;
the easiest way to do this would be to connect them.

> -in order to only use the copy callback, and remove mmap support, what
> should I do?

Er, implement the copy callback (copy the indicated data from userspace
into the shared buffer, or the other way around), and drop the
SNDRV_PCM_INFO_MMAP* flags.  And you don't need to allocate a buffer in
the pv driver.

> On the backend application side:
> - how using dmix, dsnoop, asym plugins affects sample position
>   accuracy using snd_pcm_delay, snd_pcm_avail, snd_pcm_status_get_delay ?

The asym plugin just instantiates another plugin.

The dmix and dsnoop plugins just pass through snd_pcm_avail, but AFAICS
they do not report the delay at all.

> - how could I be woken up exactly every period using dmix, dsnoop,
>   asym plugins?

The dmix/dsnoop plugins get their interrupts from the base device; they
are woken up normally like any other type of device.

> all is working well but echo cancellation

Try with hw instead of dmix.  If that works, it would imply that echo
cancellation does not work with an unvirtualized dmix either, but I
don't know what device Skype actually opens.


Regards,
Clemens
