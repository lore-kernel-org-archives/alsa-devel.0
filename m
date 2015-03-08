From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: add missing semicolon
Date: Sun, 8 Mar 2015 22:21:43 +0000
Message-ID: <20150308222143.GD28806@sirena.org.uk>
References: <10196569.gafhWQrdaI@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7760102738694201437=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 874D426054D
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 23:21:59 +0100 (CET)
In-Reply-To: <10196569.gafhWQrdaI@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7760102738694201437==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q4+B1pX2h4duw/kc"
Content-Disposition: inline


--Q4+B1pX2h4duw/kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2015 at 10:10:14PM +0100, Arnd Bergmann wrote:
> A recent patch introduced a build error because of a trivial typo, this
> gets it back to compile.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6afda7f50754 ("ASoC: davinci-mcasp: Allow complete shutdown of McA=
SP when not in use")

The same fix was sent several days ago, please submit against current
code.

--Q4+B1pX2h4duw/kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/Mt2AAoJECTWi3JdVIfQxC0H/3eV2SXiar6Jz2Yz0qbJSoIv
Qxv06vbE2BGL97aU6Yje9oZX7dX0G50vYD0u6fRBBoWbpe3jdDVU9qp6Wg+blihG
XJYM8Rr9Qz21ET2ZR89yGyabJLZTnSAvMZ6L/bwEdWC6MrTLkRDsu0bVkpgBI1zK
bibSZXZv9VVOx3TG7jRHg9gNYr4+rKrq9m0fT2aAv8i5Nfu0e8CcC+r2ojJsmfJx
ptLbrLq92iOZeY+hs4kouo6eSaKVZvPFFk8SLq8Y0qBEO0XPNmxw9+gkemwyxPaZ
uS7u8PELyHY2jZGgC81edloC6t0UWHy8dE2u67OVRYzgKo+9vKj4uonpwfwgUlM=
=OIK7
-----END PGP SIGNATURE-----

--Q4+B1pX2h4duw/kc--

--===============7760102738694201437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7760102738694201437==--
