From: Mark Brown <broonie@kernel.org>
Subject: Re: [ASoC]fsl_ssi: fix of_property_read_u32_array return value check
Date: Tue, 24 Feb 2015 17:24:48 +0900
Message-ID: <20150224082448.GY6236@finisterre.sirena.org.uk>
References: <54E1199F.3000107@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8MNCZdTuKvcKRZar"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E1199F.3000107@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--8MNCZdTuKvcKRZar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 15, 2015 at 11:11:43PM +0100, Maciej S. Szmigiero wrote:
> of_property_read_u32_array returns 0 on success, so the return value shouldn't be inverted twice,
> first on assignment then in condition expression.

This doesn't apply to current code, please check and resend.  Please
also keep your changelog under 80 columns as covered in
SubmittingPatches.

--8MNCZdTuKvcKRZar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7DVPAAoJECTWi3JdVIfQf+MH/i8Xeh96TWeBtOpLCFHAXlqT
d0dyo15pWC6pzUtPneQn2JpHFIu9fd1NH2LDk111Ng/IZq+6yuqYaQnr+bDCYWG6
BQTW5GX7t5q17fDyo42Uobw3tbaCSBBFC9i5h/fVE06m5CD9OLY6J1tpoMLT/kd4
yBHnhp8J+ERoGadFJMrdc060Z0VlXGEhPB296J1BFxF1KOu6c/Py1oayq+E2pA7i
9M/GVwAIWchsT1VHvHnR5JWBwrxUr82d9uXSjMjrEQc20BqhwUT2b59Vrw+fZFvH
/w2ekPoHSu37i+CkvfNSp0yAOsdJ4yu5h64KmbrIn7loxQ16OkLgPgnlse9UEJM=
=BmqK
-----END PGP SIGNATURE-----

--8MNCZdTuKvcKRZar--
