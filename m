From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: snd-hda-intel: Power management not enabled until
 audio is played
Date: Mon, 13 Feb 2012 20:51:26 +0100
Message-ID: <1329162686.4030.4.camel@mattotaupa>
References: <1328954344.3359.18.camel@mattotaupa>
	<s5hsjie24zv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5492274352444878306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B42103CEF
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 20:51:46 +0100 (CET)
In-Reply-To: <s5hsjie24zv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5492274352444878306==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/5Iyn3yelsOl6XBKycHc"


--=-/5Iyn3yelsOl6XBKycHc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 13.02.2012, 15:16 +0100 schrieb Takashi Iwai:
> At Sat, 11 Feb 2012 10:59:04 +0100,
> Paul Menzel wrote:

> > playing with PowerTOP 1.97 I notice that it lists 100 % usage for the
> > Audio device on several systems [1].
> >=20
> > I made sure that power management is enabled.
> >=20
> >         $ grep snd /etc/modprobe.d/*
> >         =E2=80=A6: options snd_hda_intel power_save=3D1
> >         $ more /sys/module/snd_hda_intel/parameters/power_save_controll=
er
> >         Y
> >         $ more /sys/module/snd_hda_intel/parameters/power_save
> >         0
> >=20
> > Since I was on AC power pm-utils seems to reset that parameter to not
> > save power. :/
> >=20
> >         $ sudo su
> >         # echo "1" > /sys/module/snd_hda_intel/parameters/power_save
> >         # exit
> >=20
> > But enabling that does not change anything right away. Only after using
> > the device by playing some audio =E2=80=93 `speaker-test` in this case,=
 the
> > power management seems to kick in.
>=20
> Right, it's a known issue.

Should I submit a bug report to track that issue?

> You don't have to play actually but just opening/closing a device
> should suffice.

Is `touch /dev/dsp` enough? I am thinking about adding that command to
some start script.

> The reason is that changing the sysfs parameter file would change only
> the variable but doesn't trigger the event by itself.  It's possible
> to add some triggering action, but it'd become fairly messy.  So I've=20
> postponed the implementation, so far.

Understood. I guess most users do not experience that since nowadays the
login manager plays some sound opening the device every start up. Mostly
advanced users will suffer from this not using such a login manager or
desktop environment like GNOME or KDE.


Thanks,

Paul

--=-/5Iyn3yelsOl6XBKycHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk85ab4ACgkQPX1aK2wOHVhrcACfYOLgY2nWyuNxeyBmctQiD98C
6UYAn1bIHuoplwevlkcL6i9Nq6XLwULs
=aFN0
-----END PGP SIGNATURE-----

--=-/5Iyn3yelsOl6XBKycHc--


--===============5492274352444878306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5492274352444878306==--
