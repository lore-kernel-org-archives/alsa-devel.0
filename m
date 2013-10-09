From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] no reset_resume for driver snd-usb-audio for logitech
 headset H600
Date: Wed, 09 Oct 2013 10:41:57 +0200
Message-ID: <525516D5.6030200@ladisch.de>
References: <BLU0-SMTP368B73167BF4C991BFDCE6A11C0@phx.gbl> <Pine.LNX.4.44L0.1310081335400.1102-100000@iolanthe.rowland.org> <s5hwqlmc1y7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hwqlmc1y7.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> On Tue, 8 Oct 2013 baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=62691
>>>
>>> Summary: no reset_resume for driver snd-usb-audio for logitech headset H600
>
> How about simply applying the same resume for reset_resume like below?
>
> ---
>
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 9d9de8d..c591a83 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -747,6 +747,7 @@ static struct usb_driver usb_audio_driver = {
>  	.disconnect =	usb_audio_disconnect,
>  	.suspend =	usb_audio_suspend,
>  	.resume =	usb_audio_resume,
> +	.reset_resume =	usb_audio_resume,
>  	.id_table =	usb_audio_ids,
>  	.supports_autosuspend = 1,
>  };

When the device was reset, the state of all mixer controls has been
lost.  Disconnecting the card (the default behaviour without
reset_resume) is the correct thing to do in this situation.

Userspace should pick up the USB device again when it reappears.
(But it doesn't.  Is this a PulseAudio or a KDE problem?)

And why does the kernel whine about the lack of a callback that is
documented as being optional?


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
