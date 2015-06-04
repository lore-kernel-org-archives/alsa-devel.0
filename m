From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/7] ASoC: wm8903: generalize GPIO control register bits
Date: Thu, 4 Jun 2015 10:24:39 +0100
Message-ID: <20150604092439.GC3902@opensource.wolfsonmicro.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-3-git-send-email-vz@mleia.com> <CACRpkdaGf+oQA3OF5HnVGXh5exz2L8RSye1Fj=r-=wzsMay_ag@mail.gmail.com> <20150604091924.GZ14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150604091924.GZ14071@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Liam Girdwood <lgirdwood@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2015 at 10:19:24AM +0100, Mark Brown wrote:
> On Thu, Jun 04, 2015 at 10:30:10AM +0200, Linus Walleij wrote:
> 
> > > +#define WM8903_GPn_PU_MASK                      0x0004  /* GPn_PU */
> > > +#define WM8903_GPn_PU_SHIFT                          2  /* GPn_PU */
> > > +#define WM8903_GPn_PU_WIDTH                          1  /* GPn_PU */
> 
> > Pull-down/pull-up?
> 
> > That is pin control, not GPIO.
> 
> Those register definition defines are just an automatically generated
> dump of the complete CODEC register map, the GPIO pins have some pin
> control type functionality in there.
> 
> > I know I should probably be a bit relaxed on enforcing strict frameworks
> > on ASoC and DRI/DRM alike, because the drivers are complex and sometimes
> > need to be on top of things rather than split things apart and set up
> > complex cobwebs of subsystem cross-dependencies, but I'd
> > like to know a bit more about the design philisophy here.
> 
> > I guess this dates back to the time before the pin control subsystem?
> 
> There's that as well, but more generally I'm not sure if there's even
> any use of those defines for the driver (without looking at the source
> to check).

Many of the drivers contain a gpio defaults style entry in the
pdata, which basically is doing what pin control should be and
setting up the pulls/functions etc. But replacing that in all
the legacy CODECs would be a massive task.

Thanks,
Charles
