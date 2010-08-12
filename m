From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: ALSA: How to create multiple cards?
Date: Thu, 12 Aug 2010 09:46:33 +0200
Message-ID: <1281599193.3890.3.camel@mattotaupa>
References: <AANLkTinRfPUww40Ar3iB07rkkHWnRLUH-Hdcc29pTrS1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2841589566528911765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id E3F9824406
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 09:46:38 +0200 (CEST)
Received: from f053036048.adsl.alicedsl.de ([78.53.36.48]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OjSUn-0004fO-Bl
	for alsa-devel@alsa-project.org; Thu, 12 Aug 2010 07:46:37 +0000
In-Reply-To: <AANLkTinRfPUww40Ar3iB07rkkHWnRLUH-Hdcc29pTrS1@mail.gmail.com>
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


--===============2841589566528911765==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-BpUS+aDa+1K3A0rxleeu"


--=-BpUS+aDa+1K3A0rxleeu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Truong,


Am Donnerstag, den 05.08.2010, 20:11 -0700 schrieb Truong Hoang:

> I have a problem that I need help from the ALSA experts.
>=20
> I want to write an alsa shim .ko which creates multiple cards. Let's assu=
me
> 2 cards. My program calls
> snd_card_create() and snd_card_register() two times. I also has 1 PCM for
> each of these card.
>=20
> After install the .ko to the kernal, I see the /proc/asound has card0 and
> card1. But the "aplay -l" sees only card0. The snd_card_next() only retur=
ns
> 0 (i.e. 1 card).
> What did I miss in my program? The /dev/snd/ has only hwC0D0 and pcmD0C0p=
.
>=20
> I am a beginner in ALSA, so I appreciate if you can give the explanation =
in
> detail.

please attach your source code so the experts =E2=80=93 not me =E2=80=93 ca=
n point out
what is missing.


Thanks,

Paul

--=-BpUS+aDa+1K3A0rxleeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxjpswACgkQPX1aK2wOHVhxIwCcDZqtKSKMIH3lrK37Cv/2I/VB
4hMAniencX6kxmMTSCXotWCFTQLrPXj0
=wQYL
-----END PGP SIGNATURE-----

--=-BpUS+aDa+1K3A0rxleeu--


--===============2841589566528911765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2841589566528911765==--
