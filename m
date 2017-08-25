From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Fri, 25 Aug 2017 15:33:23 -0400
Message-ID: <20170825193323.GO2827@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503669407.25945.102.camel@linux.intel.com>
 <20170825142426.GN2827@bill-the-cat>
 <20170825170504.7d547aa4.john@metanate.com>
 <1503679371.25945.110.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503679371.25945.110.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: John Keeping <john@metanate.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 07:42:51PM +0300, Andy Shevchenko wrote:
> On Fri, 2017-08-25 at 17:05 +0100, John Keeping wrote:
> > On Fri, 25 Aug 2017 10:24:26 -0400, Tom Rini wrote:
> > > On Fri, Aug 25, 2017 at 04:56:47PM +0300, Andy Shevchenko wrote:
>=20
> > > > Apparently you are the one who tested the commit
> > > > 	89128534f925 ("ASoC: rt5677: Add ACPI support")
> > > > year ago.=A0=A0
> > >=20
> > > Yes.
> > >=20
> > > > The commit states that ACPI properties that are used in Chromebook
> > > > Pixel
> > > > 2015 is non-standard (not the same as for DT).
> > > >=20
> > > > However, DSDT shows the opposite!=A0=A0
> > >=20
> > > Interesting.=A0=A0I'm not an ACPI person, I just tested what John came
> > > up
> > > with.
> >=20
> > And the patch adding this was the first (and still only) time I've
> > really looked at ACPI, so it's quite possible that I misunderstood
> > something at the time.
>=20
> Maybe.
>=20
> > From memory, I think the particular problem I was referring to in the
> > commit message was that certain GPIOs were only defined by index and
> > not
> > by property name (specifically "plug-det-gpios", "mic-present-gpios"
> > and
> > "headphone-enable-gpios"), and having dumped DSDT just now I do not
> > see
> > those strings appearing anywhere.
>=20
> Exactly, and this part of the patch I'm _not_ talking about (it's pretty
> much good and working).
>=20
> What I'm talking about is a specific function called
>=20
> rt5677_read_acpi_properties()
>=20
> in the rt5677.c codec driver.
>=20
> The question is do we have _real publicly available_ hardware with that
> kind of properties?
>=20
> Because now it's a mess (wrt to real DSDT attached to the thread).
>=20
> The proposed change to fix this is like
>=20
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 6448b7a00203..28bde5f50ed9 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5145,20 +5145,18 @@ static int rt5677_i2c_probe(struct i2c_client
> *i2c)
> =A0		match_id =3D of_match_device(rt5677_of_match, &i2c->dev);
> =A0		if (match_id)
> =A0			rt5677->type =3D (enum rt5677_type)match_id-
> >data;
> -
> -		rt5677_read_device_properties(rt5677, &i2c->dev);
> =A0	} else if (ACPI_HANDLE(&i2c->dev)) {
> =A0		const struct acpi_device_id *acpi_id;
> =A0
> =A0		acpi_id =3D acpi_match_device(rt5677_acpi_match, &i2c-
> >dev);
> =A0		if (acpi_id)
> =A0			rt5677->type =3D (enum rt5677_type)acpi_id-
> >driver_data;
> -
> -		rt5677_read_acpi_properties(rt5677, &i2c->dev);
> =A0	} else {
> =A0		return -EINVAL;
> =A0	}
> =A0
> +	rt5677_read_device_properties(rt5677, &i2c->dev);
> +
> =A0	/* pow-ldo2 and reset are optional. The codec pins may be
> statically
> =A0	=A0* connected on the board without gpios. If the gpio device
> property
> =A0	=A0* isn't specified, devm_gpiod_get_optional returns NULL.
>=20
> + removing rt5677_read_acpi_properties() completely.
>=20
> Tom, if you can test it (basic test + might be quality of sound) on your
> Chromebook, it would be nice!

OK.  I did the above manually (on top of the correct fix for the problem
I originally reported from asoc-next), also removed
rt5677_read_acpi_properties and gave the various THX/Dolby sound tests a
spin and they sound good.

As an unrelated request for help, the headphone jack isn't automatically
detected and used, but I assume this is a user configuration issue.
This is unchanged with your patch :)

--=20
Tom

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZoHuDAAoJEIf59jXTHXZS7TEQAJ6vpMttHpqN3d8uvcqrhlhu
3M1I/ZntbyZbYby07GXcvKUnoyIVxMA5cRAdxRYhQxIuvcqKdg1FczSizOixI9Ra
i6ATMMU9+3WbXcWdQRluKJEgM84bAaonsq9IqNcY8ZPAKRX9we0W35g/bPqzJRD6
5cD2yL07Vo1W32WjMHrnS4WYTK06U0EBVqtAhc5r2K8hnaDdgNwXHoKIQQAvoeB/
lxsaZg7pZ+sCOaXcgoofC8VSCPSAl6zsX6hfCk5f25BkJQoyyU4waWaFqENbIzSi
Pp34fBLZ46xbEGGdqgxOz/rNU7T13lkfcQbfkQPIIlqqNpOF3S3eESC/0n7N6/HC
1MRp7lXu0tKbtVv3U1HwdcQK5Cs+DCu/SKNNM93Uxxv06EWzhCHNnup/aAl6Wx3v
yeTDy9UKY4i6Ha2z5kV+r1xdpsb4iiWZeVQjHPi0M27LZXR6V+5Wh5akHZv3LOpR
cqx3j6wyTfTWyRNY8mm97+PYDFE0nG3qBcTKyLxBAYc8CFcE2RQV0kZETffV00QF
nOlHOq9Vzt9aOcp2P37K1CDCilIVlcD/DImIt10pZMEynPrfLTJXgd56teGoEvzC
K6CnHN89tEOor5XzUrMQUVmLKFLlLkodWbrsTruWLLVq3D3vBvdptJuHLA+z4+WY
w6cqFm/z+Sfl9KLcYMGv
=MnnT
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--
