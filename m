From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 07/12] ASoC: sun4i-i2s: bclk and lrclk
 polarity tidyup
Date: Wed, 2 Aug 2017 11:09:25 +0800
Message-ID: <CAGb2v64LyQ+Ba9YWvQzpE0B9MFqsotNpEXkQ5RVhAo2z5QpvGQ@mail.gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com> <20170729141753.20174-8-codekipper@gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBB7MEQXGAKGQENWWYUJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170729141753.20174-8-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
> On newer SoCs the bit fields for the blck and lrclk polarity are in
> a different locations. Use regmap fields to set the polarity bits
> as intended.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 171df99a267e..90daa974bd27 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -50,6 +50,8 @@
>  #define SUN4I_I2S_FMT0_FMT_RIGHT_J                     (2 << 0)
>  #define SUN4I_I2S_FMT0_FMT_LEFT_J                      (1 << 0)
>  #define SUN4I_I2S_FMT0_FMT_I2S                         (0 << 0)
> +#define SUN4I_I2S_FMT0_POLARITY_INVERTED               (1)
> +#define SUN4I_I2S_FMT0_POLARITY_NORMAL                 (0)
>
>  #define SUN4I_I2S_FMT1_REG             0x08
>  #define SUN4I_I2S_FIFO_TX_REG          0x0c
> @@ -101,6 +103,8 @@
>   * @fmt_offset: Value by which wss and sr needs to be adjusted.
>   * @field_fmt_set_wss: regmap field to set word select size.
>   * @field_fmt_set_sr: regmap field to set sample resolution.
> + * @field_fmt_set_bclk_polarity: regmap field to set clk polarity.
> + * @field_fmt_set_lrclk_polarity: regmap field to set frame polarity.

You can cut these down to "field_fmt_{b,lr}clk_pol".
It still makes sense in this context, and you can make the lines fit
under 80 characters in the last hunk.

ChenYu
