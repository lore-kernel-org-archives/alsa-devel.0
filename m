From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 09:50:14 -0700
Message-ID: <20100409165014.GC5184@xanatos>
References: <s5hhbnncflj.wl%tiwai@suse.de>
 <Pine.LNX.4.44L0.1004071452560.5760-100000@iolanthe.rowland.org>
 <20100408003313.GE4365@kroah.com>
 <4BBE6E57.6020600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BBE6E57.6020600-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 06:01:27PM -0600, Robert Hancock wrote:
> On 04/07/2010 06:33 PM, Greg KH wrote:
> >On Wed, Apr 07, 2010 at 03:13:11PM -0400, Alan Stern wrote:
> >>On Wed, 7 Apr 2010, Takashi Iwai wrote:
> >>
> >>>>Ok, I'll write some dummies for usb_malloc() and usb_zalloc() which
> >>>>will just call kmalloc() with GFP_DMA32 for now.
> >>>
> >>>Can't we provide only zalloc() variant?  Zero'ing doesn't cost much,
> >>>and the buffer allocation shouldn't be called too often.
> >>
> >>Linus specifically requested us to avoid using kzalloc in usbfs.  I
> >>can't find the message in the email archives, but Greg KH should be
> >>able to confirm it.
> >>
> >>As long as we're imitating kmalloc for one use, we might as well make
> >>it available to all.
> >>
> >>>>And while at it,
> >>>>usb_alloc_buffer() will be renamed to usb_alloc_consistent().
> >>>
> >>>Most of recent functions are named with "coherent".
> >>
> >>Yes, the terminology got a little confused between the PCI and DMA
> >>realms.  I agree, "coherent" is better.
> >>
> >>BTW, although some EHCI controllers may support 64-bit DMA, the driver
> >>contains this:
> >>
> >>	if (HCC_64BIT_ADDR(hcc_params)) {
> >>		ehci_writel(ehci, 0,&ehci->regs->segment);
> >>#if 0
> >>// this is deeply broken on almost all architectures
> >>		if (!dma_set_mask(hcd->self.controller, DMA_BIT_MASK(64)))
> >>			ehci_info(ehci, "enabled 64bit DMA\n");
> >>#endif
> >>	}
> >>
> >>I don't know if the comment is still true, but until the "#if 0" is
> >>removed, ehci-hcd won't make use of 64-bit DMA.
> >
> >I think someone tried to remove it recently, but I wouldn't let them :)
> >
> >What a mess, hopefully xhci will just take over and save the world from
> >this whole thing...

I hate to break it to you, but 64-bit DMA support is optional for an
xHCI implementation.  There's a bit in HCCPARAMS that tells whether the
host supports it (see the HCC_64BIT_ADDR macro in xhci.h).  The xHCI
driver currently doesn't do anything with that bit, although it should.
All the implementations I've seen do 64-bit DMA.

> True.. except for the fact that the xhci driver currently doesn't do
> 64-bit DMA either

What makes you think that?  I've seen URB buffers with 64-bit DMA
addresses.  I can tell when the debug polling loop runs and I look at
the DMA addresses the xHCI driver is feeding to the hardware:

Dev 1 endpoint ring 0:
xhci_hcd 0000:05:00.0: @71a49800 01000680 00080000 00000008 00000841

So the TRB at address 71a49800 is pointing to a buffer at address
0x0008000001000680.

If I'm setting a DMA mask wrong somewhere, or doing something else to
limit the DMA to 32-bit, then please let me know.

> nor does it support MSI even though the HW
> supports it (surprisingly enough the NEC Windows driver does, MSI-X
> even).

There's a patch from AMD to enable MSI-X.  The code was there, just
commented out because the early prototypes didn't do MSI-X.

> At this point only Intel likely knows how to do this
> properly, though, since AFAICS the spec isn't publicly available
> yet.

I have tried very hard to fix this, and will continue to do so.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
