From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Use '%llx' with 'u64' type.
Date: Mon, 16 Apr 2012 19:37:02 +0100
Message-ID: <20120416183701.GF3219@opensource.wolfsonmicro.com>
References: <1334584389-26268-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0154816869350069380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7D05244CD
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 20:37:04 +0200 (CEST)
In-Reply-To: <1334584389-26268-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0154816869350069380==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 10:53:09AM -0300, Fabio Estevam wrote:
> Fix the following build warning:
>=20
> sound/soc/soc-dapm.c: In function 'snd_soc_dai_link_event':
> sound/soc/soc-dapm.c:2913: warning: format '%lx' expects type 'long unsig=
ned int', but argument 3 has type 'u64'=20
>=20
> '%llx' should be used with 'u64' type.

Applied, thanks.

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPjGbHAAoJEBus8iNuMP3dWC4QAJ0czSoY+CdnOMbX/BoeCiRg
yxIpMn2x8rLL4qejuZt2FokUVTuXod4zF+jk+uAZnpUIj8Kf5RFmhEdhDqrlL/ow
9wxgpYQb0JpWTMLqH7vgF8y5/BSa+CSnSwz68fdxl08ED4ZrJkBz6MuplyUeDs82
YFFT5gbAtsHsUuMp4SZWZMpyha2ecYQmkwZw/cCrgsbA+uoWlCBic45b6NIEzVzE
D4/dQVJLsV7IXy49FlaHRGoRm5rj+yQXhoW8Zu+gwuBotB8nRTDjyjFMi7kuCv27
YyUO/uQkN/utuhfIdv1gmpbI8Tpnu+fmVA7E2v2ppLYM7IxI6TmVOo3eNsIdgOfe
iOpYYxU4O/HCkebNUNPqsKe+S/8WTEC1MNyhVniy+kOYoPCtSX1uOIimlT9rqTBl
5uRVEpY8OBFaib2PnXqTFaHWmwuRhaq3O6T8hVuzU7JJelry4LYGqXTqRveaE71R
ecGBUpBaB5ws+IfEsNQR4W8LmBYAmoc8x+w/8105rxlwyvztmIbbn3gG+c3u6q7a
5qE/JxclBmcdq5+hwlFBBdK499v4nbOIbbiurYWrX2kpd2U7zcFhRzDK+qNy5hWO
Y/zONxqG+wC+8Oft/CDjOLRm7QEti0UslxROi8KervPu9O/v/Wfd7AI8JpJrqRqj
stVzYrFpP8uMKsFd44x2
=V0M9
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--

--===============0154816869350069380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0154816869350069380==--
