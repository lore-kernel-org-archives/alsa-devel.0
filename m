From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Wed, 28 Aug 2013 08:41:50 +0200
Message-ID: <521D9BAE.2060508@ladisch.de>
References: <Pine.LNX.4.44L0.1308271608430.940-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308271608430.940-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> On Tue, 27 Aug 2013, Clemens Ladisch wrote:
>> Alan Stern wrote:
>>> On Tue, 27 Aug 2013, Clemens Ladisch wrote:
>>>> The current algorithm uses very short capture URBs to ensure that _some_
>>>> URB is completed as soon as possible after a period ends.
>>>> [...]
>>>> I'd suggest to keep the old calculation for capture URBs.  It would
>>>> make sense to use longer capture URBs only if the period size is
>>>> relatively large.
>>>
>>> Okay.  What about playback endpoints with implicit sync?  The current
>>> driver treats them the same as capture endpoints.  Is that really the
>>> right thing to do?
>>
>> The only reason to not have an interrupt after each packet is to avoid
>> the interrupt overhead (for both CPU and power); shorter URBs would
>> result in a more precise DMA position reported to user space.  If there
>> is already an interrupt for some capture URB (or for the feedback packet
>> in case of explicit feedback), we might as well handle the playback
>> packets so far.
>
> I don't quite understand.  Are you saying that playback endpoints with
> implicit sync may as well use the same values for urb_packs and
> ep->nurbs as other playback endpoints, rather than using the values
> calculated for capture endpoints (which is what the current driver
> does)?

Sorry, what I said applies more to explicit sync endpoints.  When using
implicit sync, a playback URB is submitted for each completed capture
URB, with the number of samples per packet identical to the
corresponding capture packet, so the parameters must be identical.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
