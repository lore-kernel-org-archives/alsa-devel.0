From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: Add support for NAU8825 codec to
 ASoC
Date: Mon, 13 Jul 2015 10:23:10 +0100
Message-ID: <1436779390.2533.20.camel@loki>
References: <55A369B2.5040500@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A369B2.5040500@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>
Cc: Mark Brown <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-07-13 at 15:33 +0800, Chih-Chiang Chang wrote:
> +static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
> +{
> +    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +    pr_debug("%s :: sys_clk=%x\n", __func__, sys_clk);
> +    switch (sys_clk) {
> +    case NAU8825_INTERNALCLOCK:
> +        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_DIS);
> +        regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
> +                NAU8825_DCO_EN_MASK, NAU8825_DCO_EN);
> +        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_EN);
> +        break;
> +    case NAU8825_MCLK:
> +    default:
> +        regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
> +                NAU8825_DCO_EN_MASK, NAU8825_DCO_DIS);
> +        regmap_update_bits(nau8825->regmap, NAU8825_I2S_PCM_CTRL_2,
> +                NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
> +        /* FLL clock source from MCLK */
> +        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_DIS);
> +        mdelay(2);

Probably best to sleep here rather than block, especially if this code
will be used in init/PM sequences.

Btw, is there anyway to check whether the FLL actually achieves lock
after the 2ms ?

> +        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_EN);
> +        break;
> +    }
> +}
> +

Thanks

Liam
