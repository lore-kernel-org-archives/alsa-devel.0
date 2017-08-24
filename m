From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 09:47:37 -0400
Message-ID: <20170824134737.GB17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <1503560349.25945.72.camel@linux.intel.com>
 <20170824111547.GA17193@bill-the-cat>
 <1503577560.25945.84.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xwCJTF497Cudft2o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503577560.25945.84.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--xwCJTF497Cudft2o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 03:26:00PM +0300, Andy Shevchenko wrote:
> On Thu, 2017-08-24 at 07:15 -0400, Tom Rini wrote:
> > On Thu, Aug 24, 2017 at 10:39:09AM +0300, Andy Shevchenko wrote:
> > > On Wed, 2017-08-23 at 20:05 -0400, Tom Rini wrote:
> > > > On Wed, Aug 23, 2017 at 01:39:12PM -0400, Tom Rini wrote:
> > > > > On Wed, Aug 23, 2017 at 05:29:33PM +0300, Andy Shevchenko wrote:
> > > > >=20
> > > > > > Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide
> > > > > > platform
> > > > > > data
> > > > > > in the module sources") does not fix your issue?
> > > > >=20
> > > > > As that's not in master yet I can't tell.=A0=A0Can you give me a
> > > > > pointer
> > > > > to
> > > > > somewhere?
> > >=20
> > > It's in ASoC next at least.
> > >=20
> > > > > =A0=A0Thanks!
> > > >=20
> > > > OK, my bad, it has a different hash upstream, but no, that change
> > > > doesn't fix things as I see the problem on top of Linus'
> > > > tree.=A0=A0Thanks!
> > >=20
> > > Interesting...
> > >=20
> > > The only bug so far I saw is the following one
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D196397
> > >=20
> > > ...and above commit fixes it.
> > >=20
> > > Can you place somewhere the bundle of the following:
> > >=20
> > > 1. Output file (tables.dat) of
> > > 	% acpidump -o tables.dat
> >=20
> > https://gist.github.com/trini/b9a9a547e37cb812506a22e18cd2aff5
> >=20
> > > 2. Output of
> > > 	% cat /proc/interrupts
> >=20
> > https://gist.github.com/trini/39a5d88a5ecb9b71336ff5fe9da7c720
> >=20
> > > 3. Output of
> > > 	% lspci -vv -xx
> >=20
> > https://gist.github.com/trini/e81ab21909eeaa05ea50dc0596d23c14
> >=20
> > > 4. Output of
> > > 	% grep -H 15 /sys/bus/acpi/devices/*/status
> >=20
> > https://gist.github.com/trini/698dc284634ad9e1cfbafad8e705de5f
>=20
> Thanks!
>=20
> I have checked those files and found that device is in the table and
> pretty much properly defined ACPI I2C slave.
>=20
> The change in the driver you referred to makes the change to modalias.
>=20
> Thus, I'm suspecting that your user space helper either has some hard
> coded values for previous case, or just broken.
>=20
> Can you also check is the codec module loaded (lsmod) and, if it's not,
> load it manually and check if sound works again.
>=20
> P.S. In any case you need the patch mentioned in bug #196397

I've applied "ASoC: rt5677: Hide platform data in the module sources"
manually to Linus' tree and still see the same problem.  Perhaps there's
now some missing alias information that really needs to still be
provided?  snd-soc-sst-bdw-rt5677-mach is not loaded and I can't
manually load it later on.  What user space helper configuration am I
supposed to need to have now, for this to work?  Thanks!

--=20
Tom

--xwCJTF497Cudft2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZntj4AAoJEIf59jXTHXZS0oYP/jEL7vMsVDLGiVbwnw4YAiK2
Y59SJLIEx4103+datlHyMaEUSE1YO0qIWhqtTj1vYfntM1TDYAe8TOB4Zb+6O7Tn
a8A7x2BoM5nJJUz12XmsvwM+ZOrsRL+COhvh8jMRVW0cJPNs6Twciie0H+y8nrlK
TXtpe7nlaPQCENWiXPmbYpFXQmTI5HrdqQWp7gmnGqR4Ke0XfCtKfj+CCenx9lYY
TjNSMcqAkjNHqvW2c6U8MTxwqV0byOPy2x+fQAOh1WspzPt/4QCyBs3PdBGQpjL5
qBAN1mtgLWf/2j+Yi6w7sYS0ht8vvFu3Btjl886BFzoKyByu5RdjidEE3+iONYXZ
p9/mrA8r8d4CvF/AmV9Z7aOzaZkdaqSZicY78jWZK+Y1p22Rv7m/VCXQFtRCf8ay
24G+uZkdgBcXLAhWGilk6J4wzZYk8ZaCjuza0Jz2G1BQVYoFQ2SRmSy3ByiJ48kD
sQrv7mty/OGuKs70N4OtEiM9KgsbWleCqacmJHDmwVav14VJsDby8AIx3uSl5nt9
4UGcwcSCqyI4q9IJg7wWpFq389Sp45oyMIvwC/wI9Jto0fh6SscFbSyjK9TQKLev
wYRU+vGMEPeDj6ez9aWLFx2CayQQ6JbF7G6wM0pLidPSZb8h39zF0Wfl0lnn2v6o
1o2+npVjkUhvRzgWBRiE
=EIqR
-----END PGP SIGNATURE-----

--xwCJTF497Cudft2o--
