From: Joshua Kwan <joshk@triplehelix.org>
Subject: Some problems with snd-au8830
Date: Sun, 12 Sep 2004 01:42:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040912084204.GA22712@darjeeling.triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268533AbUILImP@vger.kernel.org>
Content-Disposition: inline
To: alsa-devel@lists.sourceforge.net, linux-kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello ALSA developers (cc: LKML for any inspiration),

Some snd-au8830 concerns..

I've recently been using my Aureal Vortex2 SQ2500 with ALSA's snd-au8830
to do some recording, and I got a humongous pile of these in my dmesg:

vortex: IRQ reg error
vortex: IRQ fifo error
vortex: IRQ dma error

and at the end of each batch:

vortex: 0 virt=3D0, real=3D0, delta=3D-1

Also, I can't seem to start up JACK using the ALSA backend:

loading driver ..
creating alsa driver ...
hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period =3D 1024 frames, buffer =3D 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
ALSA: cannot set period size to 1024 frames for capture
ALSA: cannot configure capture channel
cannot load driver module alsa

It only works when I use -p 512 (512 frames/period) and disable capture
outputs:

$ jackd -d alsa -p512 -P

creating alsa driver ... hw:0|-|512|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period =3D 512 frames, buffer =3D 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead

It all works perfectly with my other machine which uses snd-intel8x0.
(Except, of course, that there's no nice hardware mixing.) Any ideas?

Thanks!

--=20
Joshua Kwan

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUQL3KOILr94RG8mAQLi/A//dYWegIpCxPx3vQB6kHAs1501j2ujVjvj
wQ4jbi/anDe9lID+p3e4SVqmfbJbHfH5pnb0+Dkr4Fh3UQ+/Uena/DBLJQJ3KQYE
UiQneRPu5swQfCEBAxu3tHXjmBscGcpZ3CJm4I30gIHj0m4ePUnaCKEdrOUMI9y1
LcpR0hP9GVUnrad7+fABJwwRLufU7iG2Hxp1ZHr9omVAj36f4MmYs+EripJoUNLC
b8MQtkzt267ojna/XhV0pjzmC2e2ostPTILmLGzuLwYlcL2WZf8KpKmJGal/W79z
BvJckkeisVwmE/e9IEPtGyQ/5YlEo6LXGl5jjU5iOwirau1ZkzaUkKI+H9W0lTPy
SUKnSnRqpg2BQjU5ElqnBtKYZ6OoqjLeL4r4LMW+Me24+h+Kt/wYNHZBfJabn288
l6IHF2i3oZ6Mhw3X4/N3pU4V0df/pqQIg+wCNdXCnWjxeMCjfPEFAFwpXBG5A96Z
/NHJok5dttkX/ShhZoN8z25pZ3jKQOrquZP24YBTKu2N7mjzLjgQlNhIEKSDOqJo
w8iARbztnLT7uoejINI4VRmd9uwtAIcmg74xmhQeJh7j3nrxAX6BU01Iry2Ku8aI
ZiwTXA36VJJnOjNZh7iHZjLQkM9V+NZzqFHw9sLKtUer9ytTgcta5lS0c3hq8MIb
nT8RcyHwpRA=
=Bopd
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
