From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to handle parameter variation across different
 boards but same platform
Date: Wed, 4 Jul 2012 15:01:18 +0100
Message-ID: <20120704140118.GA4111@opensource.wolfsonmicro.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704131749.GZ4111@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2492648885707385444=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20E5910441C
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 16:01:20 +0200 (CEST)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "'sudhakar.raj@ti.com" <'sudhakar.raj@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============2492648885707385444==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8teuZUM8bA5gqecl"
Content-Disposition: inline


--8teuZUM8bA5gqecl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2012 at 01:43:12PM +0000, Hebbar, Gururaja wrote:
> On Wed, Jul 04, 2012 at 18:47:50, Mark Brown wrote:

> > What do you mean by "board"?  If these are plugin modules for your
> > platform you need to either identify this at runtime and register a
> > different machine driver or select at compile time.

> By board I mean a new development board.=20

> New board
> sysclk =3D 24MHz
> codec_name =3D "tlv320aic3x-codec.1-001b"

> Previous Board
> sysclk =3D 12MHz
> .codec_name =3D "tlv320aic3x-codec.2-001b",

> Both boards share the same machine is API (machine_is_am33xx()).

> So, is there any mechanism/api to differentiate these 2 boards inside=20
> Code?

> Has anyone else faced such situation?

If these are totally different boards they should have different machine
IDs set so machine_is_() should identify.  If that isn't there then you
need to do something custom to your products to identify the boards
further.

--8teuZUM8bA5gqecl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9EyhAAoJEBus8iNuMP3dhN0P/A2oON9MO4DohNQ8xAPCl6T9
hC5nGgO0GvNd1qP1XinfHTiGNLMMkPNfigNizg2GPb0rZID7JM50aJJ82hvieW5e
8Fonm/qU7vCqsYv+vsA3yHwRPFpBSYj98BtxRCiMdKAtFH36LQgqZdBOLX4+awHl
sMMxEsSM8GlzjLLPhTjQeOqtEQWTkIt7F3lksnb+OPutjZCoIbWwhLGUlDtDQU5c
9OLy6pdk55OG7cRORgzs6lV+1tLwKbaykj2vhGudcEtzw1YMtWIMp07qH7+x4o1a
GeSZA7xBSvnwYz0Hd5PXUQD9WGZms8pCgcqdwdjOkM4NEtn3/Xrsg79ueLeLEg+w
oIIQuiFekJE6adM7eFiMdZp3spzo1iAoMX5+u6hZfI5MMFQt3rs5d7hDxGGJgku5
szPPSXzEIzUhkznoLaLc4Rd9IucoXyyKD2HZRLtt2Iwm5Md3vKHkQ4/oQYJYMBps
OZJoenyc79VfF6XHiv58EixHShvF7O6Xy75OrC12rFeRTh1deLTyhQLPnMtv8DB8
OZofQaR8Hk9PLacrYBTMWSJ+pFY30l3UB0+y84sExXnITga6IKpxK8jUCzaoFnrQ
QT8PkJ+spaZg73haKSfOWqsNoPYGHqHpi3PhFEi8tGvwpEJHeiXnd/NQMLE4iMwZ
KxayNgayZz4SIZsp5iGT
=m78/
-----END PGP SIGNATURE-----

--8teuZUM8bA5gqecl--

--===============2492648885707385444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2492648885707385444==--
