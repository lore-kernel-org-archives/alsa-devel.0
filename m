From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
Date: Sat, 30 Jul 2016 22:52:45 +0800
Message-ID: <170941469890365@web9j.yandex.ru>
References: <20160730142716.29377-1-codekipper@gmail.com> <20160730142716.29377-3-codekipper@gmail.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBQH66K6AKGQES3VSUMA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160730142716.29377-3-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: "codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



30.07.2016, 22:45, "codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
> reset is controlled via a separate reset controller.
>
> The DMA also complains when the maxburst is set to 4 so it's been adjuste=
d
> to 8 which suites both the older and newer SoCs.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =C2=A0sound/soc/sunxi/sun4i-spdif.c | 17 ++++++++++++++++-
> =C2=A01 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.=
c
> index 0b04fb0..88fbb3a 100644
> --- a/sound/soc/sunxi/sun4i-spdif.c
> +++ b/sound/soc/sunxi/sun4i-spdif.c
> @@ -29,6 +29,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> =C2=A0#include <sound/dmaengine_pcm.h>
> =C2=A0#include <sound/pcm_params.h>
> =C2=A0#include <sound/soc.h>
> @@ -162,6 +163,7 @@ struct sun4i_spdif_dev {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_dev=
ice *pdev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct clk *spdif_c=
lk;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct clk *apb_clk=
;
> + struct reset_control *rst;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct snd_soc_dai_=
driver cpu_dai_drv;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regm=
ap;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct snd_dmaengin=
e_dai_dma_data dma_params_tx;
> @@ -411,6 +413,7 @@ static const struct snd_soc_dapm_route dit_routes[] =
=3D {
>
> =C2=A0static const struct of_device_id sun4i_spdif_of_match[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "=
allwinner,sun4i-a10-spdif", },
> + { .compatible =3D "allwinner,sun6i-a31-spdif", },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
> @@ -482,11 +485,23 @@ static int sun4i_spdif_probe(struct platform_device=
 *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host->dma_params_tx=
.addr =3D res->start + SUN4I_SPDIF_TXFIFO;
> - host->dma_params_tx.maxburst =3D 4;
> + host->dma_params_tx.maxburst =3D 8;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host->dma_params_tx=
.addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0platform_set_drvdat=
a(pdev, host);
>
> + if (of_device_is_compatible(pdev->dev.of_node,
> + "allwinner,sun6i-a31-spdif")) {
> + host->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
> + if (IS_ERR(host->rst) && PTR_ERR(host->rst) =3D=3D -EPROBE_DEFER) {
> + ret =3D -EPROBE_DEFER;
> + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
> + goto err_disable_apb_clk;
> + }
> + if (!IS_ERR(host->rst))
> + reset_control_deassert(host->rst);
> + }
> +
I think you do not need the compatible.
You can just detect whether the reset is present.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_snd_so=
c_register_component(&pdev->dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sun4i_spdif_component, =
&sun4i_spdif_dai, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> --
> 2.9.2
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
