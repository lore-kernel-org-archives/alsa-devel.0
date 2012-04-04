From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: UHCI dropped audio samples / DMA starvation fix
Date: Wed, 04 Apr 2012 22:54:34 +0200
Message-ID: <4F7CB50A.5090701@ladisch.de>
References: <CACrD=+9OSMrf1ghQdvQ7xP7gpXUvT2jkgNh+1qQ5Efem7wsZaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 057FB24761
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 22:54:44 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CF211217F6
	for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2012 16:54:41 -0400 (EDT)
In-Reply-To: <CACrD=+9OSMrf1ghQdvQ7xP7gpXUvT2jkgNh+1qQ5Efem7wsZaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Monty Montgomery <xiphmont@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Monty Montgomery wrote:
> UHCI overlaps sending on the USB bus with DMAing the data from memory.
> It does not have all the data it needs to transmit a complete packet
> before it begins doing so.  If the data it needs is in a dirty cache
> line on a CPU, the flush triggers after DMA is already started; the
> UHCI host controller has to wait for the flush before accessing it,

I've heard that the latest Intel architecture allows DMA to and from(?)
the L3 cache.

> and if the flush happens too late, UHCI aborts the packet.  This is
> happening regularly on all the UHCI controllers I've tried thusfar.
>
> My guess is that this issue never attracted much attention because a)
> every one knows isoch transfers are 'unreliable'

FireWire controllers show how this is done: read entire packets into a
FIFO, and do this several frames before sending.  (Whether that works in
practice depends on how big the FIFO is, and if the FIFO is shared with
asynchronous packets to be transmitted.)

I've never heard of a USB controller being advertized as having a big
FIFO.

The UHCI spec says:
| The Host Controller processes the schedule one entry at a time (this
| discussion does not preclude prefetching of schedule entries).
but then:
| The Host Controller fetches the next entry from the Frame List when
| the millisecond allotted to the current frame expires.

... so it is not actually possible to prefetch packets in a useful way.

The EHCI spec does not mention prefetching; the v1.1 addendum ("Energy-
efficient extensions") defines a mechanism to allow prefetching, but
this is not support by Linux.

> The fix for usbaudio is dead easy.  Call:
>
> clflush_cache_range(urb->transfer_buffer, urb->transfer_buffer_length);

... if you happen to be on an x86 architecture ...

> as the last step of prepare_playback_urb() and
> prepare_nodata_playback_urb().  This completely corrects the DMA
> starvation behavior on my machines here.
>
> Note that the clflush_cache_range() has nothing to do with
> maintaining coherency.

And this is the problem with portability; all the portable functions in
<asm/cacheflush.h> are NOPs on cache-coherent architectures.

It might be possible to define a new function like
flush_coherent_dcache_range_for_faster_dma().  Maybe this should be
called from into usb_hcd_map_urb_for_dma() or from the arch
implementation of dma_map_*() for DMA_TO_DEVICE.  For the latter, this
might be implemented as a new DMA attribute.

> Unfortunately, the URB abstraction gives us no reliable way to do it
> in the HCD, because other drivers don't necessarily pass a valid
> CPU-side buffer address when using URB_NO_TRANSFER_DMA_MAP.

But the USB API requires this (any HCD might use PIO or use its own
double-buffering scheme).

> Should I whip up some patches for usb audio for 2.6.x and 3.3.x

It easily fixes an actual problem, so yes, it's definitely stable-worthy.


Regards,
Clemens
