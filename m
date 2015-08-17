From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Mon, 17 Aug 2015 10:33:17 -0700
Message-ID: <20150817173317.GQ10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508141106040.27635@lnxricardw1.se.axis.com>
 <20150814160731.GS10748@sirena.org.uk>
 <alpine.DEB.2.02.1508170844030.27635@lnxricardw1.se.axis.com>
 <55D191BB.1000204@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8955013482975310774=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AC02260427
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 19:33:21 +0200 (CEST)
In-Reply-To: <55D191BB.1000204@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ricard Wanderlof <ricard.wanderlof@axis.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8955013482975310774==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C3csQhHPgbq3tf44"
Content-Disposition: inline


--C3csQhHPgbq3tf44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 09:48:11AM +0200, Lars-Peter Clausen wrote:

> Yes, I was. In my opinion this set_dai_fmt() implementation is useful to
> have as a mechanism to detect invalid configurations. E.g. if you don't
> implement the callback the CODEC will accept any setting while with he
> callback it will error out with the wrong configuration. Given that a I2S
> link typically at least somewhat works, even if you have the wrong settin=
g,
> I think it makes sense to keep it to catch errors early on.

I agree that it's useful to catch such errors however I don't want to go
to implementing basically empty functions if we don't have to - we
should add the ability to specify capabilites in the DAI for the core to
check instead.=20

--C3csQhHPgbq3tf44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0hrcAAoJECTWi3JdVIfQKlcH/jwGcJNI7FsYCgo9yDtU/Su1
5pytcaakpC+DKqP8Ou7p3Yz6huvN+P8/dEGTEROj+F/K7c423FiQepuUDNowKeps
6zUnCpP8B6HQ9jnbxwKmoKNIGJsonutPy1ni8skc9oIklk4UZxscVRmV4vAqdPQX
M9JR5s6KoSM/GNcGylyS9KtMvRu29rclNkUtNkWezzT0rz2uzYluo3oSYHS8Dkz7
HWyuh9pBvg7qJy7HdsiRliTDco66rh/RobwThi8BOuM7T62QxEgubE6EKzRyaiDl
xSCjJsr5kTPKI+ieBjodoMuyEZZa+rFZdCv9O7o8n+0pH4boatCcQvC/YTXadbY=
=1xA8
-----END PGP SIGNATURE-----

--C3csQhHPgbq3tf44--

--===============8955013482975310774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8955013482975310774==--
