From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 3 Sep 2013 10:04:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1309030958270.1063-100000@iolanthe.rowland.org>
References: <CABRv+93oVW0rDEJnNeGyfqem2PM42b28-z9q+Ze8r7rky7szDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABRv+93oVW0rDEJnNeGyfqem2PM42b28-z9q+Ze8r7rky7szDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Aug 2013, James Stone wrote:

> At 32 frames/period (reported round-trip latency 1.33ms), it starts up
> but there are too many xruns for it to be usable.

After further testing (off-list), it turns out that 32 frames/period
works okay with three periods/buffer instead of two.  Not surprising
really; with two periods you get only two URBs, and whenever one of 
them completes, the other isn't long enough to exceed the scheduling 
threshold.

In summary, it now appears that the most recent patch works better than
the current driver.

> > Daniel and Eldad, more testing of the most recent proposed patch would
> > be welcome.

Yes, please, more testing is needed.  I intend to submit the patch 
when the current merge period ends.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
