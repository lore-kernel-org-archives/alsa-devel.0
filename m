From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 05/12] sun4i-codec: Move struct sun4i_codec_quirks further up.
Date: Fri, 9 Jun 2017 15:46:25 +0800
Message-ID: <CAGb2v66tnwdr2mGMvmdTM_gsNLeWJj35TLHCELhK1ixQ8nNpqA@mail.gmail.com>
References: <20170609062216.26807-1-dannym@scratchpost.org> <20170609062216.26807-6-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609062216.26807-6-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 9, 2017 at 2:22 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:

Why?

> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 25870a64..f56a59ad 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -889,6 +889,16 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>
>  };
>
> +struct sun4i_codec_quirks {
> +       const struct regmap_config *regmap_config;
> +       const struct snd_soc_codec_driver *codec;
> +       struct snd_soc_card * (*create_card)(struct device *dev);
> +       struct reg_field reg_adc_fifoc; /* used for regmap_field */
> +       unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config */
> +       unsigned int reg_adc_rxdata;    /* RX FIFO offset for DMA config */
> +       bool has_reset;
> +};
> +
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
>         .component_driver = {
>                 .controls               = sun4i_codec_controls,
> @@ -1546,16 +1556,6 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
>         .max_register   = SUN8I_H3_CODEC_ADC_DBG,
>  };
>
> -struct sun4i_codec_quirks {
> -       const struct regmap_config *regmap_config;
> -       const struct snd_soc_codec_driver *codec;
> -       struct snd_soc_card * (*create_card)(struct device *dev);
> -       struct reg_field reg_adc_fifoc; /* used for regmap_field */
> -       unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config */
> -       unsigned int reg_adc_rxdata;    /* RX FIFO offset for DMA config */
> -       bool has_reset;
> -};
> -
>  static const struct sun4i_codec_quirks sun4i_codec_quirks = {
>         .regmap_config  = &sun4i_codec_regmap_config,
>         .codec          = &sun4i_codec_codec,
