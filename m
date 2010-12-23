From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: tegra: Harmony machine support
Date: Thu, 23 Dec 2010 02:19:16 +0000
Message-ID: <20101223021916.GB25886@opensource.wolfsonmicro.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-11-git-send-email-swarren@nvidia.com>
	<20101217222636.GJ25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD7885D@HQMAIL01.nvidia.com>
	<20101217230618.GA28364@sirena.org.uk>
	<20101220211131.GG14986@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78E6C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CE052473F
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 03:19:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF030FD78E6C@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 05:13:20PM -0800, Stephen Warren wrote:
> Mark Brown wrote:

> > The below *completely untested* patch should get the FLL going, though
> > I really must emphasise the *completely untested* part - the patch


> Unfortunately, this doesn't seem to work for me.

Oh dear.  I did say it was completely untested :)

> I briefly investigated, and think the following code is required near the
> end of wm8903_hw_params() right before all the register write calls:

> 	if (wm8903->sysclk_src == WM8903_SYSCLK_FLL)
> 		clock1 |= WM8903_CLK_SRC_SEL_MASK;
> 	else
> 		clock1 &= ~WM8903_CLK_SRC_SEL_MASK;

> (plus some extra defines in the header for that field)

Yes, that's definitely needed at some point - good spot.

> As an aside, I was looking through the Tegra documentation, and in fact
> the cdev1 pin (which feeds the codec MCLK) can be sourced from pll_a,
> i.e. the same clock domain as the I2S bit clock. The existing kernel
> clock driver is simply missing the code to set this up.

OK, that's a better solution anyway as it uses less power - the only
reason to use the FLL if you can provide a good MCLK directly would be
to allow the CODEC to clock itself with the CPU completely off for jack
or button detection but that is fairly unusual (usually jack detection
wouldn't be a wake event).

> Again unfortunately, implementing and doing that doesn't solve the noise
> issue. I suppose I need to start probing the pins with a 'scope/analyzer
> to make sure of what's really coming out of Tegra. Pity they're so small
> and have no test points:-(

Does providing a good MCLK have any impact at all on the noise levels?
It might be interesting to try having the CODEC master the I2S bus - it
might not change anything, but it sometimes shows up if one of the clock
lines is misconfigured.

> P.S. In theory I'm on holiday/vacation until the 2nd. Perhaps I'll get
> bored and keep toying with this though...

Me too.  Once I'm back in the office I can test the code out with real
audio test equipment which might give some hints as to what is wrong
with the setup without having to probe.
