From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
Date: Sat, 22 Dec 2018 00:54:48 +0800
Message-ID: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-5-codekipper@gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBZNV6TQAKGQEJNB7AHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20181221152110.17982-5-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 21, 2018 at 11:21 PM <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Also add offset to RX channel select
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Commit log seems a bit lacking. You could probably explain how you
found this, either when comparing datasheet macros, or some actual
error manifested and you "heard" it. You could also state what the
fixed outcome should be.

Also please add a fixes tag.

The RX channel select offset should be added as a separate patch,
also with an explanation on how you found this missing, and a fixes
tag.

ChenYu

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index adb988ae9ac5..93a484d7e228 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -110,7 +110,7 @@
>
>  #define SUN8I_I2S_TX_CHAN_MAP_REG      0x44
>  #define SUN8I_I2S_TX_CHAN_SEL_REG      0x34
> -#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13, 11)
> +#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13, 12)
>  #define SUN8I_I2S_TX_CHAN_OFFSET(offset)       (offset << 12)
>  #define SUN8I_I2S_TX_CHAN_EN_MASK              GENMASK(11, 4)
>  #define SUN8I_I2S_TX_CHAN_EN(num_chan)         (((1 << num_chan) - 1) << 4)
> @@ -482,6 +482,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                 regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>                                    SUN8I_I2S_TX_CHAN_OFFSET_MASK,
>                                    SUN8I_I2S_TX_CHAN_OFFSET(offset));
> +
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET_MASK,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET(offset));
>         }
>
>         regmap_field_write(i2s->field_fmt_mode, val);
> --
> 2.20.1
>
