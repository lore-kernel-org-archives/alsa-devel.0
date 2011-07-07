From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 07 Jul 2011 14:14:00 +0200
Message-ID: <4E15A308.7080502@ladisch.de>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> I have to revisit an issue we've discussed in length around a year ago
> and which still remains unsolved. I've been getting feedback from more
> users of my driver snd-usb-caiaq who report the issue found in bug
> #15580 in the kernel bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=15580
> 
> Let me quickly summarize the current state of this issue as I see it.
> 
> The problem seems to be that certain 64bit chipsets can't deal with
> the fact that an URB's transfer_buffer is allocated with
> kmalloc(GFP_KERNEL). The effect is that kmalloc() is very likely to
> hand out memory which is not addressable by devices that are connected
> via 32bit PCI busses, such as EHCI controllers. In theory, DMA bounce
> buffers should be installed in such cases, or the IOMMU would be in
> charge to re-map these buffers to suitable locations, but for at least
> two people who have reported the issue, this obviously fails.

The problem is that snd-usb-caiaq modifies the URB buffer after
submission.

USB drivers must always be prepared to work with host controllers that
use double buffering.  (IIRC there are some exotic ones where the
hardware works only with internal SRAM.)  DMA mapping, if available, is
only an optimization.

> The question now is how to proceed. I see three possible ways.
> ...
> 3. re-activate the currently disabled functions
> usb_buffer_{map,unmap,sync} functions and let the USB stack do the
> memory mapping

This is the only way that allows bounce buffers to be copied at the
correct time.

> What really puzzles me is that this doesn't hit a lot more people with
> other drivers.

I don't think there is any other driver that relies on the buffer being
coherently DMA-mapped.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
