From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V4 08/10] ASoC: qcom: Add ability to build QCOM drivers
Date: Sat, 7 Feb 2015 07:00:58 +0800
Message-ID: <20150206230058.GK31311@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-9-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="73fGQZLCrFzENemP"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423169626-22166-9-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--73fGQZLCrFzENemP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:53:44PM -0800, Kenneth Westfield wrote:

> +config SND_SOC_IPQ806X
> +	tristate "SoC Audio support for IPQ806x based platforms"
> +	depends on SND_SOC_QCOM || ARCH_QCOM || COMPILE_TEST
> +        select SND_SIMPLE_CARD
> +	select SND_SOC_LPASS_CPU
> +	select SND_SOC_LPASS_PLATFORM
> +        select SND_SOC_MAX98357A

No, we don't have blocks like this selecting simple-card for any other
platforms using simple-card so we shouldn't do that here either.  Just
let all the drivers be individually selectable.

You've also got a mix of tabs and spaces going on.

--73fGQZLCrFzENemP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1UepAAoJECTWi3JdVIfQCBEH/AlWqqZODP6WfMuA4Z48FQuj
e0VFGTc5vcVcc9O9/Q9unC3QQP4nFoVjaABv7vIIH0PdcITrfMsavIeIkzfIi9hW
SWCpR5KfCllxXQokuZAQpjczfEDJnGio+T6ch8mB3x4FtWEHFM/13a9QtILnCIAK
apzZ928e9IdcnZcH/Q5Ch2XlEmAT/WQR5eqSCx+ARKP+Zs5iHaZDYmeKECTBR/YS
vsg03WS8P28d4gFss+iyG458wkttQ8GjfVPX3gVZTAfPNR5dF2pQ0c+mfuVG+3yB
F9qtJoBVplUVu/d67AallhGFhILY7K0DXSbjQ08G2JOoZdPDboNN26R1gIUKH3w=
=fdIH
-----END PGP SIGNATURE-----

--73fGQZLCrFzENemP--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
