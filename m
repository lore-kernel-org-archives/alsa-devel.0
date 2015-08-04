From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Mon, 3 Aug 2015 20:13:40 -0700
Message-ID: <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B2FB926064F
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 05:13:41 +0200 (CEST)
Received: by vkhl6 with SMTP id l6so804691vkh.1
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2015 20:13:40 -0700 (PDT)
In-Reply-To: <20150731182716.GO20873@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, mfelton1@nuvoton.com, So KC <kcso@nuvoton.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>, Dylan Reid <dgreid@google.com>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Jul 31, 2015 at 11:27 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 27, 2015 at 04:13:57PM -0700, Anatol Pomozov wrote:
>
> Looks mostly good, a few things below though:
>
>> +             break;
>> +     case 1:
>> +             dev_info(nau8825->dev, "OMTP (micgnd1) mic connected\n");
>
> This is far too noisy - these should be dev_dbg() at most.

Done

>
>> +             } else {
>> +                     dev_warn(nau8825->dev, "Headset completion IRQ fired but no headset connected\n");
>> +                     nau8825_eject_jack(nau8825);
>> +             }
>
> Things like this that aren't supposed to happen are fine but normal
> operation shouild be quiet.
>
>> +     /* VMID Enable and Tieoff */
>> +     regmap_write(regmap, NAU8825_REG_BIAS_ADJ, 0x0060);
>
> You're leavinng VMID enabled all the timme?

Currently yes. One of the next steps is to look at the power
management for this chip (set_bias and suspend/resume). I need to work
with Nuvoton HW engineers to find correct sequence of steps.

>
>> +     /* Jack Detect pull up (High=eject, Low=insert) */
>> +     regmap_write(regmap, NAU8825_REG_GPIO12_CTRL, 0x0800);
>
> This seems like it should be a board setting?

Created DTS property for it. Thanks.

>
>> +     /* Setup SAR ADC */
>> +     regmap_write(regmap, NAU8825_REG_SAR_CTRL, 0x0280);
>
> Lots of magic numbers in these things...

These init config settings recommended by Nuvoton engineers. I found
that chip requires quite a lot of initial preconfiguration to get it
into operating state.

> some of them I can guess
> what's going on but this one is a bit obscure, perhaps it should be user
> controllable?

This setting configures SARADC (ADC for sensing button presses). It
sets sample rate, series resistor and ADC voltage range. It does not
look like they need to be user-controllable.

>
>> +     /* Setup ADC x128 OSR */Moved to
>> +     regmap_write(regmap, NAU8825_REG_ADC_RATE, 0x0002);
>> +     /* Setup DAC x128 OSR */
>> +     regmap_write(regmap, NAU8825_REG_DAC_CTRL1, 0x0082);
>
> I'd expect this to be user controllable.

The oversampling configuration is important for chip audio quality.
There is audible hissing without these settings.

My understanding that all users need to set these values and it is
better to move it to the driver initialization sequence.

>> +static int nau8825_i2c_probe(struct i2c_client *i2c,
>> +     const struct i2c_device_id *id)
>> +{
>> +     struct device *dev = &i2c->dev;
>> +     struct nau8825 *nau8825;
>> +     int ret, value;
>> +
>> +     nau8825 = devm_kzalloc(dev, sizeof(*nau8825), GFP_KERNEL);
>> +     if (!nau8825)
>> +             return -ENOMEM;
>> +
>> +     i2c_set_clientdata(i2c, nau8825);
>> +
>> +     nau8825->regmap = devm_regmap_init_i2c(i2c, &nau8825_regmap_config);
>> +     if (IS_ERR(nau8825->regmap))
>> +             return PTR_ERR(nau8825->regmap);
>> +     nau8825->irq = i2c->irq;
>> +     nau8825->dev = dev;
>> +
>> +     nau8825_reset_chip(nau8825->regmap);
>> +     ret = regmap_read(nau8825->regmap, NAU8825_REG_I2C_DEVICE_ID, &value);
>> +     if (ret < 0) {
>> +             dev_err(dev, "Failed to read device id from the NAU8825: %d\n",
>> +                     ret);
>> +             return ret;
>> +     }
>> +     if ((value & NAU8825_SOFTWARE_ID_MASK) !=
>> +                     NAU8825_SOFTWARE_ID_NAU8825) {
>> +             dev_err(dev, "Not a NAU8825 chip\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     return snd_soc_register_codec(&i2c->dev, &nau8825_codec_driver,
>> +                     &nau8825_dai, 1);
>> +}
>
> I'd expect any initial register initialistion to happen here (if only so
> we save power until the card registers).

Moved most of the initialization here. The only part is left in
codec_probe() is interruption initialization via I2S master mode
toggling. That toggling trick depends on MCLK signal to initialize
interruption block correctly. In our case (a tegra SoC device) MCLK is
initialized later at audio platform driver probe.
