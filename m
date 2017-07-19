From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: rt5677: Remove never used
	variables
Date: Wed, 19 Jul 2017 12:24:12 +0100
Message-ID: <20170719112412.wrqgdk7typqie72d@sirena.org.uk>
References: <20170718173419.65980-1-andriy.shevchenko@linux.intel.com>
 <20170718173419.65980-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1868339907945332159=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F10A266998
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 13:24:28 +0200 (CEST)
In-Reply-To: <20170718173419.65980-4-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1868339907945332159==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aiv6noqcokz3am35"
Content-Disposition: inline


--aiv6noqcokz3am35
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 08:34:19PM +0300, Andy Shevchenko wrote:
> There are two variables that have never been used.
>=20
> sound/soc/codecs/rt5677.c:785:35: warning: =E2=80=98in_vol_tlv=E2=80=99 d=
efined but not used [-Wunused-const-variable=3D]
> static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
>=20
> sound/soc/codecs/rt5677.c:783:35: warning: =E2=80=98out_vol_tlv=E2=80=99 =
defined but not used [-Wunused-const-variable=3D]
> static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
>=20
> Simple remove them.

Are we sure this doesn't mean something has the wrong TLV or a missing
TLV?

--aiv6noqcokz3am35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllvQVsACgkQJNaLcl1U
h9D9qQf/Q+B3hXUIvfDdIUIEWkUCckcXBOs7IcJmX6UeLsuAyGbMuFykIGx9bs/g
pSlQmBSevK/K4k+ErR93hbl8aznqvkm+T4t7yeE/5AgSktu2mUiyk2HSCS6KVgvO
7Tz53s6rDaAvJwpWAFh28WWSPEAiHgrcihHkZQJgMMzANildfEHKZDNvVBWTBmFo
2lyoPodZ8GN6FYVlpntG5qL7E5XE/RnYQKO55+Ltg+HVNLIBrBAGPtOJimcO4/Q7
JgF/He4Ip/5F+iExTeOk6i89pH5jbG50BQdJbehRov8qb1867yQQ06KiyTL8N2wu
T5SeF8SCMntLqUFra/q5B045Q6huRg==
=J7ib
-----END PGP SIGNATURE-----

--aiv6noqcokz3am35--

--===============1868339907945332159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1868339907945332159==--
