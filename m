From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] ASoC: sun4i: Revert A83t description
Date: Tue, 27 Aug 2019 17:51:59 +0800
Message-ID: <CAGb2v64u+Q87woZpVbRLfwn=ocbx9QJeANYiALZ7x7rdDFXc=w@mail.gmail.com>
References: <20190827093206.17919-1-mripard@kernel.org> <20190827093206.17919-2-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827093206.17919-2-mripard@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Code Kipper <codekipper@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2019 at 5:32 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The last set of reworks included some fixes to change the A83t behaviour
> and "fix" it.
>
> It turns out that the controller described in the datasheet and the one
> supported here are not the same, yet the A83t has the two of them, and the
> one supported in the driver wasn't the one described in the datasheet.
>
> Fix this by reintroducing the proper quirks.
>
> Fixes: 69e450e50ca6 ("ASoC: sun4i-i2s: Fix the LRCK period on A83t")
> Fixes: bf943d527987 ("ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t")
> Fixes: 2e04fc4dbf50 ("ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t")
> Fixes: 515fcfbc7736 ("ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs")
> Fixes: c1d3a921d72b ("ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs")
> Fixes: fb19739d7f68 ("ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs")
> Fixes: 71137bcd0a9a ("ASoC: sun4i-i2s: Move the format configuration to a callback")
> Fixes: d70be625f25a ("ASoC: sun4i-i2s: Move the channel configuration to a callback")
> Reported-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a6a3f772fdf0..498ceebd9135 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1106,18 +1106,18 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
>         .has_reset              = true,
>         .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> -       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> -       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
> -       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> -       .bclk_dividers          = sun8i_i2s_clk_div,
> -       .num_bclk_dividers      = ARRAY_SIZE(sun8i_i2s_clk_div),
> -       .mclk_dividers          = sun8i_i2s_clk_div,
> -       .num_mclk_dividers      = ARRAY_SIZE(sun8i_i2s_clk_div),
> -       .get_bclk_parent_rate   = sun8i_i2s_get_bclk_parent_rate,
> -       .get_sr                 = sun8i_i2s_get_sr_wss,
> -       .get_wss                = sun8i_i2s_get_sr_wss,
> -       .set_chan_cfg           = sun8i_i2s_set_chan_cfg,
> -       .set_fmt                = sun8i_i2s_set_soc_fmt,
> +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> +       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
> +       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
> +       .bclk_dividers          = sun4i_i2s_bclk_div,
> +       .num_bclk_dividers      = ARRAY_SIZE(sun4i_i2s_bclk_div),
> +       .mclk_dividers          = sun4i_i2s_mclk_div,
> +       .num_mclk_dividers      = ARRAY_SIZE(sun4i_i2s_mclk_div),
> +       .get_bclk_parent_rate   = sun4i_i2s_get_bclk_parent_rate,
> +       .get_sr                 = sun4i_i2s_get_sr_wss,
> +       .get_wss                = sun4i_i2s_get_sr_wss,

You want sun4i_i2s_get_sr and sun4i_i2s_get_wss here.

Otherwise, with both patches applied, I2S on the A83T returns to normal.

Tested-by: Chen-Yu Tsai <wens@csie.org>

on the Bananapi-M3 with a PiFi DAC v2.0 (has PCM5122) connected.
16bit stereo 44.1kHz, 48kHz, and 96kHz samples tested.

> +       .set_chan_cfg           = sun4i_i2s_set_chan_cfg,
> +       .set_fmt                = sun4i_i2s_set_soc_fmt,
>  };
>
>  static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> --
> 2.21.0
>
