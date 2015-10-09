From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 8/8] ARM: multi_v7_defconfig: Add rockchip audio
 support
Date: Fri, 9 Oct 2015 08:27:00 +0100
Message-ID: <20151009072700.GN17172@x1>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1444311079-2892-9-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444311079-2892-9-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof@l>
List-Id: alsa-devel@alsa-project.org

Thanks an awful lot of people you've spammed there.

Are you sure they all care about your Rockchip changes?

Hint: I'm sure that they don't.

Please be careful and only send patches to relevant people.

> Enable support for audio device found on rockchip boards.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> ---
>=20
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>=20
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/m=
ulti_v7_defconfig
> index 03deb7f..febce7e 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -478,6 +478,10 @@ CONFIG_SND_USB_AUDIO=3Dy
>  CONFIG_SND_SOC=3Dm
>  CONFIG_SND_ATMEL_SOC=3Dm
>  CONFIG_SND_ATMEL_SOC_WM8904=3Dm
> +CONFIG_SND_SOC_ROCKCHIP=3Dm
> +CONFIG_SND_SOC_ROCKCHIP_SPDIF=3Dm
> +CONFIG_SND_SOC_ROCKCHIP_MAX98090=3Dm
> +CONFIG_SND_SOC_ROCKCHIP_RT5645=3Dm
>  CONFIG_SND_SOC_SH4_FSI=3Dm
>  CONFIG_SND_SOC_RCAR=3Dm
>  CONFIG_SND_SOC_RSRC_CARD=3Dm
> @@ -489,6 +493,7 @@ CONFIG_SND_SOC_TEGRA_TRIMSLICE=3Dm
>  CONFIG_SND_SOC_TEGRA_ALC5632=3Dm
>  CONFIG_SND_SOC_TEGRA_MAX98090=3Dm
>  CONFIG_SND_SOC_AK4642=3Dm
> +CONFIG_SND_SOC_SPDIF=3Dm
>  CONFIG_SND_SOC_WM8978=3Dm
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
