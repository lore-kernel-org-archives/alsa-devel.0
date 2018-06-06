From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: unnecessary test?
Date: Wed, 6 Jun 2018 22:06:28 +0900 (JST)
Message-ID: <alpine.DEB.2.20.1806062206070.4659@hadrien>
References: <alpine.DEB.2.20.1806062135430.4445@hadrien> <s5h4lignk0q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4lignk0q.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Wed, 6 Jun 2018, Takashi Iwai wrote:

> On Wed, 06 Jun 2018 14:39:05 +0200,
> Julia Lawall wrote:
> >
> > In the file sound/pci/ctxfi/cthw20k1.c, the function daio_mgr_dao_init
> > contains:
> >
> > set_field(&ctl->spoctl, SPOCTL_OS << (idx*8),
> >           ((conf >> 3) & 0x1) ? 2 : 2); /* Raw */
> >
> > Could the second argument just be 2?  It's true that the preceeding call
> > contains conf >> ..., but in a more useful way, so perhaps it could be
> > useful for uniformity?
>
> I guess this is a typo of "2 : 0".  The code seems toggling the
> control bit depending on the S/PDIF passthru mode.  It might be
> reversed, but I bet 1 for non-audio from a common sense.
>
> Ditto for cthw20k1.c.  This one is likely 1, not 2, though.

OK, should I send a patch?  I have no way to test it.

julia

>
>
> thanks,
>
> Takashi
>
