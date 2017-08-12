From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH v3 11/11] ASoC: sun4i-i2s:
	Add support for H3
Date: Sat, 12 Aug 2017 20:27:44 +0800
Message-ID: <CAGb2v66T9gNhnuvM-z8ZVwtWjgg=i0O-H2QXuR_vvz9Vy_YbWg@mail.gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
 <20170812110059.5115-12-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id CD81C266AF9
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 14:28:09 +0200 (CEST)
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
 [209.85.214.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 7031620311
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 20:28:06 +0800 (CST)
Received: by mail-it0-f46.google.com with SMTP id 76so5398413ith.0
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 05:28:06 -0700 (PDT)
In-Reply-To: <20170812110059.5115-12-codekipper@gmail.com>
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

On Sat, Aug 12, 2017 at 7:00 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The sun8i-h3 introduces a lot of changes to the i2s block such
> as different register locations, extended clock division and
> more operational modes. As we have to consider the earlier
> implementation then these changes need to be isolated.
>
> None of the new functionality has been implemented yet, the
> driver has just been expanded to allow it work on the H3 SoC.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
>  sound/soc/sunxi/sun4i-i2s.c                        | 176 ++++++++++++++++++++-
>  2 files changed, 176 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index ee21da865771..fc5da6080759 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible: should be one of the following:
>     - "allwinner,sun4i-a10-i2s"
>     - "allwinner,sun6i-a31-i2s"
> +   - "allwinner,sun8i-h3-i2s"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: should contain the I2S interrupt.
> @@ -22,6 +23,7 @@ Required properties:
>
>  Required properties for the following compatibles:
>         - "allwinner,sun6i-a31-i2s"
> +       - "allwinner,sun8i-h3-i2s"
>  - resets: phandle to the reset line for this codec
>
>  Example:
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a6b464c8cc6c..b6faa95d972a 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -92,11 +92,41 @@
>  #define SUN4I_I2S_RX_CHAN_SEL_REG      0x38
>  #define SUN4I_I2S_RX_CHAN_MAP_REG      0x3c
>
> +/* Defines required for sun8i-h3 support */
> +#define SUN8I_I2S_CTRL_BCLK_OUT                        BIT(18)
> +#define SUN8I_I2S_CTRL_LRCK_OUT                        BIT(17)
> +
> +#define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK                GENMASK(17, 8)
> +#define SUN8I_I2S_FMT0_LRCK_PERIOD(period)     ((period << 8) - 1)

I'm pretty sure this should be ((period - 1) << 8).

Once fixed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

P.S. the version tag for this series in the subject is wrong.
