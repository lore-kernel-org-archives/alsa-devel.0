From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] ALSA: hda: Use LPIB for Toshiba A100-259
Date: Sat, 22 May 2010 21:27:43 +0200
Message-ID: <1274556463.21620.1.camel@mattotaupa>
References: <AANLkTikdfY6kUNYqlXCKRgUjystXVoPyYqviryMCrHjk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6727544741615494677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id B8273245E7
	for <alsa-devel@alsa-project.org>;
	Sat, 22 May 2010 21:27:48 +0200 (CEST)
Received: from f053039181.adsl.alicedsl.de ([78.53.39.181]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OFuMN-0000M6-E0
	for alsa-devel@alsa-project.org; Sat, 22 May 2010 19:27:47 +0000
In-Reply-To: <AANLkTikdfY6kUNYqlXCKRgUjystXVoPyYqviryMCrHjk@mail.gmail.com>
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


--===============6727544741615494677==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zOUVjojrQBb0tkMCPKBT"


--=-zOUVjojrQBb0tkMCPKBT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Daniel,


Am Samstag, den 22.05.2010, 13:25 -0400 schrieb Daniel Chen:

[=E2=80=A6]

> -       SND_PCI_QUIRK(0x1106, 0x3288, "ASUS M2V-MX SE", POS_FIX_LPIB),
>         SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", POS_FIX_LPIB),
> +       SND_PCI_QUIRK(0x1106, 0x3288, "ASUS M2V-MX SE", POS_FIX_LPIB),
> +       SND_PCI_QUIRK(0x1179, 0xff10, "Toshiba A100-259", POS_FIX_LPIB),

Is not =C2=BBm=C2=AB before =C2=BBp=C2=AB in the alphabet?


Thanks,

Paul

--=-zOUVjojrQBb0tkMCPKBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkv4MBwACgkQPX1aK2wOHVjAggCaAwXZNym+j2TAhch+KavfyOCh
skMAnRwv6hn+3IkUT3WnKc/amvNtNige
=YLHi
-----END PGP SIGNATURE-----

--=-zOUVjojrQBb0tkMCPKBT--


--===============6727544741615494677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6727544741615494677==--
