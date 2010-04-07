From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 12:04:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004071157460.1779-100000@iolanthe.rowland.org>
References: <20100407155122.GA13974@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100407155122.GA13974-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Apr 2010, Greg KH wrote:

> > FWIW, most drivers I've seen in the past hours use a wild mix of
> > kmalloc(), kzalloc(), kcalloc() and usb_buffer_alloc(). That should
> > really be unified.

Well, kcalloc can easily be replaced by kzalloc, right?  Or the 
equivalent.

The extra overhead of initializing the memory to 0 isn't present in 
kmalloc, so we need to maintain the distinction between kmalloc and 
kzalloc.

However usb_buffer_alloc is fundmentally different from all the others.

> Yes, if it is necessary that we have to handle this type of crappy
> hardware, then it all needs to be unified.  Or at least unified into 2
> types of calls, one that needs the bounce buffer fun (what
> usb_buffer_alloc() does today), and one that doesn't (usb_kzalloc()
> perhaps?)

usb_buffer_alloc has very little to do with bounce buffers.  Its 
purpose is to allocate dma-consistent memory, that it, memory which 
does not need to be mapped for DMA before each I/O operation and 
unmapped afterward.

The mapping and unmapping operations aren't extremely time consuming,
so in general it makes sense to avoid them only when the _same_ buffer
is going to be used for many I/O operations during a short period of
time.  For instance, it makes sense for audio and video, where all the
data streams through a small set of buffers arranged in a ring.

But for most other uses it makes no sense.  Especially since some 
platforms have limited amounts of consistent memory available.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
