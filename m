From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 8/8] sound/soc: introduce missing kfree
Date: Sat, 12 Sep 2009 13:58:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0909121357350.8557@pc-004.diku.dk>
References: <Pine.LNX.4.64.0909111822480.10552@pc-004.diku.dk>
 <20090912115029.GA14300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753734AbZILL67@vger.kernel.org>
In-Reply-To: <20090912115029.GA14300@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Sep 2009, Mark Brown wrote:

> On Fri, Sep 11, 2009 at 06:23:04PM +0200, Julia Lawall wrote:
> > From: Julia Lawall <julia@diku.dk>
> 
> > Error handling code following a kzalloc should free the allocated data.
> > Error handling code following an ioremap should iounmap the allocated data.
> 
> This doesn't seem to be a complete fix for the issue.  There are several
> other places where the function can fail but which don't do this cleanup
> - this may indicate a problem with the automatic analysis if it fails to
> spot the problem in the fixed code?
> 
> In general for this sort of issue I'd suggest considering adding the
> error handling using the goto unwind block style since that tends to be
> a bit more robust against forgotten error handling than adding unwind
> code at each error site.  It's also a bit more managable when the code
> is doing a series of allocations like this is.

OK, thanks for the suggestions.  I see that there is a return near the 
end:

	if (rc) {
		free_irq(psc_dma->irq, psc_dma);
		free_irq(psc_dma->capture.irq,
			 &psc_dma->capture);
		free_irq(psc_dma->playback.irq,
			 &psc_dma->playback);
		return -ENODEV;
	}

that I missed.  I will send a new patch, using the suggested goto style.

julia
