From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] USB-sound: prevent kernel panic on disconnect
Date: Fri, 11 Feb 2011 17:42:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>
References: <20110211222224.GA9588@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110211222224.GA9588@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Feb 2011, Sarah Sharp wrote:

> (Resending this, as the mail seems to have been eaten on the way to the
> linux-usb mailing list.)
> 
> Hi Pierre,
> 
> I'm forwarding this to the linux-usb mailing list, as they might have
> some insight into your issue.  I think this is a kernel issue since it
> involves a kernel crash.  It looks like an issue with UHCI or the USB
> audio driver.

I'd guess the audio driver, because that's where the crash occurs.

> I suspect it might be the audio driver, as someone on the alsa mailing
> list suggested the USB sound driver can't handle when one isochronous
> buffer in an URB has an error, but the URB status is 0.

I don't think that can happen.  The URB status won't be 0 unless all 
the individual buffers have 0 status.

>  I think Pierre
> is running with the latest alsa code, which perhaps triggers the crash?
> 
> But I'm not an alsa or a USB sound expert, so could Jaroslav, Takashi,
> or Clemens look at this issue?
> 
> Attached is Pierre's dmesg from the original crash, along with lsusb
> output.  Note that the patch below is supposed to be against
> sound/usb/urb.c.
> 
> Sarah Sharp
> 
> ----- Forwarded message from Pierre-Louis Bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> -----
> 
> Date: Wed,  9 Feb 2011 13:13:24 -0600
> From: Pierre-Louis Bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> Cc: bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
> 	Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: [PATCH] ALSA: usb - prevent kernel panic on disconnect
> 
> Fix 100% reproducible kernel panic when a USB audio device is
> disconnected during playback. When the PCM substream is NULL, any
> dereference causes a kernel panic. This isn't a recent problem, the crash
> happened with a 2.6.35 kernel as well
> 
> Note that this is only a work-around, it does not address the
> root cause of this inconsistency between urbs and PCM states. The
> dmesg below shows two calls to snd_urb_complete, the substream is
> NULL and the state is either running or stopped. This doesn't make
> any sense.
> 
> Thanks to Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> for her
> help.
> 
> usb 6-1: USB disconnect, address 16
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:492: frame 0 active: -84
> ALSA urb.c:197: cannot submit urb (err = -19)
> ALSA urb.c:186: NULL substream (subs->running 1) <- How is this possible?
> ALSA urb.c:186: NULL substream (subs->running 0)

It's most likely a matter of the device being disconnected but the
device file still being open.  Perhaps not everything gets cleaned up
the way it should when that happens.

Clemens is the best person to fix this.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
