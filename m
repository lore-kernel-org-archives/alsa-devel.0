From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: add recovery support for
 under/over flow error on SRC
Date: Thu, 15 Jan 2015 15:58:33 +0000
Message-ID: <20150115155833.GB3043@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87k30yt4zn.wl%kuninori.morimoto.gx@renesas.com>
 <87iogit4vq.wl%kuninori.morimoto.gx@renesas.com>
 <20150112130312.GK4160@sirena.org.uk>
 <87vbkbtacs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1541884823026790007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 90140260605
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 16:59:03 +0100 (CET)
In-Reply-To: <87vbkbtacs.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1541884823026790007==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t8N2qprAjL+0GVly"
Content-Disposition: inline


--t8N2qprAjL+0GVly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 07:20:12AM +0000, Kuninori Morimoto wrote:

> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >=20
> > > L/R channel will be switched if under/over flow error happen on
> > > Renesas R-Car sound device by the HW bugs. Then, HW restart is requir=
ed
> > > for salvage. This patch add salvage support for SRC.
> >=20
> > Applied, but please don't send new patches in reply to old serieses - it
> > makes it harder to follow what's going on and results in things being
> > less noticable.

> I'm sorry about it.

> BTW, I couln't find this patch on mark/topic/rcar.
> Which branch ?

It should be on there, I might not've pushed when you looked though.

--t8N2qprAjL+0GVly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt+OoAAoJECTWi3JdVIfQGWYH/AjsFd+kiK/eAeq/WK1Qb6T1
iD+pkc44OapWqUCDq+pkHrBCx11zT1PAz1zuuIf/pj3JWaOy4tqIuA2Lx/Dr+cz3
vUGY6dQOULDNItLjFLPGxWTNHBBuvC66blJ9PM9Ho2tuogXCIyZkxDds+0F8U/59
QPWvO2E9MY6VW7kMp6jt8oSQUr58rnZTqPOYjXernmjEl5CPMisqk4+cGnpVg3YW
p+S2wAiAtdOAGLR5tsqSVIDx+NSiKu0XBlEIBymNKJlLDQOTXwTApqw4kfcOvJsQ
0bUCBOC0tty7AIN/+6H4ZWLAqgxA2i7+5QXh+V2dCeRYz6LkkQ+Ols3B0XVdSh0=
=wcYL
-----END PGP SIGNATURE-----

--t8N2qprAjL+0GVly--

--===============1541884823026790007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1541884823026790007==--
