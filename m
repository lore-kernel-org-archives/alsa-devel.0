From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/10 v3] ASoC: rsnd: no more SSI restart
 when unusual situation
Date: Sun, 22 Mar 2015 18:12:31 +0000
Message-ID: <20150322181231.GV6643@sirena.org.uk>
References: <87mw39eide.wl%kuninori.morimoto.gx@renesas.com>
 <87h9theiap.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8198159598772535872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80D07261A5E
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:03:28 +0100 (CET)
In-Reply-To: <87h9theiap.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8198159598772535872==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4QzzFpAwbwI4hdN6"
Content-Disposition: inline


--4QzzFpAwbwI4hdN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 04:13:47AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> It will be SSI interrupt endless loop f unusual situation happen.
> This patch adds restart limit for it.

Applied, thanks.

--4QzzFpAwbwI4hdN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwYOAAoJECTWi3JdVIfQT8EH/0sCCff66zdIpruNVyy+BYUb
h8J1yyKOiPRCTbQoZit/21eSsd1tzWciwkMq/knKn1jDO9QnZoJRX54qpuD+rL0h
cnkJjHzDeiWAfQ3bYI0x0d0ZQu9GtLNP7bxuMLZggsbiuE4y7/z72ueDfUp5mqUZ
oLckGa9aJGWKpOhjnoyQgQWXmSmYceM2xoXSTX9J0NLnc8qrWK6n5w+YmpTaSiYw
q58YwGW3z8jpqKMzHQiHua7TerPvYrd+tkkjtRrUbHFbgf3SIY6/CRLWYHNuQDZ6
46ZSvljI13tYiO89l18D3hzfhviHfT2CUXwMucLD6OYpgkKp7N2xQeA+2KuSVGk=
=8K/8
-----END PGP SIGNATURE-----

--4QzzFpAwbwI4hdN6--

--===============8198159598772535872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8198159598772535872==--
