From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] ASoC: sun8i-codec: constify
	snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 08:35:30 +0200
Message-ID: <20170713063530.mheqk6kymzrxfbud@flea>
References: <20170713055223.GA18940@embeddedgus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5271295559547152861=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A2A3B266C3C
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 08:35:31 +0200 (CEST)
In-Reply-To: <20170713055223.GA18940@embeddedgus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5271295559547152861==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3bssdaytoy2ddxl"
Content-Disposition: inline


--l3bssdaytoy2ddxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 12:52:23AM -0500, Gustavo A. R. Silva wrote:
> This structure is only stored in the ops field of a snd_soc_dai_driver
> structure. That field is declared const, so snd_soc_dai_ops structures
> that have this property can be declared as const also.
>=20
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--l3bssdaytoy2ddxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZZxSxAAoJEBx+YmzsjxAgkIUP/3oT1gw+doiyMYdHUbriOCul
8g2k9I9QGmsJcHDXdRLDdjjmWG2Frd/xwLLp6bkyvyPaT9ykvcaoRauqAhxcrXda
nDcCRuquyevXrifRftjY0AEGtp71P/fXkTbVDwXhRFomQ0vXVplQQmdjQSmTjKvN
tQgdQv2rFVqQulIzHumQbSnQMlcckKn9NoDgVpXxibWBqfZz1RBhlCJoLPR2OuhJ
FnSI0Bd3TCqekjeSPbLXGStxxBa5bDcapH+UNjf20eTZMEQDP/WvEywll+pazTTK
tPXbPiiBGLnvNT5fyVxGWGZ//wPdjYbisIj04EPiBdyljrOPsmjlEQ+/vPRIHh91
VzqBssj23ytHolhHqTODMPKw0NU9BBrW2tNTKHkoDspRh38WvvvQHhGQ0PvnP34V
r6DgvdaJk6Hqen1oxFbWjRwwNznfHh7oxxX8wk4lQVOuptrgupl6SpqX5ET5QRXN
N9+sylh4ltekZcufySg+wkuUy1OO1OGM3DavkQU9her4Cl3frU6flbxWViOnZ+VM
TpkHH+wJIqYgnkaO9H/XOxmGoFW1z+9Mj7xdT+nkK4j/WXs0nKliFmNDWuYbs3k5
AKSGzqyuB96yxGIuOeOd2Iq8tQqA8ArPsFDtmU8n8GDaM4WJUNPLEgkkbs6IisjJ
GwAvFFnOYRwQjxLPa9Ti
=YY46
-----END PGP SIGNATURE-----

--l3bssdaytoy2ddxl--

--===============5271295559547152861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5271295559547152861==--
