From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Ubuntu 10.04,
 VT8233/A/8235/8237: snd-via82xx `dxs_support` needs to be `3`
 instead of `5`
Date: Mon, 31 Jan 2011 10:50:59 +0100
Message-ID: <1296467459.3922.18.camel@mattotaupa>
References: <AANLkTimbB8WNVDJCD+rEng9NZbJGvtEkVBBXmxQS==7D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8037120983460156835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 238FE24408
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 10:51:02 +0100 (CET)
Received: from f053033079.adsl.alicedsl.de ([78.53.33.79]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1PjqPU-000196-OP
	for alsa-devel@alsa-project.org; Mon, 31 Jan 2011 09:51:00 +0000
In-Reply-To: <AANLkTimbB8WNVDJCD+rEng9NZbJGvtEkVBBXmxQS==7D@mail.gmail.com>
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


--===============8037120983460156835==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-BbfkBcO+q6NyrHal9kvB"


--=-BbfkBcO+q6NyrHal9kvB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Benjamin,


Am Sonntag, den 30.01.2011, 21:48 -0500 schrieb Benjamin Hovey:
> FYI, the below system required the following non-default settings for ALS=
A
> to play any SPDIF output correctly.  Prior to finding this setting, outpu=
t
> from different sources, WAV, MP3, CD, etc, were played at a slightly fast=
er
> speed than they should have.
>=20
> snd_via82xx: dxs_support=3D3
>=20
> When installed, the default setting was dxs_support=3D5.
>
>=20
> Hope this helps.  I am new to Linux and it took me quite a while to find =
out
> how to set this setting (I put it in  /etc/modprobe.d/alsa-base.conf)

thank you very much for reporting that issues especially if you are new
to GNU/Linux!

I have some questions and remarks.

Thanks for attaching/pasting the output of `alsa-info.sh`. This means
you informed yourself beforehand what is needed for debugging. Next time
please turn of line wrapping when pasting stuff though. Although I do
not know how to do that with Google Mail.

[=E2=80=A6]

> !!Soundcards recognised by ALSA
> !!-----------------------------
>=20
>  0 [V8237          ]: VIA8237 - VIA 8237
>                       VIA 8237 with VT1616i at 0xe400, irq 22
>  1 [Live           ]: EMU10K1 - SB Live! Platinum [CT4760P]
>                       SB Live! Platinum [CT4760P] (rev.8, serial:0x804011=
02) at 0xb000, irq 17

Just for me, is it true you have an extra SB Live card or is that also
from the motherboard? Sorry for my ignorance.

[=E2=80=A6]

> !!Modprobe options (Sound related)
> !!--------------------------------
>=20
> snd_via82xx: index=3D0
> snd_emu10k1: index=3D1
> snd_via82xx: dxs_support=3D4

[=E2=80=A6]

> snd_via82xx: index=3D0
> snd_emu10k1: index=3D1
> snd_via82xx: dxs_support=3D3
> snd_via82xx: ac97_clock=3D48000

These seem to be the options from `alsa-base.conf`. I do not know if it
is provided from upstream ALSA or by the distribution, in this case
Ubuntu.

Did you set the/changed it to `4` there or was it there by default? alsa
it looks like some lines are doubles. Probably from debugging and just
cosmetics though.


Thanks,

Paul

--=-BbfkBcO+q6NyrHal9kvB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1GhgMACgkQPX1aK2wOHVjjnACdGrQoZegaIBgWJv0YhcDjMIaw
LJcAmwZig8dPoUVfRVJB0pS+yLGAmekr
=nx5r
-----END PGP SIGNATURE-----

--=-BbfkBcO+q6NyrHal9kvB--


--===============8037120983460156835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8037120983460156835==--
