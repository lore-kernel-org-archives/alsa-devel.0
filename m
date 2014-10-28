From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: add
	asoc_simple_card_parse_daifmt()
Date: Tue, 28 Oct 2014 16:37:21 +0000
Message-ID: <20141028163721.GA18557@sirena.org.uk>
References: <87sii9qa27.wl%kuninori.morimoto.gx@gmail.com>
 <87r3xtqa18.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7949458804071512822=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EDED26047F
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:37:44 +0100 (CET)
In-Reply-To: <87r3xtqa18.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7949458804071512822==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JeObzbN4jAL/QUby"
Content-Disposition: inline


--JeObzbN4jAL/QUby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 06:04:52PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current daifmt setting method in simple-card driver is
> placed to many places, and using un-readable/confusable method.
> This patch adds new asoc_simple_card_parse_daifmt()
> and tidyup code.

Applied, thanks.

--JeObzbN4jAL/QUby
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT8ZAAAoJECTWi3JdVIfQXqwH/2WL2kYdbyl+YzbCOryvjcwC
6OrpF/+wgD7pVz2yVQmTj3X1wp4Tuz/KxH4THb4HQ1yIw2XO6uVDY9A2BffQSxbQ
rWt3C9JYwjLOxiF/nXQhIBscx5Y3dPmKF2aGaY657whHGwkDDJ2wYhDW+r4TDJPw
fhSq5jtBbSV5b3YAIh0rg+aSjw+ZCsr4x74Kt7NlYPB9UQgMZyK+ye6EVGqx/2t/
ikIkrai/+5Q9YeKc78dXIC5h/8r2UtdxeVLhYGEPcfkl/HqPNyEun4Z1thtttGOr
IH1GkRvghm8hZ+SQpuRsWm2YAUJncbsftdWZ08EykkVb6qF62LE1GYKEpHWfdXs=
=3ygi
-----END PGP SIGNATURE-----

--JeObzbN4jAL/QUby--

--===============7949458804071512822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7949458804071512822==--
