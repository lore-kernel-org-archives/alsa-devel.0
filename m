From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 18:06:27 +0200
Message-ID: <4773bd69-4df9-00da-4fe6-3d5cbeda7b0a@ladisch.de>
References: <1476249011.6699.15.camel@hadess.net>
        <9449bd71-7766-5323-9fe8-30e954ca8f45@sakamocchi.jp>
        <1476269923.6699.20.camel@hadess.net>
        <b0df4e0b-5d46-f14d-133d-65d40623646e@ladisch.de>
        <1476286253.6699.26.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476286253.6699.26.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Bastien Nocera wrote:
> On Wed, 2016-10-12 at 14:43 +0200, Clemens Ladisch wrote:
>> Bastien Nocera wrote:
>>> "
>>> A change of state in the audio function is most often caused by a
>>> certain event that takes place. An event can either be user-
>>> initiated
>>> or device-initiated. User-initiated jack insertion or removal is a
>>> typical example of a user-initiated event.
>>> "
>>
>> There are not many USB Audio 2.0 devices, and I'm not aware of any
>> that actually implements this.
>
> I guess I would see whether there are events if I captured the USB
> traffic even without special handling/turning on a feature in the
> drivers, right?

Most devices do not even have the status endpoint (see "lsusb -v").
To check what events arrive, you can add logging to the
snd_usb_mixer_interrupt() function.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
