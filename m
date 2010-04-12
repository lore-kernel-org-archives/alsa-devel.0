From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 13:53:00 +0200
Message-ID: <20100412115300.GM18855@one.firstfloor.org>
References: <20100407090623.GN30807@buzzloop.caiaq.de> <Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org> <87sk719hbm.fsf@basil.nowhere.org> <20100412111439.GU30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100412111439.GU30801-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

> Which is exactly what usb_buffer_alloc() does already. So at least for
> x86 you say this is the right thing to do? However, we don't necessarily
> need coherent memory on other platforms, which is why I hessitate to
> enforce that type of memory for all transfer_buffer allocations.

Yes today it's faster at least.

Probably we should have better interfaces for this, but we don't.

> 
> > Or just use GFP_KERNEL and pci_map_* later.
> 
> The USB core does this already, but at least on Pedro's machine, this
> seems unsufficient. Unfortunately, I can't reproduce the issue yet, even
> with more than 4GB of RAM installed.

Then something must be broken in Pedro's system and likely other drivers
will also not work. I don't think it should be worked around in the USB layer.

-Andi
-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org -- Speaking for myself only.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
