From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: ALSA 1.0.13rc2 release
Date: Tue, 19 Sep 2006 23:50:11 +0200
Message-ID: <1158702611.2360.4.camel@osmosis.gnet.eu>
References: <Pine.LNX.4.61.0609151756270.7856@tm8103.perex-int.cz>
	<s5h7izzj4bt.wl%tiwai@suse.de>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1869014965=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from aa012msr.fastwebnet.it (85-18-95-72.ip.fastwebnet.it
	[85.18.95.72])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40972175
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Sep 2006 23:50:16 +0200 (MEST)
In-Reply-To: <s5h7izzj4bt.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1869014965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NjLEYtU06rz01+7xao+3"


--=-NjLEYtU06rz01+7xao+3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Setting the disable_msi=3D1 option changed nothing.
My soundcard didn't work before and neither now.

Cheers,

Andrea

On Tue, 2006-09-19 at 16:53 +0200, Takashi Iwai wrote:
> At Fri, 15 Sep 2006 17:58:46 +0200 (CEST),
> Jaroslav Kysela wrote:
> >=20
> > Hi,
> >=20
> > 	almost all ALSA packages were released with version number=20
> > 1.0.13rc2. The changelog can be obtained here:
> >=20
> > http://www.alsa-project.org/changes/v1-0-13rc1--v1-0-13rc2.txt
>=20
> If you encounter problems with hda-intel driver in 1.0.13rc* release,
> please try to add "disable_msi=3D1" module option.  The new version
> tries to use MSI, and MSI support seems broken on some kernels.
>=20
> If this problem occurs in many systems, I'll disable MSI per default
> in 1.0.13-final.  So, let me know now -- before too late.
>=20
>=20
> Takashi
>=20
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=20
Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>

--=-NjLEYtU06rz01+7xao+3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFEGYToIXRn+fZcV0RAnDPAKDaVzlTbl2qzlEzkfUseWZpAXGEuACdEAp6
GmO7ZejBrS555pt5EC1u/+c=
=1SAb
-----END PGP SIGNATURE-----

--=-NjLEYtU06rz01+7xao+3--



--===============1869014965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1869014965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1869014965==--
