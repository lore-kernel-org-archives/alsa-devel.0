From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] USB: rename usb_buffer_alloc() and usb_buffer_free()
Date: Tue, 13 Apr 2010 15:27:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004131525500.1551-100000@iolanthe.rowland.org>
References: <20100413181631.GT30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100413181631.GT30801-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 Apr 2010, Daniel Mack wrote:

> On Mon, Apr 12, 2010 at 01:17:25PM +0200, Daniel Mack wrote:
> > For more clearance what the functions actually do,
> > 
> >   usb_buffer_alloc() is renamed to usb_alloc_coherent()
> >   usb_buffer_free()  is renamed to usb_free_coherent()
> > 
> > They should only be used in code which really needs DMA coherency.
> > 
> > All call sites have been changed accordingly, except for staging
> > drivers.
> 
> Is this ok? As it's quite big, I think it should be merged soon if there
> are no objections.

I have no objection.  All it does is rename a couple of functions.  
There's no reason for this to go into 2.6.34; it can wait for the next 
merge window.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
