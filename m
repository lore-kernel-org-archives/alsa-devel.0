From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Date: Wed, 14 Aug 2019 19:31:27 +0800
Message-ID: <CAGb2v65OdwwDg0Ezc0eXShvp1crQfmt6ZKAkWpOH9Dz94HFrEw@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814060854.26345-16-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Code Kipper <codekipper@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2019 at 2:09 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d3c8789f70bb..ecfc1ed79379 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -876,9 +876,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  {
>         /* Flush RX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> +       regcache_cache_bypass(i2s->regmap, false);
>
>         /* Clear RX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> @@ -897,9 +899,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>  {
>         /* Flush TX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> +       regcache_cache_bypass(i2s->regmap, false);
>
>         /* Clear TX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> @@ -1053,13 +1057,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
>
>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>  {
> -       switch (reg) {
> -       case SUN4I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> +       return true;

The commit log needs to explain why this is relevant. And I'm not sure why one
would read back the TX FIFO. Also, if it's always true, just drop the callback.

ChenYu

>  }
>
>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> @@ -1078,6 +1076,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
>         case SUN4I_I2S_FIFO_RX_REG:
> +       case SUN4I_I2S_FIFO_TX_REG:
> +       case SUN4I_I2S_FIFO_STA_REG:
>         case SUN4I_I2S_INT_STA_REG:
>         case SUN4I_I2S_RX_CNT_REG:
>         case SUN4I_I2S_TX_CNT_REG:
> @@ -1088,23 +1088,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>         }
>  }
>
> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> -{
> -       switch (reg) {
> -       case SUN8I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> -}
> -
>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         if (reg == SUN8I_I2S_INT_STA_REG)
>                 return true;
>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> -               return false;
> +               return true;
>
>         return sun4i_i2s_volatile_reg(dev, reg);
>  }
> @@ -1175,7 +1164,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
>         .reg_defaults   = sun8i_i2s_reg_defaults,
>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>         .writeable_reg  = sun4i_i2s_wr_reg,
> -       .readable_reg   = sun8i_i2s_rd_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
>         .volatile_reg   = sun8i_i2s_volatile_reg,
>  };
>
> @@ -1188,7 +1177,7 @@ static const struct regmap_config sun50i_i2s_regmap_config = {
>         .reg_defaults   = sun50i_i2s_reg_defaults,
>         .num_reg_defaults       = ARRAY_SIZE(sun50i_i2s_reg_defaults),
>         .writeable_reg  = sun4i_i2s_wr_reg,
> -       .readable_reg   = sun8i_i2s_rd_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
>         .volatile_reg   = sun8i_i2s_volatile_reg,
>  };
>
> --
> 2.22.0
>
