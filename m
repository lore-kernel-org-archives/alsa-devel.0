From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v3] ASoC: da7210: Add support for PLL and
 SRM
Date: Tue, 7 Feb 2012 18:55:49 +0530
Message-ID: <1328621149.26721.18.camel@matrix>
References: <1328095529.15257.7.camel@matrix>
	<20120201115035.GC5648@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id CE769103C53
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 14:14:06 +0100 (CET)
In-Reply-To: <20120201115035.GC5648@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-01 at 11:50 +0000, Mark Brown wrote:
> On Wed, Feb 01, 2012 at 04:55:29PM +0530, Ashish Chavan wrote:
> 
> > +static const u32 da7210_pll_div[][COL_CNT] = {
> > +	/* for MASTER mode, fs = 44.1Khz */
> > +	{ 12000000, 0xE8, 0x6C, 0x2, },		/* MCLK=12Mhz */
> 
> Even better than defines to index into the array would be an array of
> structs with named members...
> 

OK, will do that.

> > +	if (da7210->mclk_rate) {
> > +		/* PLL mode, disable PLL bypass */
> > +		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, 0);
> > +	} else {
> > +		/* PLL bypass mode, enable PLL bypass */
> > +		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP,
> > +							    DA7210_PLL_BYP);
> > +	}
> 
> This is really weird - if anything it looks the wrong way round.
> mclk_rate is what's set by set_sysclk() so if the user has configured
> MCLK we will never use it even if it's at a suitable rate but if the
> user hasn't configured one we rely on it directly.  If anything I'd
> expect this code to enable the PLL only if the MCLK is not a suitable
> rate.
> 

Actually it worked fine for me because of the way platform driver is
written. It basically uses static configurations for PLL and PLL bypass
modes. It calls set_sysclk() only in case of PLL. So the codec driver
more or less uses mckl_rate as a flag to see if PLL is enabled. I know
it's not clean and may be I can update it to comply with rest of the
stuff.

> The normal pattern is that set_sysclk() specifies the clock the bulk of
> the device will be using, when used with the PLL that'd be the PLL
> output not the PLL input.  Alternatively just specify the MCLK always
> and let the driver figure out when to use the PLL.

Yes, got the point.

> 
> > +	if (da7210->master) {
> > +		/* In PLL master mode, use master mode PLL dividers */
> > +		switch (fout) {
> > +		case 2822400:
> > +			row_idx = MASTER_2822400_DIV_OFFSET;
> > +			break;
> > +		case 3072000:
> > +			row_idx = MASTER_3072000_DIV_OFFSET;
> > +			break;
> > +		default:
> > +			dev_err(codec_dai->dev,
> > +				"Unsupported PLL output frequency %d\n", fout);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		/* In PLL slave mode, use SRM mode PLL dividers */
> > +		row_idx = SLAVE_SRM_DIV_OFFSET;
> > +	}
> 
> You need checks elsewhere to make sure that the user doesn't try to
> reconfigure master/slave while the PLL is active.

AFAIK master/slave configuration is static(depending on the board
configuration) and done via set_fmt() from hw_params() of platform
driver. Can you please point me to an example where dynamic/runtime
setting of I2S master/slave mode is supported?
