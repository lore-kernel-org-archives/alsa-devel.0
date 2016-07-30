From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add bindings for sun6i to SPDIF
Date: Sat, 30 Jul 2016 17:17:24 +0200
Message-ID: <20160730151724.GS6215@lukather>
References: <20160730142716.29377-1-codekipper@gmail.com>
 <20160730142716.29377-2-codekipper@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zu8lIfFVzXMVnfzp"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBBMK6O6AKGQE73PW2LQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160730142716.29377-2-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--zu8lIfFVzXMVnfzp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Jul 30, 2016 at 04:27:15PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
> reset is controlled via a separate reset controller.
> 
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> index 13503aa..4fe80f7 100644
> --- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> +++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> @@ -9,6 +9,7 @@ Required properties:
>  
>    - compatible		: should be one of the following:
>      - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> +    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
>  
>    - reg			: Offset and length of the register set for the device.
>  
> @@ -25,6 +26,8 @@ Required properties:
>  	"apb"		  clock for the spdif bus.
>  	"spdif"		  clock for spdif controller.
>  
> +  - reset		: reset specifier for the ahb reset (A31 and newer only)

Isn't it resets ? (plural)

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--zu8lIfFVzXMVnfzp--
