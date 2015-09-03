From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Thu, 3 Sep 2015 10:10:05 -0700
Message-ID: <CAOMFOmUR0DQD82AU9-8XrA0vscRkC0UxaV5ZvOOa6TG4RZDs1Q@mail.gmail.com>
References: <1440805070-39150-1-git-send-email-anatol.pomozov@gmail.com>
 <20150830144717.GD12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B9F9D2606BC
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 19:10:06 +0200 (CEST)
Received: by vkhf67 with SMTP id f67so28361266vkh.1
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2015 10:10:06 -0700 (PDT)
In-Reply-To: <20150830144717.GD12027@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ben Zhang <benzh@google.com>, Dylan Reid <dgreid@google.com>, mfelton1@nuvoton.com, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Sun, Aug 30, 2015 at 7:47 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 28, 2015 at 04:37:50PM -0700, Anatol Pomozov wrote:
>
>> +     SOC_SINGLE_TLV("Frontend PGA Gain", NAU8825_REG_POWER_UP_CONTROL,
>> +             8, 37, 0, fepga_gain_tlv),
>
> All volume controls need to end in Volume as per ControlNames.txt.

Done.

>
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +     regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,
>
> Blank line here.

Done.

>> +     /* Bias and clock are needed for button detection */
>> +     regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
>> +             NAU8825_BIAS_VMID, NAU8825_BIAS_VMID);
>> +     regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
>> +             NAU8825_GLOBAL_BIAS_EN, NAU8825_GLOBAL_BIAS_EN);
>
> These sound like DAPM widgets which should be being eneabled when jack
> detection is enabled.

The bias/vmid need to be enabled before clock/interruptions. Moving it
to set_bias or to a widget makes interrupts non-functional. bias/vmid
is also needed for capture and playback. So I think it is ok to enable
it here. Later Nuvoton engineers will look at power management closer
and might find better place for bias setup.

>> +     /* Ground HP Outputs[1:0], needed for headset auto detection
>> +      * Enable Automatic Mic/Gnd switching reading on insert interrupt[6] */
>> +     regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL,
>> +             NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
>> +             NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
>
> I'm still not happy to see the unconditional enabling of detection and
> switching.

Moved to enable_jack_detection(). Note that it looses "auto mic type
detection" functionality if jack_detection is disabled. Such auto mic
detection might be useful even in case if there is no physical jack
and input/output routes are soldered statically.

>
>> +             if (!nau8825->mclk_freq)
>> +                     clk_prepare_enable(nau8825->mclk);
>
> You should be checking the return value here.

Done.

>
>> +             if (nau8825->mclk_freq != freq) {
>> +                     nau8825->mclk_freq = freq;
>> +
>> +                     freq = clk_round_rate(nau8825->mclk, freq);
>> +                     clk_set_rate(nau8825->mclk, freq);
>
> Likewise here and in other cases where you're setting clocks.
>
>> +     nau8825->jkdet_enable = device_property_read_bool(dev,
>> +             "nuvoton,jkdet-enable");
>
> This DT parsing stuff should really be moved out into a separate
> function

Thanks. Moved.

> which is only called (or only does anything) if there is
> actually DT data (if there is an of_node set).

device_property_read_* handles both DTS and ACPI that covers most
(all?) modern systems.

Or are you talking about case when a platform driver passes
pre-initialized data from using dev_get_platdata() (like what rt5677
does)? I assume this is a deprecated style that predates DTS/ACPI
style configuration.

>
>> +     if (nau8825->irq) {
>> +             int ret = devm_request_threaded_irq(dev, nau8825->irq, NULL,
>> +                     nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +                     "nau8825", nau8825);
>> +
>> +             if (ret) {
>> +                     dev_err(dev, "Cannot request irq %d (%d)\n",
>> +                             nau8825->irq, ret);
>> +                     return ret;
>> +             }
>> +     }
>
> So we actually handle systems with no interrupt wired up?

I think it worth adding such configuration. Without the IRQ line this
chip looses large part of its functionality (jack detection, mic auto
detect, buttons, cross-talk configuration) but at least playback
should work.

> That seems to
> make all the non-optional enabling of the jack detection interrupts a
> bit odd.

Moved jack irq enabling to enable_jack_detection()

>
>> +static struct i2c_driver nau8825_driver = {
>> +     .driver = {
>> +             .name = "nau8825",
>> +             .owner = THIS_MODULE,
>> +     },
>> +     .probe = nau8825_i2c_probe,
>> +     .remove = nau8825_i2c_remove,
>> +     .id_table = nau8825_i2c_ids,
>> +};
>
> This has a DT binding but no OF IDs defined.  It is true that Linux will
> currently try to guess a suitable driver based on the I2C ID table but
> it is bad practice to rely on this behaviour, we do see ID collisions
> sometimes (for example both WonderMedia and Wolfson using WM for their
> parts).

Done. Thanks for the pointer.
