From: Werner Van Belle <werner@yellowcouch.org>
Subject: Closing alsa devices after forking off children
Date: Fri, 27 Mar 2009 17:13:24 +0100
Message-ID: <49CCFB24.5020100@yellowcouch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4771748664458760705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 91CD41038AF
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:12:52 +0100 (CET)
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
--===============4771748664458760705==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3EA28D3F689201F1BF44C00A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EA28D3F689201F1BF44C00A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I'm currently trying to figure out why a close of the alsa device is not
realized 'quickly'. That is it seems to take 2 to 3 seconds before I can
reopen the device in anopther program. After observing this behavior
somewhat I figured out that opening an alsa device and then forking off
a process will keep the alsa device open until the child dies, even when
the parent process closes the alsa device.

Is this behavior known and if so how can I work around this ?

I tried to use pthread_atfork to close the device in the forked off
child, but that closes the device in the parent process as well, so I
would rather want to unlink the device in such a way that the close call
does not need to wait until all children have given up their handle.

With kind regards,

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enig3EA28D3F689201F1BF44C00A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknM+yQACgkQYJM5sO5rAR1NVACgop519CGscXof+styO2mhH9aa
vIMAnROiBLYPe2xmjzW+zF3ViXEiqYHt
=AsuN
-----END PGP SIGNATURE-----

--------------enig3EA28D3F689201F1BF44C00A--

--===============4771748664458760705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4771748664458760705==--
