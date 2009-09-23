From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: snd-hda-intel and MSI
Date: Wed, 23 Sep 2009 16:33:06 +0200
Message-ID: <20090923143306.GC4488@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5233597179363267521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250]) by alsa0.perex.cz (Postfix) with ESMTP id 94ACE2439E
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 16:33:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: 547994@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--===============5233597179363267521==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

are there any contradictions to enable-msi=3D1 by default? There are
users with chips like an

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Contr=
oller (rev 03)
        Subsystem: Hewlett-Packard Company Device 30f7
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 33
        Region 0: Memory at dc500000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel

which only works with MSI. And it is somewhat hard to find the appropriate
Documantation in HD-Audio.txt. 2nd it will be very hard for Distributers to
maintain modul options by chip ID's.

Thanks for cooperation.

Elimar
(one of Debian's alsa maintainers)

--=20
  Do you smell something burning or ist it me?

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkq6MaIACgkQ3Ig8bsVPf7CNFgCeJ69SrvLrRHeEemXLpCP4uIiT
b+EAnReZ93Jwk3hfXBV6rMdDhz/1vysI
=iQQY
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

--===============5233597179363267521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5233597179363267521==--
