From: Tim Blechmann <tim@klingt.org>
Subject: Re: Hammerfall hdsploader not working in ubuntu 8.10
Date: Fri, 20 Feb 2009 16:08:41 +0100
Message-ID: <499EC779.3060708@klingt.org>
References: <499EB3A6.8020200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2072191183950229295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B852103918
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 16:08:46 +0100 (CET)
In-Reply-To: <499EB3A6.8020200@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?Um9iZXJ0IEdyw7xuZGxlcg==?= <doobre@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2072191183950229295==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig700BB23BA10E785EC4DA8DA0"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig700BB23BA10E785EC4DA8DA0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi robert,

> i'm using a rme Hammerfall hdsp multiface card which i've never had=20
> problems so far, due to
> the fact that it's pretty well supported.
>=20
> However, after upgrading to Ubuntu 8.10 the hdsploader fails to upload =

> the firmware to the card with the
> following error:
>=20
> hdsploader - firmware loader for RME Hammerfall DSP cards
> Looking for HDSP + Multiface or Digiface cards :
> Card 0 : RME Hammerfall DSP + Multiface at 0xf87f0000, irq 22
> Upload firmware for card hw:0
> Hwdep ioctl error on card hw:0 : Device or resource busy.

i did experience some `strange' behavior on my hdsp as well, starting a
few months ago.
in my case, the hdsp tells me, that the io box is not connected. my
workaround was to unload/reload the module.
maybe related to that issue, sometimes, the hdspmixer doesn't read the
meter values from the interface, giving me the same `hwdep ioctl error',
you are experiencing with hdsploader (i don't use hdsploader, since it
is basically obsolete).

i suppose, it is a similar issue, that i am experiencing ... btw are you
running a 32bit or 64bit system?

cheers, tim

--=20
tim@klingt.org
http://tim.klingt.org

=2E.. to make life worth living ...
  Keith Rowe on making music


--------------enig700BB23BA10E785EC4DA8DA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmex3wACgkQdL+4qsZfVsv/VwCfY+uDlNHfrLdUoaRWF2LW+FTV
EasAoIyzs34fFqoBoXeXRx4FuT7ZbKcs
=5qqd
-----END PGP SIGNATURE-----

--------------enig700BB23BA10E785EC4DA8DA0--

--===============2072191183950229295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2072191183950229295==--
