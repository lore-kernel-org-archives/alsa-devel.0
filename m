From: Andiry Xu <andiry.xu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 11 Aug 2011 11:22:21 +0800
Message-ID: <1313032941.1918.8.camel@brienza-desktop>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
	 <4E42A4AE.4020008@gmail.com>  <20110810231552.GA7194@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110810231552.GA7194@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Florian Mickler <florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-08-10 at 16:15 -0700, Sarah Sharp wrote:
> On Wed, Aug 10, 2011 at 05:33:02PM +0200, Daniel Mack wrote:
> > On 08/10/2011 04:32 PM, Alan Stern wrote:
> > >Looking at the driver's current code, it appears that your patch
> > >does not fix the bug properly.  Using discontiguous regions in the
> > >transfer buffer is perfectly okay.  The real problem is later on,
> > >where you do:
> > >
> > >if (send_it) { out->number_of_packets = FRAMES_PER_URB;
> > >
> > >This should be
> > >
> > >out->number_of_packets = outframe;
> > >
> > >The way it is now, the USB stack will try to use data from all the
> > >frame descriptors, and the last few will be stale because the loop
> > >doesn't set them.
> > 
> > That's actually true, even though it doesn't seem to cause any trouble.
> > I tested everything here of course, and the output URBs return back from
> > the USB stack with their length fields zeroed out, which then
> > causes the stack to send packets with zero-length fields at the end.
> 
> Actually, it causes system hangs when the driver is loaded on a device
> attached to a USB 3.0 port, as Alan Stern pointed out:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=40702
> 
> Please don't submit zero-length transfers.  The xHCI driver just isn't
> able to handle it.  Arguably, it probably should have just rejected your
> URB when it found a zero length buffer, so I'll probably be submitting a
> patch to fix that.
> 

I think queue a zero-length TRB to xhci host is OK. I've not tested it,
but the issue here seems is caused by td->last_trb = NULL. Check
count_isoc_trbs_needed(), num_trbs will be 0 if the packet length is
zero and (addr & (TRB_MAS_BUFF_SIZE - 1)) is zero. We can not return
num_trbs as 0 to xhci_queue_isoc_tx(), which caused a td added to ep's
td list, while it's not actually queued to ep ring and last_trb is not
set.

In order to avoid this, we just make sure count_isoc_trbs_needed()
always return 1 or larger numbers, instead of reject the urb. Is that
feasible?

Thanks,
Andiry


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
