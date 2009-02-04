From: Tim Blechmann <tim@klingt.org>
Subject: alsa license question
Date: Wed, 04 Feb 2009 10:07:58 +0100
Message-ID: <49895AEE.1000005@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3055342918043358052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DFD82444A
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 10:10:02 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LUdli-0000qN-7M
	for alsa-devel@alsa-project.org; Wed, 04 Feb 2009 09:10:02 +0000
Received: from 85-127-251-132.dynamic.xdsl-line.inode.at ([85.127.251.132])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 09:10:02 +0000
Received: from tim by 85-127-251-132.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 09:10:02 +0000
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
Cc: Joffrey Heyraud <heyraud@digigram.com>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3055342918043358052==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB5294236A42A2B8CEFAE40FE"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5294236A42A2B8CEFAE40FE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all,

i am currently working on an alsa driver for the digigram lx6464es
interface, based on the sources of the windows driver.

since i would like to include some parts of the windows source code,
(mainly the header files with register declarations) to the alsa driver,
i have a few question:
- is it ok, if these files don't match the coding style of the linux kern=
el?
- digigram assured, that i am allowed to include source code to the
linux driver. most of the files have the copyright notice:
COPYRIGHT (some year) DIGIGRAM. ALL RIGHTS RESERVED.
is this statement ok, or do i need to replace the `ALL RIGHTS RESERVED'
with a gpl-compatible license note?
- is there any repository for alsa driver documentation, provided by the
manufacturer? digigram provided the windows driver for the lx6464es,
mentioning that this source is `freely accessible to the GNU / ALSA
community', so if there is a repository like that, the source package
should probably be archived there.

thanks, tim

--=20
tim@klingt.org
http://tim.klingt.org

Avoid the world, it's just a lot of dust and drag and means nothing in
the end.
  Jack Kerouac


--------------enigB5294236A42A2B8CEFAE40FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmJWvEACgkQdL+4qsZfVsvpSQCaAmWMkICUCDGA5sOWjGwIPZFx
aHAAoIaUzh2o1Pg6zWT9X6brdGuk0Gzc
=uWb5
-----END PGP SIGNATURE-----

--------------enigB5294236A42A2B8CEFAE40FE--


--===============3055342918043358052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3055342918043358052==--
