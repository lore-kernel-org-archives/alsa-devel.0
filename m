From: Werner Van Belle <werner@yellowcouch.org>
Subject: Releasing a handle without closing ?
Date: Fri, 22 May 2009 11:44:11 +0200
Message-ID: <4A1673EB.3040500@yellowcouch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6252101846214609066=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 6875310380E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 11:42:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6252101846214609066==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig035F64B1A0A09E96023F1761"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig035F64B1A0A09E96023F1761
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I have an intruiging problem. I have two processes: a parent and a
child. The parent forks off the child (as can be expected, the opposite
would be somewhat unsettling), after it allocated and started to write
to a pcm device. As can be expected, the child will also have a link to
this dsp device. The problem now is that the child wants to release the
pcm handle without closing it. Is there any particular function offering
such possibility ?

Wkr,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enig035F64B1A0A09E96023F1761
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoWc+4ACgkQYJM5sO5rAR1x+QCeJiNMAU2fndKqs8D3kt09U3Zh
zg0AnRn9AMc3+/pJyp9ekkzLvaXf1ETP
=7y/X
-----END PGP SIGNATURE-----

--------------enig035F64B1A0A09E96023F1761--

--===============6252101846214609066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6252101846214609066==--
