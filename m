From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add DAC Volume Limit
	controls
Date: Wed, 28 Jun 2017 15:09:46 +0100
Message-ID: <20170628140946.dhbsdyqzo2pgkczk@sirena.org.uk>
References: <20170628125317.30561-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6257160621562591645=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7B0266BC2
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 16:09:55 +0200 (CEST)
In-Reply-To: <20170628125317.30561-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6257160621562591645==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="73gllohy5jwq773d"
Content-Disposition: inline


--73gllohy5jwq773d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2017 at 01:53:17PM +0100, Charles Keepax wrote:
> Add controls that allow the limiting of the volume coming from the DACs on
> the Arizona class devices, note that wm8998 does not have this feature.

Is it sensible to control the volume limits through normal controls
given that the level of protection offered ends up being minimal if the
two controls are sitting next to each other?  I'd kind of expect this to
be something that comes from the system integration (eg, limits on the
physical capabilities of the speaker).

--73gllohy5jwq773d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllTuKkACgkQJNaLcl1U
h9CurAf7BCmXabbphqHvsnQR2Zvl/FS1b/veA3ExVvh+SDZVpLRRNjMXe+O3Qs7u
o+lgLKoAANLs362JFne1ci6TtN9GtMVnd1NE9VE1ltsATLROMWhjn54yOxtEUSR4
ewKCLEoaCKxI2cWzcLzNJsWUYq7YK1YNvGCl+pW0x1uWpKPVwo6WAq0o/9fJWpzH
Kf1LxRW9aXXSnKssUgui4e+SDNJYzExARoIe80OIIlVOXGWd+x9wtnN4f6Iqqxd5
qRlWKOfuei1MdAHL6F6DR63RruywVOFzzNyLlfJWJfxpB9wRo5gY6mu6IUM7rskt
kqE/Us+waDlvSsMQSIgq6jZOVZIgaA==
=aYw4
-----END PGP SIGNATURE-----

--73gllohy5jwq773d--

--===============6257160621562591645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6257160621562591645==--
