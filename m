From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Mon, 24 Sep 2018 11:32:49 +0200
Message-ID: <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
Reply-To: sbahling@suse.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8257927033645296825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A1A6267730
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2018 11:32:51 +0200 (CEST)
In-Reply-To: <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org


--===============8257927033645296825==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-if12JAhgegP4sO2EonSk"


--=-if12JAhgegP4sO2EonSk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-09-17 at 23:36 +0900, Takashi Sakamoto wrote:
> Hi,


> I prepare branches in two remote repositories:
>   -=20
>=20
https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspac=
e
> =20
> (a384019c0f78)
>   - https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace=20
> (a5994ec2165f)
>=20
> Installing the patched driver, you can read the status and control
> message in userspace by mmap(2).
>=20
> Patched libhinawa produces HinawaSndTscm GObject class. This class is
> also available with gobject introspection. For example with PyGobject:
>=20
> ```
> #/usr/bin/env python3
> from time import sleep
> import gi
> gi.require_version('Hinawa', '2.0')
> from gi.repository import Hinawa
> unit =3D Hinawa.SndTscm()
> # I assume card number 1 is assigned. Take care of file permission.
> unit.open('/dev/snd/hwC1D0')
> unit.listen()
> while (True):
>    for i, frame in enumerate(unit.get_status()):
>      print('{0:02d}: {1:08x}'.format(i, frame))
>    sleep(0.1)
> ```
>=20
> This code print the message to stdout, but not start packet streaming.
> You need to start it by ALSA PCM/rawMIDI interfaces, like:
> $ aplay -Dplughw:1,0 /dev/urandom
>=20
> I notice that the branches include patches I introduced[1], with some
> minor optimizations to Linux kernel v4.17 or later. The patches are
> written just to satisfy investigation work and really ad-hoc ones.

Thanks! I finally had some time to try it out.

My test system is running a 4.12 kernel from openSUSE Leap 15.0. I
backported the patches but had to remove your GFP_KERNEL patch for it to
work on my kernel. With the GFP_KERNEL patch, user space was not seeing
updates to the data stream. With it removed, I had a constant update.

The kernel was unstable and the system hard locked frequently with the
patches enabled (with and without the GFP_KERNEL patch). But I was able
to map out all the controller functions to the bits in the first 16
quadlets. I will write up my findings and send them later.

> > I noticed that we are able to control the LEDs from the host via the
> > asynchronous link. Do you you think the faders are also controlled
> > that way
> > or would that also go via isochronous packets to the FW-1884?
>=20
> The rx isochronous packets from system to the unit include no data to
> control the unit[2]. If the faders are movable from system software,
> it should be achieved by asynchronous transactions, like blighting
> LEDs.

I guess without an analyzer that will be difficult to track down.

-Scott

--=-if12JAhgegP4sO2EonSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAluor0EACgkQAst8aI6U
pxJcqg//SGMRi2BJNVVEOSCFMPqYIev9ryX1pjc/jb5aKwmNYNSCEj2GekS5kYN0
7zTVh9dB80OOgTLvcFWlIc7l0cJyUMys7aErZpCu8XN7eu9MZIdB6vIOhAL4RGmR
pBHHEQfhGcN/uoiOk6sEkp5KzE/08g8CICGJHJPvhCZNCy+XJYKsOZNEFAesJHFm
FQ1qjw2SqNvf/CODQZf5zzv1cHY+bb0ivtqkQYGfOO1Ndr9K6E0W2iKCrsFrhp9H
HQkFqpv+xN9fd5Rjhtn8bNpF1YFAt/G9tIFPCfNgnHwSz8S23uNp8luh2G6H5B2T
zVBI1Fn7PZbzvFGjIgMRqcJYwAYgGjlXoGFWwztRL2a0QLE3xfd+Raofa2vAN2FK
xif2eNRVK6kb5Un0/UV90mg+58HiJDayQRrudP6aZPM7VL9zc7pJut4TxMKKE+cf
eIZbr26EPHmB1lMRZ1NKspV2KJFquQZ76wdaEXJKYEKqzWORLmgCAIJR5bVAFt9L
odreQE9TLVjXTCEVc6t+MndxyrPXWIQjc/YDxhGJ1fCd+7vdOq5cfDfOdjqIpTPC
ajOCYciTrlLyU/jkK+F7wjHNqCGsAG1S54O1srZXfSJ37WrToXXesLWvtO2IcdDY
oW0DTvyzyVr04nGmkHx0CU3FYWc3VXUC11nX+8jXW57XE5ZUNcI=
=XpLB
-----END PGP SIGNATURE-----

--=-if12JAhgegP4sO2EonSk--


--===============8257927033645296825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8257927033645296825==--
