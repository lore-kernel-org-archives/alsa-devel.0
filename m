From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 4/8] firmware: Sigma: Mark firmware strutcs packed
Date: Thu, 24 Nov 2011 12:19:34 -0500
Message-ID: <201111241219.37220.vapier@gentoo.org>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de> <1322138908-32127-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2117582.9HbOOzso6N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322138908-32127-4-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--nextPart2117582.9HbOOzso6N
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 24 November 2011 07:48:23 Lars-Peter Clausen wrote:
> Mark structs which are embedded into the firmware as packed to avoid
> alignment issues.

while in general this makes sense, i designed the struct layout specificall=
y to=20
work on any sane system.  that means 8bits align on 8bits, 16bits align on=
=20
16bits, and 32bits align on 32bits.

do you see any place where this is not the case ?  otherwise, using __packe=
d=20
by itself doesn't make much sense unless you also change all the loads from=
=20
the struct to the get_unaligned variety which would add useless overhead to=
=20
many embedded parts.

all in all, i'd omit the __packed markings since they're unnecessary.
=2Dmike

--nextPart2117582.9HbOOzso6N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOznypAAoJEEFjO5/oN/WBDXAP/jhDJlDQu+jzQYPZUcoCyG1X
NbDr3dxeijDd6P2zhmjDRW/2QkKwaSkexEyuZc2Px5muHv14bdBtjeBkJ3N4C5JH
CCdwiFO4w0G5OQbgti7HzkpLRMWS0Olo9RGECPwP+fPpSPgk2qv4kVeXU4CjNESd
r2u1E4NWsihID7rIoP1zriS0BRsXIi23Myof5vdahr0Te+LNZ1OdplznmN6Cwxi9
1N9TfgoWlRL7Hw53WpZPE/3E9onl7PF93uvtfX1hzsb8TLmAYakJF6E5oc0/D7dV
KmJTrAQNwS4hTAUO9/Mrl9V3Y/eg9S9+1OxsYTpGd93yYRr7jZgGntNUX2SVexqx
O5sL3NlRQOTOUAeMXG0UDWVClnmvXcuJYhj6VjODXKH9Kf073Bns32IbHavMOTrj
3XATHxRIhA+Dj75/tIeCeZ+AhwklF/SzaKcz/PoyKaz++hfSXHRs5ld0eRoY0teR
LyhQHGH0QDo+2QGd4W2yzYvxih/9Tj5YixTotyofgZpnYbAyp/bFJWRxB+8VaGVv
HihLACzPSaN5dre4gvGIJ988i57LC/8t++ffLsMqccLf5Q+unNd6hYQVtlN5ftkZ
didt0krzZBxOdZRdLspwaWG1G2K40yFBIOCQIJIZRo5H/4AbJbaL0Kj2yYGogEAW
oLRnARxhMc88oi8n8dmx
=OKQo
-----END PGP SIGNATURE-----

--nextPart2117582.9HbOOzso6N--
