From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [Patch v6 6/7] regmap: add SLIMBUS support
Date: Sat, 7 Oct 2017 07:02:42 +0200
Message-ID: <20171007050242.4smp3x2rqkwxvg5h@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-7-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zam7yb3abbxjvkrn"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-7-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--zam7yb3abbxjvkrn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 06, 2017 at 05:51:35PM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch adds support to read/write slimbus value elements.
> Currently it only supports byte read/write. Adding this support in
> regmap would give codec drivers more flexibility when there are more
> than 2 control interfaces like slimbus, i2c.
>=20
> Without this patch each codec driver has to directly call slimbus value
> element apis, and this could would get messy once we want to add i2c
> interface to it.
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
[...]
> +static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
> +					unsigned int *val)
> +{
> +	struct slim_device *slim =3D context;
> +	struct slim_val_inf msg =3D {0,};
> +
> +	msg.start_offset =3D reg;
> +	msg.num_bytes =3D 1;
> +	msg.rbuf =3D (void *)val;
> +
> +	return slim_request_val_element(slim, &msg);
> +}

This looks like it won't work on big-endian systems. I know big endian
is pretty uncommon in devices that will likely have SLIMBus, but it's
better to be endian-independent.

> +static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
> +					 unsigned int val)
> +{
> +	struct slim_device *slim =3D context;
> +	struct slim_val_inf msg =3D {0,};
> +
> +	msg.start_offset =3D reg;
> +	msg.num_bytes =3D 1;
> +	msg.wbuf =3D (void *)&val;
> +
> +	return slim_change_val_element(slim, &msg);
> +}

dito

> +static struct regmap_bus regmap_slimbus_bus =3D {
> +	.reg_write =3D regmap_slimbus_byte_reg_write,
> +	.reg_read =3D regmap_slimbus_byte_reg_read,
> +};


Thanks,
Jonathan Neusch=C3=A4fer

--zam7yb3abbxjvkrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2F/pAAoJEAgwRJqO81/btfMP/0VWWgMxXc/DEnrvscmxZ+6s
BxijMaE6dFWrMh5Fe3yLLOR8loGQFhgPGGUFZIYcdE9lw6uGv1A6iiXC9CTOmkKx
vEyFaNnneGen4c0o/BoYSiMPRWqDJkgmruMIMLB7y5fANdffEJ1M1D3K+qyaJOLo
CowaGp+D65eXg3lrJ1DtPAoqGcPba9j1AY8QCCruhhxsJCEWpbxhK436e39P103y
8A1OrbbiujLYiP4xDyYLUw2gs7O8i7PZ/GozeIExde4hVfrSI9EXCJ1uGSnqSHv8
fkC2WU0qosQ7zB7rH7C5Y4U67YRejfkKTDKBVZeNLpDBnli71c4as+o9x2AP3JRv
K7FyIsQWsdeIF71kqkyVe7shKbwUkWS2VkzoJaszBi++kGMcheoYGgBqDdmuztIV
0xQLdWQFhrNyaXz1QDYIFFQzJyaneH88SaG616wQlGCOtwlZK4w8zTxlh7Il/Lc+
AhjbUdg5H4m5Bfc54IeABJsMoK34Ovh07cAtAmBLtTdEvFCGXoOx0w9/eMX5akKf
XmGLiNBll3f6PuXywyjN7DApSsQYbIJAqXnnGpN0ysgnVwwx2OClkMr00h1F4/3V
OU2RtyzzE06/aOZoCJVZ4f0MYnOcf4o+2mqscP4ZxhCP7eQHlaJsIOsQbaqzqQuI
ZCSp4/mtBZQgVUY+g7DS
=dEkE
-----END PGP SIGNATURE-----

--zam7yb3abbxjvkrn--
