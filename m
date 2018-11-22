From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date: Thu, 22 Nov 2018 14:12:16 +0100
Message-ID: <20181122131216.GA13339@amd>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com>
 <20181119235713.GB7367@amd>
 <s5hr2fgfcrm.wl-tiwai@suse.de>
 <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de>
 <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de>
 <20181120115159.GG16916@amd>
 <s5hzhu4c569.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hzhu4c569.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>, alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-20 13:19:26, Takashi Iwai wrote:
> On Tue, 20 Nov 2018 12:51:59 +0100,
> Pavel Machek wrote:
> >=20
> > Hi!
> >=20
> > > > You have general-purpose LED, yet you are treating it as "something
> > > > special". That means ugly code (quoted above) and lack of flexibili=
ty.
> > > >=20
> > > > For example, if my notebook lacks HDD LED, I can use scrollock LED =
for
> > > > that instead. Or, in reverse way, maybe "mic mute" LED is not useful
> > > > for me, and I'd like to use it for notifications instead.
> > >=20
> > > I'm not against adding the LEDs device implementation for any exotic
> > > usage.
> > >=20
> > > But for the audio mute LED features, you'll need really lots of other
> > > works if it were implemented via leds device.  That's the hardest
> > > part, and a few lines of hooks solves it easily in the kernel side.
> > > That's all about it.
> > >=20
> > > If you are ready for submitting the real solutions in user-space side
> > > (patching PulseAudio and whatever all existing sound daemons, and
> > > creating yet another daemon for non-PA systems (another footprint,
> > > lovely), and so on), we can happily delete such in-kernel hooks :)
> >=20
> > I'm not saying we should move it to the userspace.
> >=20
> > I'm saying this should be "normal" led. drivers/leds/led-huawei-acpi.c,
> > or something. Perhaps this acpi stuff is so similar you don't really
> > need .c code.
> >=20
> > And then there should be a "mic muted" trigger. Similar to
> > drivers/leds/trigger/ledtrig-disk.c.
>=20
> And who will trigger this, e.g. when the mixer is muted?

Same code that does it now.
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv2qzAACgkQMOfwapXb+vLwoACeKq3VduycyIiw3wbuLotckmV6
b2IAn1VSvUMQE3tqN5RVxbjY1WyVfnCq
=+D6u
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
