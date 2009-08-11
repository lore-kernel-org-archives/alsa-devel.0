From: Tim Blechmann <tim@klingt.org>
Subject: Re: hard freezes with hdsp with cardbus/pci adapter
	card
Date: Tue, 11 Aug 2009 11:47:36 +0200
Message-ID: <4A813E38.5030007@klingt.org>
References: <h5q3ur$13e$1@ger.gmane.org>	<20090811050619.GA12438@pengutronix.de>	<4A811076.6000603@klingt.org>
	<4A811D1B.2020709@klingt.org>
	<20090811092526.GA3163@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3855540679279112727=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id E721024B37
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 11:47:53 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ManxP-0006mI-3r
	for alsa-devel@alsa-project.org; Tue, 11 Aug 2009 09:47:51 +0000
Received: from 85-127-248-0.dynamic.xdsl-line.inode.at ([85.127.248.0])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2009 09:47:51 +0000
Received: from tim by 85-127-248-0.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2009 09:47:51 +0000
In-Reply-To: <20090811092526.GA3163@pengutronix.de>
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
Cc: linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3855540679279112727==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD5C22CB3A3D2DE27D99905B6"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD5C22CB3A3D2DE27D99905B6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2009 11:25 AM, Wolfram Sang wrote:
> Hi Tim,
>=20
>> hm, actually, i think the issue is related to the pci latency of the
>> cardbus controller.
>=20
> Looks like it:
>=20
> http://lkml.indiana.edu/hypermail/linux/kernel/0404.1/0602.html
>=20
> Do you know if the increased latency is needed for all bridges, not jus=
t ENE?
> (I'd assume so...)

i remember that issue, it had different symptoms (distorted sound) ...
the ene bridge seems to be the only cardbus bridge, that requires the
increased latency, but maybe other controllers are just more robust and
don't completely freeze the system

cheers, tim

--=20
tim@klingt.org
http://tim.klingt.org

Happiness is a byproduct of function, purpose, and conflict; those who
seek happiness for itself seek victory without war.
  William S. Burroughs


--------------enigD5C22CB3A3D2DE27D99905B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqBPjgACgkQdL+4qsZfVsub8wCePVS0XpQYZy0HcieQ+gKXZRJI
Y0gAniyy7ImZpr7pxtm1xY4hebUiZp+H
=2HCn
-----END PGP SIGNATURE-----

--------------enigD5C22CB3A3D2DE27D99905B6--


--===============3855540679279112727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3855540679279112727==--
