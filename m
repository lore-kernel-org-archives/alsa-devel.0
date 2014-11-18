From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: arizona: Add initial CS47L24 codec driver
Date: Tue, 18 Nov 2014 17:34:32 +0000
Message-ID: <20141118173432.GA28674@opensource.wolfsonmicro.com>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com> <20141111170543.GC25738@opensource.wolfsonmicro.com> <20141118145114.GN22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118145114.GN22111@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2014 at 02:51:14PM +0000, Mark Brown wrote:
> On Tue, Nov 11, 2014 at 05:05:43PM +0000, Richard Fitzgerald wrote:
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/codecs/Kconfig   |    8 +
> >  sound/soc/codecs/Makefile  |    2 +
> >  sound/soc/codecs/arizona.c |    5 +
> >  sound/soc/codecs/cs47l24.c | 1133 ++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/cs47l24.h |   23 +
> 
> Can you split out the arizona.c change into a separate patch to be
> merged via the MFD tree along with the new #define please?  Everything
> else can go in via the ASoC tree but that build depends on the new
> defines.

Will do. I'll wait until we've agreed what to do with the MFD tables
and then respin all these patches.

It's probably worth merging the set of WM8280/WM8281 support patches
first as they are simpler. Then I can rebase these CS47L24 patches
on top of that.

