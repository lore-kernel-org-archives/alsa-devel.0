From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: xenU/x86_64: error: incompatible type for argument 1 of 'pud_val'
Date: Tue, 4 Apr 2006 13:15:57 +0200
Message-ID: <20060404111557.GS24961@neu.nirvana>
Reply-To: alsa-devel <alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zn93sY2JrH9m7VZ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to build rpms for alsa 1.0.11rc4 for several
distributions/arch in the RHEL/Fedora Core world and came across the
following issue:

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

That's on FC5/x86_64 building for the kernel flavour xenU
(guest). Building for FC5/i386 works.

Thanks!
--=20
Axel.Thimm at ATrpms.net

--6zn93sY2JrH9m7VZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMlVsQBVS1GOamfERAkVLAJ91IT4vEVzL6px573fL45gzgx3XeACeJ2BO
jNINriQDOfKy+9Rl79od0IY=
=LkI4
-----END PGP SIGNATURE-----

--6zn93sY2JrH9m7VZ--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
