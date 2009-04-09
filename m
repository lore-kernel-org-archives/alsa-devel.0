From: Mackenzie Morgan <macoafi@gmail.com>
Subject: Re: Ubuntu sound problem -
	http://ubuntuforums.org/showthread.php?t=1073090
Date: Thu, 9 Apr 2009 13:36:13 -0400
Message-ID: <200904091336.17912.macoafi@gmail.com>
References: <BLU132-W46435E073082F30B96BF12C4830@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5646303381237626789=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id B1C5F1037F0
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 19:36:31 +0200 (CEST)
Received: by qyk38 with SMTP id 38so1247356qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2009 10:36:30 -0700 (PDT)
In-Reply-To: <BLU132-W46435E073082F30B96BF12C4830@phx.gbl>
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

--===============5646303381237626789==
Content-Type: multipart/signed;
  boundary="nextPart2244710.iOaAdvZPoo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2244710.iOaAdvZPoo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 09 April 2009 12:19:42 pm jesse fillion wrote:
> "[code]#> ./configure --enable-dynamic-minors
> #> make"
>=20
> winblows@ubuntu:~/Desktop/AlsaDriver/alsa-driver$ make
> make dep
> make[1]: Entering directory `/home/winblows/Desktop/AlsaDriver/alsa-drive=
r'
> make[2]: Entering directory `/home/winblows/Desktop/AlsaDriver/alsa-
driver/acore'
> copying file alsa-kernel/core/info.c
> /home/winblows/Desktop/AlsaDriver/alsa-driver/utils/patch-alsa: 24: patch=
:=20
not found
> make[2]: *** [info.c] Error 1
> make[2]: Leaving directory `/home/winblows/Desktop/AlsaDriver/alsa-
driver/acore'
> make[1]: *** [dep] Error 1
> make[1]: Leaving directory `/home/winblows/Desktop/AlsaDriver/alsa-driver'
> make: *** [include/sndversions.h] Error 2
>=20
> #> sudo make install-modules
>=20
> This is where my noobishness may shine through. I wasn't quite sure what =
to=20
take from the make process above so I continued...

"It didn't work" would be the immediate thing to take from "Error" but othe=
r=20
than that, you're missing the command "patch" so install the "patch" packag=
e.

=2D-=20
Mackenzie Morgan
http://ubuntulinuxtipstricks.blogspot.com
apt-get moo

--nextPart2244710.iOaAdvZPoo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkneMg0ACgkQojm3DbyNMmlFwACfd6nq3dQph4oDrkqv745P4l2p
jXEAoMDgjft9yF/WqOFWil7FLC5+qxaJ
=0MVe
-----END PGP SIGNATURE-----

--nextPart2244710.iOaAdvZPoo--

--===============5646303381237626789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5646303381237626789==--
