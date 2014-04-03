From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Thu, 3 Apr 2014 23:14:06 +0100
Message-ID: <20140403221406.GI14763@sirena.org.uk>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4243586517138158478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D282656F6
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 00:14:20 +0200 (CEST)
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4243586517138158478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yxL3IctpgIvrN+d"
Content-Disposition: inline


--6yxL3IctpgIvrN+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:
> Hi,
>=20
> This new version of the cleanup is mainly a reordering of the patches. It=
 moves
> the regmap patch to the end of the series so none of the other patches de=
pend
> on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" which=
 also
> removed the switching between network and normal mode depending on the nu=
mber
> of channels. I reversed this code removal. Another new patch was added "F=
ix
> i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai_f=
mt().

It's been nearly three weeks with no response to this except for the
last patch - I've got ahead and applied since it all looks sane (modulo
the bugfix question), we can see if problems occur in -next after the
merge window.  Thanks!

--6yxL3IctpgIvrN+d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPd0qAAoJELSic+t+oim9Zq0P/iKt2Vs30cWAj8kSyuJh6oAt
g43Baa/OoIoEyCym++DBwSASkdmwYCmRsVbuY7AC44i8REAhqIemwOVACh1F8rdY
l8T8d3um8muGeO6DLjVh4UVN/tLEbZuOnCKiFg+QWPrXfpRd008TgAev33aHEe98
YiAAYUVDDgRI1SnK3yZEb4N0UclwJCWk15Fs3hIkrXzCPv3+XqvXSOoG3Dbk+tlL
9Fwi0odn9cF2GI7Jdwlr1VYPPuGPdG/VunNt/SW6Bj6rpWKov1TlzrncpiWkvmwi
LJRxwA0icoEeNW14gv07yxGWsRXqy3gfrV7XIvLxLWV2euLbVMCy7W34TQTPS3Xq
4NCargt47W/dbebv6f0O7l0rXRwb7wR/g/2xtF4jppqfH8KToH/qN9OpiobfNoOn
L9UEqAWAW08cteskLiuxTk6TCmPvntW4FTqQ1X6o/tJJQenregSd0gOV1om3hO7f
+AMXLfax5kK3rzItFh8+9CjpiGUFmVpPzDoBF2VN4aDL8oXuYl2cjrJmKYnDxWoS
EnAr7e8X+7Am1K60lQrSs+9ZKzeX15xyH2hwMKA5JGxaOIPsXmLfCS5xsBCxpfg3
+jyEL6VCsWeD0iInoIpKG2jL/mSrsrJWim5c9UctHOoe6wLKUTUHZoco9j/pussL
r+1mLdndJfdx925NeC3b
=hQ5h
-----END PGP SIGNATURE-----

--6yxL3IctpgIvrN+d--

--===============4243586517138158478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4243586517138158478==--
