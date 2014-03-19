From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/13] ASoC: Move IO functions to soc-io.c
Date: Wed, 19 Mar 2014 12:01:21 +0000
Message-ID: <20140319120121.GC11706@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-5-git-send-email-lars@metafoo.de>
 <20140319111057.GA11706@sirena.org.uk>
 <532983EF.3060704@metafoo.de>
 <20140319115347.GB11706@sirena.org.uk>
 <53298645.8000904@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8740893758810062570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BBE9265066
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 13:01:44 +0100 (CET)
In-Reply-To: <53298645.8000904@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============8740893758810062570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E3bQMLkx1c4VlqkQ"
Content-Disposition: inline


--E3bQMLkx1c4VlqkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 12:57:57PM +0100, Lars-Peter Clausen wrote:
> On 03/19/2014 12:53 PM, Mark Brown wrote:

> >Like I've said before it is not obvious to me that removing the wrappers
> >is a win - yes, things can obtain their regmap but if enough things need
> >to do it then having a convenience wrapper which does the lookup at
> >least doesn't hurt.

> It's more about things like snd_soc_update_bits. The wrappers will stay, but
> can as you said be made static inline functions and moved to the header.

I'm confused - that's what I said isn't it?

--E3bQMLkx1c4VlqkQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKYcOAAoJELSic+t+oim9B/8QAIQ0dzezPDXV5L2fXKDN4d+F
BNFaSGGJwWbEDpT4ydly4ey8mZ+ZH9P00ZNmZsHZJbzL8+PCg4pIPdmuTdYfW+qs
2CvNLUJA7ucik2ftKT8HbChEh/a4ackgGUt9oSQbJhimL8+vO8xIYj8M3nI2kGXq
Ip0Ux+XPJbm3DMA8hlo2GVEw+fwruPc1UzfT5Xsth/BdwnmLMPTCssXbwzRC14Cf
2BkosXvFaUVC4atsQLPCK9CUxYdIZwPYjMIC0E9ORt4F6QrPZWkYVMWvQw8zE+Yf
Loyg9caR4Dt5OTIBXFe1BbCVriPJkCY4PO3mh+Rbi3VIuRcvf6a2v9R8NyEkJoky
s0x2BqU+cmbFlQIjUiqCSH05vmQvGBUjKB6qFqgTs40XU0GRJoKK3hl5qfr7vTQ2
4TjgF7ZU2ExKtIJLGYi90RhuOdg291gJv7ZwBFho+QDt/DuVOoasehrP0iZT1Jl+
ABwL1MAyWIS0UUnM0ocqzMqKJsLHWa7heiYSX2y0vtFDiPVz8TepedTw18kY7Iji
HoAfzQF9rIASm33j2icbQlijxOZ4TTSuxkea8ZdSDFFD3AFiLgtur/IjcjSv7ZpO
HzgF+AvgEvoGPV4A02+/2ADOEDi0JQKh9NDdb7Qkg9D7US7erc3GyiQxTH/4Jlpq
7kGZa14T/apYaX/luFxh
=007f
-----END PGP SIGNATURE-----

--E3bQMLkx1c4VlqkQ--

--===============8740893758810062570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8740893758810062570==--
