From: <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/2] ASoC: Add support for CS43130 codec
Date: Mon, 12 Dec 2016 14:21:03 -0600
Message-ID: <148597dd-ce8d-4684-8f39-149e780d2b3b@EX3.ad.cirrus.com>
References: <09a77398-831b-4be7-9089-f7ac4fcfc16a@EX4.ad.cirrus.com>
 <20161208162336.l5g5cbcc2bzt65ke@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161208162336.l5g5cbcc2bzt65ke-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Thank you for timely feedback.

I have fixed all except following.

---------------------------------------------------------------------------------------------------------------------------------------------------
> +     case SND_SOC_DAPM_PRE_PMU:
> +             if (cs43130->pll_bypass)
> +                     cs43130_change_clksrc(codec, CS43130_MCLK_SRC_XTAL);
> +             else
> +                     cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
> +
> +             usleep_range(10000, 10050);
> +             /*ASP_3ST = 0 in master mode*/
> +             if (cs43130->dai_mode)
> +                     regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
> +                                                 0x01, 0x00);

No need to undo this in slave mode?

Master mode specific configuration

---------------------------------------------------------------------------------------------------------------------------------------------------
> +     /* Enable HP detect */
> +     regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
> +             CS43130_HP_DETECT_CTRL_MASK, CS43130_HP_DETECT_CTRL_MASK);

Why enable this when the only handling is a couple of log messages?

Placeholder for driver modification when the driver is integrated to system such as Android OS.

I suppose I could remove it, but when the driver is integrated into actual system, it may not be clear to system integrators,
where to add HP DET IRQ hooks

---------------------------------------------------------------------------------------------------------------------------------------------------
> +                     regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_9,
> +                                         CS43130_PLL_REF_PREDIV_MASK,
> +                                             pll_ratio_table[i].sclk_prediv
> +                                             );

There's no need for the ); to be on a new line here, nor for the extra
indentation on the line before.  There are lots more coding style
issues, checkpatch will probably pick up many of them.

Fixed.  

Regarding regmap_update_bits(), while I could make this API call in two lines,
often the two lines exceed 80 character limit, mandated by Linux.
If exceeding 80 char limit is ok, then I can certainly modify the API call.

checkpatch.pl did not flag additional formatting issues except for 

"Possible switch case/default not preceeded by break or fallthrough comment"

which I believe should be ok

________________________________________
From: Mark Brown [broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
Sent: Thursday, December 08, 2016 10:23 AM
To: Xu, Li
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; perex-/Fr2/VpizcU@public.gmane.org; tiwai-IBi9RG/b67k@public.gmane.org; Austin, Brian; Handrigan, Paul
Subject: Re: [PATCH 1/2] ASoC: Add support for CS43130 codec

On Wed, Dec 07, 2016 at 02:17:27PM -0600, Li Xu wrote:

Overall this looks pretty good - there's a fair number of issues below
but they're all fairly simple stylistic things rather than anything
majorly wrong so hopefully should be easy to correct.

>       select SND_SOC_CS53L30 if I2C
> +     select SND_SOC_CS43130 if I2C
>       select SND_SOC_CX20442 if TTY

Please keep Kconfig and Makefile sorted.

> +static bool cs43130_volatile_register(struct device *dev, unsigned int reg)
> +{
> +     switch (reg) {
> +     case CS43130_DEVID_AB ... CS43130_SUBREV_ID:
> +     case CS43130_INT_STATUS_1 ... CS43130_INT_STATUS_5:
> +             return true;

You don't need to mark the device ID volatile, just don't provide
defaults and regmap will cache it the first time it reads it.  If the
device ID is volatile you've got bigger problems.

> +                     /*PDN_PLL= 0,enable*/

Please use the standard kernel coding style, need spaces here.

> +                     regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_9,
> +                                         CS43130_PLL_REF_PREDIV_MASK,
> +                                             pll_ratio_table[i].sclk_prediv
> +                                             );

There's no need for the ); to be on a new line here, nor for the extra
indentation on the line before.  There are lots more coding style
issues, checkpatch will probably pick up many of them.

> +     case SND_SOC_DAPM_PRE_PMU:
> +             if (cs43130->pll_bypass)
> +                     cs43130_change_clksrc(codec, CS43130_MCLK_SRC_XTAL);
> +             else
> +                     cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
> +
> +             usleep_range(10000, 10050);
> +             /*ASP_3ST = 0 in master mode*/
> +             if (cs43130->dai_mode)
> +                     regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
> +                                                 0x01, 0x00);

No need to undo this in slave mode?

> +     if (stickies[0] & CS43130_XTAL_ERR_INT)
> +             pr_debug("%s: Crystal err\n", __func__);

dev_ prints and shouldn't this one be an error?

> +     /* Enable HP detect */
> +     regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
> +             CS43130_HP_DETECT_CTRL_MASK, CS43130_HP_DETECT_CTRL_MASK);

Why enable this when the only handling is a couple of log messages?

> +#ifdef CONFIG_PM
> +static int cs43130_runtime_suspend(struct device *dev)
> +{
> +     return 0;
> +}

Remove empty functions, they don't serve any purpose.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
