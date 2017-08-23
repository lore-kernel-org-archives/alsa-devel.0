From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 13:39:12 -0400
Message-ID: <20170823173912.GN17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3dbUQUznexwzCA76"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503498573.25945.69.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--3dbUQUznexwzCA76
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 05:29:33PM +0300, Andy Shevchenko wrote:

> On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> > Not all devices with ACPI and this combination of sound devices will
> > have the required information provided via ACPI.=A0=A0Reintroduce the I=
2C
> > device ID to restore sound functionality on on the Chromebook 'Samus'
> > model.
>=20
> > This is a regression from v4.12 on my laptop (a Chromebook 'Samus'
> > that's not running ChromeOS).=A0=A0My fault for getting out of the habit
> > of
> > trying -rc1 when it comes out and not spotting this sooner.=A0=A0I'm not
> > 100% sure if this fix is correct for all cases as I'm only able to
> > test
> > my hardware here, and this does fix my laptop.
>=20
> Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data
> in the module sources") does not fix your issue?

As that's not in master yet I can't tell.  Can you give me a pointer to
somewhere?  Thanks!

> > diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> > index 36e530a36c82..6f629278d982 100644
> > --- a/sound/soc/codecs/rt5677.c
> > +++ b/sound/soc/codecs/rt5677.c
> > @@ -5021,6 +5021,7 @@ static int rt5677_write(void *context, unsigned
> > int reg, unsigned int val)
> > =A0static const struct i2c_device_id rt5677_i2c_id[] =3D {
> > =A0	{ "rt5677", RT5677 },
> > =A0	{ "rt5676", RT5676 },
> > +	{ "RT5677CE:00", RT5677 },
> > =A0	{ }
> > =A0};
> > =A0MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
>=20
> This one looks weird.
>=20
> The board code has this=A0
>=20
> sound/soc/intel/boards/bdw-rt5677.c:285: =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0.codec_name =3D
> "i2c-RT5677CE:00",
>=20
> It's clearly a match to ACPI enumerated I2C slave device.

I suspect that the ACPI data here is less-than-optimal (but it does have
the latest underlying chromeos update).  If you tell me what to run I
can poke the data and confirm.  Thanks!

--=20
Tom

--3dbUQUznexwzCA76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnb3AAAoJEIf59jXTHXZSMHUP/1q/rZnCGCgK7a6X3Imqsh58
dAxWSlkkXn/1I/dh10VQgRPupUd35g3q9g+TkQvpaO+H1fFTyTfxskKYUFHXGrK/
xMUPdQLKSr9FGkNf6ML0MfcaPbnQxBMvvtWcuZ0USr8WV2NRQYpt64hSTMWH4Rdv
e2CwbgdZGrLOa+sF9KOUL/hXQJ4Vh8WpmL+rroJZQpM8493xucl+YQPftv0Z8RIE
q7pJ1wnLHaONdfpMVoarvjnv/rSriqsvYJ3HVru26sBCswJGZBgBA60NfjP2qrBP
pJE+M9pblty1a3bKiFpUOm56DjveTQpqc8itu/jn3Wr8gy8hm4tvSz0Vp7STxT70
zwWG1WiH3nb2NzkzC1+013cBNH8nxdNIU0zQDepxj21oTfH0d3Va6dXTY0mHApUD
O488SMiTWYPcI0Q36mv36LpaU0xMzOoo1Yx/hl3BXr89AynwPC4YZzVqbvh1MBbl
bHz9amu4gfootQlBslnt9LVJZN/jo+GBgb6OVKKG8a7y07ydOP8J0e65FtKfD8c6
uAarT67Zd/ip56Gj0YfpsjYcSBEMbVb7jng6jEBeFJebbaNjzX25U+5IkGFDfE0H
Rhe44IQPZ0eideRXVgaxHQs3HQjEHs43FytyzNyH/magJ50C/2vh8BUHJaHF7Ibj
HbOFodDuERMJxZ8roCbJ
=OcBL
-----END PGP SIGNATURE-----

--3dbUQUznexwzCA76--
