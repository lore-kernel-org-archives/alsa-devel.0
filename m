From: <baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Fwd: Re: [alsa-devel] no reset_resume for driver snd-usb-audio for
 logitech headset H600
Date: Sat, 11 Jan 2014 11:08:39 +0100
Message-ID: <BLU0-SMTP389A28B3B37C63ADEE0EE1AA1B20@phx.gbl>
References: <527FA9B6.3000403@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <527FA9B6.3000403-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

FWD:

Any news to the snd-usb-audio issue?

Thanks, Bernhard

Old Message:
-------------
I have tested the patch with kernel 3.12.0 with suspend and hibernate, and the problem is gone.

No messages "no reset_resume for driver snd-usb-audio?" or other negative effects/messages.

After resume, the usb_audio_device (Headset) is the master channel in KDE Mixer, as it should be.

=> So the problem is solved for me.

Can you please add the patch to the latest kernels and LTS-kernels or whitelist the workaround for my device (ID 046d:0a29 Logitech, Inc. H600 [Wireless Headset])

Thanks, Bernhard

On 2013-10-20 23:35, Takashi Iwai wrote:
> At Sun, 20 Oct 2013 23:18:13 +0200,
> <baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org> wrote:
>>
>> On 2013-10-09 11:16 (CEST,UTC+2), Takashi Iwai wrote:
>>>>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>>>>> index 9d9de8d..c591a83 100644
>>>>>> --- a/sound/usb/card.c
>>>>>> +++ b/sound/usb/card.c
>>>>>> @@ -747,6 +747,7 @@ static struct usb_driver usb_audio_driver = {
>>>>>>    	.disconnect =	usb_audio_disconnect,
>>>>>>    	.suspend =	usb_audio_suspend,
>>>>>>    	.resume =	usb_audio_resume,
>>>>>> +	.reset_resume =	usb_audio_resume,
>>>>>>    	.id_table =	usb_audio_ids,
>>>>>>    	.supports_autosuspend = 1,
>>>>>>    };
>>
>> Shall I add the line in b/sound/usb/card.c and try it? Which kernel version shall I use?
>
> It doesn't matter which kernel version is.
> The error message should disappear, but I don't know whether any other
> positive effect you get.  As Clemens pointed, there can be some
> negative effects by this, so it cannot be taken as is.  But at least,
> it'd be good to know the result...
>
>
> thanks,
>
> Takashi






--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
