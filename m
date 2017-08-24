From: Tom Rini <trini@konsulko.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 12:08:21 -0400
Message-ID: <20170824160821.GG17193@bill-the-cat>
References: <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <s5hk21tjb02.wl-tiwai@suse.de>
 <s5hinhdjav6.wl-tiwai@suse.de>
 <20170824144152.GC17193@bill-the-cat>
 <s5h60ddj7l8.wl-tiwai@suse.de>
 <20170824155235.2nrqjiwlo3afk4ei@sirena.org.uk>
 <20170824155437.GF17193@bill-the-cat>
 <s5h1so1j6gz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PHDeMLmKefytWajp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h1so1j6gz.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--PHDeMLmKefytWajp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 06:06:20PM +0200, Takashi Iwai wrote:
> On Thu, 24 Aug 2017 17:54:37 +0200,
> Tom Rini wrote:
> >=20
> > On Thu, Aug 24, 2017 at 04:52:35PM +0100, Mark Brown wrote:
> > > On Thu, Aug 24, 2017 at 05:42:11PM +0200, Takashi Iwai wrote:
> > >=20
> > > > OK, so the fix for 4.13 would be either to cherry-pick this commit,=
 or
> > > > just to re-add "RT5677CE:00" to i2c_id temporarily as a quick band-=
aid
> > > > fix (and remove again in 4.14).
> > >=20
> > > > The former is cleaner, but it's bigger, while the latter is a safer
> > > > oneliner at the late RC stage.
> > >=20
> > > > I leave the decision to Mark.
> > >=20
> > > I'm happier with the oneline change TBH, like you say it's pretty late
> > > in the release cycle.  Can you just apply the patch directly and send=
 it
> > > to Linus with my ack or should I put together a pull request?
> >=20
> > FWIW, I'd be happy to give the change a quick spin and Tested-by it.
>=20
> Well, it's your patch, after all :)
> Below is the patch I'm going to queue.
>=20
>=20
> Takashi
>=20
> -- 8< --
> From: Tom Rini <trini@konsulko.com>
> Subject: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
>=20
> Not all devices with ACPI and this combination of sound devices will
> have the required information provided via ACPI.  Reintroduce the I2C
> device ID to restore sound functionality on on the Chromebook 'Samus'
> model.
>=20
> [ More background note:
>  the commit a36afb0ab648 ("ASoC: rt5677: Introduce proper table...")
>  moved the i2c ID probed via ACPI ("RT5677CE:00") to a proper
>  acpi_device_id table.  Although the action itself is correct per se,
>  the overseen issue is the reference id->driver_data at
>  rt5677_i2c_probe() for retrieving the corresponding chip model for
>  the given id.  Since id=3DNULL is passed for ACPI matching case, we get
>  an Oops now.
>=20
>  We already have queued more fixes for 4.14 and they already address
>  the issue, but they are bigger changes that aren't preferable for the
>  late 4.13-rc stage.  So, this patch just papers over the bug as a
>  once-off quick fix for a particular ACPI matching.  -- tiwai ]
>=20
> Fixes: a36afb0ab648 ("ASoC: rt5677: Introduce proper table for ACPI enume=
ration")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/codecs/rt5677.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 36e530a36c82..6f629278d982 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5021,6 +5021,7 @@ static const struct regmap_config rt5677_regmap =3D=
 {
>  static const struct i2c_device_id rt5677_i2c_id[] =3D {
>  	{ "rt5677", RT5677 },
>  	{ "rt5676", RT5676 },
> +	{ "RT5677CE:00", RT5677 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);

Looks good, thanks for rewording things!

--=20
Tom

--PHDeMLmKefytWajp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnvn0AAoJEIf59jXTHXZSNW8P/2X8Gy1Kmc+vPxgaZDm1LUfS
evScMenAybyPbOmZcf39zrrJjnqlE6jQZroNpU7HpOPAcr1oAAEE88jVU9YQ0c5F
Z7+flyLRf2kR9AsMAfv8vx5NNfybpHDBAjDaTrnCdssZgcL0lZw1EX79jNYSopFj
sbzAB4RolurMP44QelroXLvHfyxEYm7b3OlHfxWV8jW/tA7Z0A0i0H0lQOYFaoRc
BS0XIf6vpidR7WpRKdqDHVd0wgnsqipwxZRdPyqOeneQyk61RqKAhrs4pJx33rzP
Vgj6rCPTcijHDkH1rN4n51S/5DTv73Oowyf9lRKa3DCfV2F0NuxAma6fG0YlJeix
bxVluFVIqnRTrtTgIxI+iqHntbmxDWGU/z/RXmtvqlJqH/WWDawQ1dgevXfnbqi7
XA92sGRGAXmBXo5DJ40cNOaX8zpdH7h8g8qTP0uKI4xC6PLF7UnXcTNX0vfHFCq4
echkl0v5jngCkg+nlP9G6+1xgnylo18eQyID6lUV1f1xHWX+ZB6itxW5Fl+lLyI9
wBcSOgfw4J68T5xc1ylOW3feAqY6bxTf96GpY55qNrTtlDwBDfH1TbrVNSPHs7AK
nMPwTucdLc4k6srvJfCCZJoGp1XAKpzEsO0WKoy1Of7P/SYPj6HAjJC0RFNA8AeG
fpH37itFcFjdokB5QRmm
=OOcj
-----END PGP SIGNATURE-----

--PHDeMLmKefytWajp--
