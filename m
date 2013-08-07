From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] 6fire: fix URB transfer buffer for midi output
Date: Wed, 7 Aug 2013 13:38:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308071334590.886-100000@iolanthe.rowland.org>
References: <s5hli4d5uj7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hli4d5uj7.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Torsten Schenk <torsten.schenk-ytc+IHgoah0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Aug 2013, Takashi Iwai wrote:

> [Cc'ed to linux-usb ML]
> 
> At Wed, 7 Aug 2013 16:51:49 +0200,
> Torsten Schenk wrote:
> > 
> > Patch fixes URB transfer buffer allocation for midi output to be DMA-able.
> 
> Is this really needed?
> That is, can't a transfer buffer be at middle of kmalloc'ed space, but
> must be always the head of the kmalloc'ed space?

A buffer _can_ be in the middle of a kmalloc'ed space, but the CPU must
not access any of the fields around it that might occupy the same cache
line while the buffer is being used for DMA.  In general, it's safest
not to put any other data in the same kmalloc'ed region with a DMA
buffer.

> > @@ -32,7 +28,7 @@
> >  	struct snd_rawmidi_substream *out;
> >  	struct urb out_urb;
> >  	u8 out_serial; /* serial number of out packet */
> > -	u8 out_buffer[MIDI_BUFSIZE];
> > +	u8 *out_buffer;
> >  	int buffer_offset;

In this case, the CPU would access out_urb while out_buffer was in use.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
