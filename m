From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 11:15:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004091114500.1852-100000@iolanthe.rowland.org>
References: <201004091650.31488.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201004091650.31488.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Apr 2010, Oliver Neukum wrote:

> Am Freitag, 9. April 2010 16:41:48 schrieb Alan Stern:
> > > It'll work on x86. On incoherent architectures this violates the cacheline
> > > rules for DMA-mapping if you have to bounce.
> > 
> > Not true.  Consider: The driver allocates a 16-byte buffer (xbuf)  
> > divided up into four sets of four bytes, and sets
> > 
> >         urb[i].transfer_buffer_dma = xbuf_dma + 4*i;
> > 
> > Then usb_submit_urb(urb[i]) will copy the appropriate four bytes to a
> > bounce buffer and map the bounce buffer.  Accesses to the other parts
> > of xbuf won't violate the cacheline rules, because xbuf isn't mapped
> > for DMA -- only the bounce buffer is.  When urb[i] completes, the
> > bounce buffer contents will be copied back to the original four bytes
> > in xbuf.  Again, there is no violation of cacheline rules.
> 
> I think you are assuming that either every or no part of the buffer is mapped
> for DMA in place. I don't think you can assume that.

Yes I can, because the code that makes this decision is part of 
usbcore and it is under my control.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
