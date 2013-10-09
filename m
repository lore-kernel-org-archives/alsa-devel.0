From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Cannot load snd-usb-audio on 3.12-rc2
Date: Wed, 9 Oct 2013 13:01:08 -0700
Message-ID: <20131009200108.GA6136@xanatos>
References: <20130923234107.GA4876@xanatos>
 <s5hfvssdlo2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hfvssdlo2.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 26, 2013 at 10:36:29AM +0200, Takashi Iwai wrote:
> At Mon, 23 Sep 2013 16:41:07 -0700,
> Sarah Sharp wrote:
> > 
> > The snd-usb-audio driver no longer loads properly on 3.12-rc2 when I
> > plug in my USB headset.  It worked fine on 3.11-rc4 (not sure about
> > vanilla 3.11).
> > 
> > Trying to manually load the driver fails:
> > 
> > sarah@xanatos:~$ sudo modprobe snd-usb-audio
> > FATAL: Error inserting snd_usb_audio
> > (/lib/modules/3.12.0-rc2/kernel/sound/usb/snd-usb-audio.ko): Invalid argument
> > 
> > dmesg shows:
> > 
> > [   44.231668] snd_usb_audio: `-2' invalid for parameter `index'
> 
> There is no corresponding code change in the USB audio driver side, so
> I guess it must be in the module parameter parser that got broken.
> 
> Does the patch below fix?

Hi Takashi,

I didn't get around to applying the patch, but USB audio seems to be
fixed in 3.12-rc4.

Thanks!
Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
