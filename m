From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 6/9] arm64: dts: allwinner: add Allwinner
 H5 .dtsi
Date: Fri, 27 Jan 2017 16:58:51 +0100
Message-ID: <20170127155851.lv64kh7gm4ztsjpg@lukather>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-7-icenowy@aosc.xyz>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aczqchan7dzeup4t"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBRW4VXCAKGQEEQDMHHY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170126154859.55855-7-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--aczqchan7dzeup4t
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jan 26, 2017 at 11:48:56PM +0800, Icenowy Zheng wrote:
> +		mmc@01c0f000 {

Please use a label based syntax here too.

> +			compatible = "allwinner,sun50i-a64-mmc",
> +				     "allwinner,sun5i-a13-mmc";

The compatibility with the A13 has never been true, and the compatible
should be "allwinner,sun50i-h5-mmc", "allwinner,sun50i-a64-mmc".

> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +		};
> +
> +		mmc@01c10000 {
> +			compatible = "allwinner,sun50i-a64-mmc",
> +				     "allwinner,sun5i-a13-mmc";
> +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> +			clock-names = "ahb", "mmc";
> +		};
> +
> +		mmc@01c11000 {
> +			compatible = "allwinner,sun50i-a64-mmc",

And this is very likely to use the emmc compatible.

> +				     "allwinner,sun5i-a13-mmc";
> +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> +			clock-names = "ahb", "mmc";
> +		};
> +
> +		clock@01c20000 {
> +			compatible = "allwinner,sun50i-h5-ccu",
> +				     "allwinner,sun8i-h3-ccu";
> +		};

If it doesn't have the same clocks, it's not compatible with the H3.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--aczqchan7dzeup4t--
