From: Mathis Hofer <mathis.hofer@dreamlab.net>
Subject: Routing multiple signals to one output with ice1712
	(Delta 66)
Date: Wed, 19 Sep 2007 10:38:04 +0200
Message-ID: <46F0DFEC.802@dreamlab.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0374783047247519402=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailer.dreamlab.net (unknown [195.50.232.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 681152459D
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 10:38:25 +0200 (CEST)
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0374783047247519402==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B4223058530A1D72A4DFABA"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B4223058530A1D72A4DFABA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks

I want to setup the following audio routing:
pcm + input1 (mic) + input2 (mic) -> output1
pcm + input1 (mic) + input2 (mic) -> output2
=2E..with pcm being the audio playback and input1&2 being two microphones=
=2E

With envy24control it is possible to select one signal for each output,
but not multiple signals. Is this a restriction of envy24control, the
alsa driver or is it simply not supported by the hardware?

Regards,
Mathis

--=20
DreamLab Technologies AG
Monbijoustrasse 36
3011 Bern
Switzerland

Tel: +41 31 398 66 66
Fax: +41 31 398 66 69

PGP Key ID: 2462240B


--------------enig2B4223058530A1D72A4DFABA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG8N/9VOkwMiRiJAsRAn+TAJ9CR/+W9SWYVHD7gwQMYHYeoi84dQCfePX8
6kllMHzmhAodaXo2Kx1iIJg=
=3DLZ
-----END PGP SIGNATURE-----

--------------enig2B4223058530A1D72A4DFABA--

--===============0374783047247519402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0374783047247519402==--
