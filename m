From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: Splitting up the HDA-INTEL modules
Date: Tue, 15 Jan 2008 19:36:34 +0100
Message-ID: <478CFD32.50405@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0743717904168583716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.velirat.de (velirat.de [85.25.68.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DB122433D
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 19:36:39 +0100 (CET)
Received: from dslb-084-056-012-010.pools.arcor-ip.net ([84.56.12.10]
	helo=[192.168.0.102])
	by www.velirat.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.68) (envelope-from <marco@harddisk.is-a-geek.org>)
	id 1JEqeM-00037K-LR
	for alsa-devel@alsa-project.org; Tue, 15 Jan 2008 19:36:38 +0100
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
--===============0743717904168583716==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDECD9434FA7DEAFC48517DC3"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDECD9434FA7DEAFC48517DC3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

when I looked today through the files of the snd-hda-intel module, I
was a bit shocked by this complex amount of code (patch_realtek.c for
example). I would think about splitting up the code in a way each
chipset gets its own .c file - which will make debugging, patching or
editing a lot easier IMO, and for second people can then comment on
just their specific chipset in config.

What do you think about this?

Marco

PS: If there are no objections, I'll start working on realtek.c on
weekend.


--------------enigDECD9434FA7DEAFC48517DC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHjP02W6S2GapJUuQRAorJAJ9MxD+aX/QqdWbEnx1i8tsXnGslhgCfUH0T
eWP6m5cUxjs4X/DYyeY4u48=
=6vh1
-----END PGP SIGNATURE-----

--------------enigDECD9434FA7DEAFC48517DC3--

--===============0743717904168583716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0743717904168583716==--
