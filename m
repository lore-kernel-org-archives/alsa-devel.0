From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: ALSA 1.0.12rc2
Date: Wed, 9 Aug 2006 13:13:19 +0200
Message-ID: <20060809111319.GD31959@neu.nirvana>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0961620532=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B35E621C
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Aug 2006 13:13:23 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0961620532==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 04, 2006 at 04:01:26PM +0200, Jaroslav Kysela wrote:
> 	1.0.12rc2 ALSA packages (except tools and oss - no changes) were=20
> released. The list of changes can be obtained here:

I tried to build on several FC/RHEL platforms, there are some new
failures wrt rc1:

a) all 2.4. kernel platforms (but probably more binutils related):
   Starting with pcm_oss.o it fails on assembly

{standard input}:5744: Warning: rest of line ignored; first ignored charact=
er is `"'
{standard input}:5745: Error: unknown pseudo-op: `.text.lock.'

b) on 2.6.10/x86_64:

  CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/ioctl32.o
  CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32.o
In file included from /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32.c=
:16:
/builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32_new.c: In function `snd=
_pcm_info_ioctl32':
/builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32_new.c:409: error: struc=
ture has no member named `no_mmap_ctrl'
make[4]: *** [/builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32.o] Error 1

c) on 2.6.17/x86_64 xen guest kernels:

  CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.o
/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c: In function 'snd_co=
mpat_vmalloc_to_page':
/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:40: error: implicit =
declaration of function 'VMALLOC_VMADDR'
/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:45: error: incompati=
ble type for argument 1 of 'pud_val'
/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:46: error: implicit =
declaration of function 'pte_offset'
/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:46: warning: assignm=
ent makes pointer from integer without a cast
make[3]: *** [/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.o] Error=
 1


--=20
Axel.Thimm at ATrpms.net

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2cNPQBVS1GOamfERAkSwAJ9IXaiLcFqKxMyjSn8BWMwgxX/OYwCeJB+2
OsHxnXuTKfr1jag3JaGei8c=
=LtlS
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--


--===============0961620532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0961620532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0961620532==--
