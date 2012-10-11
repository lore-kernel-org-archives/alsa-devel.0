From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: usb audio race at disconnect time
Date: Thu, 11 Oct 2012 12:01:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210111153110.1170-100000@iolanthe.rowland.org>
References: <5076E327.5030503@parrot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5076E327.5030503-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Oct 2012, Matthieu CASTET wrote:

> Hi,
> 
> while doing some monkey tests on a product we found races in usb audio code when
> the device in unplugged from usb (on linus master tree).
> 
> This can be reproduced with usb_audio_show_race.diff and CONFIG_DEBUG_SLAB.
> With this patch, start a stream :
> # arecord -D hw:0 -r 44100 -c 2  -f S16_LE > /dev/null
> you will see the kernel log : "in snd_usb_hw_params sleeping"
> Unplug the device before "in snd_usb_hw_params sleeping exit", and you will see
> an oops in snd_pcm_hw_params
> 
> 
> Instead of using CONFIG_DEBUG_SLAB, usb_audio_show_use_after_free.diff can show
> use after free by setting usb_device pointer to NULL in
> snd_usb_audio_disconnect. [1]
> 
> 
> In order to protect from all the races, before using any usb_device we need to
> check if it is not freed.

This should never be a problem.  Take a reference to the interface 
(usb_get_intf) and drop the reference (usb_put_intf) when you are 
finished accessing the usb_device structure.  This will prevent the 
usb_device from being deallocated while it is in use.

More important is a restriction you did not mention: Drivers are not 
allowed to communicate with a USB device after their disconnect routine 
has returned.

> What's the best way to do that ?

You could protect all occurrences of usb_submit_urb() with a spinlock.  
While holding the lock, check a flag to see if the disconnect routine
has been called.

In the disconnect routine, set this flag while holding the spinlock and 
then kill all the outstanding URBs.

I'm not very familiar with the snd-usb-audio driver; maybe it already 
does some of these things.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
