From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] ASoC: cs35l36: Add
 support for Cirrus CS35L36 Amplifier
Date: Wed, 14 Nov 2018 18:54:02 +0000
Message-ID: <SN2PR19MB08131DB009E1162D35CEED2DE4C30@SN2PR19MB0813.namprd19.prod.outlook.com>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <20181113192556.GI2089@sirena.org.uk>,
 <alpine.DEB.2.10.1811141254470.9698@james-tower>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 923862677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 19:54:10 +0100 (CET)
In-Reply-To: <alpine.DEB.2.10.1811141254470.9698@james-tower>
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
To: James Schulman <james@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Keepax, Charles" <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 Nov 2018, Mark Brown wrote:

> On Tue, Nov 13, 2018 at 12:49:16PM -0600, James Schulman wrote:
>
>> +++ b/sound/soc/codecs/cs35l36-tables.c
>> @@ -0,0 +1,315 @@
>> +/*
>> + * cs35l36-tables.c -- CS35L36 ALSA SoC audio driver
>> + *
>> + * Copyright 2018 Cirrus Logic, Inc.
>
> Please use SPDX headers.
>

Will do.

>> +    SOC_SINGLE_TLV("AMP PCM Gain", CS35L36_AMP_GAIN_CTRL, 5, 0x13, 0,
>> +                    amp_gain_tlv),
>
> All volume controls should end in Volume, see control-names.rst.
>
>> +            regmap_read(cs35l36->regmap, CS35L36_INT4_RAW_STATUS, &reg);
>> +            if (reg & CS35L36_PLL_UNLOCK_MASK)
>> +                    dev_crit(cs35l36->dev, "PLL Unlocked\n");
>
> WARN_ON_ONCE?
>

Will do.

>> +    }
>> +    return 0;
>> +}
>> +static const char * const cs35l36_chan_text[] = {
>
> Missing blank line.
>

Will do.

>> +static const char * const cs35l36_boost_text[] = {
>> +    "On",
>> +    "Off",
>> +};
>> +
>> +static SOC_ENUM_SINGLE_DECL(boost_enum, SND_SOC_NOPM, 0,
>> +            cs35l36_boost_text);
>> +
>> +static const struct snd_kcontrol_new cs35l36_boost_mux[] = {
>> +    SOC_DAPM_ENUM("Boost Enable", boost_enum),
>> +};
>
> Simple on/off conttrols should be _SINGLE controls with Switch at the
> end of their name.  It's not super clear why this is in DAPM as a widget
> at all, the routing around it is:
>
> +       {"BOOST Mux", "On", "Channel Mux"},
> +       {"CLASS H", NULL, "BOOST Mux"},
>
> which is a bit perplexing.  Possibly this should be handled in the event
> for the main amplifier?
>

We used _ENUM instead of _SINGLE because we wanted the default value to be
"On" instead of "Off". We don't want the default assumption to have boost
turned off. However, we're happy to change this if you would rather have
consitency with the _SINGLE controls.

>> +    if (cs35l36->sclk > 6000000) {
>> +            fs1_val = 3 * 4 + 4;
>> +            fs2_val = 8 * 4 + 4;
>> +    }
>
> These are just constants, why write out the operations?
>

Will do.

>> +
>> +    if (cs35l36->sclk <= 6000000) {
>
> if/else?
>

Will do.

>> +    /*
>> +     * Rev B0 has 2 versions
>> +     * L36 is 10V
>> +     * L37 is 12V
>
> \o/
>

Yes we had 2 silicon spins for this revision >_< is there anything about
this comment you want us to change?

>> +    }
>> +
>> +    return IRQ_HANDLED;
>
> This unconditionally reports that it handled the interrupt, even if it
> didn't.  This will stop the interrupt core handling for faulty interrupt
> lines working and will disrupt any support that gets added for handling
> shared threaded interrupts.
>

Earlier in the handler, we have a check to see if any unmasked bits are
set. If not we return IRQ_NONE. I figured this would be enough to ensure
we don't unconditionally report IRQ_HANDLED.

>> +    if (pdata)
>> +            cs35l36->pdata = *pdata;
>> +    else {
>
> Use { } on both sides of the if (see coding-style.rst)?
>

Will do.

>> +    cs35l36->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>> +                                                  GPIOD_OUT_LOW);
>> +    if (IS_ERR(cs35l36->reset_gpio)) {
>> +            ret = PTR_ERR(cs35l36->reset_gpio);
>> +            cs35l36->reset_gpio = NULL;
>> +            if (ret == -EBUSY)
>> +                    dev_info(dev,
>> +                             "Reset line busy, assuming shared reset\n");
>> +            else {
>> +                    dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
>> +                    goto err;
>> +            }
>> +    }
>
> This doesn't handle -EPROBE_DEFER.
>

I think we will add an err_disable_regs jump statement to ensure we don't
try to use the uninitialized reset_gpio handle. Once we do that, I think
this will handle -EPROBE_DEFER cleanly?

Thanks for the comments Mark.
- James
