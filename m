From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Boards: Add CNL RT274 I2S
 machine driver
Date: Fri, 16 Mar 2018 14:03:33 -0500
Message-ID: <57516f82-b933-325d-e166-87446208ce0d@linux.intel.com>
References: <20180315115345.3087-1-guneshwor.o.singh@intel.com>
 <26dcf212-6a6f-d9f6-bdbf-0eea559451bb@linux.intel.com>
 <20180316034046.GA31796@g2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C00267380
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 20:03:37 +0100 (CET)
In-Reply-To: <20180316034046.GA31796@g2>
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
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, bardliao@realtek.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 3/15/18 10:40 PM, Guneshwor Singh wrote:
> Hi Pierre,
> 
> On Thu, Mar 15, 2018 at 07:23:05AM -0500, Pierre-Louis Bossart wrote:
>>
>>> +
>>> +static int cnl_rt274_clock_control(struct snd_soc_dapm_widget *w,
>>> +				   struct snd_kcontrol *k, int event)
>>> +{
>>> +	struct snd_soc_dapm_context *dapm = w->dapm;
>>> +	struct snd_soc_card *card = dapm->card;
>>> +	struct snd_soc_dai *codec_dai =
>>> +		snd_soc_card_get_codec_dai(card, RT274_CODEC_DAI);
>>> +	int ret, ratio = 100;
>>> +
>>> +	if (!codec_dai)
>>> +		return -EINVAL;
>>> +
>>> +	/* Codec needs clock for Jack detection and button press */
>>> +	ret = snd_soc_dai_set_sysclk(codec_dai, RT274_SCLK_S_PLL2,
>>> +				     CNL_FREQ_OUT, SND_SOC_CLOCK_IN);
>>> +	if (ret < 0) {
>>> +		dev_err(codec_dai->dev, "set codec sysclk failed: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
>>> +		ret = snd_soc_dai_set_bclk_ratio(codec_dai, ratio);
>>> +		if (ret) {
>>> +			dev_err(codec_dai->dev,
>>> +				"set bclk ratio failed: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +
>>> +		ret = snd_soc_dai_set_pll(codec_dai, 0, RT274_PLL2_S_BCLK,
>>> +					  CNL_BE_FIXUP_RATE * ratio,
>>> +					  CNL_FREQ_OUT);
>>> +		if (ret) {
>>> +			dev_err(codec_dai->dev,
>>> +				"enable PLL2 failed: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>> it's not clear to me why you need a clock control? You are not changing
>> anything that really depends on DAPM events, to e.g. take the MCLK down and
>> use a local clock, so could this be moved to hw_params?
> 
> Yes, we can do in hw_params too. When we implemented it we thought
> during simultaneous playback and capture, hw_params will be called twice
> but clock clock event will be called just once.

Yes, I remember this discussion but what's missing here is that PLL is 
always set to the max value, in most cases we fall back to a local clock 
to save power a bit. And it's probably wrong to leave a PLL on if the 
clock reference is turned off on the SOC side.

> 
> It does not harm to call twice as done in other machine drivers. Do you
> suggest to move it to hw_params?
> 
>>> +static const struct snd_soc_dapm_route cnl_map[] = {
>>> +	{"Headphone Jack", NULL, "HPO Pin"},
>>> +	{"MIC", NULL, "Mic Jack"},
>>> +	{"DMic", NULL, "SoC DMIC"},
>>> +	{"DMIC01 Rx", NULL, "Capture"},
>>> +	{"dmic01_hifi", NULL, "DMIC01 Rx"},
>>> +
>>> +	{"AIF1 Playback", NULL, "ssp0 Tx"},
>>> +	{"ssp0 Tx", NULL, "codec1_out"},
>>> +	{"ssp0 Tx", NULL, "codec0_out"},
>> I get the routes to connect firmware widgets to codec ones, but why do we
>> need SSP0 TX-> codec1_out? shouldn't this be part of the topology?
> 
> We still have routes for BEs defined here. Only FE ones come from
> topology.

The comment was about the codec1_out->SSP0 TX. Why is this hard-coded?
You would only need SSP0 TX->AIF1 playback

> 
>>> +
>>> +	{"ssp0 Rx", NULL, "AIF1 Capture"},
>>> +	{"codec0_in", NULL, "ssp0 Rx"},
>>> +
>>> +	{"Headphone Jack", NULL, "Platform Clock"},
>>> +	{"Mic Jack", NULL, "Platform Clock"},
>>> +};
>>> +
>>> +static	struct snd_soc_jack_pin cnl_headset_pins[] = {
>>> +	{
>>> +		.pin = "Mic Jack",
>>> +		.mask = SND_JACK_MICROPHONE,
>>> +	},
>>> +	{
>>> +		.pin = "Headphone Jack",
>>> +		.mask = SND_JACK_HEADPHONE,
>>> +	},
>>> +};
>>> +
>>> +static struct snd_soc_jack cnl_headset;
>>> +
>>> +static int cnl_rt274_init(struct snd_soc_pcm_runtime *runtime)
>>> +{
>>> +	struct snd_soc_card *card = runtime->card;
>>> +	struct snd_soc_dai *codec_dai = runtime->codec_dai;
>>> +	struct snd_soc_component *component = codec_dai->component;
>>> +	int ret;
>>> +
>>> +	ret = snd_soc_card_jack_new(runtime->card, "Headset",
>>> +		SND_JACK_HEADSET, &cnl_headset,
>>> +		cnl_headset_pins, ARRAY_SIZE(cnl_headset_pins));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = snd_soc_component_set_jack(component, &cnl_headset, NULL);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
>>> +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xf, 0xf, 4, 24);
>> what are the 4 slots used for?
> 
> Ah, this is a mistake. Thanks for pointing out. It should be
> snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 2, 24) as we do not have
> speakers on rt274. Will correct in v3.

then it also begs the question why you needed to have both codec0_out 
and codec1_out mentioned above - same issue really about hard-coding 
things that should be topology defined.

> 
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
