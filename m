From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: snd-hda-intel and MSI
Date: Wed, 23 Sep 2009 19:06:35 +0200
Message-ID: <20090923170635.GD4488@aragorn.home.lxtec.de>
References: <20090923143306.GC4488@aragorn.home.lxtec.de>
	<s5hpr9hzmx0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2537884264618915911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C299103891
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 19:06:43 +0200 (CEST)
In-Reply-To: <s5hpr9hzmx0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, 547994@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--===============2537884264618915911==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Takashi Iwai [090923 17:43 +0200]
> At Wed, 23 Sep 2009 16:33:06 +0200,
> Elimar Riesebieter wrote:
> >=20
> > Hi folks,
> >=20
> > are there any contradictions to enable-msi=3D1 by default?
>=20
> MSI is broken on some platforms.  IIRC, almost all non-Intel platforms
> didn't work until the recent ones.  So, it can't be enabled blindly as
> default, unfortunately.
>=20
> > There are
> > users with chips like an
> >=20
> > 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio C=
ontroller (rev 03)
> >         Subsystem: Hewlett-Packard Company Device 30f7
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0, Cache Line Size: 64 bytes
> >         Interrupt: pin B routed to IRQ 33
> >         Region 0: Memory at dc500000 (64-bit, non-prefetchable) [size=
=3D16K]
> >         Capabilities: <access denied>
> >         Kernel driver in use: HDA Intel
> >=20
> > which only works with MSI. And it is somewhat hard to find the appropri=
ate
> > Documantation in HD-Audio.txt.
>=20
> A patch is always welcome.

Which QUIRK Table. What informations from the soundcard ist needed
and how to get it?

Elimar


--=20
  Planung:
  Ersatz des Zufalls durch den Irrtum.
                                -unknown-

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkq6VZoACgkQ3Ig8bsVPf7AHDQCghhn6X0WGNS7NOa93Z5Z1oDse
J8MAn11MoJ3V7xYC7y6Madxg84NSAJ8F
=a2MR
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--

--===============2537884264618915911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2537884264618915911==--
