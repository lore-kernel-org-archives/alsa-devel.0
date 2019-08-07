From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and
 align with other serial links
Date: Wed, 7 Aug 2019 18:56:46 +0100
Message-ID: <20190807175646.GK4048@sirena.co.uk>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
 <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 10:09:27AM -0500, Pierre-Louis Bossart wrote:

> Vinod, Mark, any feedback?

> There will be a set of SoundWire codec drivers provided upstream soonish =
and
> we'll get a number of kbuild errors without this patch.

I think I'm missing context here, I've basically been zoning out all the
soundwire stuff - the patch series are huge and generate a bunch of
discusion.  Is the patch below the full thing?  I don't see any obvious
problems.

>=20
> >=20
> > > ---
> > >   drivers/base/regmap/Kconfig | 2 +-
> > >   drivers/soundwire/Kconfig   | 7 +------
> > >   drivers/soundwire/Makefile  | 2 +-
> > >   3 files changed, 3 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> > > index 6ad5ef48b61e..8cd2ac650b50 100644
> > > --- a/drivers/base/regmap/Kconfig
> > > +++ b/drivers/base/regmap/Kconfig
> > > @@ -44,7 +44,7 @@ config REGMAP_IRQ
> > >=20
> > >   config REGMAP_SOUNDWIRE
> > >          tristate
> > > -       depends on SOUNDWIRE_BUS
> > > +       depends on SOUNDWIRE
> > >=20
> > >   config REGMAP_SCCB
> > >          tristate
> > > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > > index 3a01cfd70fdc..f518273cfbe3 100644
> > > --- a/drivers/soundwire/Kconfig
> > > +++ b/drivers/soundwire/Kconfig
> > > @@ -4,7 +4,7 @@
> > >   #
> > >=20
> > >   menuconfig SOUNDWIRE
> > > -       bool "SoundWire support"
> > > +       tristate "SoundWire support"
> > >          help
> > >            SoundWire is a 2-Pin interface with data and clock line ra=
tified
> > >            by the MIPI Alliance. SoundWire is used for transporting d=
ata
> > > @@ -17,17 +17,12 @@ if SOUNDWIRE
> > >=20
> > >   comment "SoundWire Devices"
> > >=20
> > > -config SOUNDWIRE_BUS
> > > -       tristate
> > > -       select REGMAP_SOUNDWIRE
> > > -
> > >   config SOUNDWIRE_CADENCE
> > >          tristate
> > >=20
> > >   config SOUNDWIRE_INTEL
> > >          tristate "Intel SoundWire Master driver"
> > >          select SOUNDWIRE_CADENCE
> > > -       select SOUNDWIRE_BUS
> > >          depends on X86 && ACPI && SND_SOC
> > >          help
> > >            SoundWire Intel Master driver.
> > > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > > index fd99a831b92a..45b7e5001653 100644
> > > --- a/drivers/soundwire/Makefile
> > > +++ b/drivers/soundwire/Makefile
> > > @@ -5,7 +5,7 @@
> > >=20
> > >   #Bus Objs
> > >   soundwire-bus-objs :=3D bus_type.o bus.o slave.o mipi_disco.o strea=
m.o
> > > -obj-$(CONFIG_SOUNDWIRE_BUS) +=3D soundwire-bus.o
> > > +obj-$(CONFIG_SOUNDWIRE) +=3D soundwire-bus.o
> > >=20
> > >   #Cadence Objs
> > >   soundwire-cadence-objs :=3D cadence_master.o
> > > --
> > > 2.20.1
> > >=20
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >=20

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1LEN0ACgkQJNaLcl1U
h9Doowf+Pqtbwv8TKH7n1SWpm5BzFI61YcWAq17CFzAwcyo9WP/KgUvxQuOPbkhE
BLh0VrJ0TjoAk1hFmJjOiiteW2VCD0GuSwLLta/bIuRPRVfzNbo7hhEMk9StQOzZ
IyyPf272g43ClAZI0BWc7MxKnx7Kc2Tfr+DJNlOe40TXKqQ3e9EPrZvqQjczZuLl
LgqWERVy/CAf7McruEyKoWsR9F89dmQUjYjsxXn8+vXjmYJ4KoSFpnXa65U9k3f9
dq86ylDSeaYDpuFP9HdYzn74boq8u3C+svgAcv7z6q62Pa8RDifXSnMAr84Q6Nn1
3ScPBYV/GzO3k5FLqxGL5GizewOQyw==
=9z/t
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
