From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 10/11] ASoC: tegra: Harmony machine support
Date: Wed, 22 Dec 2010 17:13:20 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD78E6C@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-11-git-send-email-swarren@nvidia.com>
	<20101217222636.GJ25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD7885D@HQMAIL01.nvidia.com>
	<20101217230618.GA28364@sirena.org.uk>
	<20101220211131.GG14986@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 5554124701
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 02:13:28 +0100 (CET)
In-Reply-To: <20101220211131.GG14986@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> 
> On Fri, Dec 17, 2010 at 11:06:18PM +0000, Mark Brown wrote:
> 
> > I'll make sure the FLL is supported as soon as possible, and if we can
> > get these drivers working on Harmoney we could also do the machine
> > driver updates there.
> 
> The below *completely untested* patch should get the FLL going, though
> I really must emphasise the *completely untested* part - the patch
> needed a bit of rework for 2.6.36 and I spent longer than intended
> fighting with the Harmony rather than setting up my normal test system
> as the Harmony setup had looked like it'd work.

Mark,

Unfortunately, this doesn't seem to work for me.

I briefly investigated, and think the following code is required near the
end of wm8903_hw_params() right before all the register write calls:

	if (wm8903->sysclk_src == WM8903_SYSCLK_FLL)
		clock1 |= WM8903_CLK_SRC_SEL_MASK;
	else
		clock1 &= ~WM8903_CLK_SRC_SEL_MASK;

(plus some extra defines in the header for that field)

However, with that, all I hear is silence. That's the same thing as
happens when MCLK isn't provided at all, so I suppose there's something
else missing in the FLL programming too.

As an aside, I was looking through the Tegra documentation, and in fact
the cdev1 pin (which feeds the codec MCLK) can be sourced from pll_a,
i.e. the same clock domain as the I2S bit clock. The existing kernel
clock driver is simply missing the code to set this up.

Again unfortunately, implementing and doing that doesn't solve the noise
issue. I suppose I need to start probing the pins with a 'scope/analyzer
to make sure of what's really coming out of Tegra. Pity they're so small
and have no test points:-(

P.S. In theory I'm on holiday/vacation until the 2nd. Perhaps I'll get
bored and keep toying with this though...

-- 
nvpublic
