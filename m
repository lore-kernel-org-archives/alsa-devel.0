From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: build failures in asihpi (was: ALSA 1.0.12rc1
	release)
Date: Sun, 2 Jul 2006 14:34:04 +0200
Message-ID: <20060702123404.GI5158@neu.nirvana>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
	<20060701231759.GQ24584@neu.nirvana>
	<200607022100.58844.linux@blennerhassett.gen.nz>
Reply-To: ALSA development <alsa-devel@alsa-project.org>,
	ATrpms development list <atrpms-devel@ATrpms.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0363392623=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 63D8B19D
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 14:34:15 +0200 (MEST)
In-Reply-To: <200607022100.58844.linux@blennerhassett.gen.nz>
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


--===============0363392623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2006 at 09:00:58PM +1200, Eliot Blennerhassett wrote:
> On Sun, 02 Jul 2006 11:17, Axel Thimm wrote:
> > I'm having troubles compiling this on x86_64 distributions (from
> > 2.6.10 to 2.6.17 based kernels). The build fails on asihpi...
>=20
> Currently asihpi does not support x86_64.     Sorry.
>=20
> The Kconfig for asihpi does say:
> depends on SND && X86 && !X86_64
> (hmm, perhaps the ordinary make system doesn't know about this)

You mean asihpi uses some next generation Kconfig?
So how do I turn asihpi off?

> Our next HPI release will be the first to support 64 bit, and we expect A=
LSA=20
> support will follow shortly after that.

Will that be in the 1.0.12 release cycle or thereafter? If it's not
going to make it in 1.0.12 it should be turned off by default.

Currently on x86_64 2.6.17 systems cannot build 1.0.11 anymore and
also 1.0.12rc1 fails. I'm getting bombed with request for packaged
alsa-driver-kmdls. :/

> -- Eliot Blennerhassett
> AudioScience Inc.
--=20
Axel.Thimm at ATrpms.net

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEp708QBVS1GOamfERAm+GAJ9YZZ3Cbxt/IRMtBWbYU/jshhsViQCfYxEw
gHi1fyUp8pGwWWKzsJ4Wego=
=2znJ
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--


--===============0363392623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0363392623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0363392623==--
