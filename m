From: Jan Losinski <losinski@wh2.tu-dresden.de>
Subject: Re: Problem and dirty Fix for hda-intel on ALC892
Date: Tue, 22 Mar 2011 00:13:21 +0100
Message-ID: <20110321231321.GA13972@atlantis.wh2.tu-dresden.de.de>
References: <20110321113702.GA15206@atlantis.wh2.tu-dresden.de.de>
	<4D87C6AF.2090906@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0720540928515575106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atlantis.wh2.tu-dresden.de (atlantis.wh2.tu-dresden.de
	[141.30.228.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 89C53103823
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 00:13:21 +0100 (CET)
Received: from localhost (x41a105b.wh16.tu-dresden.de [141.30.216.67])
	by atlantis.wh2.tu-dresden.de (Postfix) with ESMTPSA id 3B77483D0CA
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 00:13:21 +0100 (CET)
In-Reply-To: <4D87C6AF.2090906@canonical.com>
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


--===============0720540928515575106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Henningsson <david.henningsson@canonical.com> [2011-03-21 22:44]:
> Hmm, I made one or two patches in relation to this but they aimed at=20
> moving index 1 to index 0, not the other way around. Could you please=20
> give alsa-info (see wiki.ubuntu.com/Audio/AlsaInfo ) information,=20
> preferably with 2.6.38 (and without your workaround) installed?

Of course, it's located at [1] (2.6.38 without my "fix". Let me know if
you need more information or if you need someone to test).

Jan Losinski

[1] http://www.alsa-project.org/db/?f=3D80bc05cada24ed993c4f964d4188add6d0e=
1dddb

PS1: The tool does not work with LANG=3Dde_DE.UTF-8
PS2: I've subscribed the list ;)


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2H25AACgkQ1Hv7AMjH+2EmLQCdEmNRsMY3uEfALS5IgHM4otMI
AdMAnA9iUMZxtIXJJbT/820SWO35ywt4
=/fXY
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--===============0720540928515575106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0720540928515575106==--
