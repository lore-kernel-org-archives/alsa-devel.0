From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [solved] Conexant 5069: internal speakers are not
 muted when headphones are plugged in
Date: Sat, 05 Feb 2011 16:40:04 +0100
Message-ID: <1296920404.3692.22.camel@mattotaupa>
References: <1296472096.3922.67.camel@mattotaupa>
	<4D46A0C1.7010507@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5537153868038498916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 551DA2415E
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2011 16:40:08 +0100 (CET)
In-Reply-To: <4D46A0C1.7010507@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5537153868038498916==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-t6UOni44+k7r3gP2B7q8"


--=-t6UOni44+k7r3gP2B7q8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 31.01.2011, 12:45 +0100 schrieb David Henningsson:
> On 2011-01-31 12:08, Paul Menzel wrote:

> > I encounter a problem with a Lenovo G555 where the internal speakers ar=
e
> > not muted when headphones are plugged in. Ubuntu 10.10 with Linux 2.6.3=
5
> > [1] runs the Lenovo, but this seems to be a common problem [2][3].
> >
> > I tried to load the module with `model=3Dlenovo`, but the only result w=
as,
> > that the external speakers did not work at all. Do you have another ide=
a
> > what to use for the `model`? The system has to rebooted every time,
> > since I cannot unload the module using
> >
> > 	sudo modprobe -r snd-hda-intel
> >
> > or
> >
> > 	sudo rmmod snd-hda-intel
> >
> > since it seems to be in use by the system.
> >
> > Seems like I missed `model=3Dthinkpad` in [3]. But I do not have access=
 to
> > the system right now, so I am sending this report anyway.
> >
> > Please find attached the output of `alsa-info.sh` with the default
> > behavior (headphones work, but internal ones are not muted) and with
> > `model=3Dlenovo` (headphones do not work).
> >
> > David, do you know if your recent patches sent to this list
> >
> > [PATCH 2/2] ALSA: HDA: Add a new model "asus" for Conexant 5066/205xx [=
5]
> > [PATCH] ALSA: HDA: Add Lenovo vendor quirk for Conexant 205xx [6]
> >
> > will also address this issue=C2=B9? They are for 5066 and I have 5069
> > according to [2]. If yes, is there a package repository with a package
> > having this patches applied I can install using the package management
> > system?
>=20
> You have an internal mic at 0x1a, so it seems like model=3Dasus would be=
=20
> the one for you. But if you just want headphones automuting,=20
> model=3Dideapad or model=3Dthinkpad should do as well.

For now automuting headphones is good enough and `model=3Dthinkpad` works
as expected.

Can you give an estimate when a package with your patch for `model=3Dasus`
will be available? Or do I have to wait for Linux 2.6.38 [1]?


Thanks,

Paul


[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-January/03618=
3.html

--=-t6UOni44+k7r3gP2B7q8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1Nb1QACgkQPX1aK2wOHVg7PwCggM0iIsmcgIBzQvImOxrmmnsF
4mcAn2opd8MGrOCtc+UjPLmMNb1YwuIw
=JudL
-----END PGP SIGNATURE-----

--=-t6UOni44+k7r3gP2B7q8--


--===============5537153868038498916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5537153868038498916==--
