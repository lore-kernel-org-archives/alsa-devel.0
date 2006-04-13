From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: alsa/xenU/x86_64
Date: Thu, 13 Apr 2006 23:42:35 +0200
Message-ID: <20060413214235.GC23511@neu.nirvana>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (junior.physik.fu-berlin.de [160.45.32.227])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 23A5BF9
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 23:42:40 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

alsa builds OK for xen0 (the host kernel), also on xenU (guest
kernels) for i386, but fails on XenU for x86_64:

  CC [M]  /builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.o
/builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c: In function 'snd_co=
mpat_vmalloc_to_page':
/builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:40: warning: implici=
t declaration of function 'VMALLOC_VMADDR'
/builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:45: error: incompati=
ble type for argument 1 of 'pud_val'
/builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:46: warning: implici=
t declaration of function 'pte_offset'
/builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.c:46: warning: assignm=
ent makes pointer from integer without a cast
make[3]: *** [/builddir/alsa-driver-1.0.11rc4/acore/memory_wrapper.o] Error=
 1

Thanks!
--=20
Axel.Thimm at ATrpms.net

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEPsXLQBVS1GOamfERAgDdAJ97m8k4v+YLsS/zXB5iu7WJK9WgIgCfeaDk
bSKag66EU53cB5DYCdFNppA=
=ExKO
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
