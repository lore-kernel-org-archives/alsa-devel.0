From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Sun, 18 Aug 2013 18:56:14 +0200
Message-ID: <5210FCAE.3090103@ladisch.de>
References: <Pine.LNX.4.44L0.1308151136180.905-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308151136180.905-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> On Tue, 13 Aug 2013, Clemens Ladisch wrote:
>>> The difference is that this version tries always to keep a period's
>>> worth of bytes in the USB hardware queue.
>>
>> Having truncated URBs is possible only when URBs are shorter than one
>> period,
>
> No.  URBs are truncated when a full-sized URB would extend at least one
> packet beyond the end of a frame.

This thought was in the context of avoiding too-short queues.  When
there are multiple URBs per period, the queue is long enough anyway.

>> so I think that a queue length of at least two periods, together
>> with a minimum period size, should ensure the isochrounous scheduling
>> threshold.
>
> This depends on how long a period is.

In that patch, a period is guaranteed to be no smaller than the IST.

>> And while we're at it: the default number of packets per URB was chosen
>> before the driver had the ability to estimate the delay from the current
>> frame number; it should now be quite safe to increase it.
>
> I don't understand how this delay estimation is supposed to work, or
> what it is meant to accomplish.  Can you explain?

The "delay" is the difference between the time when a sample is written
by the application and when that sample is actually played, and is
important for things like A/V synchronization.  It depends on
1) the amount of samples already in the ring buffer;
2) any processing done by the driver; and
3) any processing done by the hardware.

Most drivers don't do any processing, and most of the hardware has very
low delays, so it is common for drivers to pretend 2) and 3) are zero.

snd-usb-audio computes 2) from the current number of packets in the
queue, with the progress estimated based on the current frame.  Without
this computation, it was desirable to have short URBs because the delay
would jump by a large amount whenever a URB was completed.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
