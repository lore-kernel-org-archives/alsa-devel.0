From: Peter Good <psgood@petesinternet.net>
Subject: Compile error on cs46xx
Date: 01 Nov 2002 17:05:04 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036134304.26344.1.camel@pete>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-e2Fjn3H2f3RG9rZt3y0E"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-e2Fjn3H2f3RG9rZt3y0E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Anyone struck this at all? I've lost most of my archives of this list,
due to a drive failure :/

Regards, Peter.

gcc -D__KERNEL__ -DMODULE=3D1 -I/root/alsa/alsa-driver/include
-I/lib/modules/2.4.19/build/include -O2 -mpreferred-stack-boundary=3D2
-march=3Di686 -malign-functions=3D4 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -pipe -DALSA_BUILD -DCONFIG_SND_CS46XX_NEW_DSP=3D1
-DKBUILD_BASENAME=3Dcs46xx_lib   -c -o cs46xx_lib.o cs46xx_lib.c
In file included from cs46xx_lib.c:2:
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function
`snd_cs46xx_playback_hw_params':
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1051: too many arguments to
function `cs46xx_dsp_create_pcm_channel'
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1075:
`snd_cs46xx_playback_rear_ops' undeclared (first use in this function)
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1075: (Each undeclared
identifier is reported only once
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1075: for each function it
appears in.)
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1077:
`snd_cs46xx_playback_iec958_ops' undeclared (first use in this function)
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1100:
`snd_cs46xx_playback_indirect_rear_ops' undeclared (first use in this
function)
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1102:
`snd_cs46xx_playback_indirect_iec958_ops' undeclared (first use in this
function)
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function
`_cs46xx_playback_open_channel':
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1428: too many arguments to
function `cs46xx_dsp_create_pcm_channel'
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function
`snd_cs46xx_playback_open_iec958':
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1470: warning: implicit
declaration of function `cs46xx_iec958_pre_open'
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function
`snd_cs46xx_playback_close_iec958':
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1483: warning: implicit
declaration of function `cs46xx_iec958_post_close'
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c: At top level:
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1547:
`snd_cs46xx_playback_rear_ops' used prior to declaration
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1558:
`snd_cs46xx_playback_indirect_rear_ops' used prior to declaration
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1570:
`snd_cs46xx_playback_iec958_ops' used prior to declaration
../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1581:
`snd_cs46xx_playback_indirect_iec958_ops' used prior to declaration
make[2]: *** [cs46xx_lib.o] Error 1
make[2]: Leaving directory `/root/alsa/alsa-driver/pci/cs46xx'
make[1]: *** [_modsubdir_cs46xx] Error 2
make[1]: Leaving directory `/root/alsa/alsa-driver/pci'
make: *** [compile] Error 1

--=20
"I am neither especially clever nor especially=20
gifted. I am only very, very curious." Einstein.

Peter Good
Pete's Internet Services
GnuPG Public Key: http://www.petesinternet.net/public.gpg

--=-e2Fjn3H2f3RG9rZt3y0E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9wiegxDSKIXbtT7gRApS/AJ92G+oKnavGxePqXKY9Mg5AdbOlCQCgia6T
J5eMKeIB49G8ogLTF4Eo6a8=
=nYnn
-----END PGP SIGNATURE-----

--=-e2Fjn3H2f3RG9rZt3y0E--



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
