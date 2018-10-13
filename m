From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 01/10] ASoC: sun4i-i2s: Add compatibility
 with A64 codec I2S
Date: Sat, 13 Oct 2018 12:32:18 +0800
Message-ID: <CAGb2v64jNCz2Qh74UU0NxqE_PipXePLNbpE4vwFQ9BSVQCd5tQ@mail.gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
 <20181013033230.6506-2-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F3D2678CA
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 06:32:32 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so13172419edg.13
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 21:32:32 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42])
 by smtp.gmail.com with ESMTPSA id s36-v6sm1518501edm.15.2018.10.12.21.32.30
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 21:32:30 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id e4-v6so15410784wrs.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 21:32:30 -0700 (PDT)
In-Reply-To: <20181013033230.6506-2-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Code Kipper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 13, 2018 at 11:33 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> The I2S block used for the audio codec in the A64 differs from other 3
> I2S modules in A64 and isn't compatible with H3. But it is very similar
> to what is found in A10(sun4i). However, its TX FIFO is
> located at a different address.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt   |  2 ++
>  sound/soc/sunxi/sun4i-i2s.c                   | 21 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index b9d50d6cdef3..9d81f965f666 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -10,6 +10,7 @@ Required properties:
>     - "allwinner,sun6i-a31-i2s"
>     - "allwinner,sun8i-a83t-i2s"
>     - "allwinner,sun8i-h3-i2s"
> +   - "allwinner,sun50i-a64-i2s"

This compatible is already used as the SoC-specific compatible (in case we have
unforeseen differences between A64 and H3 I2S).

Since this is tied to the codec, I think it deserves a special
compatible anyway.
How about "allwinner,sun50i-a64-codec-i2s" ?

The rest looks good, so once the compatible is changed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: should contain the I2S interrupt.
> @@ -26,6 +27,7 @@ Required properties for the following compatibles:
>         - "allwinner,sun6i-a31-i2s"
>         - "allwinner,sun8i-a83t-i2s"
>         - "allwinner,sun8i-h3-i2s"
> +       - "allwinner,sun50i-a64-i2s"
>  - resets: phandle to the reset line for this codec
>
>  Example:
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index ed30d30ac720..787b67c4f845 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -967,6 +967,23 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>         .field_rxchansel        = REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
>  };
>
> +static const struct sun4i_i2s_quirks sun50i_a64_i2s_quirks = {
> +       .has_reset              = true,
> +       .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> +       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> +       .has_slave_select_bit   = true,
> +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> +       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
> +       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
> +       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
> +       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> +       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
> +};
> +
>  static int sun4i_i2s_init_regmap_fields(struct device *dev,
>                                         struct sun4i_i2s *i2s)
>  {
> @@ -1175,6 +1192,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
>                 .compatible = "allwinner,sun8i-h3-i2s",
>                 .data = &sun8i_h3_i2s_quirks,
>         },
> +       {
> +               .compatible = "allwinner,sun50i-a64-i2s",
> +               .data = &sun50i_a64_i2s_quirks,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
> --
> 2.19.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
