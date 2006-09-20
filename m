From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: ALSA 1.0.13rc2 release
Date: Wed, 20 Sep 2006 11:56:49 +0200
Message-ID: <1158746209.12107.9.camel@osmosis.gnet.eu>
References: <Pine.LNX.4.61.0609151756270.7856@tm8103.perex-int.cz>
	<s5h7izzj4bt.wl%tiwai@suse.de>
	<1158702611.2360.4.camel@osmosis.gnet.eu>
	<s5h3bamhovj.wl%tiwai@suse.de>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801919946=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3bamhovj.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0801919946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HhCrpkPA99XDBeAZBnTJ"


--=-HhCrpkPA99XDBeAZBnTJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-20 at 11:24 +0200, Takashi Iwai wrote:
> At Tue, 19 Sep 2006 23:50:11 +0200,
> Andrea Gozzi wrote:
> >=20
> > Setting the disable_msi=3D1 option changed nothing.
> > My soundcard didn't work before and neither now.
>=20
> That's another problem.  We handle here only regressions.
> (And describe "doesn't work" more exactly, please...)
>=20

Sorry, I tried :)

Basically, the problem is that no sound comes out of the speakers and
you can only hear something from the S/PDIF plug at a very low volume.
The hardware is an Intel ICH7 with ALC260 chipset on a PB V7900 laptop.
I tried every possible configuration but still nothing, so I'm just
waiting for the ALSA release that will fix this.

Thanks anyway,

Andrea


>=20
> Takashi
>=20
> >=20
> > Cheers,
> >=20
> > Andrea
> >=20
> > On Tue, 2006-09-19 at 16:53 +0200, Takashi Iwai wrote:
> > > At Fri, 15 Sep 2006 17:58:46 +0200 (CEST),
> > > Jaroslav Kysela wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > 	almost all ALSA packages were released with version number=20
> > > > 1.0.13rc2. The changelog can be obtained here:
> > > >=20
> > > > http://www.alsa-project.org/changes/v1-0-13rc1--v1-0-13rc2.txt
> > >=20
> > > If you encounter problems with hda-intel driver in 1.0.13rc* release,
> > > please try to add "disable_msi=3D1" module option.  The new version
> > > tries to use MSI, and MSI support seems broken on some kernels.
> > >=20
> > > If this problem occurs in many systems, I'll disable MSI per default
> > > in 1.0.13-final.  So, let me know now -- before too late.
> > >=20
> > >=20
> > > Takashi
> > >=20
> > > ---------------------------------------------------------------------=
----
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to sha=
re your
> > > opinions on IT & business topics through brief surveys -- and earn ca=
sh
> > > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CI=
D=3DDEVDEV
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> >=20
> > --=20
> > Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
> > [2 This is a digitally signed message part <application/pgp-signature (=
7bit)>]
> >=20

--=20
Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>

--=-HhCrpkPA99XDBeAZBnTJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFERBhoIXRn+fZcV0RAroCAJsGgh4spDE3FQSyf3GFl8fJowGO3wCgmVgE
fv6iPzP7fpJRaO+zYhMm7m8=
=KhO/
-----END PGP SIGNATURE-----

--=-HhCrpkPA99XDBeAZBnTJ--



--===============0801919946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0801919946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0801919946==--
