From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Since kernel-2.6.32, alsactl fails to restore defaults
Date: Sun, 14 Feb 2010 15:05:07 +0100
Message-ID: <1266156307.23964.3.camel@localhost.localdomain>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6633856476473951121=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp01.jazztel.es (smtp01.jazztel.es [62.14.3.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 54FD224390
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 15:05:15 +0100 (CET)
Received: from [87.222.150.26] (helo=[192.168.1.201])
	by smtp01.jazztel.es with esmtpa (Exim 4.69)
	(envelope-from <pacho@condmat1.ciencias.uniovi.es>)
	id 1Ngf60-0003ii-Ta
	for alsa-devel@alsa-project.org; Sun, 14 Feb 2010 15:05:13 +0100
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


--===============6633856476473951121==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-HbM4mTJ3o4ulP53iWfwh"


--=-HbM4mTJ3o4ulP53iWfwh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I originally reported this issue downstream to:
http://bugs.gentoo.org/show_bug.cgi?id=3D299362=20

Later to kernel:
http://bugzilla.kernel.org/show_bug.cgi?id=3D15107=20

And they told me that this is an alsactl issue, since it's not exiting
with 0 when it notices that the device doesn't need special quirks:
# alsactl -f /var/lib/alsa/asound.state restore
Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
"0x1415"
Hardware is initialized using a guess method
# echo $?
157

What could I do? Thanks for helping me, if you need more information,
simply ask me for it :-)


--=-HbM4mTJ3o4ulP53iWfwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt4AxMACgkQCaWpQKGI+9SOzwCfWqQ+pksJh9LNR8hll2h44YyZ
uLUAnRZ6uIcnbuBnVO3DrUB3ICINV09u
=HiMS
-----END PGP SIGNATURE-----

--=-HbM4mTJ3o4ulP53iWfwh--


--===============6633856476473951121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6633856476473951121==--
