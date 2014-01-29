From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: core: volume control using
 signed register values
Date: Wed, 29 Jan 2014 19:19:17 +0000
Message-ID: <20140129191917.GI22609@sirena.org.uk>
References: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5192826790318625073=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA58D2652C3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 20:19:27 +0100 (CET)
In-Reply-To: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5192826790318625073==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 04:02:09PM +0100, Markus Pargmann wrote:

> There are a lot of codecs using negative and positive volume control ranges as
> values in their registers. These two patches add support for arbitrary size
> signed integer values in registers.

Applied both, thanks.

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6VQyAAoJELSic+t+oim9v/MP/i5P0bvuEdZ3NFS8FrNtH6IA
p/JXso/8pQ+XPvSRbwy2qA0uw3Jcf9HDAuQOk7+siA2QC7+z2s8W2mGgRDhDuXNc
5KPxNGGP8HZvDW08kN0fd1GqnbzwetHEt884mAScRrXA9+IlIXFOr6AuzJJM8RLU
QlzukSjmYUt3pruKYtXgid/Bk72cy0wN+diLINHL0OJ5H52BuFyLQ8vUcRgfaj4o
v5wMZZ7vsbf285lI0mdQddoraMaf85sJpsfd7M7+p2JKVFnGutX0Kr2X0W3lm7HI
hA2w8d06dtsfymjWDASpMLwTpZWvLVpNbeKjasI1SRdjHUQwyB5i3qjbVKOEyQP/
00UDCMMSgO2K+ymuU2HG4xCkZlKB4bGRJCEkmlmYaAJx48VcVKL6yay12wX9skPK
tZtBuZUsR6iZDnQDjzsEJGlmgsOXK2QZ+xJBXvgoJJuC+tirQaj/WpvZVvEoXUHq
zz9NWQUQN5YnWAQiMglvSET3THXiagw+NqUDM3ljaGSWOsiQB/OrAYD8D9s7vUsN
muOlfuja2nEOOTppzgXxHmnjE0kUdr6raeaYtsFpgx2uA/86juKEj+GqSuFwmqW9
9jYHov657cY4D6hq0y493oTviuigIMao6Isz9TrCLruhuQ2b9xR1DJSx/CK4v0XA
rFy914osDrRhUD97HvZ/
=rXDX
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--

--===============5192826790318625073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5192826790318625073==--
