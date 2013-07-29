From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Mon, 29 Jul 2013 21:23:15 +0200
Message-ID: <51F6C123.7020407@gmail.com>
References: <Pine.LNX.4.44L0.1307291400450.1479-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1307291400450.1479-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 29.07.2013 20:20, Alan Stern wrote:
> data_ep_set_params() checks snd_usb_endpoint_implicit_feedback_sink() 
> in three places.  It looks like only the second place is correct.
> 
> Can you verify whether the other two are right, and explain to me if 
> they are?

Which version are you looking at? Eldad Zack recently posted work in
that area, but I can't seem to find them anywhere yet in the sound tree.
Takashi?

Eldad, as you're likely more into the detail right now - any oppinion on
Alan's findings?


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
