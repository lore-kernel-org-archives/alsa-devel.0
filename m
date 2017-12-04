From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 3/9] ASoC: sun8i-codec: Add quirk to
	specify aif1_lrck_div value
Date: Mon, 4 Dec 2017 15:38:46 +0800
Message-ID: <CAGb2v65KMosNgkCa5Ddmf_T--8-BeLLjdqrdX3wb4H+kbudLjA@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-4-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9BE266D06
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 08:39:15 +0100 (CET)
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
 [209.85.128.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id E9974221D2
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 15:39:09 +0800 (CST)
Received: by mail-wr0-f179.google.com with SMTP id v22so16089914wrb.0
 for <alsa-devel@alsa-project.org>; Sun, 03 Dec 2017 23:39:09 -0800 (PST)
In-Reply-To: <20171203204157.20829-4-anarsoul@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 4, 2017 at 4:41 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> LRCK divider for A64 differs from A33, so add a quirk to support that.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index 3dd183be08a4..054201d1de03 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/of_device.h>

Please keep them sorted in alphabetical order.

>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -75,11 +76,22 @@
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK  GENMASK(8, 6)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK  GENMASK(12, 9)
>
> +/*
> + * struct sun8i_codec_quirks - Differences between SoC variants.
> + *
> + * @aif1_lrck_div: LRCK divider
> + */
> +struct sun8i_codec_quirks {
> +       unsigned int    aif1_lrck_div;
> +};
> +
> +
>  struct sun8i_codec {
> -       struct device   *dev;
> -       struct regmap   *regmap;
> -       struct clk      *clk_module;
> -       struct clk      *clk_bus;
> +       struct device                   *dev;
> +       struct regmap                   *regmap;
> +       struct clk                      *clk_module;
> +       struct clk                      *clk_bus;
> +       const struct sun8i_codec_quirks *variant;
>  };
>
>  static int sun8i_codec_runtime_resume(struct device *dev)
> @@ -305,7 +317,7 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
>
>         regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>                            SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
> -                          SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16);
> +                          scodec->variant->aif1_lrck_div);

Hard coding a fixed divider is generally a bad idea.
You adding another fixed value for this is evidence of this.

The BCK:LRCK divider is equal to sample width * 2. You should
have that instead.

Also I see no evidence that either the I2S controller (see my
comment on patch 1) or the codec is limited to a certain sample
width in hardware, other than your claims, which are vague at
best.

The user manual for both the A33 and A64 list many possible
widths and dividers. If the user manual is wrong, please provide
solid evidence proving it wrong.

Either way this series will not be accepted in its current form.

ChenYu

>
>         sample_rate = sun8i_codec_get_hw_rate(params);
>         if (sample_rate < 0)
> @@ -440,6 +452,10 @@ static const struct regmap_config sun8i_codec_regmap_config = {
>         .cache_type     = REGCACHE_FLAT,
>  };
>
> +static const struct sun8i_codec_quirks sun8i_a33_codec_quirks = {
> +       .aif1_lrck_div  = SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16,
> +};
> +
>  static int sun8i_codec_probe(struct platform_device *pdev)
>  {
>         struct resource *res_base;
> @@ -453,6 +469,13 @@ static int sun8i_codec_probe(struct platform_device *pdev)
>
>         scodec->dev = &pdev->dev;
>
> +       scodec->variant = of_device_get_match_data(&pdev->dev);
> +       if (!scodec->variant) {
> +               dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
> +               return -ENODEV;
> +       }
> +
> +
>         scodec->clk_module = devm_clk_get(&pdev->dev, "mod");
>         if (IS_ERR(scodec->clk_module)) {
>                 dev_err(&pdev->dev, "Failed to get the module clock\n");
> @@ -524,7 +547,10 @@ static int sun8i_codec_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sun8i_codec_of_match[] = {
> -       { .compatible = "allwinner,sun8i-a33-codec" },
> +       {
> +               .compatible = "allwinner,sun8i-a33-codec",
> +               .data = &sun8i_a33_codec_quirks,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> --
> 2.15.0
>
