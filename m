From: John Sauter <John_Sauter@systemeyescomputerstore.com>
Subject: Re: Fix bug in arecord --max-file-time where	the file
 size could overflow 32 bits
Date: Sat, 24 Jun 2017 04:39:19 -0400
Message-ID: <1498293559.2383.3.camel@systemeyescomputerstore.com>
References: <mailman.1530.1498285564.896.alsa-devel@alsa-project.org>
Reply-To: John_Sauter@systemeyescomputerstore.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0499691425675409006=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob19.registeredsite.com (atl4mhob19.registeredsite.com
 [209.17.115.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D6DDD266847
 for <alsa-devel@alsa-project.org>; Sat, 24 Jun 2017 10:39:26 +0200 (CEST)
Received: from mailpod1.hostingplatform.com ([10.30.71.113])
 by atl4mhob19.registeredsite.com (8.14.4/8.14.4) with ESMTP id v5O8dND4043473
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
 for <alsa-devel@alsa-project.org>; Sat, 24 Jun 2017 04:39:23 -0400
In-Reply-To: <mailman.1530.1498285564.896.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: scott.gilliland@gatech.edu
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0499691425675409006==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-EbjP9nD2zXkIRRAcM3Oi"


--=-EbjP9nD2zXkIRRAcM3Oi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> Date: Fri, 23 Jun 2017 18:35:03 +0000
> From: "Gilliland, Scott M" <scott.gilliland@gatech.edu>
> To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Subject: [alsa-devel] [PATCH] Fix bug in arecord --max-file-time
> where
> 	the file size could overflow 32 bits
> Message-ID:
> 	<CY4PR07MB3544F3467606CB0401C3F0918DD80@CY4PR07MB3544.namprd07.
> prod.outlook.com>
> =09
> Content-Type: text/plain; charset=3D"iso-8859-1"
>=20
> From: Scott Gilliland <scott.gilliland@gatech.edu>
>=20
> Fix bug in arecord --max-file-time where the file size could overflow
> 32 bits
>=20
> Signed-off-by: Scott Gilliland <scott.gilliland@gatech.edu>
> ---
> =C2=A0aplay/aplay.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/aplay/aplay.c b/aplay/aplay.c
> index f793c82..00af662 100644
> --- a/aplay/aplay.c
> +++ b/aplay/aplay.c
> @@ -3027,7 +3027,7 @@ static void capture(char *orig_name)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (count =3D=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0count =3D LLONG_MAX;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* compute the number of =
bytes per file */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0max_file_size =3D max_file_tim=
e *
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0max_file_size =3D (long long) =
max_file_time *
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0snd_pcm_format_size(hwparams.format,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hwpara=
ms.rate *
> hwparams.channels);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* WAVE-file should be ev=
en (I'm not sure), but wasting one
> byte
> --=C2=A0
> 2.11.0

Thank you for fixing this bug, which I introduced in 2010 through
failing to understand the type conversion rules of C.

Acked-by: John Sauter <John_Sauter@systemeyescomputerstore.com>

--=20
PGP fingerprint=C2=A0E24A D25B E5FE 4914 A603 =C2=A049EC 7030 3EA1 9A0B 511=
E

--=-EbjP9nD2zXkIRRAcM3Oi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZTiU5AAoJEHAwPqGaC1EeOVkH/iGv0Cz9EL3q2UZVthTyDgzc
vq+W6fn5ArcFg9NlrQaDzbLaurvoUhUtuzeWjsQls9Oz37LMhlPHn9QpGkh5GBTY
eHsFPM99X7Auk6R1CsgxfAExSsjEtMg5dzcYZcD7J6ZxBcPfsmccLqJVOujb7sXf
fWGRARGTSz7ODU4RfFfPfhVGL6f2rYZbPgnoCEpai4BWK2Hhl8lENORFg9euQBe4
hekqdXaJijiX1oYsPVmTSgBqsLdLf+/Q2iO2RaeLXArzugIGORLHcMUmbKCP7J29
dvr4K8SolaAW9Kq72je7v1eSEhoFDIJSmhpfTRCm0eEvGQUoK8CSDuzAfVzawto=
=IPlZ
-----END PGP SIGNATURE-----

--=-EbjP9nD2zXkIRRAcM3Oi--


--===============0499691425675409006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0499691425675409006==--
