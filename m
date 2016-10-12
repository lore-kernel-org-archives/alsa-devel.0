From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [alsa-devel] Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 17:30:53 +0200
Message-ID: <1476286253.6699.26.camel@hadess.net>
References: <1476249011.6699.15.camel@hadess.net>
         <9449bd71-7766-5323-9fe8-30e954ca8f45@sakamocchi.jp>
         <1476269923.6699.20.camel@hadess.net>
         <b0df4e0b-5d46-f14d-133d-65d40623646e@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b0df4e0b-5d46-f14d-133d-65d40623646e-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-10-12 at 14:43 +0200, Clemens Ladisch wrote:
> Bastien Nocera wrote:
> > Looks like whether or not jack sensing works depends on the device
> > itself, but there is a mechanism to propagate the change in setup
> > in
> > the USB Audio 2.0 spec
> 
> 
> Some recent Windows 10 beta added partial support for USB Audio 2.0.
> Earlier Windowses implement only USB Audio 1.0, which does not
> mention
> jacks.
> 
> > "
> > A change of state in the audio function is most often caused by a
> > certain event that takes place. An event can either be user-
> > initiated
> > or device-initiated. User-initiated jack insertion or removal is a
> > typical example of a user-initiated event.
> > "
> 
> 
> There are not many USB Audio 2.0 devices, and I'm not aware of any
> that actually implements this.

I guess I would see whether there are events if I captured the USB
traffic even without special handling/turning on a feature in the
drivers, right?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
