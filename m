From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 8 Apr 2010 13:07:43 +0200
Message-ID: <20100408110743.GP30807@buzzloop.caiaq.de>
References: <20100407090623.GN30807@buzzloop.caiaq.de>
 <20100407153154.GC13425@kroah.com>
 <20100407153551.GK30801@buzzloop.caiaq.de>
 <201004080809.11756.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201004080809.11756.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 08:09:11AM +0200, Oliver Neukum wrote:
> Am Mittwoch, 7. April 2010 17:35:51 schrieb Daniel Mack:
> > > Alan, any objection to just using usb_buffer_alloc() for every driver?
> > > Or is that too much overhead?
> > 
> > FWIW, most drivers I've seen in the past hours use a wild mix of
> > kmalloc(), kzalloc(), kcalloc() and usb_buffer_alloc(). That should
> > really be unified.
> 
> kmalloc() & friends != usb_buffer_alloc(). They do different things.

I know. I just believe that many developers used usb_buffer_alloc() even
though they don't really need coherent DMA memory. The function's name
is misleading, and copy'n paste does the rest.

> It makes no sense to unify them. If you really need an ordinary
> buffer DMA will surely work on, this needs a third primitive.

I think it will help a lot to rename usb_buffer_alloc() in the first
place and then reconsider where coherent memory is really needed.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
