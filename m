From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 02/12] ASoC: sun4i-i2s: Add clkdiv
 offsets to quirks
Date: Tue, 1 Aug 2017 10:55:38 +0800
Message-ID: <CAGb2v66cKxXuh_8o=0_yoLauHHqGjY1rkoDu_NQyC+bO8fNoPA@mail.gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com> <20170729141753.20174-3-codekipper@gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBQW377FQKGQEYKFUSPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170729141753.20174-3-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> The BCLKDIV and MCLKDIV found on newer SoCs start from an offset of 1.
> Add the functionality to adjust the division values according to the
> needs to the device being used.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d7ee7a443e4e..1d538de4e4d0 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -94,9 +94,13 @@
>   * struct sun4i_i2s_quirks - Differences between SoC variants.
>   *
>   * @has_reset: SoC needs reset deasserted.
> + * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> + * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>   */
>  struct sun4i_i2s_quirks {
>         bool                            has_reset;
> +       unsigned int                    mclk_offset;
> +       unsigned int                    bclk_offset;
>  };
>
>  struct sun4i_i2s {
> @@ -149,7 +153,7 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>                 const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
>
>                 if (bdiv->div == div)
> -                       return bdiv->val;
> +                       return bdiv->val + i2s->variant->bclk_offset;

The offset should best be applied when the value is written to the register,
in sun4i_i2s_set_clk_rate(). sun4i_i2s_get_*_div() should do what the name
says, that is calculate a divider based on the parameters it is given.

Regards
ChenYu

>         }
>
>         return -EINVAL;
> @@ -167,7 +171,7 @@ static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
>                 const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
>
>                 if (mdiv->div == div)
> -                       return mdiv->val;
> +                       return mdiv->val + i2s->variant->mclk_offset;
>         }
>
>         return -EINVAL;
> --
> 2.13.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
