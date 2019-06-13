From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: fix fake interruption when
	booting
Date: Thu, 13 Jun 2019 12:20:42 +0100
Message-ID: <20190613112042.GJ5316@sirena.org.uk>
References: <20190610024029.12193-1-KCHSU0@nuvoton.com>
 <20190610034040.12629-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3410610475068703505=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FF1DF80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 13:20:46 +0200 (CEST)
In-Reply-To: <20190610034040.12629-1-KCHSU0@nuvoton.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, WTLI@nuvoton.com, lgirdwood@gmail.com, yuhsuan@google.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, Cheng-Yi Chiang <cychiang@chromium.org>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============3410610475068703505==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2019 at 11:40:40AM +0800, John Hsu wrote:
> There is no pull-up resistor at IRQ line where it connects from
> the codec to SoC. When booting, the signal of IRQ pin will keep low

On some specific system?

Please don't send new patches in the middle of old threads, it makes it
hard to spot them and work out what the current version is.

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CMYoACgkQJNaLcl1U
h9BCTAf+Mjb6YCp4CTitdaG9w5US+Xpm8f5gKjJxQYAlSzwm721Yd8d6uEYHUvJe
jwZmsPyWSyVD8BgnElrfqzW+8i8JjwWgBjbuUMy5nMvT+5aldnWUvFaUvVT9eBuh
Ce8oQPd3OtRkjGlSeOhTbBLmNb4qnWJ1I0G2uXnEnTWKdZ7P+may3cZXCP0S/2DD
VS7E6oSF948Ny3dxI/eFzwPIBvOqdUQdUHau/f99DfuyrGnwjSmLTBmte5smq44b
2Aja3m8do+SL1Z6MjZbHgB2gU3BJGWLmbvngkrUT78Oc0KeQ3AdPGbxVuIKEbiOe
PECljUe44PsQ1hcVA3TD76nG1k7Z9A==
=CDGm
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--

--===============3410610475068703505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3410610475068703505==--
