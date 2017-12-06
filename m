From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility
	with A64 codec I2S
Date: Wed, 6 Dec 2017 16:27:25 +0100
Message-ID: <20171206152725.ejvum7s3ck7yzwgn@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-3-anarsoul@gmail.com>
 <CAEKpxBmHhZ+2WNXJEPbQFS6KeKsqRrZeNodRnu1M5yLc15DerA@mail.gmail.com>
 <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
 <20171205080149.2siofhpynfrvnoiq@flea.lan>
 <CA+E=qVeZtWqLZddHtZMv264bWaVcReToYqkriYryf+wZnUVtCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1003079371844545396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 256AF26704A
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 16:27:37 +0100 (CET)
In-Reply-To: <CA+E=qVeZtWqLZddHtZMv264bWaVcReToYqkriYryf+wZnUVtCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1003079371844545396==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c6lewebwbmyj3su7"
Content-Disposition: inline


--c6lewebwbmyj3su7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 03:04:19PM -0800, Vasily Khoruzhick wrote:
> On Tue, Dec 5, 2017 at 12:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Sun, Dec 03, 2017 at 11:34:06PM -0800, Vasily Khoruzhick wrote:
> >> I'd keep it sun50i_a64_acodec_i2s, since other 3 I2S modules aren't
> >> compatible with this one, but similar to H3.
> >
> > Please don't top-post.
> >
> > What are those differences?
>=20
> Different registers and their locations. Compare quirks for
> sun50i_a64_acodec_i2s and sun8i_h3_i2s fro details.

Whatever differences should also be mentionned in your commit log.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--c6lewebwbmyj3su7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlooDFoACgkQ0rTAlCFN
r3Sm0A//VRGnIIpT1rJOrIH5upUfxBgTUFpx2N2kF97otga8fPw/QZCzbED5RVAG
zaO5a+COrTi07aivuQ+xm90H0SsqFSgefzB0ZhVX94/C8n8AhMse1vlqCwDbKBHI
Ns/mLNNKIoEZzk9nh6Z+XDNH3b1f+eoE4rU+LYmDvmfa0v6A0dFVyI9z7Wmiky2s
dG1W2XEcmLtNUO5E5a+8oVfGoAnuwbWAmN2iJwgMDxf1wDVjUXqvd418Q6t2Z8vM
4BTiunYeeZSyGosnMGtjX9tInwLjiga3ALrgwFNffnG/umPgeYkQYVZfNzjS7jYT
SyNVwKO7j7yNvVtm8cL62s2ZGXMqYPSvpSd9eDZcIsO0pR93w/2UricfZtbzLBwx
ZdVP1v+tCunZTz9W9D/9EfbkmTyuXrrppshFMzDcDzZI5/f8n+HVQ4dLufKEwgrA
tA8p1tm5PqKlU4yq7eTzLfEqE6oN8EWBkejPoXoTKjVOolrCX2swiOufjYZ9a0TL
r1Eg+0E3egliEFpnqUHBMRscrWwHj3wfYjFHh8hy2zq74RMdqJWeZJ2WIJF1aq2V
F0ioT4zo4nCe07Uy/Cb2lU92VSwf4bV4/HKDfo7udb3FIryGFU4N893gV9v7MPw5
IQW6nGnL4iFtSsmcF/0RUwx1JIPsje2DHkZS/RguFs6OI10Tu68=
=U8jy
-----END PGP SIGNATURE-----

--c6lewebwbmyj3su7--

--===============1003079371844545396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1003079371844545396==--
