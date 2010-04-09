From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 15:34:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004091529240.1852-100000@iolanthe.rowland.org>
References: <w2r74fd948d1004091119j9f33d8a6kc1824d9243abf38b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <w2r74fd948d1004091119j9f33d8a6kc1824d9243abf38b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Apr 2010, Pedro Ribeiro wrote:

> > The DMA pointers do indeed look sane. I wanted to take a deeper look at
> > this and set up a 64bit system today. However, I fail to see the problem
> > here. Pedro, how much RAM does your machine have installed?

> It has 4 GB.

That means DMA mapping cannot be the cause of the problem.  :-(

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
