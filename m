From: Nicolai Beuermann <mail@nico-beuermann.de>
Subject: Got headphone out working via hda-verb setting on
	MacPro1, 1
Date: Tue, 21 Jan 2014 01:13:03 +0100
Message-ID: <52DDBB8F.3010506@nico-beuermann.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6591330902421415618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from we305.netcup.net (we305.netcup.net [46.38.227.5])
 by alsa0.perex.cz (Postfix) with ESMTP id B307E261A9B
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 01:13:11 +0100 (CET)
Received: from [192.168.2.200] (port-92-206-26-196.dynamic.qsc.de
 [92.206.26.196])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by we305.netcup.net (Postfix) with ESMTPSA id 42A5ABFE56
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 01:13:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6591330902421415618==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3A76F1b6rrBNEA0Nw9nn8qmu4gSwdVbJH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3A76F1b6rrBNEA0Nw9nn8qmu4gSwdVbJH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,
hda-analyzer told me to write a note to this list when settings are
successful.

My setup:
MacPro 1,1
Kernel 3.10.17 (gentoo sources)
ALSA k3.10.17

Had to set
/usr/bin/hda-verb /dev/snd/hwC0D0 0x18 SET_PIN_WIDGET_CONTROL 0xc1
to get the headphone out at the front working.

Wrote a bit (in german) about it:
http://www.nico-beuermann.de/blogging/archives/117-Hier-gibt-es-was-auf-d=
ie-Ohren.html#extended


regards
Nicolai Beuermann

--=20
mailto: mail@nico-beuermann.de
online: http://www.nico-beuermann.de
GnuPG Fingerabdruck: 56DA 4E32 3A4A 52AC B769 DFC2 BF3E 9805 09BB 4259


--3A76F1b6rrBNEA0Nw9nn8qmu4gSwdVbJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLdu5YACgkQvz6YBQm7QlnZuQCfatta2dOLzPeuahF+0Ig/yUC1
xUoAn2zpvzczDOiJNXMUTEpbJaP1Rz34
=RRWd
-----END PGP SIGNATURE-----

--3A76F1b6rrBNEA0Nw9nn8qmu4gSwdVbJH--

--===============6591330902421415618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6591330902421415618==--
