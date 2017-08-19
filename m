From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v5 1/8] ASoC: sun4i-i2s: Add regmap fields
 for channels
Date: Sat, 19 Aug 2017 23:11:20 +0800
Message-ID: <CAGb2v67jSkBZtB7y6nCG+Bhkcc-qzr5yz=7_CTeiB0Z3CRtVHw@mail.gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com> <20170819124839.4034-2-codekipper@gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBMFK4HGAKGQEUKWWZCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170819124839.4034-2-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 19, 2017 at 8:48 PM,  <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> On the original i2s block the channel mapping and selection were
> configured for stereo audio by default: This is not the case with
> the newer SoCs and they are also located at different offsets.
>
> To support the newer SoC then regmap fields have been added to the
> quirks and these are initialised to their correct settings during
> probing.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Reviewed-by still stands.

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 77 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c

[...]

> +static int sun4i_i2s_init_regmap_fields(struct device *dev,
> +                                       struct sun4i_i2s *i2s)
> +{
> +       i2s->field_txchanmap =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_txchanmap);
> +       if (IS_ERR(i2s->field_txchanmap))
> +               return PTR_ERR(i2s->field_txchanmap);
> +
> +       i2s->field_rxchanmap =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_rxchanmap);
> +       if (IS_ERR(i2s->field_rxchanmap))
> +               return PTR_ERR(i2s->field_rxchanmap);
> +
> +       i2s->field_txchansel =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_txchansel);
> +       if (IS_ERR(i2s->field_txchansel))
> +               return PTR_ERR(i2s->field_txchansel);
> +
> +       i2s->field_rxchansel =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_rxchansel);
> +       return PTR_ERR_OR_ZERO(i2s->field_rxchansel);
> +}
> +

That's much better. Thanks!

ChenYu
