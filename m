From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: Fix class W controls
Date: Tue, 6 Aug 2013 10:51:18 +0100
Message-ID: <20130806095118.GA11480@sirena.org.uk>
References: <1375742107-7583-1-git-send-email-broonie@kernel.org>
 <5200B698.7080908@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4698532086436606995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ECCD22616C5
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 11:51:22 +0200 (CEST)
In-Reply-To: <5200B698.7080908@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4698532086436606995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 10:40:56AM +0200, Lars-Peter Clausen wrote:
> On 08/06/2013 12:35 AM, Mark Brown wrote:

> >  #define WM8994_CLASS_W_SWITCH(xname, reg, shift, max, invert) \
> >-	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
> >-		snd_soc_get_volsw, wm8994_put_class_w)
> >+	SOC_SINGLE_EXT(xname, reg, shift, 1, 0, \

> The patch changed 'max' to 1 and 'invert' to 0.

Meh, cut'n'paste - fixed now.  Though actually those values are always
right anyway as far as I remember.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAMcMAAoJELSic+t+oim9HcsP/iYMliyTMCo90ArV4gjovG47
jKNFqdyRbh2TwQv4iZTCnygfg9ig1QHEgPARfClS+8OX9q+3qy9p99VXWc3yqO2y
+00n3+dNbg1fuoucvLZZQm3h2O10HX0eeum5L1w6SWI5BD1vkezMmtzC3zNhm7XH
55l4jFrdwe1XftG4tgHvajk5P11Njv49vBYAs4Dml3rGoMYaxsTLvA1rYunnMZYo
BVYlHtAhy+bC+8za+AZjKu1arOUJmHI7hrg0qQXc65x2wlBUwvAmbkt7kPWrTuvs
dvxkVc8+qBcULOXV/jYDBaAbwkAFSKo0TDIu+OmUkp0aLSN5RO8I2HVV5+AOaVO+
f3R1L44rg1m/GJuv2FAduvq8LUks6RY1Fjm1V1G4YcL/IHawqiI8GLpRxciJf/y1
u42EiwNs38bwMgWKwmbN4BQblIhEkDk53en6JmoLqu2DWnQae6JMEOQc+T41fuT/
6uGT4/oIk4pG3R1jwuIlV4UueTIJiRDZYbu36gGRnNKz0xemFOhhRYyhuDICSl0g
7V/ajdak96YxBBDILL9SsfQzq/oZDO9Oqepbl+VVkzIOOxw5j0DJIFv/icMTKqbo
ISEPQMcY042Yx4Q9mj92MavJJ2Nyr7rhw5XhPYL38QvPH2ynBoHsbNxm/TV5QZ4S
Dzdzzwm27i4UiHEr8uec
=dE7n
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============4698532086436606995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4698532086436606995==--
