From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: tlv320dac3: Use
	devm_regulator_bulk_get()
Date: Fri, 25 Apr 2014 12:23:47 +0100
Message-ID: <20140425112347.GK12304@sirena.org.uk>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
 <1398389226-18569-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3552810261881160265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DC17261A12
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:23:56 +0200 (CEST)
In-Reply-To: <1398389226-18569-2-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3552810261881160265==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XTuBnh2YsTamljA3"
Content-Disposition: inline


--XTuBnh2YsTamljA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 10:27:04PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as =
we
> do not need to call regulator_bulk_free() in the error and remove paths.

Applied, thanks.

--XTuBnh2YsTamljA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWkXAAAoJELSic+t+oim9RukP/jQSJfTPE6Xv1wJLCJTcmj/W
o5v3g38HKJLq3oQp17UZzJW4dxk7vNHu31M+oF650pCjwb/xiPfOa1PXSesQN2Fx
/7QGqm13TY7ALWrJPQdCY7AwuReDuy3pKIUqbCOpd0n+B2uT05kD++I+5KOTVt8K
UjnDfQGrJlIysgV4jRDHNKc+H+jhQFzAJQ2+zWe5Wh3H/L9JDvsek3fE8UJ4te/r
jTZHhi73uELPZxUl8Mm0ZRcoP/ViBPeoA+SWgQI/Jsrla3QFcI3a2o5FrpAFf0iX
Ni5yNaOPgWAmowCuQjRdZEQ3rttgVYAbYopSlMQhSQjHZlgHSURjB0FebB6NAkHR
4n46UE5o8JYcTYnm7Frx40IqDa5eorPSM+dsaVqtvOdOAW/Iqbdpr1fJVskdifYl
5yfzTCw7/YC6Haei+zfFA5uI0rXEcMNj+kxWY1DrenfIItPji+url/yqlgpg8EkR
ovoHCmPN3UYpU4jAOhu05tTciDXf87zuZ8ylXxf5TcXoZ0iNTQ2iBtD3ift2jj1P
aMzDfkbK+x3UV2ZN0OnyKEId309ebmae80OT7dW5/EsGrffqy5Vzoc6fbCHuHpx0
1S+d2mFGrXRCker16TZ9qaWaPk7B9bSjOM7CBtmn32idVixZvAa2vKyDXXZAoSPY
sl94wGAxw+1UEhegf/Xd
=i+Gw
-----END PGP SIGNATURE-----

--XTuBnh2YsTamljA3--

--===============3552810261881160265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3552810261881160265==--
