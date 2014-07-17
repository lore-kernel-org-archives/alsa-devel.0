From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH v7] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Thu, 17 Jul 2014 17:07:07 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49D84EBF@DFLE09.ent.ti.com>
References: <1405368645-4168-1-git-send-email-dmurphy@ti.com>
 <20140717165816.GA17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark


On 07/17/2014 11:58 AM, Mark Brown wrote:
> On Mon, Jul 14, 2014 at 03:10:45PM -0500, Dan Murphy wrote:
>
> There's a few smallish issues below but this is basically good so I've
> applied it, please send incremental fixed for the things below.
>
>> +	/* Turn on Class D amplifier */
>> +	snd_soc_update_bits(codec, TAS2552_CFG_2, TAS2552_CLASSD_EN_MASK,
>> +						TAS2552_CLASSD_EN);
>> +
> Why is this being done in hw_params() and not using DAPM?
>
>> +static int tas2552_runtime_suspend(struct device *dev)
>> +{
>> +	struct tas2552_data *tas2552 = dev_get_drvdata(dev);
>> +
>> +	tas2552_sw_shutdown(tas2552, 0);
>> +
>> +	if (tas2552->enable_gpio)
>> +		gpiod_set_value(tas2552->enable_gpio, 0);
>> +
>> +	regcache_cache_only(tas2552->regmap, true);
>> +	regcache_mark_dirty(tas2552->regmap);
> It's better to do the GPIO set after making the device cache only in
> order to be sure nothing can come in and try to use the register map
> between the two.
>
>> +static void tas2552_shutdown(struct snd_pcm_substream *substream,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +
>> +	snd_soc_update_bits(codec, TAS2552_CFG_2, TAS2552_PLL_ENABLE, 0);
>> +}
> I'd also expect the PLL power to be managed via DAPM.
>
>> +	ret = pm_runtime_get_sync(codec->dev);
>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "Enabling device failed: %d\n",
>> +			ret);
>> +		goto probe_fail;
>> +	}
> There's no matching put for this in remove().
>
>> +	snd_soc_write(codec, TAS2552_CFG_2, TAS2552_CLASSD_EN |
>> +				  TAS2552_BOOST_EN | TAS2552_APT_EN |
>> +				  TAS2552_LIM_EN);
>> +	return 0;
> The class D is still being enabled here.

Thanks will send updates in a day or two.

-- 
------------------
Dan Murphy

