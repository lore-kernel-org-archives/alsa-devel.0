From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Use of start_frame in usbusx2yaudio.c
Date: Wed, 12 May 2010 08:21:37 -0700
Message-ID: <20100512152137.GA3358@xanatos>
References: <20100512051058.GA32459@xanatos>
 <Pine.LNX.4.44L0.1005121051040.1962-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005121051040.1962-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Lameter <cl-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 10:54:23AM -0400, Alan Stern wrote:
> On Tue, 11 May 2010, Sarah Sharp wrote:
> 
> > Are there any drivers in the kernel that set urb->start_frame on every
> > URB?
> > 
> > Could those drivers handle it if only the first URB they submitted to
> > the host controller was scheduled for that frame ID, and all the rest of
> > the URBs were scheduled ASAP?
> 
> BTW, urb->start_frame generally is ignored as an input parameter.  Many 
> host controller drivers pay no attention to it.  Unless someone has a 
> real reason, I think we are better off not using it.

Oh good.  In theory, the xHCI driver is supposed to be able to set the
starting frame ID of an isoc transfer (although the current patches for
isoc don't do that).  The xHCI spec writers were looking at limiting
software to only being able to set the frame ID on the very first
transfer you enqueue to the endpoint, to limit the complexity of the
hardware scheduler.  It looks like they won't have an issue with legacy
drivers if they do.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
