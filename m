From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] question about webcam audio capture
Date: Mon, 09 Sep 2013 15:37:39 +0200
Message-ID: <522DCF23.8090301@ladisch.de>
References: <CAOVJa8GsD9aO1RyPL0a_e1CnxkMMRCjbHv9C1Bap7DC_yOTptQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8GsD9aO1RyPL0a_e1CnxkMMRCjbHv9C1Bap7DC_yOTptQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

vichy wrote:
> I try to do webcam audio capture on my arm platform.
> when I execute audio capture I got below message
> "retire_capture_urb: 108 callbacks suppressed"

This means that the retire_capture_urb() function printed lots of
messages, and that 108 of them were thrown away because they were
identical.  You have to look at the previous line to get the actual
message.

> 2. from usb mon log, it seems HW keep Active status high even until
> ehci_io_watchdog happen, because the ep status is  -EXDEV.

How are you trying to capture data?


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
