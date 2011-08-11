From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 11 Aug 2011 10:36:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108111027520.1958-100000@iolanthe.rowland.org>
References: <1313032941.1918.8.camel@brienza-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313032941.1918.8.camel@brienza-desktop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andiry Xu <andiry.xu-5C7GfCeVMHo@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Mickler <florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Aug 2011, Andiry Xu wrote:

> > Please don't submit zero-length transfers.  The xHCI driver just isn't
> > able to handle it.  Arguably, it probably should have just rejected your
> > URB when it found a zero length buffer, so I'll probably be submitting a
> > patch to fix that.
> > 
> 
> I think queue a zero-length TRB to xhci host is OK. I've not tested it,
> but the issue here seems is caused by td->last_trb = NULL. Check
> count_isoc_trbs_needed(), num_trbs will be 0 if the packet length is
> zero and (addr & (TRB_MAS_BUFF_SIZE - 1)) is zero. We can not return
> num_trbs as 0 to xhci_queue_isoc_tx(), which caused a td added to ep's
> td list, while it's not actually queued to ep ring and last_trb is not
> set.
> 
> In order to avoid this, we just make sure count_isoc_trbs_needed()
> always return 1 or larger numbers, instead of reject the urb. Is that
> feasible?

I just looked for the first time at the code in 
count_isoc_trbs_needed().  It does seem rather sub-optimal.

The basic idea is that you need to know how many TRB buffers can cover 
the memory area spanned by the packet data, where a TRB buffer's size 
cannot be larger than TRB_MAX_BUFF_SIZE and all but the first buffer 
must be aligned on a TRB_MAX_BUFF_SIZE boundary, right?  With a slight 
adjustment in the case of a zero-length packet, since you always need 
at least one TRB.

Given that the packet data starts at addr and has length td_len, the 
number of TRBs should be calculated as follows:

	num = DIV_ROUND_UP(td_len + (addr & (TRB_MAX_BUFF_SIZE - 1))), 
			TRB_MAX_BUFF_SIZE);
	num += (num == 0);

No need for a running_total or a loop.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
