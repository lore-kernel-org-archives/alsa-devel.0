From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V4 05/10] ASoC: ipq806x: add LPASS header files
Date: Sat, 7 Feb 2015 06:58:43 +0800
Message-ID: <20150206225843.GJ31311@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-6-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423169626-22166-6-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:53:41PM -0800, Kenneth Westfield wrote:

> +#define __LPASS_H__
> +
> +#define LPASS_AHBIX_CLOCK_FREQUENCY		131072
> +
> +/* Both the CPU DAI driver and platform driver will access this data */
> +struct lpass_data {
> +
> +	/* clocks inside the low-power audio subsystem (LPASS) domain */
> +	struct clk *ahbix_clk;

This uses struct clk so it needs at least a forward declaration of it if
not just a straight inclusion of linux/clk.h.  There's several other
types and annotations that are referenced without an include to ensure
the compiler knows about them, the general idea is to avoid implicit
dependencies and thee surprising build breaks they cause.

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1UciAAoJECTWi3JdVIfQHNwH/0XOJY37GdxRR3qDgatMhQiS
ZSHvM439Fade6vgGtJ9Q/jsr3lFa98sOGihrVG0Z46+lzK7Kg9ttWgLp8Io99E2v
WxGDC4M8gJBS3zUAVSLaJpWNcEucvvxO7gB4lrbEdylScqMG6ZKlymdii/2MrMD/
n7OfsuW50mGAkZMQo5ETHlEBmBOl+LNxJiz2hdWrWwx7BnRCun26FjqgHa6+gPjF
U8sT6lZjDBq1ZIZqqbSq3F06HCM0RAe8LSPezKf/fpsaeQD9C3CkC4VBU3oRNZXQ
HzfiIrLJT1g2SKMwHP9LzpPJVQzKfupoggJEmm0OmIqsoP6wQEsE5P/zLWXiTDY=
=sE3h
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
