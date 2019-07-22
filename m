From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: Add Broadwell rt5650 machine
 driver
Date: Mon, 22 Jul 2019 17:34:04 -0500
Message-ID: <a2b40b35-d572-04af-2a38-ece191bd91b4@linux.intel.com>
References: <20190718231225.88991-1-jflat@chromium.org>
 <f2e1c69e-bba9-8798-536c-1a2681e02599@linux.intel.com>
 <CACJJ=py4hEJMSVBX+=O8Myj-LQYvDL6vugTUR4ypq0W6uCn1kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29D38F800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 00:34:09 +0200 (CEST)
In-Reply-To: <CACJJ=py4hEJMSVBX+=O8Myj-LQYvDL6vugTUR4ypq0W6uCn1kw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jon Flatley <jflat@chromium.org>
Cc: benzh@chromium.org, alsa-devel@alsa-project.org, broonie@kernel.org, cujomalainey@chromium.org, fletcherw@chromium.org
List-Id: alsa-devel@alsa-project.org



On 7/22/19 4:04 PM, Jon Flatley wrote:
> On Mon, Jul 22, 2019 at 5:34 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>
>> On 7/18/19 6:12 PM, Jon Flatley wrote:
>>> From: Ben Zhang <benzh@chromium.org>
>>>
>>> Add machine driver for Broadwell + rt5650.
>>
>> Interesting. the only Broadwell device we encountered with I2S instead
>> of HDaudio was Samus w/ rt5677, can you share which model this is?
> 
> Yes, this is for the Acer Chromebase 24, aka Buddy.

Ah ok, I wasn't aware of this one, thanks for the pointer.


>>> +static int bdw_rt5650_rtd_init(struct snd_soc_pcm_runtime *rtd)
>>> +{
>>> +     struct snd_soc_component *component =
>>> +             snd_soc_rtdcom_lookup(rtd, DRV_NAME);
>>> +     struct sst_pdata *pdata = dev_get_platdata(component->dev);
>>> +     struct sst_hsw *broadwell = pdata->dsp;
>>> +     int ret;
>>> +
>>> +     /* Set ADSP SSP port settings
>>> +      * clock_divider = 4 means BCLK = MCLK/5 = 24MHz/5 = 4.8MHz
>>> +      */
>>> +     ret = sst_hsw_device_set_config(broadwell, SST_HSW_DEVICE_SSP_0,
>>> +             SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
>>> +             SST_HSW_DEVICE_TDM_CLOCK_MASTER, 4);
>>
>> this is going to break compilation if SOF is selected. this function
>> should be filtered out with
>> #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
>>
>> as done in bdw-rt5677
>>
>>> +     if (ret < 0) {
>>> +             dev_err(rtd->dev, "error: failed to set device config\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int bdw_rt5650_init(struct snd_soc_pcm_runtime *rtd)
>>> +{
>>> +     struct bdw_rt5650_priv *bdw_rt5650 =
>>> +             snd_soc_card_get_drvdata(rtd->card);
>>> +     struct snd_soc_component *component = rtd->codec_dai->component;
>>> +     struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>> +     int ret;
>>> +
>>> +     /* Enable codec ASRC function for Stereo DAC/Stereo1 ADC/DMIC/I2S1.
>>> +      * The ASRC clock source is clk_i2s1_asrc.
>>> +      */
>>> +     rt5645_sel_asrc_clk_src(component,
>>> +                             RT5645_DA_STEREO_FILTER |
>>> +                             RT5645_DA_MONO_L_FILTER |
>>> +                             RT5645_DA_MONO_R_FILTER |
>>> +                             RT5645_AD_STEREO_FILTER |
>>> +                             RT5645_AD_MONO_L_FILTER |
>>> +                             RT5645_AD_MONO_R_FILTER,
>>> +                             RT5645_CLK_SEL_I2S1_ASRC);
>>> +
>>> +     /* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
>>> +     ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
>>
>> could we move this to bdw_rt5650_rtd_init() so that this doesn't impact SOF?
> 
> I'm not familiar with the differences in SOF. Can you elaborate on
> what exactly needs to be moved?

The 2 main differences are that SOF does not have any support for this 
sst_hsw_device_set_config() function - and it should have been 
abstracted away with a dai operation - and the fixed settings are 
replaced by topology-defined configurations.

we can of course do the SOF support later but you want to make sure the 
compilation issue is sorted out with the #if !IS_ENABLED() code above.
