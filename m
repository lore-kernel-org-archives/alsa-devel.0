From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
Date: Sun, 31 Jul 2016 00:40:48 +1000
Message-ID: <CAGRGNgU-7skLeRNOxfVpqNXSaLTLA+vAZrm8=sdo0NJLbopJ7Q@mail.gmail.com>
References: <20160730142716.29377-1-codekipper@gmail.com> <20160730142716.29377-3-codekipper@gmail.com>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDQIP76OUQLBBBHZ6K6AKGQES32MCFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160730142716.29377-3-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Marcus,

On Sun, Jul 31, 2016 at 12:27 AM,  <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
> reset is controlled via a separate reset controller.
>
> The DMA also complains when the maxburst is set to 4 so it's been adjusted
> to 8 which suites both the older and newer SoCs.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-spdif.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
> index 0b04fb0..88fbb3a 100644
> --- a/sound/soc/sunxi/sun4i-spdif.c
> +++ b/sound/soc/sunxi/sun4i-spdif.c
> @@ -482,11 +485,23 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
>         }
>
>         host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
> -       host->dma_params_tx.maxburst = 4;
> +       host->dma_params_tx.maxburst = 8;
>         host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>
>         platform_set_drvdata(pdev, host);
>
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "allwinner,sun6i-a31-spdif")) {

Given how much Allwinner likes to shuffle stuff around with each SoC
generation, would it make sense to add a flag for this in some
compatible specific config structure instead of checking against the
compatible?

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/
