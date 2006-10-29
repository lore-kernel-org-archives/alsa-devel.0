From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Enable stereo line input for TAS codec
Date: Sun, 29 Oct 2006 09:31:32 +0100
Message-ID: <1162110692.14051.22.camel@johannes.berg>
References: <17732.10675.757518.888784@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379969656=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF9FF26E
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2006 09:32:45 +0100 (MET)
In-Reply-To: <17732.10675.757518.888784@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mackerras <paulus@samba.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1379969656==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TbK0DzBDCZoK6tVA+JkU"


--=-TbK0DzBDCZoK6tVA+JkU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-29 at 15:10 +1100, Paul Mackerras wrote:
>=20
> +        */
> +       tas->acr &=3D ~(TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL);
>         if (ucontrol->value.enumerated.item[0])
> -               tas->acr |=3D TAS_ACR_INPUT_B;
> +               tas->acr |=3D TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL |
> +                     TAS_ACR_B_MON_SEL_RIGHT;=20

it seems a bit inconsequential to set the B_MON_SEL_RIGHT bit only when
the microphone is selected, but leave it set afterwards. I suppose it
doesn't matter in this case though since only B_MONAURAL (heh, we should
fix that too, I'll make a patch to apply after yours) is buggy.

johannes

--=-TbK0DzBDCZoK6tVA+JkU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARURm4qVg1VMiehFYAQLqmBAAmszOE5yhzk+bYZW+DwpnwPdlOg8+t0xo
Uwi8s1KoVQZdW35bAdP3aZPbT/ByP4LvLVqQ1F7Ho2u72uSLUGrIizSNqeupxnJ8
NXN99fRjYzpqaofdn1Pb3vmIRaWJJxYOrEQRICog1XWNFbt0VCE4Nkc7VRqwX8e7
sGeNXo71Gqo6LoFXH0+4b9ivqbjSgl5CkZB/F6j5YdLVyLuJWg1rhWH0kM6R/42l
yp7Vvxy2+U5TcfMzC7A5lCoYOybQasOxS4NSwFsNJsPY6I5R9ytYxH9aBHmqV+o+
5fgfTu1Qroh0a8D5apzG2VdIU4QsqzRDFDszItncWA1Mme3z/ZAmGZ7x0sq3y0Hr
tzstSAVNbyo5Y+gvw6OBE1GDp4ZH+aWTz7+aY8nhBuJP/ivqpWBYFcAhOCSSdjXf
H4VC6j2+LAiD16RczhemtYhiGy8NHTrymNU5UcoNEvG3/+DHHGOoopX95XeaJwLF
sewgp1DN2DpFJMkc4xSn8h9ZtfnIq40/7s17YZpttBGkD8YJ2f6bIzmqghBU853+
zKNFVH2MIdp7kOjGfoMSCbkjo2hkw8oA1bv6TG3CnHeXVJtQiFUxtd85Nop+OwHl
70kf0Uvh1Y0pD3hziJhmabW8F+GnOk8SHz4Btz/yEzon1HG1kt1xHiPtmKDWd62G
97r+ad0p0QI=
=bDq5
-----END PGP SIGNATURE-----

--=-TbK0DzBDCZoK6tVA+JkU--



--===============1379969656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1379969656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1379969656==--
