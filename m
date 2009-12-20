From: Chris <cpollock@embarqmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 349696 bytes (1821 ms).
Date: Sat, 19 Dec 2009 19:26:09 -0600
Message-ID: <1261272369.18070.42.camel@localhost.localdomain>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8701039242113626807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 33BA41037F2
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 02:26:12 +0100 (CET)
In-Reply-To: <4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
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


--===============8701039242113626807==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gLaTTsxdcB25/eG8JjyV"


--=-gLaTTsxdcB25/eG8JjyV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> I can reproduce this bug on pulseaudio-0.9.14 by
>=20
> aplay -v --period-size=3D32  any_rate_not_equal_44100Hz.wav
>=20
>=20
Note - I reported this as bug#
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4834 on 14
December.


--=20
KeyID 0xE372A7DA98E6705C


--=-gLaTTsxdcB25/eG8JjyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkstfTEACgkQ43Kn2pjmcFyd+wCeM1gVefm+kbXLsNlWjBuTM9FV
x8MAn2jiQEX7vGgpQQ0jEvLHAsADQ4EQ
=UrBk
-----END PGP SIGNATURE-----

--=-gLaTTsxdcB25/eG8JjyV--


--===============8701039242113626807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8701039242113626807==--
