From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 22:51:51 +0200
Message-ID: <201004092251.51739.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1004091114500.1852-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1004091114500.1852-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Freitag, 9. April 2010 17:15:43 schrieb Alan Stern:
> > > Then usb_submit_urb(urb[i]) will copy the appropriate four bytes to a
> > > bounce buffer and map the bounce buffer.  Accesses to the other parts
> > > of xbuf won't violate the cacheline rules, because xbuf isn't mapped
> > > for DMA -- only the bounce buffer is.  When urb[i] completes, the
> > > bounce buffer contents will be copied back to the original four bytes
> > > in xbuf.  Again, there is no violation of cacheline rules.
> > 
> > I think you are assuming that either every or no part of the buffer is mapped
> > for DMA in place. I don't think you can assume that.
> 
> Yes I can, because the code that makes this decision is part of 
> usbcore and it is under m

It seems to me that in usbcore you can positively know that a buffer
will be mapped. However if the mapping is not done in usbcore you
cannot know what the HCD driver will do to a buffer, in particular
you don't know whether it will be processed by PIO or mapped for
DMA.

Maybe I understand this wrongly. Which code exactly were you refering to?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
