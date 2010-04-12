From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 19:22:33 +0200
Message-ID: <20100412172233.GR18855@one.firstfloor.org>
References: <20100412162947.GQ18855@one.firstfloor.org> <Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org> <20100412171507.GB30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100412171507.GB30801-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 07:15:07PM +0200, Daniel Mack wrote:
> On Mon, Apr 12, 2010 at 12:57:16PM -0400, Alan Stern wrote:
> > On Mon, 12 Apr 2010, Andi Kleen wrote:
> > > Hmm, thanks. But things must still go wrong somewhere, otherwise
> > > the GFP_DMA32 wouldn't be needed?
> > 
> > Indeed, something must go wrong somewhere.  Since Daniel's patch fixed
> > the problem by changing the buffer from a streaming mapping to a
> > coherent mapping, it's logical to assume that bad DMA addresses have
> > something to do with it.  But we don't really know for certain.
> 
> Given that - at least for non-64-aware host controllers - we want memory
> <4GB anyway for USB transfers to avoid DMA bouncing buffers, maybe we
> should just do that and fix the problem at this level? I already started
> to implement usb_[mz]alloc() and use it in some USB drivers.

If the area is not mapped correctly it will fail in other situations,
e.g. with an IOMMU active or in virtualized setups. So the bug
has to be eventually tracked down.

> 
> But even after all collected wisdom about memory management in this
> thread, I'm still uncertain of how to get suitable memory. Using
> dma_alloc_coherent() seems overdone as that type of memory is not
> necessarily needed and might be a costly good on some platforms. And as
> fas as I understand, kmalloc(GFP_DMA) does not avoid memory >4GB.

It does actually, but it only has 16MB to play with. Don't use it.
If anything use __get_free_pages(GFP_DMA32), but it's a x86-64 
specific code.

> Can anyone explain which is the right way to go?

The right thing would be to define a proper interface for it.

I had an attempt for it a couple of years ago with the mask allocator, 
but it didn't make it into the tree.

-Andi
-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org -- Speaking for myself only.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
