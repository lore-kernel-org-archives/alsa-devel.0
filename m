From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: ALSA 1.0.12rc2
Date: Thu, 10 Aug 2006 17:32:00 +0200
Message-ID: <20060810153200.GB3148@neu.nirvana>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<20060809111319.GD31959@neu.nirvana> <s5hd5baducm.wl%tiwai@suse.de>
	<20060809113618.GE31959@neu.nirvana> <s5h8xlydrwq.wl%tiwai@suse.de>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0436343798=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCAB5184
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Aug 2006 17:32:05 +0200 (MEST)
In-Reply-To: <s5h8xlydrwq.wl%tiwai@suse.de>
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


--===============0436343798==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2006 at 02:17:57PM +0200, Takashi Iwai wrote:
> At Wed, 9 Aug 2006 13:36:18 +0200,
> Axel Thimm wrote:
> >=20
> > On Wed, Aug 09, 2006 at 01:25:13PM +0200, Takashi Iwai wrote:
> > > > c) on 2.6.17/x86_64 xen guest kernels:
> > > >=20
> > > >   CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.o
> > > > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c: In function=
 'snd_compat_vmalloc_to_page':
> > > > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:40: error: i=
mplicit declaration of function 'VMALLOC_VMADDR'
> > > > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:45: error: i=
ncompatible type for argument 1 of 'pud_val'
> > > > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:46: error: i=
mplicit declaration of function 'pte_offset'
> > > > /builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.c:46: warning:=
 assignment makes pointer from integer without a cast
> > > > make[3]: *** [/builddir/alsa-driver-1.0.12rc2/acore/memory_wrapper.=
o] Error 1
> > >=20
> > > This must be because of the failed detection in configure.
> > > Could you show config.log?
> >=20
> > configure:7100: checking for vmalloc_to_page
> > configure:7131: /usr/bin/gcc -c -Wall -fno-strict-aliasing -O2 -g -pipe=
 -Wall -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -fstack-protector --param=3Ds=
sp-buffer-size=3D4 -m64 -mtune=3Dgeneric -I/amd/heretic/0/data_nobkp/bac
> > h/bach-kernel/fc5-x86_64/2.6.17-1.2157_FC5-x86_64-xenU/include  -nostdi=
nc -iwithprefix include -DKBUILD_STR(s)=3D#s -DKBUILD_BASENAME=3DKBUILD_STR=
(dummy)  conftest.c >&5
> > In file included from /builddir/kernel/include/linux/smp.h:19,
> >                  from /builddir/kernel/include/linux/sched.h:26,
> >                  from /builddir/kernel/include/linux/mm.h:4,
> >                  from conftest.c:26:
> > /builddir/kernel/include/asm/smp.h: In function 'hard_smp_processor_id':
> > /builddir/kernel/include/asm/smp.h:79: warning: implicit declaration of=
 function 'GET_APIC_ID'
> > /builddir/kernel/include/asm/smp.h:79: error: 'APIC_BASE' undeclared (f=
irst use in this function)
> > /builddir/kernel/include/asm/smp.h:79: error: (Each undeclared identifi=
er is reported only once
> > /builddir/kernel/include/asm/smp.h:79: error: for each function it appe=
ars in.)
> > /builddir/kernel/include/asm/smp.h:79: error: 'APIC_ID' undeclared (fir=
st use in this function)
> > /builddir/kernel/include/asm/smp.h: In function 'cpu_present_to_apicid':
> > /builddir/kernel/include/asm/smp.h:114: error: 'BAD_APICID' undeclared =
(first use in this function)
> > /builddir/kernel/include/asm/smp.h: In function 'logical_smp_processor_=
id':
> > /builddir/kernel/include/asm/smp.h:137: warning: implicit declaration o=
f function 'GET_APIC_LOGICAL_ID'
> > /builddir/kernel/include/asm/smp.h:137: error: 'APIC_BASE' undeclared (=
first use in this function)
> > /builddir/kernel/include/asm/smp.h:137: error: 'APIC_LDR' undeclared (f=
irst use in this function)
> > configure:7137: $? =3D 1
>=20
> This looks like a bug of asm-x86_64/smp.h.
> The patch (to HG version) below is a workaround for this problem.
> Could you check it?

I tried, it still fails

  CC [M]  /builddir/alsa-driver-1.0.12-hg20060810/acore/memory_wrapper.o
/builddir/alsa-driver-1.0.12-hg20060810/acore/memory_wrapper.c: In function=
 'snd_compat_vmalloc_to_page':
/builddir/alsa-driver-1.0.12-hg20060810/acore/memory_wrapper.c:40: error: i=
mplicit declaration of function 'VMALLOC_VMADDR'
/builddir/alsa-driver-1.0.12-hg20060810/acore/memory_wrapper.c:45: error: i=
ncompatible type for argument 1 of 'pud_val'
/builddir/alsa-driver-1.0.12-hg20060810/acore/memory_wrapper.c:46: error: i=
mplicit declaration of function 'pte_offset'
/builddir/alsa-driver-1.0.12-hg20060810/acore/memory_wrapper.c:46: warning:=
 assignment makes pointer from integer without a cast
--=20
Axel.Thimm at ATrpms.net

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE21FwQBVS1GOamfERAqC1AJ9dygh2QE5m0UTqZ6PRHwCbVaIA0wCgjBfX
PlSpf1qhuL55tttyXakzQR8=
=feSZ
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--


--===============0436343798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0436343798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0436343798==--
