From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: constification patches
Date: Mon, 15 Jun 2015 11:32:38 +0100
Message-ID: <20150615103238.GI18309@sirena.org.uk>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7391281572365686996=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10F03260870
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 12:32:52 +0200 (CEST)
In-Reply-To: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============7391281572365686996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2015 at 02:25:12PM +0200, Mathias Krause wrote:
> Hi Liam, Mark,
>=20
> this series constifies a few variables in the SoC code that are only
> read, namely struct reg_default and struct acpi_device_id.

Applied, but again please make an effort to use relevant CC lists for
patches.

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfqnFAAoJECTWi3JdVIfQ7tsH/iPoxrvZh9GYkBNwMvbOxbc0
V9KdW7ldgiFqMQnBHdaLt9DDMEnWF5pG9AcYM7KYV5NsKXNa7Kg31Or6lMKqCB50
p0LF6WEz1lyidekq1ktcP//yFyUjeJ9HkjPqRrv8NuvraJCZTzp3oxsnb9+y+y/1
xfIz5h1gJgfwlhIowLpLF8ZQHG0c50pO24yKkGaeBpBbDy5XLchEZjrjbuzEfKBp
63rewQjL8+HAqv7QFGnnpgCkJvCPz3abbrhWjRwxkDH3QB6vD845gaYfihJGSZ1z
B2HbQEZ9+BU+QXpIuDNdx4BFhTCDJu1nYZ9cdwjwvYD/4BrS3ymyQLAgmTkuigg=
=FU3s
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

--===============7391281572365686996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7391281572365686996==--
