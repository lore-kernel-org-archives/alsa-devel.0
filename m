From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Cannot load snd-usb-audio on 3.12-rc2
Date: Tue, 24 Sep 2013 17:52:00 +0200
Message-ID: <5241B520.7010803@gmail.com>
References: <20130923234107.GA4876@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923234107.GA4876@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Sarah,

On 24.09.2013 01:41, Sarah Sharp wrote:
> The snd-usb-audio driver no longer loads properly on 3.12-rc2 when I
> plug in my USB headset.  It worked fine on 3.11-rc4 (not sure about
> vanilla 3.11).
> 
> Trying to manually load the driver fails:
> 
> sarah@xanatos:~$ sudo modprobe snd-usb-audio
> FATAL: Error inserting snd_usb_audio
> (/lib/modules/3.12.0-rc2/kernel/sound/usb/snd-usb-audio.ko): Invalid argument
> 
> dmesg shows:
> 
> [   44.231668] snd_usb_audio: `-2' invalid for parameter `index'

That's really strange. I just tested on an ARM board where I currently
run 3.12-rc2 as well, and I can load the module without problems. Also,
sound/usb/card.c (where the params are declared) hasn't seen an update
in 3.12.

I suspect your OS is passing "index=-2" from something like
/etc/modprobe.d/* or cmdline settings. Could you investigate in that
direction?


HTH,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
