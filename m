From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: fsl: fix allyesconfig build for imx-pcm
Date: Wed, 6 Feb 2013 08:58:31 +0000
Message-ID: <201302060858.31510.arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de> <201302051642.25361.arnd@arndb.de> <20130206040212.GA18613@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130206040212.GA18613@S2101-09.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arm@kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 06 February 2013, Shawn Guo wrote:
> On Tue, Feb 05, 2013 at 04:42:25PM +0000, Arnd Bergmann wrote:
> > Patch 25b8d314 "ASoC: fsl: fix multiple definition of init_module changed
> > the Makefile for imx-pcm.ko to build two modules that both contain the
> > imx-pcm.c file, which nicely solves the problem of building both versions
> > of the driver as modules, but it causes two new problems:
> > 
> It's my fault, Arnd.  The patch 25b8d314 is a crap.  Instead of making
> the Kconfig even complexer, I chose to revert the patch and do a little
> surgery on the code to make it match the Kconfig rational.  The fix[1]
> should be on the way to mainline now.
> 
> I'm sorry for messing thing up during -rc time.
> 
> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.alsa.devel/105018
> 

Ok, again you were faster than I was at finding a solution, and the
new one looks good to me.

Thanks for taking care of this already,

	Arnd
