From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: add sun4i SPDIF
 transceiver bindings
Date: Tue, 2 Feb 2016 23:31:15 +0100
Message-ID: <20160202223115.GE4652@lukather>
References: <1454424594-25208-1-git-send-email-codekipper@gmail.com>
 <1454424594-25208-2-git-send-email-codekipper@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cseAwlqrBzmhRTxO"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBNO4YS2QKGQER3IGDMA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454424594-25208-2-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--cseAwlqrBzmhRTxO
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Feb 02, 2016 at 03:49:53PM +0100, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add devicetree bindings for the SPDIF transceiver found on
> found on Allwinners A10 and A20 SoCs.
> 
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/sun4i,spdif.txt      | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun4i,spdif.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun4i,spdif.txt b/Documentation/devicetree/bindings/sound/sun4i,spdif.txt
> new file mode 100644
> index 0000000..55ed2f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun4i,spdif.txt
> @@ -0,0 +1,46 @@
> +Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Allwinner S/PDIF audio block is a transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +  - compatible		: should be one of the following:
> +    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - interrupts		: Contains the spdif interrupt.
> +
> +  - dmas		: Generic dma devicetree binding as described in
> +			  Documentation/devicetree/bindings/dma/dma.txt.
> +
> +  - dma-names		: Two dmas have to be defined, "tx" and "rx".
> +
> +  - clocks		: Contains an entry for each entry in clock-names.
> +
> +  - clock-names		: Includes the following entries:
> +	"apb"		  clock for the spdif bus.
> +	"spdif"		  clock for spdif controller.
> +
> +Optional:
> +
> +  - spdif-in		: Enable block for capturing an SPDIF signal.
> +
> +  - spdif-out		: Enable block for transmitting an SPDIF signal.

Is that a generic property? What values can it hold?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--cseAwlqrBzmhRTxO--
