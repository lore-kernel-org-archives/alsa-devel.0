From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 10:41:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004091033150.1852-100000@iolanthe.rowland.org>
References: <201004090804.36213.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201004090804.36213.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Apr 2010, Oliver Neukum wrote:

> Am Freitag, 9. April 2010 00:20:36 schrieb Alan Stern:
> > > > That would work, but it doesn't match the way existing drivers use the
> > > > interface.  For example, the audio driver allocates a 16-byte coherent
> > > > buffer and then uses four bytes from it for each of four different 
> > > > URBs.
> > > 
> > > That will not work with any fallback that does not yield a coherent buffer.
> > 
> > What you mean isn't entirely clear.  But it certainly does work in 
> > various circumstances that don't yield coherent buffers.  For example, 
> > it works if the controller uses PIO instead of DMA.  It also works if 
> > the controller uses DMA and the URBs have to be bounced.
> 
> It'll work on x86. On incoherent architectures this violates the cacheline
> rules for DMA-mapping if you have to bounce.

Not true.  Consider: The driver allocates a 16-byte buffer (xbuf)  
divided up into four sets of four bytes, and sets

	urb[i].transfer_buffer_dma = xbuf_dma + 4*i;

Then usb_submit_urb(urb[i]) will copy the appropriate four bytes to a
bounce buffer and map the bounce buffer.  Accesses to the other parts
of xbuf won't violate the cacheline rules, because xbuf isn't mapped
for DMA -- only the bounce buffer is.  When urb[i] completes, the
bounce buffer contents will be copied back to the original four bytes
in xbuf.  Again, there is no violation of cacheline rules.

> So it seems to me that
> if you want to share a buffer between URBs, it must be coherent.

No.  But it must be allocated via usb_alloc_buffer() (or whatever that 
routine gets renamed to).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
