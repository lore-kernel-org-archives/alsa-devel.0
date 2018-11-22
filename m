From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date: Thu, 22 Nov 2018 14:18:02 +0100
Message-ID: <20181122131802.GB13339@amd>
References: <20181108171701.4444-4-ayman.bagabas@gmail.com>
 <20181119235713.GB7367@amd>
 <s5hr2fgfcrm.wl-tiwai@suse.de>
 <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de>
 <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de>
 <20181120115159.GG16916@amd>
 <s5hzhu4c569.wl-tiwai@suse.de>
 <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ayman Bagabas <ayman.bagabas@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-11-22 13:36:43, Andy Shevchenko wrote:
> On Tue, Nov 20, 2018 at 2:19 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Tue, 20 Nov 2018 12:51:59 +0100,
> > Pavel Machek wrote:
> > >
> > > Hi!
> > >
> > > > > You have general-purpose LED, yet you are treating it as "somethi=
ng
> > > > > special". That means ugly code (quoted above) and lack of flexibi=
lity.
> > > > >
> > > > > For example, if my notebook lacks HDD LED, I can use scrollock LE=
D for
> > > > > that instead. Or, in reverse way, maybe "mic mute" LED is not use=
ful
> > > > > for me, and I'd like to use it for notifications instead.
> > > >
> > > > I'm not against adding the LEDs device implementation for any exotic
> > > > usage.
> > > >
> > > > But for the audio mute LED features, you'll need really lots of oth=
er
> > > > works if it were implemented via leds device.  That's the hardest
> > > > part, and a few lines of hooks solves it easily in the kernel side.
> > > > That's all about it.
> > > >
> > > > If you are ready for submitting the real solutions in user-space si=
de
> > > > (patching PulseAudio and whatever all existing sound daemons, and
> > > > creating yet another daemon for non-PA systems (another footprint,
> > > > lovely), and so on), we can happily delete such in-kernel hooks :)
> > >
> > > I'm not saying we should move it to the userspace.
> > >
> > > I'm saying this should be "normal" led. drivers/leds/led-huawei-acpi.=
c,
> > > or something. Perhaps this acpi stuff is so similar you don't really
> > > need .c code.
> > >
> > > And then there should be a "mic muted" trigger. Similar to
> > > drivers/leds/trigger/ledtrig-disk.c.
> >
> > And who will trigger this, e.g. when the mixer is muted?
>=20
> Is this settled? I'm encouraged to promote this series to our for-next br=
anch.

I'd prefer this to be normal LED and "mic muted" to become normal
trigger.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv2rIoACgkQMOfwapXb+vLZ5wCfewOeVToe6MPLBy+FfxIJ6IQj
LbQAn3WL7JCKPHSqp71aCj7pjhWp7eJo
=vYC4
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
