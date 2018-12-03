From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 04/10] dma-engine: sun4i: Add support
 for Allwinner suniv F1C100s
Date: Mon, 3 Dec 2018 12:00:51 +0100
Message-ID: <20181203110051.gp2ajxrmflvlyx7k@flea>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncgakdes6smr5r7x"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB3UZSTQAKGQEJWN734Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ncgakdes6smr5r7x
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Dec 03, 2018 at 12:23:11AM +0300, Mesih Kilinc wrote:
> DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
> DDMA channels and endpoints are different. Also F1C100s has reset bit
> for DMA in CCU. Add support for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/dma/Kconfig     |  4 ++--
>  drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index de511db..f8a65d2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -163,8 +163,8 @@ config DMA_SA11X0
>  
>  config DMA_SUN4I
>  	tristate "Allwinner A10 DMA SoCs support"
> -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
> -	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
> +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
> +	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index d267ff9..c0452c9 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -36,7 +36,11 @@
>  #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
>  #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
>  
> +#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
> +#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)
> +
>  #define SUN4I_MAX_BURST	8
> +#define SUNIV_MAX_BURST	4
>  
>  /** Normal DMA register values **/
>  
> @@ -44,6 +48,9 @@
>  #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
>  #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
>  
> +#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
> +#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)

Also, you're not using that define anywhere

> +
>  /** Normal DMA register layout **/
>  
>  /* Dedicated DMA source/destination address mode values */
> @@ -57,6 +64,9 @@
>  #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
>  #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
>  
> +#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
> +#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
> +

Or those two.

>  /** Dedicated DMA register values **/
>  
>  /* Dedicated DMA source/destination address mode values */
> @@ -69,6 +79,9 @@
>  #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
>  #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
>  
> +#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1

This is the same value

> +#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
> +

And this one isn't used

>  /** Dedicated DMA register layout **/
>  
>  /* Dedicated DMA configuration register layout */
> @@ -122,6 +135,11 @@
>  #define SUN4I_DMA_NR_MAX_VCHANS						\
>  	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
>  
> +#define SUNIV_NDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_DDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
> +#define SUNIV_DDMA_NR_MAX_VCHANS	10
> +

I'm not sure we need those, you can just use the raw value in the
structure.

Also, how was the number of vchans calculated?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--ncgakdes6smr5r7x--
