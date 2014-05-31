From: "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: Add support for CS4265 CODEC
Date: Sat, 31 May 2014 22:08:24 +0000
Message-ID: <0FB99937-124F-489E-B4A5-15BA0E91CA1B@cirrus.com>
References: <1400872614-21666-1-git-send-email-Paul.Handrigan@cirrus.com>
 <1400872614-21666-2-git-send-email-Paul.Handrigan@cirrus.com>,<20140523203945.GN22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140523203945.GN22111-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



> On May 23, 2014, at 3:40 PM, "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Fri, May 23, 2014 at 02:16:54PM -0500, Paul Handrigan wrote:
>> This patch adds support for the Cirrus Logic Stereo I2C CODEC
> 
> This all looks pretty clean and nice, I have got a few comments below
> but they're all pretty small things.
> 
>> +    SOC_SINGLE("De-emp 44.1kHz", CS4265_DAC_CTL, 1,
>> +                1, 0),
>> +    SOC_SINGLE("DAC INV", CS4265_DAC_CTL2, 5,
>> +                1, 0),
>> +    SOC_SINGLE("DAC Zero Cross", CS4265_DAC_CTL2, 6,
>> +                1, 0),
>> +    SOC_SINGLE("DAC Soft Ramp", CS4265_DAC_CTL2, 7,
>> +                1, 0),
> 
> All boolean controls should have Switch at the end of the name.
> 
>> +    SOC_SINGLE("ADC HPF Disable", CS4265_ADC_CTL, 1,
>> +                1, 0),
> 
> Invert this one and call it ADC HPF Switch (similarly for other disable
> controls).
> 
>> +
>> +    for (i = 0; i < ARRAY_SIZE(clk_map_table); i++) {
>> +        if (clk_map_table[i].rate == rate &&
>> +            clk_map_table[i].mclk == mclk)
>> +            return i;
> 
> Indent the second line of the if condition with the (.
> 
>> +static int cs4265_set_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
>> +            unsigned int freq, int dir)
>> +{
>> +    struct snd_soc_codec *codec = codec_dai->codec;
>> +    struct cs4265_private *cs4265 = snd_soc_codec_get_drvdata(codec);
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(clk_map_table); i++) {
>> +        if (clk_map_table[i].mclk == freq) {
> 
> It's better to check that clk_id is 0 here, just in case you think of
> another clock to control in future (perhaps with a new device that can
> share the same driver even if it's not possible for this one).
> 
>> +    {
>> +        .name = "cs4265-spdif",
>> +        .playback = {
>> +            .stream_name = "SPDIF Playback",
>> +            .channels_min = 1,
>> +            .channels_max = 2,
>> +            .rates = CS4265_SPDIF_RATES,
>> +            .formats = CS4265_FORMATS,
>> +        },
>> +        .ops = &cs4265_ops,
>> +    },
> 
> You should have separate operations for the DAC and S/PDIF DAIs and only
> mute the relevant interfaces.  If you can't mute the DAC DAIs
> independently just don't provide an operation and let the user control
> it as they like.  This avoids problems if more than one stream is
> running at once.

I am going to remove the S/PDIF DAI.  Since it is TX only.
> 
>> +static int cs4265_probe(struct snd_soc_codec *codec)
>> +{
>> +    return 0;
>> +}
> 
> Remove empty operations.
> 
>> +    } else {
>> +        pdata = devm_kzalloc(&i2c_client->dev,
>> +                     sizeof(struct cs4265_platform_data),
>> +                GFP_KERNEL);
>> +        if (!pdata) {
>> +            dev_err(&i2c_client->dev, "could not allocate pdata\n");
>> +            return -ENOMEM;
>> +        }
>> +        pdata->reset_gpio = of_get_named_gpio(i2c_client->dev.of_node,
>> +                        "reset-gpio", 0);
>> +        cs4265->pdata = *pdata;
>> +    }
> 
> Can you convert this to use the new gpiod_ APIs and directly request by
> name?  There's also the -gpios thing I mentioned for the binding.
> 
>> +    ret =  snd_soc_register_codec(&i2c_client->dev,
>> +            &soc_codec_dev_cs4265, cs4265_dai,
>> +            ARRAY_SIZE(cs4265_dai));
>> +    return ret;
> 
> devm_
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
