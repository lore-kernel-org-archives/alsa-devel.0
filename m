From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: 2.6.19-rc1: known regressions (v2)
Date: Sun, 8 Oct 2006 01:02:33 +0200
Message-ID: <200610080102.37267.prakash@punnoor.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061007214620.GB8810@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1429860620=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 800D822B
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Oct 2006 01:02:40 +0200 (MEST)
In-Reply-To: <20061007214620.GB8810@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1429860620==
Content-Type: multipart/signed; boundary="nextPart3582523.QVHlDXvm4u";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3582523.QVHlDXvm4u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag 07 Oktober 2006 23:46 schrieb Adrian Bunk:
> Subject    : snd-hda-intel <-> forcedeth MSI problem
> References : http://lkml.org/lkml/2006/10/5/40
> Submitter  : Prakash Punnoor <prakash@punnoor.de>
> Status     : unknown

AFAIK, strictly speaking this is not a regression, but rather a new feature=
=20
breaking: MSI capability of snd-hda-intel. Alsa dev =20
Takashi Iwai doesn't think it is snd-hda-intel doing something wrong, but=20
rather an IRQ routing probem. As such I am not sure who to cc....

While I don't really understand the details, I guess it is due to snd and n=
et=20
sharing the interrupt in "pure" APIC more:

 23:     232796          0   IO-APIC-fasteoi  HDA Intel, eth0

So both are physically on the same INT line? But MSI of snd want to assign=
=20
another IRQ to itself:

 23:       7486          0   IO-APIC-fasteoi  eth0
316:          0          0   PCI-MSI-edge     HDA Intel

So it seems that irq23 still receives signals from snd and thus the nobody=
=20
cared message gets printed.

Thus my work-around is simply to disable MSI of snd by=20
snd-hda-intel.disable_msi=3D1 and all is well again.

So if this cannot be fixed for 2.6.19, I humbly suggest deactivating MSI of=
=20
snd-intel-hda by default.

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3582523.QVHlDXvm4u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKDINxU2n/+9+t5gRAtieAJ0Vw0Lf2L3Vwx8jfYjDbMsRAmtvjACg+T04
5TlyAD/uTPM9eXZ6BMwAY88=
=iQT0
-----END PGP SIGNATURE-----

--nextPart3582523.QVHlDXvm4u--


--===============1429860620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1429860620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1429860620==--
