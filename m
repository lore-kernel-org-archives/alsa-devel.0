From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] USB-sound: prevent kernel panic on disconnect
Date: Mon, 14 Feb 2011 09:54:01 +0100
Message-ID: <4D58EDA9.2020805@ladisch.de>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1102111737280.13739-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> On Fri, 11 Feb 2011, Sarah Sharp wrote:
> > I suspect it might be the audio driver, as someone on the alsa mailing
> > list suggested the USB sound driver can't handle when one isochronous
> > buffer in an URB has an error, but the URB status is 0.
> 
> I don't think that can happen.  The URB status won't be 0 unless all 
> the individual buffers have 0 status.

In any case, the driver would then just copy garbage samples out of the
buffer; this wouldn't affect the driver's data structures.

> > From: Pierre-Louis Bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > Note that this is only a work-around, it does not address the
> > root cause of this inconsistency between urbs and PCM states. The
> > dmesg below shows two calls to snd_urb_complete, the substream is
> > NULL and the state is either running or stopped. This doesn't make
> > any sense.
> > ...
> > ALSA urb.c:492: frame 0 active: -84
> > ALSA urb.c:197: cannot submit urb (err = -19)
> > ALSA urb.c:186: NULL substream (subs->running 1) <- How is this possible?
> > ALSA urb.c:186: NULL substream (subs->running 0)
> 
> It's most likely a matter of the device being disconnected but the
> device file still being open.

subs->pcm_substream == NULL happens only when the device file _has_
been closed.

> Perhaps not everything gets cleaned up the way it should when that
> happens.

There seems to be a race between snd_usb_pcm_close() and
snd_usb_stream_disconnect().  I think a mutex taken by both functions
should fix this; and all functions that check 'shutdown' probably need
serializing.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
