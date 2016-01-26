From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Tue, 26 Jan 2016 11:50:28 +0000
Message-ID: <20160126115028.GE6588@sirena.org.uk>
References: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
 <20160126022948.GA21187@rob-hp-laptop>
 <56A73FDE.2060607@felipetonello.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c5Px8AoJl69cpALM"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56A73FDE.2060607-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Ferreri Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--c5Px8AoJl69cpALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2016 at 09:43:58AM +0000, Felipe Ferreri Tonello wrote:
> On 26/01/16 02:29, Rob Herring wrote:

> > Do all the i.MX audio bindings really vary more that the codec? Seems=
=20
> > like a lot of duplication.

> I agree, but that how it is today. These platform drivers for imx are
> similar but not identical. Looking at them I would guess that they have
> 50 to 60% of duplicated code.

> I believe we can add this driver and work on re-using the code on a
> future series of patches.

We have fsl-asoc-card which is supposed to allow reuse similar to
simple-card for devices which have an audmux.

--c5Px8AoJl69cpALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWp12EAAoJECTWi3JdVIfQhREH/RYtfjHqRFCyQ73KVM4lywVN
SjvW8uVkOLQmQI/RS3QT2O8X5V/OCmGecZZtQUjvm2D1ZyZy4ZyLn6IinoUo7oEx
Ow1HmCtY0ILefvzh0ES2JQjA7XLjw4kUcHIzUVDuELVKKVRVVz1a3ybH8p4wiLuq
LBYHActaBQVmX7zRKfyxT+B0z0UKpqPHmGTAk6tkYRaPrpTDHb78uJ+O42s4KEKd
tThHM1QRJm8E3oDZfBvvU6CwP0MjAQCdfUrwUm1Dngtmbd+u3ykZu4IoX7xUVrND
YL9Oh+WB7tKkNOLmQWVzFrS0mPtg3ETgvQ0J8WdnW0ZWnlUHPuz/LEtaIwAGM3o=
=DXbu
-----END PGP SIGNATURE-----

--c5Px8AoJl69cpALM--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
