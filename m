From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: Add ADAU1X61 and ADAU1X81 CODECs
	common code
Date: Thu, 29 Aug 2013 09:58:19 +0200
Message-ID: <521EFF1B.9070202@metafoo.de>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
 <20130828165957.GL10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-004.synserver.de (smtp-out-004.synserver.de
 [212.40.185.4]) by alsa0.perex.cz (Postfix) with ESMTP id 0075A261646
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 09:56:49 +0200 (CEST)
In-Reply-To: <20130828165957.GL10783@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/28/2013 06:59 PM, Mark Brown wrote:
> On Wed, Aug 28, 2013 at 05:20:09PM +0200, Lars-Peter Clausen wrote:
> 
>> +static void adau17x1_check_aifclk(struct snd_soc_codec *codec)
>> +{
>> +	struct adau *adau = snd_soc_codec_get_drvdata(codec);
>> +
>> +	/* If we are in master mode we need to generate bit- and frameclock,
>> +	 * regardless of whether there is an active path or not */
>> +	if (codec->active && adau->master)
>> +		snd_soc_dapm_force_enable_pin(&codec->dapm, "AIFCLK");
>> +	else
>> +		snd_soc_dapm_disable_pin(&codec->dapm, "AIFCLK");
>> +	snd_soc_dapm_sync(&codec->dapm);
>> +}
> 
> I think this is eminently sensible but it seems like it should be a
> framework feature.  That'd have to enable an actual AIF slot though
> which is a bit fun, which slot do we enable for example?

It would be nice if this could be handled by the core. But how? One option
might be tracking the the DAI format in the core and power up the DAI widget
in DAPM if the stream is active regardless of if there is an active path if
the DAI is in master mode. That may power up more than what is needed
though. E.g. for this CODEC the clock generator and the rest of the DAI can
be powered up independently and we only need to power up the clock generator.

> 
>> +static int adau17x1_set_dai_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
>> +{
>> +	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
>> +
>> +	if (div < 0 || div > 4)
>> +		return -EINVAL;
>> +
>> +	adau->sysclk_div = div;
>> +
>> +	return regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
>> +		ADAU17X1_CLOCK_CONTROL_INFREQ_MASK, (div - 1) << 1);
>> +}
> 
> What's this doing?  It'd be better to have a specific ID and check that
> too.

Setting the relationship between the external clock rate and the internal
base sample rate. There might be a better way to do this though.

> 
>> +int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
>> +	enum adau17x1_micbias_voltage micbias)
>> +{
>> +	struct adau *adau = snd_soc_codec_get_drvdata(codec);
>> +
>> +	switch (micbias) {
>> +	case ADAU17X1_MICBIAS_0_90_AVDD:
>> +	case ADAU17X1_MICBIAS_0_65_AVDD:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_write(adau->regmap, ADAU17X1_MICBIAS, micbias << 2);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(adau17x1_set_micbias_voltage);
> 
> When would a machine driver use this (as opposed to just letting it be
> set by platform data)?

It is not meant to be used by machine drivers, but by the adau1761 and
adau1781 CODEC drivers, which set the micbias based on platform data.

Thanks for the fast review,
- Lars
