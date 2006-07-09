From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: build failures in asihpi (was: ALSA 1.0.12rc1
	release)
Date: Mon, 10 Jul 2006 00:31:20 +0200
Message-ID: <20060709223120.GE27639__7157.35314083776$1152524882$gmane$org@neu.nirvana>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
	<200607022100.58844.linux@blennerhassett.gen.nz>
	<20060702123404.GI5158@neu.nirvana>
	<200607101021.35954.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2092554060=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C200A19D
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 11:47:20 +0200 (MEST)
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	F21D899CB8 for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 00:31:25 +0200 (MEST)
In-Reply-To: <200607101021.35954.linux@blennerhassett.gen.nz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Cc: ATrpms development list <atrpms-devel@ATrpms.net>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2092554060==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2006 at 10:21:35AM +1200, Eliot Blennerhassett wrote:
> On Mon, 03 Jul 2006 00:34, Axel Thimm wrote:
> > On Sun, Jul 02, 2006 at 09:00:58PM +1200, Eliot Blennerhassett wrote:
> > > On Sun, 02 Jul 2006 11:17, Axel Thimm wrote:
> > > > I'm having troubles compiling this on x86_64 distributions (from
> > > > 2.6.10 to 2.6.17 based kernels). The build fails on asihpi...
> > >
> > > Currently asihpi does not support x86_64.     Sorry.
> > >
> > > The Kconfig for asihpi does say:
> > > depends on SND && X86 && !X86_64
> > > (hmm, perhaps the ordinary make system doesn't know about this)
> >
> > You mean asihpi uses some next generation Kconfig?
>=20
> No, just ordinary Kconfig.
>=20
> > So how do I turn asihpi off?
>=20
> AFAIK the "depends on SND && X86 && !X86_64"  should result in asihpi not=
=20
> being built on x86_64.   Have you figured out why this doesn't work?

No.

> CS5535 driver in alsa-kernel has the same depends - does it work (i.e. dr=
iver=20
> is not built)?

Comparing to the i686 build this driver is built after asihpi, so I
can't say, the build broke before getting as far.

> I'm not sure what the problem with asihpi is, but the short term answer i=
s to=20
> fix the Kconfig or other part of build system to force it not to be built=
 for=20
> X86_64.

I'll probably patch it out of the builds when I'll redo the packaging.
--=20
Axel.Thimm at ATrpms.net

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEsYO4QBVS1GOamfERAqVxAJ9kjBIPge2bky8Iajd9nZlTrzZILACfQxv3
EagVGoMvF1zAjlPUIc7MhsA=
=ganP
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--


--===============2092554060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============2092554060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2092554060==--
