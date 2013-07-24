From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Buffer size for ALSA USB PCM audio
Date: Wed, 24 Jul 2013 10:41:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307241013190.1313-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

I have been studying the data_ep_set_params() function in
sound/usb/endpoint.c.  This is the routine that calculates the number
of samples and I/O requests to keep on the USB hardware queue for PCM
audio, based on the ALSA parameters.

It uses the PERIOD_BYTES parameter but not BUFFER_BYTES.  In simplified
terms (ignoring rounding, boundary cases, and other things), the number
of periods per buffer is fixed at 24 for recording and 1 for playback,
completely ignoring the user's setting.  If you look at the parameters
copied in snd_usb_hw_params() in sound/usb/pcm.c, you'll see what I
mean.

Is this really the intended behavior?  It doesn't seem right at all.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
