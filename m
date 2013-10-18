From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Fri, 18 Oct 2013 15:27:40 +0100
Message-ID: <20131018142740.GY25034@n2100.arm.linux.org.uk>
References: <20130924124122.64834b2a@armhf> <20131018003439.GG2443@sirena.org.uk> <20131018103019.GW25034@n2100.arm.linux.org.uk> <20131018124832.GK2443@sirena.org.uk> <20131018125638.GX25034@n2100.arm.linux.org.uk> <20131018134829.GQ2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131018134829.GQ2443-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 18, 2013 at 02:48:29PM +0100, Mark Brown wrote:
> On Fri, Oct 18, 2013 at 01:56:38PM +0100, Russell King - ARM Linux wrote:
> 
> > Let me remind you that I had a definition of what a front end and a back
> > end DAI was from Liam, and your definition is at odds with that.
> 
> Could you please provide some detail on this?  I was aware that you were
> for a time confused about this but had not been aware of the source of
> the confusion.

Let's see:

16:10 < rmk> broonie: can you explain this pcm frontend/backend stuff in
	asoc. what exactly is a frontend and backend pcm, and how do they
	relate to the CPU hardware and codec links?  Which are the ones
	which are given ALSA PCMs?
17:22 < broonie> rmk: A front end is the bit that does DMA from memory, a
	back end is a physical interface.
17:22 < broonie> The bit in the middle is usually a DSP.
17:23 < broonie> To be frank I've not actually *used* this stuff myself
	except in bolting a new CODEC on the edge of it during system
	integrations - going to be rectifying that very soon with the
	Samsung drivers I hope.
17:24 < broonie> But the general idea is that the front end is what the
	application sees, the back end is what comes out of the hardware
	at the other end.
17:25 < broonie> And the bit in the middle does any routing an rewriting
	of formats between the two.
17:26 < broonie> (The Samsung picture should be very similar to Kirkwood
	but the opposite way around - two front ends mixed togther to a
	single back end)
...
16:49 < rmk> oh, another question
16:49 < rmk> .dynamic in the dai link structure, that's for backends only,
	right?
16:50 < broonie> Think so, yes.
16:52 < rmk> hmm
16:52 < rmk>         if (rtd->dai_link->dynamic) {
16:52 < rmk>                 rtd->ops.open           = dpcm_fe_dai_open;
16:52 < rmk> probably needed for frontends
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
