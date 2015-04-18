From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Sat, 18 Apr 2015 18:11:37 +0100
Message-ID: <20150418171137.GY26185@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hkxLWrKAgbGf75mf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--hkxLWrKAgbGf75mf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 18, 2015 at 09:16:36AM -0700, Kevin Cernekee wrote:
> On Sat, Apr 18, 2015 at 4:36 AM, Mark Brown <broonie@kernel.org> wrote:

> >> +static int tas571x_set_sysclk(struct snd_soc_dai *dai,
> >> +                           int clk_id, unsigned int freq, int dir)

> > Remove empty functions, at best they waste space at worst they break
> > things.

> Without the empty function, we run into problems with drivers that
> abort when they get -ENOTSUPP here:

> sound/soc/atmel/atmel_wm8904.c: ret =
> snd_soc_dai_set_sysclk(codec_dai, WM8904_CLK_FLL,
> sound/soc/atmel/atmel_wm8904.c-                 0, SND_SOC_CLOCK_IN);
> sound/soc/atmel/atmel_wm8904.c- if (ret < 0) {
> sound/soc/atmel/atmel_wm8904.c-         pr_err("%s -failed to set
> wm8904 SYSCLK\n", __func__);
> sound/soc/atmel/atmel_wm8904.c-         return ret;
> sound/soc/atmel/atmel_wm8904.c- }

Someone trying to use the atmel_wm8904 driver with something other than
a wm8904 shouldn't really be expecting a good experince...

> Is there a stub version that I can use instead?  Nothing jumped out at
> me when looking at the other codec drivers.

No, such a stub would make no sense - why would we put a stub in all the
drivers rather than just making the core do the right thing?

> >> +             /*
> >> +              * The master volume defaults to 0x3ff (mute), but we ignore
> >> +              * (zero) the LSB because the hardware step size is 0.125 dB
> >> +              * and TLV_DB_SCALE_ITEM has a resolution of 0.01 dB.
> >> +              */
> >> +             if (regmap_write(priv->regmap, TAS571X_MVOL_REG, 0x3fe))
> >> +                     return -EIO;

> > I don't understand this - is the LSB a mute bit or sommething?

> The 10-bit master volume field on 5717/5719 works like:

> 0x3ff: MUTE (power-on default)
> 0x3fe: -103.750 dB
> 0x3fd: -103.625 dB
> [lots more options, in 0.125 dB increments]
> 0x001: 23.875 dB
> 0x000: 24.000 dB

> Since we only have a resolution of 0.01 dB, the driver forces the LSB
> to 0 and uses 0.25 dB increments instead of 0.125 dB.  Mute is handled
> through the dedicated per-channel soft mute register bits instead of
> the 0x3ff volume setting.

It's not entirely clear to me why we need to reset the bit, or why if
we're just trying to update that one bit we write the entire register
value rather than use _update_bits().  If the goal is just to change
that one bit then _update_bits() would be a lot clearer.

--hkxLWrKAgbGf75mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpBIAAoJECTWi3JdVIfQ5wUH/12ZWuXL78rXmt4t28h8IRPP
xoOFW9YAKnVdhewJZxWsKmjOyd8bUgXbdXpINNQdU7adLUfEnt9Z0P8+/Jus0aZC
Xeiz5M59RCd0YqhaCcC99dMfrNrqe+ffJUlofmD1ukkmniuNK14y/eOFvoTZLEhC
3OX+X+OWjRIbh5TOvo8tv4VmOK09lQyNtgdxEg1eKURA2lMFUbV/RrPUIajfR4Ku
u8oaZc9NQW5wt95WwmVKcfLAtPXJ8vRfkHdOIHWVkWvFzS7nGOLpVTmjE4LqdwLs
wz7geTrYafbRpLOsa6RUdEd8gv2Sa7wkVh9aoiHXkjRP51gC6syyM+UU4w2rbys=
=exjq
-----END PGP SIGNATURE-----

--hkxLWrKAgbGf75mf--
