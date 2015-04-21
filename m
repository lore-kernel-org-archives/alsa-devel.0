From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
Date: Tue, 21 Apr 2015 11:15:03 +0100
Message-ID: <20150421101503.GD22845@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
 <20150418173740.GF26185@sirena.org.uk>
 <20150420045017.GI6325@pengutronix.de>
 <20150420205230.GK14892@sirena.org.uk>
 <20150421055041.GQ6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150421055041.GQ6325-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 07:50:41AM +0200, Sascha Hauer wrote:

> Oh, that's not magic at all, the crossbar switch has inputs and outputs
> numbered from 0 to MTK_AFE_INTERCONN_NUM_INPUT /
> MTK_AFE_INTERCONN_NUM_OUTPUT (they have the same numbers in the
> datasheet. To connect input x with output y look at index [x][y] in the
> table and write the register values found at that place. If .creg is 0x0
> then it's not possible to connect the given input with the given output.

A comment saying that would help then.

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNiMnAAoJECTWi3JdVIfQMGkH/20UeTWumIYGr7GnR268v2Cm
tpVOD+AnRXp90/9JNAjlNJk4hlI6gRaohBQSDMxCLB7iTpI6vNu41YwnF5YO5XrI
a/pqTtj6yrikgCsI7XnVb96Y+WbOnNFUwqNaWui3aHye1gTHIsdHSum02EHxlrsT
D1gXQhTajoTOX7Q6wiXnKDlz0DaZ1uvfbjCGHI4jftgxM7Kyk1WxdEmq0PQ1uxrN
fPAsC2i2WUP1v1NjrcM3oMGRDI0M4ijVEh1bZiYm4VlHk4BCojQb5XcynSYLg5MN
RUwRWTMsXqK5KN5Zlz5YhbV5SD5mnjXhmA+6/tMWwgCzbLy8s64tkS5il0lyqh0=
=fnDQ
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
