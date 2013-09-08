From: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: question about webcam audio capture
Date: Sun, 8 Sep 2013 23:24:48 +0800
Message-ID: <CAOVJa8Epo9+7puHP-q2dOBhhuEmaScXP4aFX-g8m0VrB4dykSg@mail.gmail.com>
References: <CAOVJa8GsD9aO1RyPL0a_e1CnxkMMRCjbHv9C1Bap7DC_yOTptQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8GsD9aO1RyPL0a_e1CnxkMMRCjbHv9C1Bap7DC_yOTptQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

2013/9/8 vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> hi all:
> I try to do webcam audio capture on my arm platform.
> when I execute audio capture I got below message
> "retire_capture_urb: 108 callbacks suppressed"
>
> my questions:
> 1. where I can get the message "retire_capture_urb: 108 callbacks
> suppressed" show in sound/usb driver?
>     I try to  grep -rwn '"retire_capture_urb.*' sound/usb/*, but get nothing.
>
> 2. from usb mon log, it seems HW keep Active status high even until
> ehci_io_watchdog happen, because the ep status is  -EXDEV.
> if my observation is correct, is it possible to modify usb sound
> driver to purposely send fix number urbs.
> Because from the usb mon log, the first 8 urb will get time out already.
BTW, forget to say my kernel version is 3.8.2

>thanks for your help in advance,
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
