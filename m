From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] hdspmixer: fix drawing problems with black
 background
Date: Fri, 01 Apr 2011 12:28:29 +0200
Message-ID: <1301653709.3951.52.camel@mattotaupa>
References: <6a9fbdb6a976e82ef55bbb9e9f20c73afa748287.1301652949.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1160048997707215808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id DD29F103834
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 12:28:32 +0200 (CEST)
Received: from f053035217.adsl.alicedsl.de ([78.53.35.217]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q5bag-0000XX-KG
	for alsa-devel@alsa-project.org; Fri, 01 Apr 2011 10:28:30 +0000
In-Reply-To: <6a9fbdb6a976e82ef55bbb9e9f20c73afa748287.1301652949.git.tim@klingt.org>
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


--===============1160048997707215808==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EBgoDtOSRoonl46uuy46"


--=-EBgoDtOSRoonl46uuy46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 01.04.2011, 12:16 +0200 schrieb Tim Blechmann:
> - use foreground color instead of black
> - HDSPMixerSelector: set colors before setting labels
> - automated removal of some trailing spaces

A separate patch for the white space change would make reviewing this
patch on the list much easier, since there are no options in my mail
client or the archive =E2=80=93 at least that I know of =E2=80=93 to not di=
splay white
space changes.

[=E2=80=A6]


Thanks,

Paul

--=-EBgoDtOSRoonl46uuy46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2VqM0ACgkQPX1aK2wOHVitTgCgi6kEz/gQwDw7HkhOVoPJhEbr
2tQAmQE67e8jYM0gea1vmxqZ6tP1yz23
=VGTq
-----END PGP SIGNATURE-----

--=-EBgoDtOSRoonl46uuy46--


--===============1160048997707215808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1160048997707215808==--
