From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/27] ASoC: rsnd: explain SRC bypass mode
 settings in comment
Date: Mon, 27 Jan 2014 19:45:54 +0000
Message-ID: <20140127194554.GT11841@sirena.org.uk>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <87ob32f6h2.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4049956234229827915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B45261A80
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 20:45:59 +0100 (CET)
In-Reply-To: <87ob32f6h2.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4049956234229827915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZNotpC0yWfjHZxBL"
Content-Disposition: inline


--ZNotpC0yWfjHZxBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 06:39:56PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> SRC bypass mode is useful for debugging.
> This patch explains SRC bypass mode settings in comment

Surely it's also useful for providing a power saving in cases where the
SRC is not required?  Depending on the implementation it may also end up
resulting in a small improvement in audio quality in such cases.

--ZNotpC0yWfjHZxBL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rdvAAoJELSic+t+oim9HxQP/0bvkalDleoAzfvbDBhv10Fi
KrKikGHi6WVUVG/1tIO3YF+Pe7WWwFTeZEfFLHPmnO/WH6WOfERQZZDIidK9ufHH
pLS+rqXCwL69bT2YHb4bpEZKggKiXVqsnPHsU74HXpwVKI9fqbrtL6gDmDat+dTM
eXfNv0lWD4wSKzQfWdRGDrFXFc26JRege0A1GdVLLXVd+8zdiv83KHVldsOsHU/s
lQxV/Ck94Xy5IJqQmxbRUPbWvx/RHfIFbpPA+CyYzbI+fp+oXkOjBl9wETJxHoKV
XKHDjFeKKBLqUPk9v2MdRW8BFNbq2P0ZjRBWp+Yl5HQDxrmH8kZ0KsL1cpdLnt8x
EYL9Is33DpBUmTtgCGWU9wH7nOxydYuCEhC6Jy0YLFKeBBINTXItN++AEJQfBHWD
N5H/8iMYp5F4veBRHwCT9GceqgS1z9dE7YkKix3mTXo+vDFIlYdKUJn3MhinwHqw
D4wJ6QCtuAItFOHbw3LfHLSQfgtRxSjscCUC7Iq0KJt3lNcxbU0nP5aFJrmWyRgd
SVb20VIH/gwCc1MTm0t28pp0UZQ7njucr881WHHzfPbnNwv2ZgkMN9hBUHmteFLD
PqoDwxlPGYFtX2aH6fPp/TjlWHswVPDXAgFl3xVXOVKVayMCUpeSQ/3gfXGTKo/W
U3sZTSy2epUmIpbQJ5mg
=hYgy
-----END PGP SIGNATURE-----

--ZNotpC0yWfjHZxBL--

--===============4049956234229827915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4049956234229827915==--
