From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: update pll and clock setting
	function
Date: Tue, 30 Jun 2015 11:42:00 +0100
Message-ID: <20150630104200.GJ6321@opensource.wolfsonmicro.com>
References: <5630bd343217e8fa895c5d133497f50739417453.1435316484.git.zidan.wang@freescale.com> <20150629094412.GH6321@opensource.wolfsonmicro.com> <20150630085347.GA22709@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150630085347.GA22709@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 30, 2015 at 04:54:09PM +0800, Zidan Wang wrote:
> On Mon, Jun 29, 2015 at 10:44:12AM +0100, Charles Keepax wrote:
> > On Fri, Jun 26, 2015 at 07:09:22PM +0800, Zidan Wang wrote:
> > > When using snd_soc_dai_set_pll to set pll in machine driver, we
> > > should set pll in and pll out freq and ensure 5 < PLLN < 13,
> > > otherwise set pll will be failed. In order to support more
> > > formats and sample rates for a certain MCLK, if snd_soc_dai_set_pll
> > > failed, it will calculate a available pll out freq and set the pll
> > > again.
> > > 
> > > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > > ---
> > 
> > I think this need a little more explaination on how this is
> > expected to work. From looking at the code what it looks like
> > what happens is you can set a PLL frequency through set_pll but
> > then if that frequency doesn't support the sample rate requested
> > through hw_params it will be changed. This makes me a little
> > nervous, as something explicitly requested is being overwritten
> > automatically.
> > 
> From RM, we should ensure 5 < PLLN < 13. When i using snd_soc_dai_set_pll
> to set pll frequency, it's hard for me to get a common pll out frequency.
> Sometimes, when codec MCLK or sample rate changed, the pll out frequency
> also should be changed, otherwise set_pll function will be failed.
> 
> I made it to auto select pll frequency when snd_soc_dai_set_pll failed, so that
> it can support more sample rate, and don't need to set different pll out
> frequency for different sample rate and different MCLK.

But none the less I still asked for one frequency and got another
frequency, that seems troubling. For example the chip has the
ability to output the PLL output on GPIO1, what if that is being
used to feed another chip that expects a certain rate?

What are your feeling on my previous suggestion of adding a
particular define that indicates set the PLL to "auto" mode?

Thanks,
Charles

> 
> > Would it perhaps be better to allow the auto selection of the
> > PLL frequency only when things haven't been manually set, or
> > provide some setting that indicates auto mode?
> > 
> > Thanks,
> > Charles
