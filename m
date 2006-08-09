From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: ALSA 1.0.12rc2
Date: Wed, 9 Aug 2006 13:36:18 +0200
Message-ID: <20060809113618.GE31959@neu.nirvana>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<20060809111319.GD31959@neu.nirvana> <s5hd5baducm.wl%tiwai@suse.de>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1857003531=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00FC2234
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Aug 2006 13:36:22 +0200 (MEST)
In-Reply-To: <s5hd5baducm.wl%tiwai@suse.de>
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


--===============1857003531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2006 at 01:25:13PM +0200, Takashi Iwai wrote:
> > c) on 2.6.17/x86_64 xen guest kernels:
> >=20
> >   CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.o
> > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c: In function 'sn=
d_compat_vmalloc_to_page':
> > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:40: error: impli=
cit declaration of function 'VMALLOC_VMADDR'
> > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:45: error: incom=
patible type for argument 1 of 'pud_val'
> > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:46: error: impli=
cit declaration of function 'pte_offset'
> > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:46: warning: ass=
ignment makes pointer from integer without a cast
> > make[3]: *** [/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.o] E=
rror 1
>=20
> This must be because of the failed detection in configure.
> Could you show config.log?

configure:7100: checking for vmalloc_to_page
configure:7131: /usr/bin/gcc -c -Wall -fno-strict-aliasing -O2 -g -pipe -Wa=
ll -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -fstack-protector --param=3Dssp-b=
uffer-size=3D4 -m64 -mtune=3Dgeneric -I/amd/heretic/0/data_nobkp/bac
h/bach-kernel/fc5-x86_64/2.6.17-1.2157_FC5-x86_64-xenU/include  -nostdinc -=
iwithprefix include -DKBUILD_STR(s)=3D#s -DKBUILD_BASENAME=3DKBUILD_STR(dum=
my)  conftest.c >&5
In file included from /builddir/kernel/include/linux/smp.h:19,
                 from /builddir/kernel/include/linux/sched.h:26,
                 from /builddir/kernel/include/linux/mm.h:4,
                 from conftest.c:26:
/builddir/kernel/include/asm/smp.h: In function 'hard_smp_processor_id':
/builddir/kernel/include/asm/smp.h:79: warning: implicit declaration of fun=
ction 'GET_APIC_ID'
/builddir/kernel/include/asm/smp.h:79: error: 'APIC_BASE' undeclared (first=
 use in this function)
/builddir/kernel/include/asm/smp.h:79: error: (Each undeclared identifier i=
s reported only once
/builddir/kernel/include/asm/smp.h:79: error: for each function it appears =
in.)
/builddir/kernel/include/asm/smp.h:79: error: 'APIC_ID' undeclared (first u=
se in this function)
/builddir/kernel/include/asm/smp.h: In function 'cpu_present_to_apicid':
/builddir/kernel/include/asm/smp.h:114: error: 'BAD_APICID' undeclared (fir=
st use in this function)
/builddir/kernel/include/asm/smp.h: In function 'logical_smp_processor_id':
/builddir/kernel/include/asm/smp.h:137: warning: implicit declaration of fu=
nction 'GET_APIC_LOGICAL_ID'
/builddir/kernel/include/asm/smp.h:137: error: 'APIC_BASE' undeclared (firs=
t use in this function)
/builddir/kernel/include/asm/smp.h:137: error: 'APIC_LDR' undeclared (first=
 use in this function)
configure:7137: $? =3D 1

--=20
Axel.Thimm at ATrpms.net

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2ciyQBVS1GOamfERAqhDAJ0RdmMlxciboucAL2Rqwh7DNmy/bgCfaL9g
rWYkf6rH3ALZ1tgi/0t0yE0=
=8ITm
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--


--===============1857003531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1857003531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1857003531==--
