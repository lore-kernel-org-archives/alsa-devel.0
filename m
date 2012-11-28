From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/14] ASoC: ak4535: Use
	devm_regmap_init_i2c()
Date: Wed, 28 Nov 2012 17:42:45 +0000
Message-ID: <20121128174245.GX32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6469156861963904176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8460E2625E6
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:42:46 +0100 (CET)
In-Reply-To: <1353930587-12907-6-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============6469156861963904176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Weqbz6OltVu8XOAh"
Content-Disposition: inline


--Weqbz6OltVu8XOAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:38PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--Weqbz6OltVu8XOAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtk0OAAoJELSic+t+oim9/hYP/AjHNN2lEmc6E+BQEZm8cJ06
28Rj9uU7X7LxTjxvz5Gpp8SwTBSBUqX6AYDvYQCQvNNoYImsJBHe8h9mrPiXtJio
STTetoBQZ/EqDvs57dHel5li0rPYULG+eKQZCnIDr/GhnLDvEbw/wDELJXrJbEHK
SrA0Y97y8aYLPv2z2efLZiMFHEq6K6QjQlpfAQ0pA5Qc5Vh5Fbu6I/70OYNPpFZe
MovOVVVHE9N8urOfHV86s4mHBlVpFrFJcMXhRQ8H4pVhT7tuP3IqcUtV9Alh+csT
Y1a0wLnpGZM+42SUOyPK4Eh+cBHMqt5eQg97QUKFC+fxu0UDtEddvRWRnBKK1nYY
XEf2i4WHTfUJgbC6yCsswhlu5Q/ir5j8za+aT7WvviWI78Y9X/BTw9wxYVcjQNor
LNH+ONEW1fQ8EOZZg+GuGBemLeReInwLFHTX/0sxSQrtTH45xIrPm13+BncRfECv
puzfcbezvaBeqVJ1VTPVb0obwZ+ndb/QwWGV5EUafUBJE0+NsibNeXb8V8GGPzSo
8A8GMwfHLqUYjCi0449CPGp9HuwiIaSbUec5sp0eMGeNvaOPeMPWqCmMr2TeSlNM
ZF8XPIwdodJwVx/FTDoYB/DSCDaspu0lXt1HiR1J+vTerVv3ARZCOPHQ30XZVxqY
WTVkZP/TX5loUmCDmPOP
=SwNv
-----END PGP SIGNATURE-----

--Weqbz6OltVu8XOAh--

--===============6469156861963904176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6469156861963904176==--
