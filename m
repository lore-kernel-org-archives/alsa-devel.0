From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: add sunxi SPDIF
 transceiver bindings
Date: Thu, 1 Oct 2015 22:12:15 +0200
Message-ID: <20151001201215.GN7104@lukather>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-2-git-send-email-codekipper@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opXR4bS/BgjGcxUR"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBTVVW2YAKGQEK6TKQ6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443635458-8873-2-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--opXR4bS/BgjGcxUR
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Sep 30, 2015 at 07:50:55PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add devicetree bindings for the SPDIF transceiver found on
> found on Allwinners A10, A20 and A31 SoCs.
> 
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/sunxi,spdif.txt      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sunxi,spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
> new file mode 100644
> index 0000000..1868722
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
> @@ -0,0 +1,49 @@
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
> +    - "allwinner,sun7i-a20-spdif": for the Allwinner A20 SoC
> +    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC

Are all these compatibles really work? Is there any significant
difference between the controller on all these SoCs?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--opXR4bS/BgjGcxUR--
