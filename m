From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Wed, 29 Oct 2014 06:45:05 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
 <20141028164822.GB18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C3B33260435
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:47:08 +0100 (CET)
In-Reply-To: <20141028164822.GB18557@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, October 29, 2014 12:48 AM

> > +config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
> > +        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with
> RT5672 codec"
> > +        depends on X86_INTEL_LPSS
> > +        select SND_SOC_RT5670
> > +        select SND_SST_MFLD_PLATFORM
> > +        select SND_SOC_INTEL_SST
> > +        select SND_SST_IPC
> > +        select SND_SST_MACHINE
> > +        default n
> 
> n is the default anyway.

Will remove " default n"

> > +obj-$(CONFIG_SND_SST_MACHINE) += board/
> 
> It's a bit weird to have the Kconfig in the root Intel directory if the boards are
> getting moved into a subdirectory - why not just source a Kconfig in the board
> directory?

Will source a Kconfig in the board directory.

> > +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
> > +					struct snd_pcm_hw_params *params) {
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +	int ret;
> > +
> > +	if (strncmp(codec_dai->name, "rt5670-aif1", 11))
> > +		return 0;
> 
> 11 is a magic number!  Why not use strlen() here (and why do we do nothing
> in the AIF1 hw_params() if we're working with AIF1)?

It not necessary. Will remove.
> 
> > +	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5670_PLL1_S_MCLK,
> > +				  CHT_PLAT_CLK_3_HZ, params_rate(params) * 512);
> > +	if (ret < 0) {
> > +		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_PLL1,
> > +				     params_rate(params) * 512,
> > +				     SND_SOC_CLOCK_IN);
> > +	if (ret < 0) {
> > +		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
> > +		return ret;
> > +	}
> 
> Nothing ever stops the PLL - a set_bias_level() callback with a handler for _OFF.
> Otherwise we're wasting power.

Can we introduce a power supply widget for the platform clock used as MCLK?
That widget can be added into the playback and capture path. 
So when idle, the platform clock can be turn off and let the codec PLL selects
its internal low frequency clock only for jack detection. It's verified internally.

The platform clock driver is not upstream yet, so in the widget control we can't
really turn off the MCLK output to codec, but at least we can let the codec PLL
no longer locked to the high frequency MCLK. 

Or we don't change the code at moment, until we upstream the platform clock
driver at first?

Which way is better?

> 
> > +	snd_soc_card_cht.dev = &pdev->dev;
> > +	ret_val = snd_soc_register_card(&snd_soc_card_cht);
> > +	if (ret_val) {
> 
> devm_snd_soc_register_card() and the removal function can go entirely.

Okay.

Thanks
Mengdong
