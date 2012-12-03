From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] Missing exactly 3 of 8 audio packets?
Date: Mon, 3 Dec 2012 13:04:25 -0800
Message-ID: <20121203210425.GB11877@xanatos>
References: <50B4A870.7040201@gmail.com>
 <Pine.LNX.4.44L0.1211271213580.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1211271213580.1489-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Griscom <griscom-yI/1Hl18UA1Wk0Htik3J/w@public.gmane.org>, Alsa Developer <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 27, 2012 at 12:20:42PM -0500, Alan Stern wrote:
> The only thing that's strange is that there are so many dropped packets 
> and that they seem to fall into a small number of patterns.  This 
> strongly suggests hardware issues.  Daniel G., have you tried running 
> your tests on a different computer?  Preferably with a different brand 
> of motherboard?

What host controller were you running under?  I know that some xHCI host
controllers (NEC in particular) have pretty bad issues with missing
service intervals on isochronous transfers.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
