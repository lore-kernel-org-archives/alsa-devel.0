From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10 v3] ASoC: core: add
 snd_soc_get_dai_drv() to get DAI driver
Date: Sun, 22 Mar 2015 18:08:27 +0000
Message-ID: <20150322180827.GU6643@sirena.org.uk>
References: <87mw39eide.wl%kuninori.morimoto.gx@renesas.com>
 <87lhiteic9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170626389572933380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBE726044F
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 05:58:54 +0100 (CET)
In-Reply-To: <87lhiteic9.wl%kuninori.morimoto.gx@renesas.com>
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


--===============8170626389572933380==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rNtUoUA3Tn0/N1iC"
Content-Disposition: inline


--rNtUoUA3Tn0/N1iC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 04:12:50AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Sometimes sound card driver want to get cpu/codec driver.
> This patch adds snd_soc_get_dai_drv() and enable it.

Why would a sound card driver need to get the DAI driver?  The changelog
should explain this.

--rNtUoUA3Tn0/N1iC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwUaAAoJECTWi3JdVIfQnFEH/ihxpVTNHQXytBQmEyavMUnP
MrkPzN9SfzahK1upXYVWC0fJd1n6TA+FC1ukjyHs5fsob38ccrPWoAY8TZOxINZX
WYxIdIQFRZjGdFGhzrFKtmA4vgE8ljREZUhUK0gmp7Hd5vFt51NhUdxSH7PxcoAK
ibrtNhjXnhVlbLnKVSNAphqsdy56HFouKTHSVezatIgmNjbZ2fAGqcOUwjlUFw91
pBezUaR/B+zdvHtiQgCHyCpf6wHfVGIPixIPa9pNyII4+y3pvSe/fOIAzKjJfEzS
BIxG2Xuwk4JcxS/DSrug7I+2+ou9VP3RQIrfRv9nM9dzmZ6SoW5gVuGIpjdgn2M=
=2KAK
-----END PGP SIGNATURE-----

--rNtUoUA3Tn0/N1iC--

--===============8170626389572933380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170626389572933380==--
