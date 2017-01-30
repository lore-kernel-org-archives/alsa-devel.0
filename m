From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 03/10] clk: sunxi-ng: rename sun8i-h3
 driver to sunxi-h3-h5
Date: Mon, 30 Jan 2017 10:03:07 +0100
Message-ID: <20170130090307.mmeab5ybfxaeicq2@lukather>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-4-icenowy@aosc.xyz>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oa6hxwnkli4wexjx"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBTECXTCAKGQENKWIVJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170129023331.62106-4-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--oa6hxwnkli4wexjx
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sun, Jan 29, 2017 at 10:33:24AM +0800, Icenowy Zheng wrote:
> As the CCU in the Allwinner H5 SoC is very similar to the one in H3,
> rename the H3 driver to sunxi-h3-h5 so that it can be extended with H5
> support.
> 
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
> The original PATCH v2 3/9 is splited into two patches in v3, this one renames
> the H3 driver to h3-h5, and the next one finally add H5 support to it.
> 
>  drivers/clk/sunxi-ng/Kconfig                       |   4 +-
>  drivers/clk/sunxi-ng/Makefile                      |   2 +-
>  .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} |  42 +++---
>  .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  10 +-
>  include/dt-bindings/clock/sun8i-h3-ccu.h           | 146 +--------------------
>  include/dt-bindings/clock/sunxi-h3-h5-ccu.h        | 145 ++++++++++++++++++++
>  include/dt-bindings/reset/sun8i-h3-ccu.h           | 104 +--------------
>  include/dt-bindings/reset/sunxi-h3-h5-ccu.h        | 103 +++++++++++++++
>  8 files changed, 282 insertions(+), 274 deletions(-)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (96%)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (88%)
>  mode change 100644 => 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/clock/sunxi-h3-h5-ccu.h
>  mode change 100644 => 120000 include/dt-bindings/reset/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/reset/sunxi-h3-h5-ccu.h

Please generate your patches with -M

> -static void __init sun8i_h3_ccu_setup(struct device_node *node)
> +static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
> +				  const struct sunxi_ccu_desc *desc)
>  {

The indentation should be on the opening parenthesis.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--oa6hxwnkli4wexjx--
