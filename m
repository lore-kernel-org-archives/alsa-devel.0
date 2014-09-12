From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: usb sound cannot get frequency from enpoind
Date: Fri, 12 Sep 2014 08:41:45 +0200
Message-ID: <541295A9.9080603@ladisch.de>
References: <CAOVJa8ECMNHi5a-iFsk39E9JfKrA+CykrTa7Fh6AdyfTFqo_SQ@mail.gmail.com>
	<CAOVJa8Gyd_hbAmrmeYY9RorhMQUK8QnM0r3ySqdNfC_xWK73ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8Gyd_hbAmrmeYY9RorhMQUK8QnM0r3ySqdNfC_xWK73ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

vichy wrote:
>> ALSA sound/usb/clock.c:237 2:3:1: cannot get freq at ep 0x82
>> ALSA sound/usb/mixer.c:929 5:2: cannot get min/max values for control 2 (id 5)
>> ALSA sound/usb/mixer.c:929 5:2: cannot get min/max values for control 2 (id 5)
>
> (from the description, the ep 0x82 did have different sample rate
> configuration, but why uac cannot get it?)

This is likely to be a bug in the device's firmware.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
