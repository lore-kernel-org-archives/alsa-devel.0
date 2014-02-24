From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 6/6] ASoC: Intel: Add Haswell Machine
 support
Date: Mon, 24 Feb 2014 19:55:15 +0000
Message-ID: <1393271715.2323.64.camel@loki>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-6-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221052247.GF25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B5252265457
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 20:55:33 +0100 (CET)
In-Reply-To: <20140221052247.GF25940@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-21 at 14:22 +0900, Mark Brown wrote:
> On Thu, Feb 20, 2014 at 09:48:47PM +0000, Liam Girdwood wrote:
> > Add support for Haswell based machines with SST DSP audio.
> 
> Applied, thanks.
> 
> > +config SND_SOC_INTEL_HASWELL_MACH
> > +        tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
> > +        depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
> > +	select SND_SOC_INTEL_HASWELL
> > +	select SND_SOC_RT5640
> > +	help
> > +          This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
> > +	  Ultrabook platforms.
> > +          Say Y if you have such a device
> > +          If unsure select "N".
> 
> Looks like there's formatting issues here again - tab/space probably.
> 
> > +static const struct snd_soc_dapm_route haswell_rt5640_map[] = {
> > +
> > +	{"Headphones", NULL, "HPOR"},
> > +	{"Headphones", NULL, "HPOL"},
> > +	{"IN2P", NULL, "Mic"},
> > +
> > +	/* CODEC BE connections */
> > +	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
> > +	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
> > +};
> 
> A DPCM system in mainline!  Yay!
> 
> > +static int haswell_rt5640_hw_params(struct snd_pcm_substream *substream,
> > +	struct snd_pcm_hw_params *params)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +	int ret;
> > +
> > +	/* Set codec DAI configuration */
> > +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> > +			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
> > +	if (ret < 0) {
> > +		dev_err(rtd->dev, "can't set codec DAI configuration\n");
> > +		return ret;
> > +	}
> 
> Set .dai_fmt in the dai_link?

Will update, I think we left that so we could read the DAI fmt from ACPI
in the near future. However, I do intend to read the DAI link from ACPI
in the near future too, so we should construct the DAI link with DAI
format from ACPI at the same time. 

> 
> > +	/* set correct codec filter for DAI format and clock config */
> > +	snd_soc_update_bits(rtd->codec, 0x83, 0xffff, 0x8000);
> 
> The CODEC driver ought to be figuring out the magic numbers for itself
> really.

I was thinking of a codec public API call for the last one here. I'll
chat with Bard after BYT upstreaming and see what we can come up with.

Liam
