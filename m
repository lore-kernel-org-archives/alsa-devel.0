From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine driver
Date: Wed, 18 Jun 2014 18:22:52 +0800
Message-ID: <53A1687C.9010705@kosagi.com>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com> <1403063242-20840-4-git-send-email-xobs@kosagi.com> <20140618100233.GE5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140618100233.GE5099-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 06/18/14 18:02, Mark Brown wrote:
> On Wed, Jun 18, 2014 at 11:47:21AM +0800, Sean Cross wrote:
>
>> +config SND_SOC_IMX_ES8328
>> +	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
>> +	depends on OF && (I2C || SPI)
>> +	select SND_SOC_ES8328_I2C if I2C
>> +	select SND_SOC_ES8328_SPI if SPI_MASTER
> I expect this is going to break configurations where I2C is modular and
> SPI is enabled since it'll try to build in the I2C bus interface.
I see this pattern used frequently in the blackfin tree.  Is there a way
to achieve this without breaking configuration?
>> +static int imx_set_frequency(struct imx_es8328_data *data, int freq)
>> +{
>> +	int ret;
>> +
>> +	ret = clk_set_parent(data->output_clk, data->codec_clk);
>> +	if (ret) {
>> +		dev_err(data->dev, "unable to set clk output");
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_set_parent(data->codec_clk_sel, data->codec_clk_post_div);
>> +	if (ret) {
>> +		dev_err(data->dev, "unable to set clk parent");
>> +		return ret;
>> +	}
> This should be handled by the clock bindings not open coded in the
> driver - leaving this here most likely won't play nicely when the clock
> API can configure the defaults for the tree.  There is supposed to be
> support for setting default clock trees going in (or perhaps already in)
> the clock bindings.
Can you give me more information on it?  Currently, it looks like most
boards use a 24 MHz clock, judging from this comment in
mach-imx/clk-imx6q.c:

        /*
         * Let's initially set up CLKO with OSC24M, since this configuration
         * is widely used by imx6q board designs to clock audio codec.
         */

This codec requires the more unusual 22.5792 MHz clock.  What is the
appropriate method of obtaining this particular frequency?

>> +	data->codec_regulator = devm_regulator_get(dev, "codec");
>> +	if (IS_ERR(data->codec_regulator)) {
>> +		dev_err(dev, "No codec regulator\n");
>> +		data->codec_regulator = NULL;
>> +	} else {
>> +		ret = regulator_enable(data->codec_regulator);
>> +		if (ret)
>> +			dev_err(dev,
>> +				"Unable to enable codec regulator: %d\n", ret);
>> +	}
> No, this is broken.  The CODEC should request its own supplies which
> need to correspond to the supplies the physical device has and failing
> to get the supplies should be a fatal error unless the device works
> without power (in which case why bother enablin them at all?).
Not all codecs have power supplies.  Most don't, in fact, it's just this
board where a switch was added to reset the codec in case it gets
wedged.  Boards might use this codec but omit the power switch to save
cost, because they are confident the codec won't get stuck, in which
case they would be forced to use a dummy regulator.

Additionally, since the regulator is external to the codec (as it
physically cuts 3.3V from the power supply), it doesn't make sense to
put it in the codec driver.


Sean
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
