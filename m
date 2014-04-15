From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix snd_soc_kcontrol_platform()
	return type
Date: Tue, 15 Apr 2014 23:53:28 +0100
Message-ID: <20140415225328.GL12304@sirena.org.uk>
References: <1397593461-11369-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8333280133187519152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9916260799
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 00:53:44 +0200 (CEST)
In-Reply-To: <1397593461-11369-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8333280133187519152==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uus2/pBTyv0r7Av1"
Content-Disposition: inline


--Uus2/pBTyv0r7Av1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 10:24:21PM +0200, Lars-Peter Clausen wrote:
> This should obviously be snd_soc_platform * and not snd_soc_codec *

Applied, thanks.

--Uus2/pBTyv0r7Av1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTbhlAAoJELSic+t+oim9+EoP/RRCcg87D28UFOtzK4Gs00mt
/aehwfIYC/OLzjZ3wkUgMuoX+19RvGaPpn4479cQQciSEFnQTf2jM38RnKccbbs/
7ychLwGtudyfjPzePTsgp/5keL7iAi/6m3tNdOWfABDa9IKZZb1JIE3rPNWZ2LrR
t3hrafHTOFl+hKzcYnhW7mh+ENjzhDSA5Od+W5YVGvvBHKaZcA9oa5Iqj85yQY2J
D/mKVQ5Mh+VXIJ0TMKoEIeFoUVEifD0DEaUb9/pPAHRQ5o1BbFxOemrBoKMy9ZEl
QSfhgYKacG5kuXtur0HqJcIIOYFqHTYsM9MGev1Wl7l9Q6S293CSqiobjuZVHD+v
0rU1g/43tjLEGjg3FbwNk8G8c0u1DVkhADj1HTihPtx8+p1VY3YsYI2P4fj1rbbm
WVeWin03xN8PLz1yWx6gNh9v7D6cJ+Fma9H5rX8sUnpOQLd0vY6Q8gGUOVDJRstl
C+rQxIdNLN6LRwYsVFY4eiVCMxxztlFLsLkNtOY7hsLJwMfIUOhUdU2QYJ/hQMfn
uexO7bmQQ5tP8/EVVPjOCMvUeGCuED18iibP+Wv4owFGUjX5stDNlZIi9B9/qKmE
Uogjpp80jDV9Y2/zwHjDePWAUp0Mlmfy3d6p0ssVo12NLiBWbSVB5VY1t1DaUwDg
z/bAES899UqmIom05u2Z
=nvpV
-----END PGP SIGNATURE-----

--Uus2/pBTyv0r7Av1--

--===============8333280133187519152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8333280133187519152==--
