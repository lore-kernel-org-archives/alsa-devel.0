From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: `hda-intel: spurious response` several times in
 output of `dmesg`
Date: Wed, 31 Aug 2011 12:19:01 +0200
Message-ID: <1314785943.3769.30.camel@mattotaupa>
References: <1314185760.3628.30.camel@mattotaupa>
	<1314284537.26121.6.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1344295438233355614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id CE3FA244D7
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 12:19:03 +0200 (CEST)
Received: from f053046058.adsl.alicedsl.de ([78.53.46.58]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Qyhsx-0001yv-FH
	for alsa-devel@alsa-project.org; Wed, 31 Aug 2011 10:19:07 +0000
In-Reply-To: <1314284537.26121.6.camel@mattotaupa>
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


--===============1344295438233355614==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-28XFMzqiPS+JsDxNFpP+"


--=-28XFMzqiPS+JsDxNFpP+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA folks,


Am Donnerstag, den 25.08.2011, 17:01 +0200 schrieb Paul Menzel:

[=E2=80=A6]

> I just want to add that I also see these messages with Linux kernel
> 3.0.2 and say seem to be related to suspend and resume.
>=20
> The values seem to differ though every time.
>=20
>         [ 1130.984969] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x620000
>         [ 1130.984990] hda-intel: spurious response 0x1003c:0x0, last cmd=
=3D0x620000
>         [ 1130.985011] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x620000
>         [ 1130.985032] hda-intel: spurious response 0x10034:0x0, last cmd=
=3D0x620000
>         [ 1130.985053] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x620000
>=20
>         [ =E2=80=A6 another suspend/resume =E2=80=A6 ]
>=20
>         [ 2726.277102] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1e70700
>         [ 2726.277123] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1e70700
>         [ 2726.277144] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1e70700
>         [ 2726.277165] hda-intel: spurious response 0xb:0x0, last cmd=3D0=
x1e70700
>=20
> Please find the output of `alsa-info.sh` [1] with this Linux version at
> the end.

who is the correct person to address these things to?


Thanks,

Paul

--=-28XFMzqiPS+JsDxNFpP+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5eCpYACgkQPX1aK2wOHVgy9QCfZw4+a3vTQsx/uby1N6ixjNQI
mjQAn2Nt2nKBJEVcH87JQ/Rx/AhpNKc+
=hUFN
-----END PGP SIGNATURE-----

--=-28XFMzqiPS+JsDxNFpP+--


--===============1344295438233355614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1344295438233355614==--
