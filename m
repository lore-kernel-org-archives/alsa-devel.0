From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: New platform CherryTrail/ES8316 audio output is
 silent
Date: Mon, 20 Feb 2017 14:33:26 -0600
Message-ID: <d745b36a-4e6b-118b-88d6-5d362bc471d2@linux.intel.com>
References: <20170111190728.1824-1-drake@endlessm.com>
 <99853b70-6677-38c7-8783-372d41d5e651@linux.intel.com>
 <CAD8Lp47RdbQ_Ts-arfk6kasKHqdwQ7oOS1Go+0PJzVuXEt1R+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3459A266B26
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 21:33:29 +0100 (CET)
In-Reply-To: <CAD8Lp47RdbQ_Ts-arfk6kasKHqdwQ7oOS1Go+0PJzVuXEt1R+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <drake@endlessm.com>
Cc: yang.a.fang@intel.com, vinod.koul@intel.com, alsa-devel@alsa-project.org, Linux Upstreaming Team <linux@endlessm.com>, yangxiaohua <yangxiaohua@everest-semi.com>
List-Id: alsa-devel@alsa-project.org



On 02/20/2017 02:14 PM, Daniel Drake wrote:
>   .On Fri, Jan 13, 2017 at 1:33 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> That is very unusual. We have not seen any platforms use SSP1 for the codec
>> connections. Are you really sure? If you can share the schematics privately
>> I'd like to take a look. We don't have support upstream for SSP1 usage so
>> that'd be really problematic.
> I have now confirmed it is using SSP2, sorry for the noise there.
>
> After modifying it to use SSP2 I am still only getting silence though.
> I am now using the code submitted to
> https://bugzilla.kernel.org/show_bug.cgi?id=189261 and I'll post my
> version shortly. Any further suggestions would be much appreciated.
There were quite a few comments provided to David @ Everest Audio, I'll 
wait until I see an updated version with a --signoff to chime in.
>
> I'd like to follow up on some of your review comments that also apply
> to that code:
>
>>> +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
>>> +                       struct snd_pcm_hw_params *params)
>>> +{
>>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>> +       unsigned int fmt;
>>> +       int ret;
>>> +
>>> +       pr_debug("Enter:%s", __func__);
>>> +
>>> +       //add for voip call no sound by zm 1211
>>> +       if (strncmp(codec_dai->name, "ES8316 HiFi", 11))
>>> +                return 0;
>>> +
>>> +       /* I2S Slave Mode*/
>>> +       fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>> +                       SND_SOC_DAIFMT_CBS_CFS;
>>> +
>>> +       /* Set codec DAI configuration */
>>> +       ret = snd_soc_dai_set_fmt(codec_dai, fmt);
>>> +       if (ret < 0) {
>>> +               pr_err("can't set codec DAI configuration %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +#if 0
>>> +       ret = snd_soc_dai_set_pll(codec_dai, 0, ES8316_PLL_SRC_FRM_MCLK,
>>> +                               CHT_PLAT_CLK_3_HZ, params_rate(params) *
>>> 256);
>>> +       if (ret < 0) {
>>> +               pr_err("can't set codec pll***********: %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +
>>> +       if (codec_dai->driver && codec_dai->driver->ops->hw_params)
>>> +               codec_dai->driver->ops->hw_params(substream, params,
>>> codec_dai);
>>> +
>>> +       snd_soc_dai_set_sysclk(codec_dai, ES8316_CLKID_PLLO,
>>> CHT_PLAT_CLK_3_HZ, 0);
>>> +#endif
>>> +#if 0
>>> +       ret = snd_soc_dai_set_sysclk(codec_dai, 0,
>>> +                       params_rate(params) * 512, SND_SOC_CLOCK_IN);
>>> +       if (ret < 0) {
>>> +               pr_err("can't set codec sysclk: %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +#endif
>>
>> weird, the PLL doesn't seem to be set, only the value for the system clk?
> I realise that work will need to be done here before the code can be
> accepted. But I think I should be able to get audio output working
> first, because after starting to play a sound I am using regmap
> debugfs to write all the codec registers using values that I dumped
> from windows. Please correct me if I'm missing something.
>
> Also the es8316.c codec driver does not have a set_pll function and
> while the hw_params does calculate some coefficients related to sample
> rate and clock speed, it never actually uses any of the results of the
> calculation.
>
>>> +       snd_soc_dai_set_sysclk(codec_dai, ES8316_CLKID_PLLO,
>>> CHT_PLAT_CLK_3_HZ, 0);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int cht_compr_set_params(struct snd_compr_stream *cstream)
>>> +{
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct snd_soc_pcm_stream cht_dai_params = {
>>> +       .formats = SNDRV_PCM_FMTBIT_S24_LE,
>>> +       .rate_min = 48000,
>>> +       .rate_max = 48000,
>>> +       .channels_min = 2,
>>> +       .channels_max = 2,
>>> +};
>>> +
>>> +static struct snd_soc_compr_ops cht_compr_ops = {
>>> +       .set_params = cht_compr_set_params,
>>> +};
>>> +
>>> +static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
>>> +                           struct snd_pcm_hw_params *params)
>>> +{
>>> +       struct snd_interval *rate = hw_param_interval(params,
>>> +                       SNDRV_PCM_HW_PARAM_RATE);
>>> +       struct snd_interval *channels = hw_param_interval(params,
>>> +
>>> SNDRV_PCM_HW_PARAM_CHANNELS);
>>> +
>>> +       pr_debug("Invoked %s for dailink %s\n", __func__,
>>> rtd->dai_link->name);
>>> +
>>> +       /* The DSP will covert the FE rate to 48k, stereo, 24bits */
>>> +       rate->min = rate->max = 48000;
>>> +       channels->min = channels->max = 4;//2
>>
>> again that part is wild
> What is the wild part? The min/max 4 channels instead of 2, or the
> whole function?
>
> It's otherwise identical to working code in cht_bsw_rt5645.c.
No. In the code above you set the codec_dai to work in I2S mode, and 
here you are asking for 4 slots.
Unless you have evidence that the codec support TDM, use 2 channels I2S 
and set the same value on the cpu_dai side.
>
>>> +       /* Back ends */
>>> +       {
>>> +               .name = "SSP2-Codec",
>>> +               .id = 1,
>>> +               .cpu_dai_name = "ssp1-port",
>>> +               .platform_name = "sst-mfld-platform",
>>> +               .no_pcm = 1,
>>> +               .codec_dai_name = "ES8316 HiFi",
>>> +               .codec_name = "i2c-ESSX8316:00",
>>> +               .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
>>> +                                       | SND_SOC_DAIFMT_CBS_CFS,
>>
>> the format here is not consistent with what you are asking the codec dai to
>> do, and it's not consistent either with the Intel side which doesn't use
>> this mode.
> The same dai_fmt is working fine in cht_bsw_rt5645.c. Neverthless I'd
> be happy to fix it up, can you suggest a correct value?
same comment, pick 2 or 4 channels but be consistent.
>
> Thanks
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
