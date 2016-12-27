From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: Re: [PATCH 1/2] ASoC: rt5660: Add ACPI support
Date: Tue, 27 Dec 2016 11:31:08 +0800
Message-ID: <1482809468.3862.6.camel@canonical.com>
References: <20161219135147.24208-1-shrirang.bagul@canonical.com>
         <20161219135147.24208-2-shrirang.bagul@canonical.com>
         <20161219154428.qedy4fxmtsvownvh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bpIMdyIRQAB00TiOtVi6"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219154428.qedy4fxmtsvownvh@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--=-bpIMdyIRQAB00TiOtVi6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-12-19 at 15:44 +0000, Mark Brown wrote:
> On Mon, Dec 19, 2016 at 09:51:46PM +0800, Shrirang Bagul wrote:
>=20
> > +static const struct acpi_gpio_params audio_wake_intr_gpio =3D { 0, 0, =
false
> > };
> > +static const struct acpi_gpio_params lineout_mute_gpio =3D { 1, 0, tru=
e };
>=20
> Can we please write these in a fashion more idiomatic for the kernel and
> useful for human readers with named struct fields?
Okay, will update in ver. 2 of the patch. Thanks.
--=-bpIMdyIRQAB00TiOtVi6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQI6BAABCAAkBQJYYeB8HRxzaHJpcmFuZy5iYWd1bEBjYW5vbmljYWwuY29tAAoJ
ELlj3b/+u+hkeHMP/Razg3jYOTiblXJ0/9qE0WQvESZze6pknqBm+OgFibUZeNwn
gXcM2RbEYllAeeQJf+1oZNbuRtZ5+1uXJ8+fTXwmmUnZR32scKe2nnIp1JUvKDV5
pR3iXhyPaLnmQUuYjkDFvIVVW10LlSiFmvdmwAGlxaXA/r83AD9/5PtsLPQQVyBv
oiqN+BFAc9THP/NT8QawsVYrsqbS2G7e3B+dcOKD+U+S5vqNzCZuEzDHqQYTmXDD
Da6OjDZkyXZEfk8UkbJHh6Y2Ij7O0/ZPY7UUpgma43LvKi+X8gmcXo+Zbwvfv+JL
+fUdc8iqbTX4muMxsS3yzi83xG0zptIHT/Pph41Lme4y5ExuQBsW0m+CWKJgC8by
60gHqp3AQ6uD+KrpKwPSo/zF/oGH2Bht/PahcKI+orI2/rQ/iQ9myGV6k85VQ1h5
DAVLUoUgZEwNH3+uIGCnql1o55Fv2vLsWYmUY1eYvMQQaBEbV7c2Ku7lbg6Kc+Bj
4cqRjIz7gmTbKaC500sfd7wf8V40dldlKruifxd8xT3WkYKGBjo+oEok7yOt9wBo
e9oEuN9NXg9qGuaOWG3lEMKEB3kVL60NDqX1jbqiDNPm1SxT6k6mh+KrTWNYRwA7
rAvnpNCdgU2c8gtuauwOBnD6jgKA0LCrYDZj8bLhnSozTR3zy+9BWh3xFWsY
=rCm2
-----END PGP SIGNATURE-----

--=-bpIMdyIRQAB00TiOtVi6--
