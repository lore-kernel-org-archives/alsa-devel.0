From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: build failures in asihpi
Date: Mon, 10 Jul 2006 09:37:10 +0200
Message-ID: <20060710073710.GA12073__12464.7851255306$1152524883$gmane$org@neu.nirvana>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
	<200607022100.58844.linux@blennerhassett.gen.nz>
	<20060702123404.GI5158@neu.nirvana>
	<200607101021.35954.linux@blennerhassett.gen.nz>
	<20060709223120.GE27639@neu.nirvana> <44B186D0.1010000@stesmi.com>
Reply-To: ALSA development <alsa-devel@alsa-project.org>,
	ATrpms development list <atrpms-devel@atrpms.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0243080940=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 316991A3
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 11:47:19 +0200 (MEST)
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	EA58199F35 for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 09:37:15 +0200 (MEST)
In-Reply-To: <44B186D0.1010000@stesmi.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>, ATrpms development list <atrpms-devel@atrpms.net>
List-Id: alsa-devel@alsa-project.org


--===============0243080940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2006 at 12:44:32AM +0200, Stefan Smietanowski wrote:
> Axel Thimm wrote:
> > On Mon, Jul 10, 2006 at 10:21:35AM +1200, Eliot Blennerhassett wrote:
> >>On Mon, 03 Jul 2006 00:34, Axel Thimm wrote:
> >>>On Sun, Jul 02, 2006 at 09:00:58PM +1200, Eliot Blennerhassett wrote:
> >>>>On Sun, 02 Jul 2006 11:17, Axel Thimm wrote:
> >>>>>I'm having troubles compiling this on x86_64 distributions (from
> >>>>>2.6.10 to 2.6.17 based kernels). The build fails on asihpi...
> >>>>Currently asihpi does not support x86_64.     Sorry.
> >>>So how do I turn asihpi off?
> >>AFAIK the "depends on SND && X86 && !X86_64"  should result in asihpi n=
ot=20
> >>being built on x86_64.   Have you figured out why this doesn't work?
> > No.
>=20
> Try "depends on SND && X86_32" which sounds like what you're after
> really. The X86 && !X86_64 could be what's confusing.
>=20
> X86 =3D=3D 32 or 64bit.
> X86_32 =3D 32bit
> X86_64 =3D 64bit

Thanks, but that didn't work either.

I finally simply ripped out asihpi and now everything builds for
x86_64, too. The packages will soon be uploaded to ATrpms testing.
--=20
Axel.Thimm at ATrpms.net

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD4DBQFEsgOlQBVS1GOamfERAkpDAJjOmf5xz2JhF1Nlig8dJshG327vAKCVUK3b
9lPr2csIJr8n6aGgTL8F0w==
=Nctd
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


--===============0243080940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0243080940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0243080940==--
