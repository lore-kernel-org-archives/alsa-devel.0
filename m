From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-spdif: Remove error message upon
 devm_kzalloc() failure
Date: Mon, 2 Dec 2013 11:12:52 +0000
Message-ID: <20131202111252.GJ27568@sirena.org.uk>
References: <1385952084-20149-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6862999530372339328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB2A2610CB
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:12:55 +0100 (CET)
In-Reply-To: <1385952084-20149-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6862999530372339328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GD0jJf8rm+K0B4Sk"
Content-Disposition: inline


--GD0jJf8rm+K0B4Sk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2013 at 12:41:24AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> No need to have a specific OOM message, since there is generic MM out of =
memory
> message in place.

Applied, thanks.

--GD0jJf8rm+K0B4Sk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnGsxAAoJELSic+t+oim9kh0P/1RxEuTIlhuohDb5u05Qbii3
H49QDVgp6ZXLZRqCzGgTnEaRzIG62kHFjB87saVZQ/E17iDe6bJHHy5W7nEQ1wbg
+1+lDDNR76xj1rxUn4CtvcawPTORmTKGA+JezrU49BoP2D6V/v+aXU+6QETQpcQ2
TRkD9F6AKyONvHmsr0d8pIvATl5pdDsRc9GcM0dAu2q33qWw3RwCXZAqNZEHDW95
d7Kghi+ZGa9IgRWvUhqVSfHxNHughPzFgUX2q2uemmfq+oj/NHInKiRltF9xBJmt
FoTB7B+bmc4ajAghT2TNXDHH144l1Em06z7FPPfPfIoGneZ+7lKzh+nRJ0eEvQdB
JtiDXhORLh2SLInAT0sG0Q+A08oUk8whM1/g2Z9hwUr5am0plS2rZfXPp8xtj8wM
dUXDFuufzRatFc9HaEP8ict2qlWiWuWu9eNzq5ZIYLSPO/8PRttSCBrdwcHDaZ3B
j6fugYOTAF2jCc/EOFhpf5hqN5ZacqilOlntr9nTvaXdI6vwjhZ/PrqZp3p2Varf
C0Q1qbLlcEcJBO+xf3AeMUgkF53YaBy8c7cOk5S/aDgREodk9RWwxt8vbOgu/HD8
nQM310n+jHkR4wRlSurDlFINxVE3Dhr5cO2yr1i+vWcN+euKAPyheDwZoFl139C8
rT79vQaU3xXYAmolEwcN
=9pYF
-----END PGP SIGNATURE-----

--GD0jJf8rm+K0B4Sk--

--===============6862999530372339328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6862999530372339328==--
