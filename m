From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] sound: usb: USB3 Super Speed patch
Date: Wed, 11 Aug 2010 11:36:58 +0200
Message-ID: <20100811093658.GN17833@buzzloop.caiaq.de>
References: <F6C4814A9B336243ABC3D1FB44E08AE8012C2846E3@US01WXMBX1.internal.synopsys.com>
 <4C624A15.206@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C624A15.206-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Paul Zimmerman <Paul.Zimmerman-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 11, 2010 at 08:58:29AM +0200, Clemens Ladisch wrote:
> Paul Zimmerman wrote:
> > This patch adds Super Speed support to the USB drivers under sound/. It adds
> > tests for USB_SPEED_SUPER to all the places that check for the USB speed.
> 
> > +++ b/sound/usb/midi.c
> > @@ -834,7 +834,8 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
> > +++ b/sound/usb/misc/ua101.c
> > +++ b/sound/usb/usx2y/us122l.c
> > +++ b/sound/usb/usx2y/usb_stream.c
> 
> These devices do not support super speed.
> 
> > +++ b/sound/usb/pcm.c
> > -	if (snd_usb_get_speed(subs->dev) != USB_SPEED_HIGH)
> > +	if (snd_usb_get_speed(subs->dev) != USB_SPEED_HIGH &&
> > +	    snd_usb_get_speed(subs->dev) != USB_SPEED_SUPER)
> >  		/* full speed devices have fixed data packet interval */
> >  		ptmin = 1000;
> 
> In places like this, it would be better to write something like
> 	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL)
> or
> 	if (snd_usb_get_speed(subs->dev) < USB_SPEED_HIGH)

Yep, or reconstruct the code to use switch-case statements.

Other than that, the patch looks fine to me.

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
