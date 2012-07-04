From: Mohsen Pahlevanzadeh <mohsen@pahlevanzadeh.org>
Subject: static build on two machine
Date: Wed, 04 Jul 2012 16:36:59 +0430
Message-ID: <1341403619.5509.9.camel@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8784628410429925684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.pw-hc.in (static.109.189.63.178.clients.your-server.de
	[178.63.189.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EAEA2448A
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 14:07:03 +0200 (CEST)
Received: from [91.99.8.52] (port=10615 helo=[192.168.1.50])
	by server.pw-hc.in with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.77)
	(envelope-from <mohsen@pahlevanzadeh.org>) id 1SmOMH-0007hK-UU
	for alsa-devel@alsa-project.org; Wed, 04 Jul 2012 16:37:02 +0430
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


--===============8784628410429925684==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-WCbseGGGbHMYdFrpzuoV"


--=-WCbseGGGbHMYdFrpzuoV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear all,

My co-worker built alsa-lib-1.0.25 and now, i should work on this
project, So i get it and compile and compile with the following
commands:
        libtoolize --force --copy --automake
        aclocal
        autoheader
        automake --foreign --copy --add-missing
        autoconf
	./configure --enable-shared=3Dno --enable-static=3Dyes
--prefix=3D/usr/i686 ;make install
Now, When i compile my own software, i get two warning however my
co-worker doesn't get them:
///////////////////////
/usr/i686/lib/libasound.a(pcm_dmix.o):-1: In function
`snd_pcm_dmix_sync_ptr':
pcm_dmix.c:-1: warning: Warning: snd_pcm_hwsync() is deprecated,
consider to use snd_pcm_avail()
/////////////////////////
When i run  my program my program that my co-worker wrote, crashed, But
when he run it, it's crashed.
How can i solve this problem?

--Best regards
Mohsen.

--=-WCbseGGGbHMYdFrpzuoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iJwEAAECAAYFAk/0MeMACgkQBq6ixBojHB8X2AP/e6kTrLzituBbyUEqlzXrvod0
EVid7ngTy0mHnpl27dYTl6qRJwIqfuqHYLjx9miicYEBacn2qJkLwh9QRlKGv1QQ
D7HTWgqnln+crest8u+Dp9pkmqr6HoVLg5/B0gTIN2bHQGNNBaKBe6g05fPNPqAw
qGkqLGt5U5wR4MRRf00=
=cwEA
-----END PGP SIGNATURE-----

--=-WCbseGGGbHMYdFrpzuoV--


--===============8784628410429925684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8784628410429925684==--
