From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: davinci: Use edma-pcm and remove
	davinci-pcm
Date: Wed, 4 Mar 2015 17:26:15 +0000
Message-ID: <20150304172615.GR21293@sirena.org.uk>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1933923791078301016=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA5B26526F
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 18:26:26 +0100 (CET)
In-Reply-To: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, khilman@deeprootsystems.com, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1933923791078301016==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N8bpTmlvM7/fDIud"
Content-Disposition: inline


--N8bpTmlvM7/fDIud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2015 at 04:45:16PM +0200, Peter Ujfalusi wrote:
> Hi,
>=20
> This series will deprecate and removes the davinci-pcm platform driver and
> converts the daVinci DAI drivers to use the edma-pcm.

Looks good, applied all thanks.

--N8bpTmlvM7/fDIud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU90A2AAoJECTWi3JdVIfQmCkH/1PFeUk+2ggtAT2n6QChSwiN
Fc1Kd7oxt5pQ6f2vi1lalEeTAn7459NaYmdw0Cc5dAjlEjcZybrMFDKvgsiAcy/y
enMvZdnVuUhYAw1CcwLcSAYlK4XP4hjr8DcLJrNbvpd/mmjcz+moKDVjU0drjn5W
x4nYTfkSb7VGLrI8f5GwUN2PRpF8Tkg6JGVfanNuyba5iWyDK+/gklycb20i4jaa
46XWqZ3Bp2pZgZr5QogAGokQsVThozyhyU9Bp51zU4kZDgh8ro+zUTjMhZBQYaME
pR4SoRQ9Ky2Hz8VzLUr9+zJMXAXvPVL8T2dwlxAVfOjNnmjxf0Hb+12A/Q3bJKg=
=Y4X9
-----END PGP SIGNATURE-----

--N8bpTmlvM7/fDIud--

--===============1933923791078301016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1933923791078301016==--
