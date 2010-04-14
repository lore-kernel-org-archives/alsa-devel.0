From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 14 Apr 2010 10:08:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004141003170.1716-100000@iolanthe.rowland.org>
References: <t2w74fd948d1004140347k3447bffapb73856eacddfde55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <t2w74fd948d1004140347k3447bffapb73856eacddfde55-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Apr 2010, Pedro Ribeiro wrote:

> On 14 April 2010 11:09, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> 
> > Thanks! So the only thing I can do for now is submit exactly this patch.
> > At least, it helps you and it shouldn't break anything. The question
> > remains whether this type of memory should be used for all
> > transfer_buffers.
> >
> 
> Is there any chance you could push this to -stable? I don't care
> because I always use the latest kernel, but the next Debian stable and
> Ubuntu LTS are going to use 2.6.32.

No!  Please don't do it: Don't submit the patch and _certainly_ don't
submit it to -stable.  It doesn't fix anything; it only works around a
bug, and at the moment we don't even know if the bug is in the kernel
or in Pedro's hardware (and even though it affects two different
systems of his, nobody else has reported a similar problem).  Papering
over it will only remove the incentive to fix it properly.

In addition, you'll most likely find that lots of Linux developers will
object vociferously to any proposed patch that uses GFP_DMA.  That flag
is supposed to be _only_ for ISA devices, which really need it.  By 
limiting the memory allocation to the lowest 16 MB of physical memory, 
it greatly increases the chances that the allocation will fail.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
