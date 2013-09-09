From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] question about webcam audio capture
Date: Mon, 09 Sep 2013 22:22:57 +0200
Message-ID: <522E2E21.5090901@ladisch.de>
References: <CAOVJa8GsD9aO1RyPL0a_e1CnxkMMRCjbHv9C1Bap7DC_yOTptQ@mail.gmail.com>	<522DCF23.8090301@ladisch.de> <CAOVJa8G2Om-eTinhA4BBeK+r9c6C5BvXu4cS7+RSJc=cVWgriA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8G2Om-eTinhA4BBeK+r9c6C5BvXu4cS7+RSJc=cVWgriA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

vichy wrote:
> 2013/9/9 Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>:
>> vichy wrote:
>>> I try to do webcam audio capture on my arm platform.
>>> when I execute audio capture I got below message
>>> "retire_capture_urb: 108 callbacks suppressed"
>>
>> This means that the retire_capture_urb() function printed lots of
>> messages, and that 108 of them were thrown away because they were
>> identical.
>
> Does that mean:
> 1. 108 of messages are the same and through away

No, that at least 109 are the same.

>> You have to look at the previous line to get the actual
>> message.
>
> Would you please tell me what the "previous line to get the actual
> message"  you mean?

The previous line in the message log.

> tinycap record.wav -D 0 -d 0 -c 2 -r 32000

Try increasng -n or -p.

Does recoding on a PC with the same parameters work?


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
