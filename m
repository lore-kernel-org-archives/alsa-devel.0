From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 10/11] ASoC: tegra: Harmony machine support
Date: Mon, 3 Jan 2011 11:39:32 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD79220@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-11-git-send-email-swarren@nvidia.com>
	<20101217222636.GJ25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD7885D@HQMAIL01.nvidia.com>
	<20101217230618.GA28364@sirena.org.uk>
	<20101220211131.GG14986@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78E6C@HQMAIL01.nvidia.com>
	<20101223021916.GB25886@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id E17F11038D5
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 20:41:15 +0100 (CET)
In-Reply-To: <20101223021916.GB25886@opensource.wolfsonmicro.com>
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
> On Wed, Dec 22, 2010 at 05:13:20PM -0800, Stephen Warren wrote:
> > As an aside, I was looking through the Tegra documentation, and in fact
> > the cdev1 pin (which feeds the codec MCLK) can be sourced from pll_a,
> > i.e. the same clock domain as the I2S bit clock. The existing kernel
> > clock driver is simply missing the code to set this up.
> 
> OK, that's a better solution anyway as it uses less power - the only
> reason to use the FLL if you can provide a good MCLK directly would be
> to allow the CODEC to clock itself with the CPU completely off for jack
> or button detection but that is fairly unusual (usually jack detection
> wouldn't be a wake event).
> 
> > Again unfortunately, implementing and doing that doesn't solve the noise
> > issue. I suppose I need to start probing the pins with a 'scope/analyzer
> > to make sure of what's really coming out of Tegra. Pity they're so small
> > and have no test points:-(
> 
> Does providing a good MCLK have any impact at all on the noise levels?
> It might be interesting to try having the CODEC master the I2S bus - it
> might not change anything, but it sometimes shows up if one of the clock
> lines is misconfigured.

Having the codec be master of the bit and frame clocks appears to completely
solve the noise issues. I do notice that different sample rates play the same
audio at different pitches though, so something is still wrong, but it's most
likely to be incorrect codec MCLK input right now; I'll keep investigating...

Thanks.

-- 
nvpublic
