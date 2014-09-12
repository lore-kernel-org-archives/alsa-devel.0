From: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb sound cannot get frequency from enpoind
Date: Fri, 12 Sep 2014 15:25:45 +0800
Message-ID: <CAOVJa8ExKBcFNpebScGjfZ9L=wVH4TaN=zN5rcMOTCNp__7CXg@mail.gmail.com>
References: <CAOVJa8ECMNHi5a-iFsk39E9JfKrA+CykrTa7Fh6AdyfTFqo_SQ@mail.gmail.com>
	<CAOVJa8Gyd_hbAmrmeYY9RorhMQUK8QnM0r3ySqdNfC_xWK73ng@mail.gmail.com>
	<541295A9.9080603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <541295A9.9080603-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

hi Clements:

2014-09-12 14:41 GMT+08:00 Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>:
> vichy wrote:
>>> ALSA sound/usb/clock.c:237 2:3:1: cannot get freq at ep 0x82
>>> ALSA sound/usb/mixer.c:929 5:2: cannot get min/max values for control 2 (id 5)
>>> ALSA sound/usb/mixer.c:929 5:2: cannot get min/max values for control 2 (id 5)
>>
>> (from the description, the ep 0x82 did have different sample rate
>> configuration, but why uac cannot get it?)
>
> This is likely to be a bug in the device's firmware.
How could we determine it?
is the any tool, log or experiments we can do to to show the bug
belongs to device not uac?

appreciate your kind help,
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
