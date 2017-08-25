From: John Keeping <john@metanate.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Fri, 25 Aug 2017 18:09:13 +0100
Message-ID: <20170825180913.4f95ce5d.john@metanate.com>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
        <1503669407.25945.102.camel@linux.intel.com>
        <20170825142426.GN2827@bill-the-cat>
        <20170825170504.7d547aa4.john@metanate.com>
        <1503679371.25945.110.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503679371.25945.110.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Aug 2017 19:42:51 +0300, Andy Shevchenko wrote:

> On Fri, 2017-08-25 at 17:05 +0100, John Keeping wrote:
> > On Fri, 25 Aug 2017 10:24:26 -0400, Tom Rini wrote: =20
> > > On Fri, Aug 25, 2017 at 04:56:47PM +0300, Andy Shevchenko wrote: =20
>=20
> > > > Apparently you are the one who tested the commit
> > > > 	89128534f925 ("ASoC: rt5677: Add ACPI support")
> > > > year ago.=C2=A0=C2=A0 =20
> > >=20
> > > Yes.
> > >  =20
> > > > The commit states that ACPI properties that are used in Chromebook
> > > > Pixel
> > > > 2015 is non-standard (not the same as for DT).
> > > >=20
> > > > However, DSDT shows the opposite!=C2=A0=C2=A0 =20
> > >=20
> > > Interesting.=C2=A0=C2=A0I'm not an ACPI person, I just tested what Jo=
hn came
> > > up
> > > with. =20
> >=20
> > And the patch adding this was the first (and still only) time I've
> > really looked at ACPI, so it's quite possible that I misunderstood
> > something at the time. =20
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
> > those strings appearing anywhere. =20
>=20
> Exactly, and this part of the patch I'm _not_ talking about (it's pretty
> much good and working).
>=20
> What I'm talking about is a specific function called
>=20
> rt5677_read_acpi_properties()
>=20
> in the rt5677.c codec driver.

Right, I don't see any reason why it shouldn't be possible to replace
that with rt5677_read_device_properties() given the DSDT I have.

I expect that exists because I was using the chromeos-3.14 tree as a
reference (which was the supported kernel on this hardware at the time),
but it looks like the unified device property API was added in 3.18 so
of course was not used there, and I did not realise that the device
property versions could be used here.

I'll try to find time to test this change over the weekend, if Tom
doesn't beat me to it!
