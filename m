From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Mon, 10 May 2010 10:58:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005101049100.1626-100000@iolanthe.rowland.org>
References: <1273483265.372.3383.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273483265.372.3383.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: FUJITA Tomonori <fujita.tomonori-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>, daniel-rDUAYElUppE@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 10 May 2010, David Woodhouse wrote:

> On Mon, 2010-05-10 at 11:50 +0900, FUJITA Tomonori wrote:
> > On Fri, 7 May 2010 10:51:10 -0400 (EDT)
> > Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > 
> > > On Fri, 7 May 2010, Daniel Mack wrote:
> > > 
> > > > > At least the audio class and ua101 drivers don't do this and fill the
> > > > > buffers before they are submitted.
> > > > 
> > > > Gnaa, you're right. I _thought_ my code does it the way I described, but
> > > > what I wrote is how I _wanted_ to do it, not how it's currently done. I
> > > > have a plan to change this in the future.
> > > > 
> > > > So unfortunately, that doesn't explain it either. Sorry for the noise.
> > > 
> > > At one point we tried an experiment, printing out the buffer and DMA 
> > > addresses.  I don't recall seeing anything obviously wrong, but if an 
> > > IOMMU was in use then that might not mean anything.  Is it possible 
> > > that the IOMMU mappings sometimes get messed up for addresses above 4 
> > > GB?
> > 
> > You mean that an IOMMU could allocate an address above 4GB wrongly? If
> > so, IIRC, all the IOMMU implementations use dev->dma_mask and
> > dev->coherent_dma_mask properly. And the DMA address space of the
> > majority of IOMMUs are limited less than 4GB.
> 
> The Intel IOMMU code will use dev->dma_mask and dev->coherent_dma_mask
> properly. It is not limited to 4GiB, but it will tend to give virtual
> DMA addresses below 4GiB even when a device is capable of more; it'll
> only give out higher addresses when the address space below 4GiB is
> exhausted.

What I meant was: Is it possible that the IOMMU code will return a
virtual DMA address before 4 GB but will somehow forget to actually map
that address to the data buffer?

The problem goes away when Pedro boots with mem=4G.  And the dma_mask
value is set properly (in fact, the ehci-hcd driver currently doesn't
use 64-bit DMA at all).

If anyone wants to see the debug log entries showing the buffer and DMA
addresses, they are attached to this email message:

	http://marc.info/?l=linux-kernel&m=127076841801054&w=2

Either the data isn't getting written to the buffer correctly or else
the buffer isn't getting sent to the device correctly.  Can anybody
suggest a means of determining which is the case?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
