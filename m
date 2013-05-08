From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 4/6] ASoC: ux500: Update tx tdm slots configuration
Date: Wed, 8 May 2013 13:32:10 +0200
Message-ID: <20130508113210.GA29130@balto.lan>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-5-git-send-email-fabio.baltieri@linaro.org>
 <20130508110149.GF7478@sirena.org.uk>
 <20130508111110.GD3459@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508111110.GD3459@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2013 at 12:11:10PM +0100, Lee Jones wrote:
> On Wed, 08 May 2013, Mark Brown wrote:
> 
> > On Wed, May 08, 2013 at 09:14:19AM +0200, Fabio Baltieri wrote:
> > > Update ab8500-codec and mop500_ab8500 tx slot configuration to reflect
> > > the actual one used by STE.  Also update a wrong comment in the process.
> > 
> > This seems wrong, the individual chip drivers should just be doing
> > whatever they're being told by the machine driver.  Sounds like there's
> > two fixes needed here - one is to change the TDM API so that the chip
> > drivers are just implementing configuration supplied by the machine
> > driver and the other is to change the configuration being done to
> > whatever is desired.
> 
> Do you mean that the original implementation is incorrect, or that
> this patch is doing the wrong thing? I think this patch is a bugfix
> rather than a opportunity to refactor the driver.

That's correct, the idea for this whole series was just to fix the
existing codebase so that it can be enabled and used for regression
testing, rather than mixing up bug fixes and code cleanups.

Fabio

-- 
Fabio Baltieri
