From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH v6 1/3] ASoC: sun4i-i2s: incorrect regmap
 for A83T
Date: Tue, 27 Aug 2019 12:13:04 +0800
Message-ID: <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com>
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-2-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826180734.15801-2-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Code Kipper <codekipper@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2019 at 2:07 AM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> The regmap configuration is set up for the legacy block on the
> A83T whereas it uses the new block with a larger register map.

Looking at the code Allwinner previously released [1], that doesn't seem to be
the case. Keep in mind that the register map shown in the user manual is for
the TDM interface, which we don't actually support right now.

The file shows the base address as 0x01c22800, and the last defined register
is SUNXI_RXCHMAP at 0x3c.

The I2S driver [2] also shows that it is the old register map size, but with
TX_FIFO and INT_STA swapped around. This might mean that it would need a
separate regmap_config, as the read/write callbacks need to be changed to
fit the swapped registers.

Finally, the TDM driver [3], which matches the TDM section in the manual, shows
a larger register map.

A83T is SUN8IW6, while SUN8IW7 refers to the H3.

ChenYu

[1] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.h
[2] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/i2s0/sunxi-i2s0.h
[3] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/daudio0/sunxi-daudio0.h

> Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 57bf2a33753e..34575a8aa9f6 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1100,7 +1100,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>  static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
>         .has_reset              = true,
>         .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> -       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> +       .sun4i_i2s_regmap       = &sun8i_i2s_regmap_config,
>         .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
>         .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
>         .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190826180734.15801-2-codekipper%40gmail.com.
