From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsi: add master clock control
	functions
Date: Mon, 5 Nov 2012 09:03:37 +0100
Message-ID: <20121105080336.GA28886@opensource.wolfsonmicro.com>
References: <87mwz3mjou.wl%kuninori.morimoto.gx@renesas.com>
 <87k3u7mjmp.wl%kuninori.morimoto.gx@renesas.com>
 <20121101144729.GN4413@opensource.wolfsonmicro.com>
 <874nl4271g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4679556649810253802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D2492615C7
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2012 09:03:40 +0100 (CET)
In-Reply-To: <874nl4271g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4679556649810253802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2012 at 05:05:34PM -0800, Kuninori Morimoto wrote:

> > > +	own =3D clk_get(dev, NULL);
> > > +	if (IS_ERR(own))
> > > +		return -EINVAL;

> > Any reason not to use devm_clk_get()?
>=20
> Ahh yes, Sorry.
> BTW, currect code calls this function many times now,
> (this clk is local variable now)
> then should I use...

>  1) use devm_clk_get() / devm_clk_put() pair
>  2) use clk_get() / clk_put() pair
>  3) keep these clocks under private date (struct fsi_prive)
>     and use devm_clk_get() only _probe timing.

Option 3 is the normal approach here.

> > > +	if (enable) {
> > > +		clk_disable(ick);

> > Are we sure that calls to this function are always balanced so that
> > calls to clk_enable() and clk_disable() are balanced?

> I balanced it by local technic.
> But I can say it is un-understandable.
> Can I use counter ?

Well, the whole thing is that the clk_enable() will count too so if you
don't make sure the calls are balanced you'll run into issues.  I'd add
some comments which explain why this is safe.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3K2AAoJELSic+t+oim9oGoP/1zvU7VTKKh7I8MqZNbhoNWp
XYqk6DoFydmtts2imYHk5xNC5+Cuh0Xn9FLkZOJFnTzgN2WrRuCwLk/TzRVLuRhq
lShrtY9VYr90bVL8822DlaWdIbXE5ItpU2Ov0lOy4JMYQ9nOSUkjA6PSx7Jh4M6R
I5xQtj91TEUvaa1dGK5Y+7qrTEZU4iFEt9TQA3AUxDaI3VDqatvgJXZix1bV0LYz
zjFm/4yTQztyUkqyTadgq98cvw88F7KiI/XwnFey4mSwG4Vo8tc1OOPJB/CJea6S
afEWFNLIwb+hvsQ9m4LpMYBru6K7KAOO8mHoEx3kK1lG8LZiT2NDcNkDx1m7q3RF
4WeITDDhh4PG43hBbKkqHyyjKxuAriCRyUTaMOzh0ZexF4rvOZw3yOoplTcJDDUp
i/YLo3TY8QGk5dror78OPp9pQvtagVT32ONfHSKetttfQSrWYKicJcofmksVrOZ1
+rwVCWP5a+eyGLEO/PBOP02j9Z6wIr4ni8jY5TgvBLecQE2YkmU1x0Y+2GDKSe1j
IrzxAYVL2diR8aCTbzSSI2I9C+JNixI3ygnBiVxPGFNxvFnEJ2CJieshACI6xfgJ
fg3yVbJjd346XTYNePmxsHj50dnQt9bQhF4EKKtI4+jOkmA7vzfPFX6VM+r+hwpr
UQA8RBhrgZx4WCHH4X5Y
=aYZW
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============4679556649810253802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4679556649810253802==--
