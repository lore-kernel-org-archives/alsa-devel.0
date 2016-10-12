From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 12:58:43 +0200
Message-ID: <1476269923.6699.20.camel@hadess.net>
References: <1476249011.6699.15.camel@hadess.net>
         <9449bd71-7766-5323-9fe8-30e954ca8f45@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9449bd71-7766-5323-9fe8-30e954ca8f45-sodqOivclbsO3cATojSK5Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-10-12 at 19:36 +0900, Takashi Sakamoto wrote:
> On Oct 12 2016 14:10, Bastien Nocera wrote:
> > My questions are:
> > - does the USB audio driver support jack sensing?
> > - is this something standard that's just not implemented yet? In
> > which
> > case, I'd be up for at least trying, given specs.
> > - or is it something that depends on the device, and in which case,
> > how
> > would I find out?
> 
> 
> In ALSA usb-related codes, there's no functions calls for
> snd_jack_*(),
> thus none of ALSA drivers for USB support Jack sense feature of ALSA
> control interface.
> 
> The requirement of Jack sense feature is whether hardwares support
> it.
> For example, some hardware codecs such as HDA codecs generates
> signals
> when plugs are insert to jacks connected to the codecs. Corresponding
> ALSA drivers catch the signals, then tell it to user land.
> 
> If your hardware performs like it, you have a probability to add
> support
> for jack sense feature to ALSA drivers for USB. But I don't know
> exactly
> that USB related specifications such as USB Audio Device Class
> 1.0/2.0/3.0 supports the feature.

Looks like whether or not jack sensing works depends on the device
itself, but there is a mechanism to propagate the change in setup in
the USB Audio 2.0 spec, in the "Interrupts" section:
"
A change of state in the audio function is most often caused by a
certain event that takes place. An event can either be user-initiated
or device-initiated. User-initiated jack insertion or removal is a
typical example of a user-initiated event.
"

I guess I should probably test in another operating system to check
whether the hardware I have supports this to start with, and go from
there.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
