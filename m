From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Missing exactly 3 of 8 audio packets?
Date: Tue, 27 Nov 2012 12:20:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211271213580.1489-100000@iolanthe.rowland.org>
References: <50B4A870.7040201@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B4A870.7040201-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Griscom <griscom-yI/1Hl18UA1Wk0Htik3J/w@public.gmane.org>, Alsa Developer <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Nov 2012, Daniel Mack wrote:

> > OK, this time I got some real results. I can still get the USB packet 
> > stream to misbehave, and indeed the synthesized data is being lost. 
> > The output data present on the USB bus smoothly increments during 
> > each packet, continuing smoothly in adjacent packets. But, when one 
> > or two packets are missed, the next output data is numbered as if the 
> > packets (6 stereo frames each) had been generated but lost.

That's how isochronous transfers are supposed to behave.  When data is
lost, it does not get retransmitted.

> > And, what should I look at next?
> 
> As Clemens said, check the error fields in the isochronous frames when
> the urb is given back to the driver. For isochronous data, there's
> nothing the driver can do about failed transmissions, hence there's no
> code to handle such conditions. But it might help understand what's
> going on.

There probably won't be any errors, but it's worth looking anyway.  
You never know...

> In any case, this now certainly looks more like a strange USB problem,
> rather than a bug in snd-usb.

The only thing that's strange is that there are so many dropped packets 
and that they seem to fall into a small number of patterns.  This 
strongly suggests hardware issues.  Daniel G., have you tried running 
your tests on a different computer?  Preferably with a different brand 
of motherboard?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
