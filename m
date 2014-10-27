From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Mon, 27 Oct 2014 10:47:19 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B7008F7@SHSMSX101.ccr.corp.intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <20141024162404.GJ3729@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 907FE260859
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 11:47:25 +0100 (CET)
In-Reply-To: <20141024162404.GJ3729@sirena.org.uk>
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

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, October 25, 2014 12:24 AM
 
> > Add machine driver for two Intel Cherryview-based platforms,
> > Cherrytrail and Braswell, with RT5672 codec.
> 
> This doesn't seem to have any ACPI stuff - how does the driver get loaded?

The ACPI stuff will be upstream later.
The machine device will be created by the SST ACPI loader sst-acpi.c, like Broadwell and Baytrail.
We're trying to merge ACPI stuff of new machines to the ACPI loader.

> > +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
> > +					struct snd_pcm_hw_params *params) {
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +	int ret;
> > +	unsigned int fmt;
> > +
> > +	if (strncmp(codec_dai->name, "rt5670-aif1", 11))
> > +		return 0;
> > +
> > +	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
> > +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4,
> > +				       SNDRV_PCM_FORMAT_GSM);
> > +	if (ret < 0) {
> > +		dev_err(rtd->dev, "can't set codec TDM slot %d\n", ret);
> > +		return ret;
> > +	}
> > +
> 
> This doesn't depend on the parameters so should be set on init and your use of
> SNDRV_PCM_FORMAT_GSM doesn't seem to make much sense here - what's
> going on?

Sorry, this is a misuse of SNDRV_PCM_FORMAT_GSM which happen to be 24
I'll correct this to snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24) , create a dai_link init function cht_codec_init() and move the code there.

> > +	/* TDM slave Mode */
> > +	fmt =   SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
> > +		| SND_SOC_DAIFMT_CBS_CFS;
> > +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> > +	if (ret < 0) {
> > +		dev_err(rtd->dev, "can't set codec DAI fmt %d\n", ret);
> > +		return ret;
> > +	}
> 
> Likewise, set on init (in the dai_link)

I'll move it to back end dai link .dai_fmt as below:
.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
					| SND_SOC_DAIFMT_CBS_CFS,

> > +static int cht_set_bias_level(struct snd_soc_card *card,
> > +				struct snd_soc_dapm_context *dapm,
> > +				enum snd_soc_bias_level level)
> > +{
> > +	switch (level) {
> > +	case SND_SOC_BIAS_ON:
> > +	case SND_SOC_BIAS_PREPARE:
> > +	case SND_SOC_BIAS_STANDBY:
> > +	case SND_SOC_BIAS_OFF:
> > +		break;
> > +	default:
> > +		dev_err(card->dev, "Invalid bias level=%d\n", level);
> > +		return -EINVAL;
> > +	}
> > +	card->dapm.bias_level = level;
> > +	return 0;
> > +}
> 
> This does nothing and can be removed.

Okay.

> > +static int cht_init(struct snd_soc_pcm_runtime *runtime) {
> > +	int ret;
> > +	struct snd_soc_card *card = runtime->card;
> > +
> > +	/* Set card bias level */
> > +	cht_set_bias_level(card, &card->dapm, SND_SOC_BIAS_OFF);
> > +	card->dapm.idle_bias_off = true;
> > +
> > +	ret = snd_soc_dapm_sync(&card->dapm);
> > +	if (ret) {
> > +		dev_err(card->dev, "unable to sync dapm\n");
> > +		return ret;
> > +	}
> > +	return ret;
> > +}
> 
> This also does nothing and can be removed.

Okay.

> > +static struct snd_pcm_hw_constraint_list constraints_48000 = {
> > +	.count = ARRAY_SIZE(rates_48000),
> > +	.list  = rates_48000,
> > +};
> > +
> > +static int cht_aif1_startup(struct snd_pcm_substream *substream) {
> > +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> > +			SNDRV_PCM_HW_PARAM_RATE,
> > +			&constraints_48000);
> > +}
> 
> If the rates are restricted to 48kHz then is there any need for rate dependent
> code in hw_params() at all?

Currently, we only tested 48kHz, but later will support 8KHz and 16KHz for VoIP application.
So hw_params() be reserved for reuse later?

> 
> > +static int snd_cht_mc_remove(struct platform_device *pdev) {
> > +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
> > +
> > +	snd_soc_card_set_drvdata(soc_card, NULL);
> > +	snd_soc_unregister_card(soc_card);
> > +	platform_set_drvdata(pdev, NULL);
> > +	return 0;
> > +}
> 
> No need to set the driver data to NULL, the driver core will do it anyway and
> it's buggy to look at the driver data for unbound devices.

Okay.

Thanks for your review! I'll submit the v2 patch based on your comment. 
But I lost the message ID of my original patch, sorry for this.

Regards
Mengdong
