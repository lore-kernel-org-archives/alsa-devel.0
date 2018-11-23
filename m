From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei
	WMI micmute LED
Date: Fri, 23 Nov 2018 23:05:23 +0100
Message-ID: <20181123220523.GA22118@amd>
References: <s5hr2fgfcrm.wl-tiwai@suse.de> <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de> <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de> <20181120115159.GG16916@amd>
 <s5hzhu4c569.wl-tiwai@suse.de>
 <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
 <20181122131802.GB13339@amd> <s5h8t1l5ish.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0437043279792233676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 869AB2677E8
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 23:05:24 +0100 (CET)
In-Reply-To: <s5h8t1l5ish.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Ayman Bagabas <ayman.bagabas@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Kailang Yang <kailang@realtek.com>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0437043279792233676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> > > > > > > You have general-purpose LED, yet you are treating it as "som=
ething
> > > > > > > special". That means ugly code (quoted above) and lack of fle=
xibility.
> > > > > > >
> > > > > > > For example, if my notebook lacks HDD LED, I can use scrolloc=
k LED for
> > > > > > > that instead. Or, in reverse way, maybe "mic mute" LED is not=
 useful
> > > > > > > for me, and I'd like to use it for notifications instead.
> > > > > >
> > > > > > I'm not against adding the LEDs device implementation for any e=
xotic
> > > > > > usage.
> > > > > >
> > > > > > But for the audio mute LED features, you'll need really lots of=
 other
> > > > > > works if it were implemented via leds device.  That's the harde=
st
> > > > > > part, and a few lines of hooks solves it easily in the kernel s=
ide.
> > > > > > That's all about it.
> > > > > >
> > > > > > If you are ready for submitting the real solutions in user-spac=
e side
> > > > > > (patching PulseAudio and whatever all existing sound daemons, a=
nd
> > > > > > creating yet another daemon for non-PA systems (another footpri=
nt,
> > > > > > lovely), and so on), we can happily delete such in-kernel hooks=
 :)
> > > > >
> > > > > I'm not saying we should move it to the userspace.
> > > > >
> > > > > I'm saying this should be "normal" led. drivers/leds/led-huawei-a=
cpi.c,
> > > > > or something. Perhaps this acpi stuff is so similar you don't rea=
lly
> > > > > need .c code.
> > > > >
> > > > > And then there should be a "mic muted" trigger. Similar to
> > > > > drivers/leds/trigger/ledtrig-disk.c.
> > > >
> > > > And who will trigger this, e.g. when the mixer is muted?
> > >=20
> > > Is this settled? I'm encouraged to promote this series to our for-nex=
t branch.
> >=20
> > I'd prefer this to be normal LED and "mic muted" to become normal
> > trigger.
>=20
> But how would you solve the existing problem?
>=20
> As already mentioned, you'll need to hook the LED trigger and the
> actual mixer value change.  This is the biggest missing piece, and
> it's the very reason we have the exported symbol from the platform
> driver side.
>=20
> So, if you prefer in that way, please implement that for the existing
> driver (thinkpad_acpi and dell-laptop) at first.  I'll be really happy
> to get rid of the present ugly solution!  But it's been there just
> because it's not so trivial at all.  FWIW, this must be all done
> inside the kernel; otherwise you'll hit a regression.

I am really have enough work to do at the moment, but let me take a look.

> If the path via leds class can't be achieved quickly, I'd prefer
> taking the current approach at first.  Once after it's done for those
> above, we can apply the same for huawei-wmi later, too.

I'd prefer not adding more mess. Don't expect full solution from me,
but ... I should have something better than what is in the tree rather
soon.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv4eaMACgkQMOfwapXb+vJuAACdH7eG8BCG9j+wfTKoEyj7B3hc
TIsAoI89+VS11+xTUpAodEJdFYwOmH1V
=shKN
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============0437043279792233676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0437043279792233676==--
