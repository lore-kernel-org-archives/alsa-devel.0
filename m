From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
Date: Thu, 3 Sep 2015 12:43:16 +0100
Message-ID: <20150903114316.GV12027@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B52KEoKdbCpY/p3k"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441086101-15303-3-git-send-email-songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Songjun Wu <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--B52KEoKdbCpY/p3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 01:41:41PM +0800, Songjun Wu wrote:

> +classd: classd@fc048000 {
> +		compatible = "atmel,sama5d2-classd";
> +		reg = <0xfc048000 0x100>;
> +		interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
> +		dmas = <&dma0
> +			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +			| AT91_XDMAC_DT_PERID(47))>;
> +		dma-names = "tx";
> +		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
> +		clock-names = "pclk", "gclk", "aclk";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_classd_default>;
> +		atmel,pwm-type = "diff";
> +		atmel,non-overlap-time = <10>;
> +};

> +Example:
> +sound {
> +		compatible = "atmel,asoc-classd";
> +
> +		atmel,model = "classd @ SAMA5D2-Xplained";
> +		atmel,audio-platform = <&classd>;
> +		atmel,audio-cpu-dai-name = "fc048000.classd";
> +		atmel,audio-codec = <&classd>;
> +};

Why is this a separate DT node?  It seems that this IP is entirely self
contained so I'm not clear why we need a separate node for the card, the
card is usually a separate node because it ties together multiple
different devices in the system but that's not the case here.

--B52KEoKdbCpY/p3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6DJTAAoJECTWi3JdVIfQr/UH/0v02BuUxvvl8B3FsLgfC030
36b+leJfTzV4x+omYNXF1kRVNOQ0imERJ76KlDk6MKVfIk6XftO2LYcJpsJBqIrM
QMyy0fiDk2GlQAA2aU3RkJ5HuOp4WJy2cavdk2ivkYleTSrxyws+SWDwa3zU/+xh
ejgMlq37Vs3XH+MgKsiXeZXbXyvtKVtSZxqZwIgXpJx/m9QpXaAWTII87p0yIGcG
y9CBpfgPKab5WFqzpD8cPzNy5ziAtXJD7OOUbk/iTcfU1EuFZynEWTkahQlO7ldr
0iFoh9Umb9UDQjMJF9S1jb2dPqaEBO84QFpaAJg2JIdyp1V4DyohlmqxCKZyZi4=
=wNKq
-----END PGP SIGNATURE-----

--B52KEoKdbCpY/p3k--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
