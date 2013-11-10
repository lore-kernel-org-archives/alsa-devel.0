From: <baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] no reset_resume for driver snd-usb-audio for logitech
 headset H600
Date: Sun, 10 Nov 2013 16:43:50 +0100
Message-ID: <BLU0-SMTP29704B99E3902B15F73DC41A1FC0@phx.gbl>
References: <BLU0-SMTP368B73167BF4C991BFDCE6A11C0@phx.gbl>	<Pine.LNX.4.44L0.1310081335400.1102-100000@iolanthe.rowland.org>	<s5hwqlmc1y7.wl%tiwai@suse.de>	<525516D5.6030200@ladisch.de>	<s5hob6ybyd3.wl%tiwai@suse.de>	<s5hmwmiby8c.wl%tiwai@suse.de>	<BLU0-SMTP81EAAFDB9BB4E4600757CCA1000@phx.gbl> <s5hr4bfpqwe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hr4bfpqwe.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

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

I have tested the patch with kernel 3.12.0 with suspend and hibernate, and the problem is gone.

No messages "no reset_resume for driver snd-usb-audio?" or other negative effects/messages.

After resume, the usb_audio_device (Headset) is the master channel in KDE Mixer, as it should be.

=> So the problem is solved for me.

Can you please add the patch to the latest kernels and LTS-kernels or whitelist the workaround for my device (ID 046d:0a29 Logitech, Inc. H600 [Wireless Headset])

Thanks, Bernhard


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
