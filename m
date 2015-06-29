From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: update pll and clock setting
	function
Date: Mon, 29 Jun 2015 10:44:12 +0100
Message-ID: <20150629094412.GH6321@opensource.wolfsonmicro.com>
References: <5630bd343217e8fa895c5d133497f50739417453.1435316484.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5630bd343217e8fa895c5d133497f50739417453.1435316484.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 26, 2015 at 07:09:22PM +0800, Zidan Wang wrote:
> When using snd_soc_dai_set_pll to set pll in machine driver, we
> should set pll in and pll out freq and ensure 5 < PLLN < 13,
> otherwise set pll will be failed. In order to support more
> formats and sample rates for a certain MCLK, if snd_soc_dai_set_pll
> failed, it will calculate a available pll out freq and set the pll
> again.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

I think this need a little more explaination on how this is
expected to work. From looking at the code what it looks like
what happens is you can set a PLL frequency through set_pll but
then if that frequency doesn't support the sample rate requested
through hw_params it will be changed. This makes me a little
nervous, as something explicitly requested is being overwritten
automatically.

Would it perhaps be better to allow the auto selection of the
PLL frequency only when things haven't been manually set, or
provide some setting that indicates auto mode?

Thanks,
Charles
