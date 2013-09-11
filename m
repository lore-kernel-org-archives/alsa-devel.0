From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] alsa crash with =?windows-1252?Q?=93_ALSA_s?=
 =?windows-1252?Q?ound/usb/urb=2Ec=3A179_cannot_submit_urb_=28err?=
 =?windows-1252?Q?_=3D_-27=29=94_on_imx6q_sabrelite?=
Date: Wed, 11 Sep 2013 14:55:42 +0200
Message-ID: <5230684E.6030900@gmail.com>
References: <CAFT5LgLN2dWg9Pef5AHH9AFPv-1e_WAp=3J+LEdvYTCWjKXAhg@mail.gmail.com> <522C9061.5070303@gmail.com> <CAFT5LgKjrYhZ4=cQE7PVBut6L3RvFsR3B16PUUtvEC5cqZLwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFT5LgKjrYhZ4=cQE7PVBut6L3RvFsR3B16PUUtvEC5cqZLwpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ankit Agarwal <ankitgenius90-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 11.09.2013 14:53, Ankit Agarwal wrote:
> 
> On Sun, Sep 8, 2013 at 8:27 PM, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> <mailto:zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> 
>     On 02.09.2013 12:51, Ankit Agarwal wrote:
>     > I am using alsa pcm player to listen to audio. The alsa pcm
>     crashes with
>     > the error: ALSA sound/usb/urb.c:179 cannot submit urb (err = -27).
>     I am
>     > able to hear the data initially but when other transaction begins
>     on HID
>     > report endpoint, alsa crashes with the mentioned error.
> 
>     -27 == -EFBIG, which seems to relate to a scheduling problem on the bus,
>     and hence probably rather to a host controller bug than an issue with
>     snd-usb.
> 
>     > I am working on imx6q board with linux kernel-3.0.35. I am using Apple
>     > device to get the digital audio.
> 
>     Please try with a more recent kernel, and see if you can find the
>     location where EFBIG is initially reported.
> 
> 
> I have found that EFBIG is being reported by ehci-host controller. It is
> coming from file ehci-sched.c under iso_stream_schedule() function. The
> error is thrown when the controller tries to schedule the urb too far
> into the future, ie, there is overflow of the scheduled URBs. I might be
> happening because the URBs are not scheduled properly.

Ok. What about trying a newer kernel? The issue might be fixed already.

In any case, this does not seem related to snd-usb, so I copied the usb
list.


Daniel


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
