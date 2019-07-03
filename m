From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: codecs: ad193x: Group register
 initialization at probe
Date: Wed, 3 Jul 2019 15:39:19 +0800
Message-ID: <CA+Px+wXBBgeWbjZ5uQmwJgn+d=ZE-N0aehitog7==ak3GDxMsQ@mail.gmail.com>
References: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 27, 2019 at 8:05 PM Codrin Ciubotariu
<codrin.ciubotariu@microchip.com> wrote:
> +struct ad193x_reg_default {
> +       unsigned int reg;
> +       unsigned int val;
> +};
You probably don't need to define this.  There is a struct
reg_sequence in regmap.h.

> +
> +/* codec register values to set after reset */
> +static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
> +{
> +       const struct ad193x_reg_default reg_init[] = {
> +               {  0, 0x99 },   /* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
> +               {  1, 0x04 },   /* PLL_CLK_CTRL1: no on-chip Vref */
> +               {  2, 0x40 },   /* DAC_CTRL0: TDM mode */
> +               {  4, 0x1A },   /* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
> +               {  5, 0x00 },   /* DAC_CHNL_MUTE: unmute DAC channels */
> +       };
> +       const struct ad193x_reg_default reg_adc_init[] = {
> +               { 14, 0x03 },   /* ADC_CTRL0: high-pass filter enable */
> +               { 15, 0x43 },   /* ADC_CTRL1: sata delay=1, adc aux mode */
> +       };
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(reg_init); i++)
> +               regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
> +
> +       if (ad193x_has_adc(ad193x)) {
> +               for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
> +                       regmap_write(ad193x->regmap, reg_adc_init[i].reg,
> +                                    reg_adc_init[i].val);
> +               }
> +       }
And you could use regmap_multi_reg_write( ) to substitute the two for-loops.

See https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/151090.html
as an example.  It also has some reg initializations in component
probe( ).
