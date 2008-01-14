From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: ALC268 test model not working
Date: Mon, 14 Jan 2008 17:33:18 +0100
Message-ID: <478B8ECE.4020707@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2873127694743973813=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.velirat.de (velirat.de [85.25.68.44])
	by alsa0.perex.cz (Postfix) with ESMTP id CB9E124548
	for <Alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 17:33:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2873127694743973813==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13DE2CC98CC467645337CFED"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13DE2CC98CC467645337CFED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

finally I got the patch applied to kernel src :)
But it doesn't work correctly, because when running alsamixer, dmesg
tells "hda_codec: num_steps =3D 0 for NID=3D0x1d", and alsamixer fails wi=
th
alsamixer: function snd_mixer_load failed: Invalid argument.

Is this some obscure bug in the notebook hardware or some driver bug?

Marco

(note, I apply against .24-rc6 still)


--------------enig13DE2CC98CC467645337CFED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHi47OW6S2GapJUuQRAjknAJwJ1k2aKcUElFnwj2nBQRIx+V6wgwCfQSEM
fn8neG1v1T4aPrLmWPKIF0w=
=dwBe
-----END PGP SIGNATURE-----

--------------enig13DE2CC98CC467645337CFED--

--===============2873127694743973813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2873127694743973813==--
