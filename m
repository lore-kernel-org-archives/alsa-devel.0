From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] ASoC: Samsung: Updates for v3.8
Date: Sun, 25 Nov 2012 02:25:19 +0900
Message-ID: <20121124172518.GA4719@opensource.wolfsonmicro.com>
References: <000001cdc95c$c1d7ec20$4587c460$@com>
 <20121123145945.GU4529@opensource.wolfsonmicro.com>
 <000301cdc9e9$4e781d30$eb685790$@com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2162821054408183769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7731261663
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2012 18:25:21 +0100 (CET)
In-Reply-To: <000301cdc9e9$4e781d30$eb685790$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: sachin.kamat@linaro.org, alsa-devel@alsa-project.org, 'Sangsu Park' <sangsu4u.park@samsung.com>, 'Padmavathi Venna' <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============2162821054408183769==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 24, 2012 at 11:13:28AM +0900, Sangbeom Kim wrote:

> > There's some problems with this binding.  The main one is the gpios
> > property the format of which isn't specified at all. =20

> All of above gpio property is i2s.
> That is,=20
> +	gpios =3D <&gpz 0 2 0 0>, -> SCLK
> +		<&gpz 1 2 0 0>,   ->  CDCLK
> +		<&gpz 2 2 0 0>,   -> LRCK
> +		<&gpz 3 2 0 0>,   -> SDI
> +		<&gpz 4 2 0 0>,   -> SDO[0]
> +		<&gpz 5 2 0 0>,   -> SDO[1]
> +		<&gpz 6 2 0 0>;   -> SDO[2]

> Do you want like a below one?
> +sclk-gpios =3D <&gpz 0 2 0 0>,=20
> +cdclk-gpios =3D <&gpz 1 2 0 0>, ...

That would be nice but what I was really looking for was some
indiciation in the binding document as to what all this stuff means -
it should really say what gpz is (though I can figure that out) and it
definitely needs to say what the four numbers are.

> > The requirement for an alias is also very odd, where does that come fro=
m?

> I don't know that Which one is odd. Please let me know.

Having them at all is odd - it's not something other DT bindings have
needed and there was nothing saying what it was for.

> > Some of the code also looks very peculiar, like the fact that it's
> > generating a clock name i2s_opclk%d rather than hard coding the clock,
> > the physical clock would normally be resolved based on the struct
> > device.

> This is to handle all of Samsung SOCs i2c clock mux.
> Please look at below clk_lookup table

> In case of 6410, clk_lookup
> +	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
> +	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &clk_audio_bus0.clk),
> +	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk0", &clk_i2s1),
> +	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk1", &clk_audio_bus1.clk),
> +#ifdef CONFIG_CPU_S3C6410
> +	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk0", &clk_i2s2),
> +	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk1", &clk_audio_bus2.clk),

> In case of exynos5, clk_lookup
> +	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &exynos5_clk_sclk_i2s.clk),
> +	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &exynos5_clk_i2s_bus.clk),

> We try to handle clock source of i2s by only i2s_opclk0 and i2s_opclk1.
> Each SOCs have different clock source.
> Is this wrong approach?

That makes sense but why is the driver not just requesting by name
rather than having code to generate the names, and why is this mixed in
with the patch adding DT support?

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQsQL3AAoJELSic+t+oim9snsP/A20EyLlOkL/lZkoFMVk/PLW
AGXjmTvmYop+Qso0sb9VxIVAlahPQJ37du726FKvEM5Z0hXGVUCjiHzxPwLGCxMQ
kSqG6SgcXhVyP0CPLZtcp8cd33qXOdq0tJeaZsZvx24u2vr599aoB+bUkGvjXAzQ
4GPry+DCPEfF8mGmqGaLgQYL5uahWuMKfBCDr+8dWaDCi51psoQj92Mot8bw36K7
32ubbsrNOjcIA+lTp+nBZmYGV8bdl6dHGEObX6xIxeOepgiWKhNtHvh9VzbRr5fE
6ZoTmyzxRV1IUSuvGMNsh6APYxkjE5ahkCEdFwVQeuzi/dOpiion8WA0BF/ywm5X
OasjpuDg1iwFDTP+4oL1NjzLs32r0wnJunjWI21FowmZXPWyEO6xlKec6KrRG1m2
ziez28214+rwP55jL/tyITDcMOeUDW2VjUhV+I8+P9HXr8lgnekgMCDy44XS3aba
cleuHCghaOMLUYosYDwGax/677LGDO+bTFNVUpEZNmv9v/tPzfRPMJ6KP0G3oNBz
mtBnn7XrI/e8qPcdRVftDt5KeZrehH6jxZIuor97bV8Zx09dPHEnwPS5hnHpw9C6
pPJHtJkYkl/Lr6sqkoPFoFjB/m0v9CSZsa3Im+0ldQISuM2yMQQLvVOVVJyRWZO6
F3KhKpbd3slhlOWNoXDh
=14dF
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============2162821054408183769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2162821054408183769==--
