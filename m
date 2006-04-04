From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: xenU/x86_64: error: incompatible type for argument 1 of 'pud_val'
Date: Tue, 4 Apr 2006 22:10:12 +0200
Message-ID: <20060404201012.GX24961@neu.nirvana>
References: <20060404111557.GS24961@neu.nirvana> <s5hodzh72z4.wl%tiwai@suse.de>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcaUvQ23gCOmDTXi"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hodzh72z4.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--ZcaUvQ23gCOmDTXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2006 at 05:52:15PM +0200, Takashi Iwai wrote:
> At Tue, 4 Apr 2006 13:15:57 +0200,
> Axel Thimm wrote:
> >=20
> > Hi,
> >=20
> > I'm trying to build rpms for alsa 1.0.11rc4 for several
> > distributions/arch in the RHEL/Fedora Core world and came across the
> > following issue:
> >=20
> >   CC [M]  /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.o
> > /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c: In function 'sn=
d_compat_vmalloc_to_page':
> > /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:40: warning: imp=
licit declaration of function 'VMALLOC_VMADDR'
> > /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:45: error: incom=
patible type for argument 1 of 'pud_val'
> > /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:46: warning: imp=
licit declaration of function 'pte_offset'
> > /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:46: warning: ass=
ignment makes pointer from integer without a cast
> >=20
> > That's on FC5/x86_64 building for the kernel flavour xenU
> > (guest). Building for FC5/i386 works.
>=20
> vmalloc_to_page() should exist in linux/mm.h in the case of 2.6
> kernel.  Check config.log whether configure properly detected the
> function or not.

The check failed due to

configure:7067: checking for vmalloc_to_page
configure:7098: /usr/bin/gcc -c -Wall -fno-strict-aliasing -O2 -g -pipe -Wa=
ll -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -fstack-protector --param=3Dssp-b=
uffer-size=3D4 -m64 -mtune=3Dgeneric -I/kernel/include  -nostdinc -iwithpre=
fix include -DKBUILD_BASENAME=3D"dummy"  conftest.c >&5
In file included from /kernel/include/linux/smp.h:19,
                 from /kernel/include/linux/sched.h:26,
                 from /kernel/include/linux/mm.h:4,
                 from conftest.c:26:
/kernel/include/asm/smp.h: In function 'hard_smp_processor_id':
/kernel/include/asm/smp.h:78: warning: implicit declaration of function 'GE=
T_APIC_ID'
/kernel/include/asm/smp.h:78: error: 'APIC_BASE' undeclared (first use in t=
his function)
/kernel/include/asm/smp.h:78: error: (Each undeclared identifier is reporte=
d only once
/kernel/include/asm/smp.h:78: error: for each function it appears in.)
/kernel/include/asm/smp.h:78: error: 'APIC_ID' undeclared (first use in thi=
s function)
/kernel/include/asm/smp.h: In function 'cpu_present_to_apicid':
/kernel/include/asm/smp.h:113: error: 'BAD_APICID' undeclared (first use in=
 this function)
/kernel/include/asm/smp.h: In function 'logical_smp_processor_id':
/kernel/include/asm/smp.h:136: warning: implicit declaration of function 'G=
ET_APIC_LOGICAL_ID'
/kernel/include/asm/smp.h:136: error: 'APIC_BASE' undeclared (first use in =
this function)
/kernel/include/asm/smp.h:136: error: 'APIC_LDR' undeclared (first use in t=
his function)
configure:7104: $? =3D 1


--=20
Axel.Thimm at ATrpms.net

--ZcaUvQ23gCOmDTXi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMtKkQBVS1GOamfERAsIKAJ44NvPpW7QZQUQE9SZnI0Y8McjKFwCffch6
olOrQY6PtfIZ1egKX2TR37w=
=sK6t
-----END PGP SIGNATURE-----

--ZcaUvQ23gCOmDTXi--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
