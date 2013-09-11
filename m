From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] alsa crash with =?windows-1252?Q?=93_ALSA_s?=
 =?windows-1252?Q?ound/usb/urb=2Ec=3A179_cannot_submit_urb_=28err?=
 =?windows-1252?Q?_=3D_-27=29=94_on_imx6q_sabrelite?=
Date: Wed, 11 Sep 2013 10:48:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1309111044200.1352-100000@iolanthe.rowland.org>
References: <5230684E.6030900@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5230684E.6030900-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ankit Agarwal <ankitgenius90-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Sep 2013, Daniel Mack wrote:

> On 11.09.2013 14:53, Ankit Agarwal wrote:
> > 
> > On Sun, Sep 8, 2013 at 8:27 PM, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> > <mailto:zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> > 
> >     On 02.09.2013 12:51, Ankit Agarwal wrote:
> >     > I am using alsa pcm player to listen to audio. The alsa pcm
> >     crashes with
> >     > the error: ALSA sound/usb/urb.c:179 cannot submit urb (err = -27).
> >     I am
> >     > able to hear the data initially but when other transaction begins
> >     on HID
> >     > report endpoint, alsa crashes with the mentioned error.
> > 
> >     -27 == -EFBIG, which seems to relate to a scheduling problem on the bus,
> >     and hence probably rather to a host controller bug than an issue with
> >     snd-usb.
> > 
> >     > I am working on imx6q board with linux kernel-3.0.35. I am using Apple
> >     > device to get the digital audio.
> > 
> >     Please try with a more recent kernel, and see if you can find the
> >     location where EFBIG is initially reported.
> > 
> > 
> > I have found that EFBIG is being reported by ehci-host controller. It is
> > coming from file ehci-sched.c under iso_stream_schedule() function. The
> > error is thrown when the controller tries to schedule the urb too far
> > into the future, ie, there is overflow of the scheduled URBs. I might be
> > happening because the URBs are not scheduled properly.
> 
> Ok. What about trying a newer kernel? The issue might be fixed already.

-EFBIG is still returned under the same circumstances as in earlier
kernels.  You can get more information about those errors if you enable
CONFIG_USB_DEBUG.

Starting in the 3.11 kernel, however, -EXDEV is no longer returned for
USB submission.  It would be a good idea to test with 3.11.  It also
would be a good idea to get a usbmon trace showing what happens when
the errors occur.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
