From: Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Thu, 1 Aug 2013 19:11:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308011847560.1029@xoschi>
References: <Pine.LNX.4.44L0.1307291400450.1479-100000@iolanthe.rowland.org> <51F6C123.7020407@gmail.com> <s5hob9k5z0b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hob9k5z0b.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



On Tue, 30 Jul 2013, Takashi Iwai wrote:

> At Mon, 29 Jul 2013 21:23:15 +0200,
> Daniel Mack wrote:
> > 
> > On 29.07.2013 20:20, Alan Stern wrote:
> > > data_ep_set_params() checks snd_usb_endpoint_implicit_feedback_sink() 
> > > in three places.  It looks like only the second place is correct.
> > > 
> > > Can you verify whether the other two are right, and explain to me if 
> > > they are?
> > 
> > Which version are you looking at? Eldad Zack recently posted work in
> > that area, but I can't seem to find them anywhere yet in the sound tree.
> > Takashi?
> 
> I'm waiting for the revised patchset (for the issue in patch 9/10
> Clemens pointed).

Sorry for the delayed responses - I'm working on my free time, and that 
can be very sporadic.

I'll get around to that patchset on the weekend.

> > Eldad, as you're likely more into the detail right now - any oppinion on
> > Alan's findings?

Unfortunately I haven't read too deeply into that part of the code.
FWIW, I will take a closer look at the weekend.

Alan, let me know if you plan to post the patch as-is, I'll happily test 
it. 

Cheers,
Eldad
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
