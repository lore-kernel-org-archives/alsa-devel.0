From: Prakash Punnoor <prakash@punnoor.de>
Subject: 2.6.19-rc1: hda_intel: azx_get_response timeout,
	switching to polling mode...
Date: Thu, 5 Oct 2006 09:54:57 +0200
Message-ID: <200610050954.57677.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1150387606=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E36A918F
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 09:55:07 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: Linux List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============1150387606==
Content-Type: multipart/signed; boundary="nextPart1389044.0cY7vJJixT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1389044.0cY7vJJixT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I didn't get above message with 2.6.18. Usign irqpoll above message doesn't=
=20
appear, but I think neither it optimal.

The kernel is patched with reiser4 and acpi_skip_timer_override quirk is=20
deactivated (see last link why).

I tried different combinations (dmesg + .config). Differences are mostly pc=
i=20
mt init, irqpoll, nforce eth napi, pata/ide amd driver

http://www.prakash.gmxhome.de/linux/2.6.19-rc1-1.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-2.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-3.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-4.txt.bz2

cat /proc/interrupts for 2.6.18 resp .19-rc1
http://www.prakash.gmxhome.de/linux/irqs18.txt
http://www.prakash.gmxhome.de/linux/irqs19.txt

lspci can be found here:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D2

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1389044.0cY7vJJixT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJLpRxU2n/+9+t5gRAt6ZAKClXC2qp5ybYfgfv3riLsquOE2PZQCg0Ci2
ZnRWsL1tSH/tr7PTznb9llY=
=UUbQ
-----END PGP SIGNATURE-----

--nextPart1389044.0cY7vJJixT--


--===============1150387606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1150387606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1150387606==--
