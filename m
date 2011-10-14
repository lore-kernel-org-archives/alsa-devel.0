From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: ad193x: Fix define of AD193X_PLL_INPUT_MASK
Date: Fri, 14 Oct 2011 20:38:24 +0100
Message-ID: <20111014193823.GM2931@opensource.wolfsonmicro.com>
References: <1318582919.19976.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318582919.19976.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Barry Song <21cnbao@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 05:01:59PM +0800, Axel Lin wrote:
> Current code defines AD193X_PLL_INPUT_MASK as (~0x6) which is quite
> different from other MASK defines.
> To make it consistent with other mask defines, define AD193X_PLL_INPUT_MASK
> as 0x6 and change the code accordingly.
> I think this change improves the readability.

Applied, thanks.  For the ADI drivers please CC Lars-Peter.  Lars-Peter,
could you please send a MAINTAINERS update if you've not done so already
via some other tree?
