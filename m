From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Fri, 7 May 2010 13:42:34 +0200
Message-ID: <201005071342.34923.oneukum@suse.de>
References: <g2h74fd948d1004141820ladc1941eo732d059dd678df0a@mail.gmail.com> <20100507074855.GF30801@buzzloop.caiaq.de> <4BE3E1B9.5020602@ladisch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BE3E1B9.5020602-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Am Freitag, 7. Mai 2010 11:47:37 schrieb Clemens Ladisch:
> > In the particular case of audio drivers, though, the contents of the
> > buffers are likely to change after the submission. What we do here
> > is that we map the audio stream buffers which are used by ALSA to
> > the output URBs, so they're filled asychronously. Once the buffer is
> > actually sent out on the bus, it is believed to contain proper audio
> > date. If it doesn't, that's due to too tight audio timing or other
> > problems. This breaks once buffers are magically bounced in the
> > background.
> 
> At least the audio class and ua101 drivers don't do this and fill the
> buffers before they are submitted.
> 
> > So - long story short: these audio buffers need to be DMA coherent.
> 
> Does the USB API actually guarantee that all controllers use DMA, i.e.,
> that the buffers can be filled after submission?

No, you must not touch buffers after submission. This does not even
work if we use DMA, because on some architectures this violates
guarantees to the dma primitives. It cannot be done.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
