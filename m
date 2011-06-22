From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Ubuntu 11.04 with Linux kernel 3.0.0-rc4: Noise on
	snd-hda-intel
Date: Wed, 22 Jun 2011 10:59:18 +0200
Message-ID: <1308733159.16578.9.camel@mattotaupa>
References: <4E00F373.6050001@molgaard.org> <4E00F41E.5090303@molgaard.org>
	<1308691120.6844.1.camel@mattotaupa>  <4E01A8FA.8060709@molgaard.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8089305214839913916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC611039B6
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 10:59:22 +0200 (CEST)
Received: from f053036030.adsl.alicedsl.de ([78.53.36.30]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QZJHU-0002iE-RK
	for alsa-devel@alsa-project.org; Wed, 22 Jun 2011 08:59:29 +0000
In-Reply-To: <4E01A8FA.8060709@molgaard.org>
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


--===============8089305214839913916==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3M44wVkQO3SzVQdH82gu"


--=-3M44wVkQO3SzVQdH82gu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 22.06.2011, 10:34 +0200 schrieb Sune M=C3=B8lgaard:
> Paul Menzel wrote:
> > Am Dienstag, den 21.06.2011, 21:42 +0200 schrieb Sune M=C3=B8lgaard:

[=E2=80=A6]

> > Please provide the information (attach and upload) listed on [1].

[=E2=80=A6]

Please clean up the quotes before replying!

> > [1] http://alsa-project.org/main/index.php/Help_To_Debug
>=20
> Ok, thanks.
>=20
> Attached is the generated file.

[=E2=80=A6]

> upload=3Dtrue&script=3Dtrue&cardinfo=3D
> !!################################
> !!ALSA Information Script v 0.4.60
> !!################################
>=20
> !!Script ran on: Tue Jun 21 21:23:22 UTC 2011
>=20
>=20
> !!Linux Distribution
> !!------------------
>=20
> Ubuntu 11.04 \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESCRIPTION=3D"Ubuntu 11.0=
4"

[=E2=80=A6]

> !!Kernel Information
> !!------------------
>=20
> Kernel release:    3.0.0-rc4-sune-1
> Operating System:  GNU/Linux
> Architecture:      x86_64
> Processor:         x86_64
> SMP Enabled:       Yes

Ok, so you are using Ubuntu and a self-compiled Linux kernel. These are
very important information so please mention it next time in the first
place. The answers to the following question are probably useful too?

1. Is it a regression? Does this happen with the Linux kernel shipped by
Ubuntu or did it happen with your self-compiled Linux kernels before?
2. If it also happens with the default Linux kernel shipped by Ubuntu
the easiest way is to follow their instructions to solve sound related
problems and report it to them using `ubuntu-bug audio` [1]. There are
several developers working for(?) Ubuntu who will probably be able to
help you really quickly.

> !!ALSA Version
> !!------------
>=20
> Driver version:     1.0.24
> Library version:    1.0.24.1
> Utilities version:  1.0.24.2

[=E2=80=A6]

I am sorry that I will not be able to help you any further because I do
not know anything about the internals. I hope you will be able to fix
your problem quickly.


Thanks,

Paul


[1] https://wiki.ubuntu.com/DebuggingSoundProblems

--=-3M44wVkQO3SzVQdH82gu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4BrtwACgkQPX1aK2wOHVhShQCfcvjERztVwpJGxAjw8lD/htl0
3sIAn3Pem/aw8BMcXgqOu+sE39pKIkx+
=UszT
-----END PGP SIGNATURE-----

--=-3M44wVkQO3SzVQdH82gu--


--===============8089305214839913916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8089305214839913916==--
