From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 13 Aug 2013 23:34:15 +0200
Message-ID: <520AA657.5010704@gmail.com>
References: <Pine.LNX.4.44L0.1308131659320.897-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308131659320.897-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Alan,

On 13.08.2013 23:06, Alan Stern wrote:
> On Mon, 12 Aug 2013, Alan Stern wrote:
>> On Mon, 12 Aug 2013, Takashi Iwai wrote:
>>
>>> So... Clemens, Daniel, Eldad, could you guys review the latest version
>>> of Alan's patch?  I'd love to sort this out for 3.12.
>>
>> Here's a revised version of the patch (still untested).  The difference
>> is that this version tries always to keep a period's worth of bytes in
>> the USB hardware queue.  This will provide better protection against
>> underruns when the period is larger than the queue's minimum
>> requirement.
> 
> After more thought, I decided that patch does too much.  It's not 
> necessary to keep track of the number of packets.  Instead, the driver 
> should always try to keep as much data in the USB hardware queue as it 
> is allowed to.
> 
> In other words, there should be enough URBs so that an entire ALSA 
> buffer can be queued at any time, subject only to the limit on the 
> maximum number of URBs and packets.  It doesn't make sense to allocate 
> just enough URBs to cover a single period.
> 
> Does this seem reasonable?

I think so, yes. But I'd like to comment on the actual patch, and also
give it a try first of course. It took me some days to gather my setup
again, but if you send a revised version, I hope to be able to test it
in the next days.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
