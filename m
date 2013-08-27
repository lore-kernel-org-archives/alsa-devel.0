From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 27 Aug 2013 12:53:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308271250290.1810-100000@iolanthe.rowland.org>
References: <CABRv+91ZGMHbHZFW0gYOL-zGP=HbmiJU51z-_C_2Jj+5ATisrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABRv+91ZGMHbHZFW0gYOL-zGP=HbmiJU51z-_C_2Jj+5ATisrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Aug 2013, James Stone wrote:

> This does not help at all with running jackd at lower latencies.
> 
> With this patch, I get xruns at 128 frames/period or less with jackd
> (accompanied by iso underrun messages), whereas with vanilla 3.10.9
> (which now has both yours and Clemen's patches applied), performance
> is extremely good (64 frames per period possible).

Was this was both recording and playback, or playback only?  If you 
were doing both, what happens with just playback?

Assuming you see the same problem with just playback, please collect a 
usbmon trace showing one or two of those underruns at say 64 
frames/period.  And for comparison, it would be nice to have a usbmon 
trace showing a couple of seconds of normal operation under 
vanilla 3.10.9.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
