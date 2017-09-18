From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/5] ASoC: Intel: bytcr_rt5651: add MCLK
 support and fix quirks
Date: Mon, 18 Sep 2017 12:20:48 -0500
Message-ID: <fd22421f-4556-76d9-4f7b-8cb4055b0cd6@linux.intel.com>
References: <20170908174356.23788-1-pierre-louis.bossart@linux.intel.com>
 <20170908174356.23788-4-pierre-louis.bossart@linux.intel.com>
 <1505718645.25945.265.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D3A266DBB
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 19:20:50 +0200 (CEST)
In-Reply-To: <1505718645.25945.265.camel@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 9/18/17 2:10 AM, Andy Shevchenko wrote:
> On Fri, 2017-09-08 at 12:43 -0500, Pierre-Louis Bossart wrote:
>> Same as for other codecs, enable MCLK by default. When it is not
>> present, e.g. on MinnowBoard B3 since it's not routed on the LSE
>> connector, we fall back to blck-based clocking.
>>
>> The DMIC quirks are also fixed, there is a single DMIC input of the
>> codec
> 
>>   #include <linux/device.h>
>>   #include <linux/dmi.h>
>>   #include <linux/slab.h>
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/platform_sst_audio.h>
> 
>> +#include <linux/clk.h>
> 
> Just a nit: I would rather squeeze this to somewhere above device
> (alphabetical ordering)
> 
>>   #include <sound/pcm.h>
>>   #include <sound/pcm_params.h>
>>   #include <sound/soc.h>
> 
>> +#define BYT_RT5651_MAP(quirk)	((quirk) & 0xff)
> 
> GENMASK(7, 0) ?

again a copy-paste from rt5640, I don't mind changing this but it should 
be done in both drivers for alignment.

> 
>> +#define BYT_RT5651_DMIC_EN	BIT(16)
>> +#define BYT_RT5651_MCLK_EN	BIT(17)
>> +#define BYT_RT5651_MCLK_25MHZ	BIT(18)
> 
>> +static void log_quirks(struct device *dev)
>> +{
>> +	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_DMIC_MAP)
>> +		dev_info(dev, "quirk DMIC_MAP enabled");
>> +	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
>> +		dev_info(dev, "quirk IN1_MAP enabled");
>> +	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
>> +		dev_info(dev, "quirk DMIC enabled");
>> +	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
>> +		dev_info(dev, "quirk MCLK_EN enabled");
>> +	if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
>> +		dev_info(dev, "quirk MCLK_25MHZ enabled");
>> +}
>> +
>> +#define BYT_CODEC_DAI1	"rt5651-aif1"
>> +
>> +static inline struct snd_soc_dai *byt_get_codec_dai(struct
>> snd_soc_card *card)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd;
>> +
>> +	list_for_each_entry(rtd, &card->rtd_list, list) {
>> +		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI1,
>> +			     strlen(BYT_CODEC_DAI1)))
> 
> Still same comment about str_n_cmp vs. strcmp() in this case.
> 
> (strlen() also can be calculated once size_t dai1_len = strlen(...); )

same, the same code is used in multiple places so I'd like to fix it in 
one step later.

> 
>> +			return rtd->codec_dai;
>> +	}
>> +	return NULL;
> 
> 
>> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> 
>> +		if (priv->mclk) {
> 
> Do we need this check?
> 
> I'm not sure I have read a comment why this is left as in initial
> series.

yes, we need it. I use it to check if we are using the MCLK or the bclk 
for the PLL reference. In the latter case there is no point in 
programming the PMC clocks. You might argue this is harmless but I like 
to avoid unnecessary programming sequences.

> 
>> 				     SND_SOC_CLOCK_IN);
>> +		if (!ret)
>> +			if (priv->mclk)
> 
> Ditto ?
> 
>> +				clk_disable_unprepare(priv->mclk);
>> +	}
> 
>>
> 
>>   static const struct dmi_system_id byt_rt5651_quirk_table[] = {
>> +	{
>> +		.callback = byt_rt5651_quirk_cb,
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max
>> B3 PLATFORM"),
>> +		},
>> +		.driver_data = (unsigned long *)(BYT_RT5651_DMIC_MAP
>> |
> 
> Shouldn't be just (void *)  [and maybe fit one line]?

we use this in every single driver, not sure there is a point in making 
this pretty?

> 
>> +						 BYT_RT5651_DMIC_EN),
> 
>>   
>> +	if (priv->mclk) {
> 
> Same question as above.
> 
>> +		/*
>> +		 * The firmware might enable the clock at
>> +		 * boot (this information may or may not
>> +		 * be reflected in the enable clock register).
>> +		 * To change the rate we must disable the clock
>> +		 * first to cover these cases. Due to common
>> +		 * clock framework restrictions that do not allow
>> +		 * to disable a clock that has not been enabled,
>> +		 * we need to enable the clock first.
>> +		 */
>> +		ret = clk_prepare_enable(priv->mclk);
>> +		if (!ret)
>> +			clk_disable_unprepare(priv->mclk);
>> +
>> +		if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
>> +			ret = clk_set_rate(priv->mclk, 25000000);
>> +		else
>> +			ret = clk_set_rate(priv->mclk, 19200000);
>> +
>> +		if (ret)
>> +			dev_err(card->dev, "unable to set MCLK
>> rate\n");
>> +	}
>>
> 
