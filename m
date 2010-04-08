From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 22:10:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004072207390.18281-100000@netrider.rowland.org>
References: <4BBD1B6F.3000205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BBD1B6F.3000205-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Apr 2010, Robert Hancock wrote:

> >> The problem is appearantly the way the transfer buffer is allocated in
> >> the drivers. In the snd-usb-caiaq driver, I used kzalloc() to get memory
> >> which works fine on 32bit systems. On x86_64, however, it seems that
> >> kzalloc() hands out memory beyond the 32bit addressable boundary, which
> >> the DMA controller of the 32bit PCI-connected EHCI controller is unable
> >> to write to or read from. Am I correct on this conclusion?
> >
> > That seems like the right answer.  You are correct that an EHCI
> > controller capable only of 32-bit memory accesses would not be able to
> > use a buffer above the 4 GB line.

> AFAIK, the driver shouldn't have to worry about this at all. When the 
> buffer gets DMA-mapped for the controller, the DMA mapping code should 
> see that the device has a 32-bit DMA mask and either bounce or IOMMU-map 
> the memory so that it appears below 4GB.

That's true.  It would of course be more efficient for the buffer to be
allocated below 4 GB, but it should work okay either way.  Daniel, do
you have any idea why it fails?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
