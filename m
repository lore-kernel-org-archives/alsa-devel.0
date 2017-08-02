From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH v3 08/12] ASoC: sun4i-i2s:
 Add mclk enable regmap field
Date: Wed, 2 Aug 2017 11:20:27 +0800
Message-ID: <CAGb2v65FRyp_2BfhReZF5zbqxxX2w3gzpnLLHXOJoDCt5j_a9w@mail.gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-9-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id E480C266A8A
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 05:20:51 +0200 (CEST)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 17E1922342
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 11:20:50 +0800 (CST)
Received: by mail-io0-f174.google.com with SMTP id m88so15424249iod.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Aug 2017 20:20:50 -0700 (PDT)
In-Reply-To: <20170729141753.20174-9-codekipper@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Code Kipper <codekipper@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The location of the mclk output enable bit is different on newer
> SoCs. Use a regmap field to enable it.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 90daa974bd27..6d8d2c4a675b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -74,7 +74,7 @@
>  #define SUN4I_I2S_INT_STA_REG          0x20
>
>  #define SUN4I_I2S_CLK_DIV_REG          0x24
> -#define SUN4I_I2S_CLK_DIV_MCLK_EN              BIT(7)
> +#define SUN4I_I2S_CLK_DIV_MCLK_EN              7
>  #define SUN4I_I2S_CLK_DIV_BCLK_MASK            GENMASK(6, 4)
>  #define SUN4I_I2S_CLK_DIV_BCLK(bclk)                   ((bclk) << 4)
>  #define SUN4I_I2S_CLK_DIV_MCLK_MASK            GENMASK(3, 0)
> @@ -101,6 +101,7 @@
>   * @mclk_offset: Value by which mclkdiv needs to be adjusted.
>   * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>   * @fmt_offset: Value by which wss and sr needs to be adjusted.
> + * @field_clkdiv_mclk_en: regmap field to enable mclk output.
>   * @field_fmt_set_wss: regmap field to set word select size.
>   * @field_fmt_set_sr: regmap field to set sample resolution.
>   * @field_fmt_set_bclk_polarity: regmap field to set clk polarity.
> @@ -119,6 +120,7 @@ struct sun4i_i2s_quirks {
>         unsigned int                    fmt_offset;
>
>         /* Register fields for i2s */
> +       struct reg_field                field_clkdiv_mclk_en;
>         struct reg_field                field_fmt_set_wss;
>         struct reg_field                field_fmt_set_sr;
>         struct reg_field                field_fmt_set_bclk_polarity;
> @@ -141,6 +143,7 @@ struct sun4i_i2s {
>         struct snd_dmaengine_dai_dma_data       playback_dma_data;
>
>         /* Register fields for i2s */
> +       struct regmap_field     *field_clkdiv_mclk_en;
>         struct regmap_field     *field_fmt_set_wss;
>         struct regmap_field     *field_fmt_set_sr;
>         struct regmap_field     *field_fmt_set_bclk_polarity;
> @@ -279,8 +282,9 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
>
>         regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
>                      SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
> -                    SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
> -                    SUN4I_I2S_CLK_DIV_MCLK_EN);
> +                    SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
> +
> +       regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
>
>         return 0;
>  }
> @@ -710,6 +714,9 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>         .has_reset              = false,
>         .reg_offset_txdata      = SUN4I_I2S_FIFO_TX_REG,
>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG,
> +                                           SUN4I_I2S_CLK_DIV_MCLK_EN,
> +                                           SUN4I_I2S_CLK_DIV_MCLK_EN),

Nit: just use raw number to match all the other lines. And you won't
need to change the macro.

ChenYu
