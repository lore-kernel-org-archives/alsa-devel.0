From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 12:17:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004121214460.1702-100000@iolanthe.rowland.org>
References: <20100412154323.GP18855@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100412154323.GP18855-qrUzlfsMFqo/4alezvVtWx2eb7JE58TQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Apr 2010, Andi Kleen wrote:

> > Well, the sound driver itself doesn't care for any of those things, just
> > like any other USB driver doesn't. The USB core itself of the host
> > controller driver should do, and as far as I can see, it does that, yes.
> 
> Hmm, still things must go wrong somewhere. Perhaps need some instrumentation
> to see if all the transfer buffers really hit the PCI mapping functions.

Such a test has already been carried out earlier in this thread:

	http://marc.info/?l=linux-usb&m=127074587029353&w=2
	http://marc.info/?l=linux-usb&m=127076841801051&w=2
	http://marc.info/?l=linux-usb&m=127082890510415&w=2

> It might be interesting to test if the device works with enabled
> IOMMU. That would trigger any failures to properly map the buffers
> earlier.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
