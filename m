From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Use of start_frame in usbusx2yaudio.c
Date: Tue, 11 May 2010 22:10:58 -0700
Message-ID: <20100512051058.GA32459@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Lameter <cl-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Are there any drivers in the kernel that set urb->start_frame on every
URB?

Could those drivers handle it if only the first URB they submitted to
the host controller was scheduled for that frame ID, and all the rest of
the URBs were scheduled ASAP?

I see there are three drivers that set start_frame (while not setting
URB_ISO_ASAP):
 - drivers/isdn/hisax/st5481_d.c
 - drivers/usb/core/devio.c
 - sound/usb/usx2y/usbusx2yaudio.c

I'm not really sure what usbusx2yaudio.c is doing.  I think when one URB
completes, it sets the next URB's start_frame to the previous URB's
start_frame plus the number of URBs (2 by default) times the number of
packets (4 by default).  Isn't this basically like setting URB_ISO_ASAP?
I really can't tell what fall back method is if this submission fails.

What is usbusx2yaudio.c attempting to do?  I've tried to get an overall
picture of what it expects the isochronous scheduling to look like, but
I'm finding the driver a bit hard to read.

I'm not too worried about the other two drivers.  The code in st5481_d.c
seems to fall back fine to URB_ISO_ASAP if the submission with the
start_frame set failed.  devio.c is usbfs, and I can't tell what
userspace drivers do. (It could be argued that if they needed such tight
control over isoc, they should have written a kernel driver.)

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
