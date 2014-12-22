From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/5] ASoC: dwc: Ensure FIFOs are flushed to prevent
 channel swap
Date: Mon, 22 Dec 2014 13:45:51 +0000
Message-ID: <20141222134551.GO17800@sirena.org.uk>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <8f40608d5665e80bfd3e9723784ec3bc2078e0d2.1418826016.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zipuvUKAEymKn2g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8f40608d5665e80bfd3e9723784ec3bc2078e0d2.1418826016.git.Andrew.Jackson@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6zipuvUKAEymKn2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 04:18:05PM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>=20
> Flush the FIFOs when the stream is prepared for use.  This avoids
> an inadvertent swapping of the left/right channels if the FIFOs are
> not empty at startup.

Applied, thanks.

--6zipuvUKAEymKn2g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmCCOAAoJECTWi3JdVIfQMjMH/is0DkMuFODkJSyTCO60aAmm
NIbsRZR7zFY2f86spS3JzQ2pw0SKPSIw2OrCIqiJY8KxqjUbQAuJAeCYRooCKGMU
AiX8bxsQD9lAKYI0N63RL4mB5Wj5ZakIR19eaFhqvgugD8UG5Gm70oT5LMrbeV3B
MquDsWJyPqxmlFa12+ulL3lNcZUl0MvjFyoK3ww5NmSHQq1NJouWZ8oouzr79vXn
pEE1hxwnhEPS+e8hARsJ5fVU8/jbr8lsClLLoirf2kbRCp2gVJ2SDnQrIaFBGK7/
0dduTfgyfuPz/JmfWVERWF7RW12DfM+X1f96pmLZTyOf2HA98UpMQYU3WLyiaSE=
=r6bD
-----END PGP SIGNATURE-----

--6zipuvUKAEymKn2g--
