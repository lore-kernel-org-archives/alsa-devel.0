From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: fsl_ssi: Remove unneeded
 'i2s-slave' property
Date: Tue, 30 Sep 2014 13:43:17 +0100
Message-ID: <20140930124317.GD4273@sirena.org.uk>
References: <1412043930-15243-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6718990517239121561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C07082606DD
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 14:43:25 +0200 (CEST)
In-Reply-To: <1412043930-15243-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============6718990517239121561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 11:25:29PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> There is no need to use 'i2s-slave' property, since master/slave configur=
ation
> are passed via machine layer.

Applied both, thanks.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKqVkAAoJECTWi3JdVIfQRKMH/1p1NE4h95Fl6wX1BwKXN82U
nYa9ZgyjRHu/nDqQ+Z+LgBDxXa97YVgzi11O6yxZxMIV+G7fs5gWNC5QYWjDknvq
VvaqBtFcjGggfXqyypNf1Gu4znrpZDIWtKB5puPoUHqIAfWiiqRjb46dARjb5imx
2MtkChZWgOX0nuSVORRU2EocclNwTvlPL6zuBAcFYZpAte/T9rneXKdmyH2heNpR
3uUG0aPIp/ue7ePfsvgGwjTTsb1H8j2B91v3VZZmqJr7dbvqNroa2hTdRDs8WFp3
kRXu07kJzTwJoKlXjGw4YO4PhSBLNiL98/xZjYeMZEKIuULh8lgJhEn+ZxCyc+w=
=Uu1j
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--

--===============6718990517239121561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6718990517239121561==--
