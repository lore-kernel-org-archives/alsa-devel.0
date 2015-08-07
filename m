From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 30/31] sound/atom: use kmemdup rather than duplicating
 its implementation
Date: Fri, 7 Aug 2015 13:29:35 +0100
Message-ID: <20150807122935.GU20873@sirena.org.uk>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
 <1438934377-4922-31-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cKYDpu/i0M0TNss1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438934377-4922-31-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--cKYDpu/i0M0TNss1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 09:59:36AM +0200, Andrzej Hajda wrote:
> The patch was generated using fixed coccinelle semantic patch
> scripts/coccinelle/api/memdup.cocci [1].
>=20
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2014320
>=20

Applied, but please make an effort to use subject lines reflecting the
style for the subsysetem and if you're sending a patch series make sure
that at least the cover letter goes to everyone or (if there are no
interdependencies as is the case here) just send them individually.
That way people can tell what's going on in terms of dependencies.

--cKYDpu/i0M0TNss1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxKSuAAoJECTWi3JdVIfQBSsH/0AkB0rSFHxr0M5UWOZMJcwg
QVdCPkz0gM8YdPB8tpSYUEBm9whyvltqYyYYKjYvFL/g9duJA0kHewIvdEohsRHY
UBl7j6ECyYAD182eJk4NHEc+50z4akKauwJe1v1rKA4K31NxvepMZWsNR1cJ1+bU
Z/kOzqxnyR8oLD2zyqZ6JRW2Y54ORdULwe+JMLXtjDkYGq13zmH9Yu1CkTUhGuT8
FRecwktAI61IanKu/YkDzjEWwRF4xpF3pPYGD5j1HQX44prnKRDBNGhVyZ5qSiGh
qx0gwddNA+GuMvuCelhz40Xulwkf7pYBKiUPsaFf2TWIXQJ+dSClrettcARx6Nw=
=7/OE
-----END PGP SIGNATURE-----

--cKYDpu/i0M0TNss1--
