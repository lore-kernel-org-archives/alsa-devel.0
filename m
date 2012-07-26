From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Crash when probing imx_mc13783
Date: Thu, 26 Jul 2012 21:19:44 +0100
Message-ID: <20120726201944.GA4560@opensource.wolfsonmicro.com>
References: <CAOMZO5B4Z4jACQFt5gy2o3VLqGrQg+bXcN12ChysrQphYNxQBA@mail.gmail.com>
 <3192997.N5KLupAYnr@laptop>
 <CAOMZO5BsOV3X09DKc-uexe9mqhYhkbmKZg2vh_h2-hBB=X1A7Q@mail.gmail.com>
 <50116D38.6050001@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4251785885418297472=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 05393265F29
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 22:20:26 +0200 (CEST)
In-Reply-To: <50116D38.6050001@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============4251785885418297472==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 05:15:52PM +0100, Lee Jones wrote:

> The patch is apparently not correct (although, I do see a place for
> it). The problem is that unless your code populates

No, really.  There's no place for it.  Think about what it does - it
takes the code that sets up the shared I/O accessors and changes it so
that if the code is explicitly asked to set up regmap accessors it might
just ignore that and not tell anyone.  Clearly this is not a good idea,
this code has a simple job to do and you're making it more fragile and
obscure.

That change is clearly working at the wrong abstraction layer.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEaZZAAoJEBus8iNuMP3dl5QP/2ClqkWKdUjPDZvcXOanna+H
gxN6w1bg8cuarPYwwxa8HtlUhW/zXVJBik4hkpNK5XidxI1K7pdgmPZfoxy/zyJi
+LtXstSwF4zmCZjew6fZHoG21MuhUQP4b9VfrCgAzOkXzzfEXOd+NvX2sB93qjef
k+NOarDqITUN8ojfTpaR371MGJT6mrqgVH8mQuTifVwpezkWt7nv3UpqtS4GdQ4S
YyR5aiD/ciw43OKJlPkpVRvWmazww3EJNx3lHo4jJZrp4HHPNazVNpvCsEu5t4j5
gtBY0ukPr8QVNB/w1NPq8rwmGg74SPwqyyRbqGxyxQpoN00dY9oP0PCcLgn1+DmU
9mxtMtXf3FSErO6dOBMptW4StANgsxjzgSk6CdMXU5DiHROjy7cxhnSjUCYZiPA0
Bchfh3A9p4zLP2c68rCFPzsuHv7PwCa9pQ2Q5o7GpJ8noqjFx1frhrFoCR7T6z6q
cs4s4Oy8nrOVfNu7ulQz4wHN98lnryNFVKxKCRB7Soe1GW8IbJAjLu+OLn2xO7Rg
Ph+RPFEHoK3B5jeSRCdFcAyyPNd29U93Us08pkRl+UcasXRcUD7aMY0+jI30NxZn
ctL8V4F/7FmkMHssfwcUjgWcpLRU7kpqlR4IiNY+BOYUaFFH9uuqQZWgvFfr039U
zqiNCGA3qId2t0W/8iS7
=QJ38
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--===============4251785885418297472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4251785885418297472==--
