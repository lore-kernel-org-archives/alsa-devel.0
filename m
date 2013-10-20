From: <baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] no reset_resume for driver snd-usb-audio for logitech
 headset H600
Date: Sun, 20 Oct 2013 23:18:13 +0200
Message-ID: <BLU0-SMTP81EAAFDB9BB4E4600757CCA1000@phx.gbl>
References: <BLU0-SMTP368B73167BF4C991BFDCE6A11C0@phx.gbl>	<Pine.LNX.4.44L0.1310081335400.1102-100000@iolanthe.rowland.org>	<s5hwqlmc1y7.wl%tiwai@suse.de>	<525516D5.6030200@ladisch.de>	<s5hob6ybyd3.wl%tiwai@suse.de> <s5hmwmiby8c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hmwmiby8c.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2013-10-09 11:16 (CEST,UTC+2), Takashi Iwai wrote:
>>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>>> index 9d9de8d..c591a83 100644
>>>> --- a/sound/usb/card.c
>>>> +++ b/sound/usb/card.c
>>>> @@ -747,6 +747,7 @@ static struct usb_driver usb_audio_driver = {
>>>>   	.disconnect =	usb_audio_disconnect,
>>>>   	.suspend =	usb_audio_suspend,
>>>>   	.resume =	usb_audio_resume,
>>>> +	.reset_resume =	usb_audio_resume,
>>>>   	.id_table =	usb_audio_ids,
>>>>   	.supports_autosuspend = 1,
>>>>   };

Shall I add the line in b/sound/usb/card.c and try it? Which kernel version shall I use?

+	.reset_resume =	usb_audio_resume,

Do you need further debugging information?

Thanks, Bernhard


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
