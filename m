From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 18:54:55 +0200
Message-ID: <201004071854.55530.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1004071036060.1779-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, 7. April 2010 16:59:47 schrieb Alan Stern:
> > The fix is to use usb_buffer_alloc() for that purpose which ensures
> > memory that is suitable for DMA. And on x86_64, this also means that the
> > upper 32 bits of the address returned are all 0's.
> 
> That is not a good fix.  usb_buffer_alloc() provides coherent memory, 
> which is not what we want.  I believe the correct fix is to specify the 
> GFP_DMA32 flag in the kzalloc() call.
> 
> Of course, some EHCI hardware is capable of using 64-bit addresses.  
> But not all, and other controller types aren't.  In principle we could
> create a new allocation routine, which would take a pointer to the USB
> bus as an additional argument and use it to decide whether the memory 
> needs to lie below 4 GB.  I'm not sure adding this extra complexity 
> would be worthwhile.

What about XHCI? Do you really want to limit it to 32bits?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
