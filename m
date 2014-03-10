From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: migor: Convert to table based DAPM
	setup
Date: Mon, 10 Mar 2014 17:35:23 +0000
Message-ID: <20140310173523.GV28112@sirena.org.uk>
References: <1393830854-17460-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0646402236625632606=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 066A42651B4
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 18:35:33 +0100 (CET)
In-Reply-To: <1393830854-17460-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============0646402236625632606==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xOx87wJzmWs6TPt"
Content-Disposition: inline


--5xOx87wJzmWs6TPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 08:14:14AM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes.  This on one hand
> makes the code a bit shorter and cleaner and on the other hand the board level
> DAPM elements get registered in the card's DAPM context rather than in the
> CODEC's DAPM context.

Applied, thanks.

--5xOx87wJzmWs6TPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHffYAAoJELSic+t+oim9fekP/1pQQG+fSCcOQpZLsS4UCY2l
i1g5/X8giCalpo2rBvSuOudfA742Da/pS3w5T1uqaqKzw72Xx1TdW/QzXe+e2DqH
U38LOkDrN91T3DIauFGcikWZ5B2ppejjHVr1IT8o/4W8Yk/g6hS/CHRmVCr7fVa+
vTKO8t4YutqXpE6UKEHCVm/PhiiLLtedx1hYkMgoG12h+bKoZxlp12K/a6Sx0TrC
dI3TiR/JK1LUyDQo+N6dsDnMwHrmfIh1kcOpgxbjO4TyTcCcvwL/SMiF0GDnp/R2
wHBE9TFavzE2STP757haTlXOCeyYqcWVPTdj+QvJxCLraMJHvFLr5wP07RUgXuhq
QOb3NG2EIowyEGoTTefK/NTaoxyfacpPwWNjX+eVLXUs3Gl5et7Zf2SpWnpOFQro
jTCgvcHbVrMuhSkX8JKbs4eqh7elE8auiX3rWN+c4fyeq64HjCkPtz+8bt+NC6ae
S9/h2PUQ6jBQEVOHbbcjOdmmOUoh+aJ3CIctba1CNu7/Kq+rLgrUs5bVs6TDhGq6
LY9Pp5nFGMBl2IfEjN3bIvoWkhD43QZAB/Bs8cIWwW03cWhoBq95rHtpv8BJpui3
sE4VoRbE50GTMUFGuW90+nZRyRyY+env6bC+AudUMGC+9cMkpHfb4i6ogPdDTYlh
PoD4P4Q24BQMrxI3gowh
=WGzM
-----END PGP SIGNATURE-----

--5xOx87wJzmWs6TPt--

--===============0646402236625632606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0646402236625632606==--
