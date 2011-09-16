From: Forest Bond <forest@alittletooquiet.net>
Subject: VT1708 clicks & pops
Date: Fri, 16 Sep 2011 16:36:01 -0400
Message-ID: <20110916203601.GD8309@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8872822880116043757=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 13B6A10381B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 22:36:05 +0200 (CEST)
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


--===============8872822880116043757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have two boards with a VT1708:

* VIA EPIA EX15000G
* VIA VB8002

I'm using VLC to play audio via PulseAudio to the analog outputs.  The VB80=
02
sounds great, but the EX15000G has random pops and clicks in the output.  B=
oth
machines are running exactly the same configuration (they are using the same
pre-built OS image).

I've tested on the EX15000G using a few different driver versions.  One is
essentially the version from Ubuntu 10.04, but rebuilt due to unrelated ker=
nel
changes.  The other is alsa-driver snapshot
alsa-driver-1.0.24.72.g7c48f.1314.geb1d0.

You can find output from alsa-info.sh as follows:

EX15000G (using Ubuntu 10.04 driver):
http://www.alsa-project.org/db/?f=3Dea56226a7917391d6adf9078650d3a9395f51b17

EX15000G (using driver from alsa-driver-1.0.24.72.g7c48f.1314.geb1d0):
http://www.alsa-project.org/db/?f=3Dd0265991ec3e975820dc439470aea1df925ca1db

VB8002 (using Ubuntu 10.04 driver):
http://www.alsa-project.org/db/?f=3D611cc772a3fab7552bbda193b6ad7998f66a60fb

Any ideas what the problem might be?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5zszEACgkQRO4fQQdv5Awk5gCgif0n1g7o8SzBXWslHMI+XXQE
q8wAoIsFkBuHqLAat3/FHYtMkpgPpMRa
=lNpG
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--===============8872822880116043757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8872822880116043757==--
