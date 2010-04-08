From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 8 Apr 2010 12:59:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004081257450.1720-100000@iolanthe.rowland.org>
References: <201004080812.04419.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201004080812.04419.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Apr 2010, Oliver Neukum wrote:

> Am Mittwoch, 7. April 2010 17:46:17 schrieb Alan Stern:
> > Or alternatively, instead of allocating regular memory the routine
> > could simply fail.  Then the caller would be responsible for checking
> > and using regular memory instead of dma-consistent memory.  Of course,
> > that would put an even larger burden on the caller than just forcing it
> > to keep track of what flag to use.
> 
> Then it would be sensible to pass it a filled URB, modify it or return
> an error code.

That would work, but it doesn't match the way existing drivers use the
interface.  For example, the audio driver allocates a 16-byte coherent
buffer and then uses four bytes from it for each of four different 
URBs.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
