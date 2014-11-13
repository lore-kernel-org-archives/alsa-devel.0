From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] mfd: arizona: Add support for CS47L24
Date: Thu, 13 Nov 2014 16:40:17 +0000
Message-ID: <20141113164017.GA12443@opensource.wolfsonmicro.com>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com> <20141111171532.GA26106@opensource.wolfsonmicro.com> <20141113101228.GE24004@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141113101228.GE24004@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2014 at 10:12:28AM +0000, Lee Jones wrote:
> On Tue, 11 Nov 2014, Richard Fitzgerald wrote:
> 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> >  drivers/mfd/Kconfig              |    6 +
> >  drivers/mfd/Makefile             |    3 +
> >  drivers/mfd/arizona-core.c       |   91 ++-
> >  drivers/mfd/arizona-irq.c        |   42 +-
> >  drivers/mfd/arizona-spi.c        |    9 +
> >  drivers/mfd/arizona.h            |    5 +
> >  drivers/mfd/cs47l24-tables.c     | 1632 ++++++++++++++++++++++++++++++++++++++
> 
> No chance.
> 
> Please resend with these in a header file (like all of the others).
> 
> I'd also like Charles' Reviewed-by before accepting.

This looks good to me. I don't quite follow what you are
requesting with the header file? This still uses the header file
for the registers but just defining which are available on this
chip.

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
