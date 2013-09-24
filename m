From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ab8500: Explicitly set I/O up
Date: Tue, 24 Sep 2013 15:19:10 +0100
Message-ID: <20130924141910.GC3226@sirena.org.uk>
References: <1380020163-20496-1-git-send-email-broonie@kernel.org>
 <20130924120115.GK2185@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1986519972985379717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 60A7B2619F5
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 16:19:14 +0200 (CEST)
In-Reply-To: <20130924120115.GK2185@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, linus.walleij@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1986519972985379717==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2013 at 01:01:15PM +0100, Lee Jones wrote:
> On Tue, 24 Sep 2013, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > We do some I/O in probe so we need to ensure the I/O operations are fully
> > set up then.

> Olof, would you mind testing this please?

It's in -next so should be caught by the build tomorrow if you don't
mind waiting.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQZ9bAAoJELSic+t+oim9pN0P/jOXq2Cgs2A0oshvqFJEUwbC
uarBuZo2UAbdPZICI5ezx0BlvK5x6sUgLk+u/Tf/fwttPf+RmPD3n6+uEzx9lfXL
S6m0o1Ff5ry8wN2WwJnHACQserxDFsJHA6ZuZYG2UWLrkU2aQq7J1uWhCctcOaly
nI4toYAc0lM5bLaFsBkjhvQEXkHAPcc9u8HcPpb/jh6dGFaoj0E5Y3xQL7cbgt2G
F0sZL9xA3g1H1gnRLy+GNRgc4CMh+DuIqw51/i+h6cQM2qZGVpCNtMXMl/Ie2BwY
tfpI9MIX6CRfnZcMlmL1R/SqBv6sJxWyB9KY7gFZxaVXeBOnNLW0YiDaePKxdRpV
yU7Pql5MqpWfeddKJoNPrcO54e40d/0vBXZ3G9NvaG+3c7dLs+48/bntbRlVGicW
p620OZxSmJqx77cqyH58b6kk3SBBSCdIS7uH42ExgARGMitCx8rPm8d8ODzDSQrv
RGgtsCkosnTjVyoj3tCv6rBWcLnC86deJqLfBZEzWQuRsBwQE0bTyAGVXFWAoehH
FgDy5vujYa+ZmveijTA4xSod7LLijyMM/guUV1eYPaVNiJI9bnAqRdJLgm4565Qi
BWSwbVMnPyyEdFZFJ5O7v3EmWOyT2VB9MntRCVV3WuQk/PangZblYYfsl8GD6SoB
hIV5vRzOM/d0/xY9e93O
=9O7W
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

--===============1986519972985379717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1986519972985379717==--
