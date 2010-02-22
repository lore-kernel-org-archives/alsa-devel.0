From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 0/2] McBSP: OMAP3: Add sidetone feature
Date: Mon, 22 Feb 2010 10:35:26 -0800
Message-ID: <20100222183526.GN18786@atomide.com>
References: <1266841272-13135-1-git-send-email-ilkka.koskinen@nokia.com>
 <20100222143928.GA2133@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100222143928.GA2133@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ilkka Koskinen <ilkka.koskinen@nokia.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, eduardo.valentin@nokia.com, ext-Eero.Nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [100222 06:36]:
> On Mon, Feb 22, 2010 at 02:21:10PM +0200, Ilkka Koskinen wrote:
> > The first patch implements McBSP sidetone feature on OMAP3 while the second
> > one provides ALSA interface for using it.
> > 
> > The patch set is based on the patch Eduardo Valentin sent to alsa-devel
> > mailing list in October 2009. Channel gain control and enabling the sidetone
> > have been moved to ALSA interface as suggested in comments. 
> > 
> > These patches apply on top of Janusz Krzysztofik's McBSP register cache
> > patches in linux-omap-2.6.git
> 
> Both patches
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> too.

OK, I'll add them into omap for-next.

Regards,

Tony
