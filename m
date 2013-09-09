From: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] question about webcam audio capture
Date: Mon, 9 Sep 2013 23:12:35 +0800
Message-ID: <CAOVJa8G2Om-eTinhA4BBeK+r9c6C5BvXu4cS7+RSJc=cVWgriA@mail.gmail.com>
References: <CAOVJa8GsD9aO1RyPL0a_e1CnxkMMRCjbHv9C1Bap7DC_yOTptQ@mail.gmail.com>
	<522DCF23.8090301@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <522DCF23.8090301-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

hi Clemens:

2013/9/9 Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>:
> vichy wrote:
>> I try to do webcam audio capture on my arm platform.
>> when I execute audio capture I got below message
>> "retire_capture_urb: 108 callbacks suppressed"
>
> This means that the retire_capture_urb() function printed lots of
> messages, and that 108 of them were thrown away because they were
> identical.
Does that mean:
1. 108 of messages are the same and through away
2. alsa get data from uac device through Host controller driver 108
times and find they are the same and through away

>You have to look at the previous line to get the actual
> message.
I try to  grep -rwn '"retire_capture_urb.*' sound/usb/*, but get nothing.
Would you please tell me what the "previous line to get the actual
message"  you mean?

>
>> 2. from usb mon log, it seems HW keep Active status high even until
>> ehci_io_watchdog happen, because the ep status is  -EXDEV.
>
> How are you trying to capture data?
I use the capture function in tinyalsa.

BTW, If I want to use number of urbs I expected and only send/complete
only 1 round, where I can find the source code to modify?


Thanks for your great help,
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
