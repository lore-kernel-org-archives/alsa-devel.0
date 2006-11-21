From: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
Subject: snd_hda_intel 3stack mode for ASUS P5P-L2
Date: Tue, 21 Nov 2006 14:46:34 +0300
Message-ID: <1164109594.3771.2.camel@t94>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2005072423=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
List-Id: alsa-devel@alsa-project.org


--===============2005072423==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2OVCI2N+9L/1I91TKtFZ"


--=-2OVCI2N+9L/1I91TKtFZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello all.

I have ASUS P5PL2 motherboard and it's embedded sound card requires
the following patch which sets "3stack" model to operate properly:

00:1b.0 0403: 8086:27d8 (rev 01)
        Subsystem: 1043:817f
        Flags: bus master, fast devsel, latency 0, IRQ 177
        Memory at dfdf8000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=3D0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

Signed-Off-By: Nickolay V. Shmyrev <nshmyrev@yandex.ru>

--- patch_analog.c	Tue Nov 21 14:11:53 2006
+++ patch_analog.c.new	Tue Nov 21 14:42:26 2006
@@ -798,6 +798,8 @@ static struct hda_board_config ad1986a_c
 	  .config =3D AD1986A_3STACK }, /* ASUS P5RD2-VM / P5GPL-X SE */
 	{ .pci_subvendor =3D 0x1043, .pci_subdevice =3D 0x81cb,
 	  .config =3D AD1986A_3STACK }, /* ASUS M2NPV-VM */
+	{ .pci_subvendor =3D 0x1043, .pci_subdevice =3D 0x817f,
+	  .config =3D AD1986A_3STACK }, /* ASUS P5P-L2 */
 	{ .pci_subvendor =3D 0x17aa, .pci_subdevice =3D 0x1017,
 	  .config =3D AD1986A_3STACK }, /* Lenovo A60 desktop */
 	{ .modelname =3D "laptop",	.config =3D AD1986A_LAPTOP },


--=-2OVCI2N+9L/1I91TKtFZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: =?koi8-r?Q?=FC=D4=C1?= =?koi8-r?Q?_=DE=C1=D3=D4=D8?=
	=?koi8-r?Q?_=D3=CF=CF=C2=DD=C5=CE=C9=D1?=
	=?koi8-r?Q?_=D0=CF=C4=D0=C9=D3=C1=CE=C1?=
	=?koi8-r?Q?_=C3=C9=C6=D2=CF=D7=CF=CA?=
	=?koi8-r?Q?_=D0=CF=C4=D0=C9=D3=D8=C0?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFYucaLCDh4YwOt9kRAu3CAKCONH6y2EtHzqoWvFCFtj9kKFX4bgCfeO74
M4RoM/hpAw0+ZMrxxpazllc=
=KDUK
-----END PGP SIGNATURE-----

--=-2OVCI2N+9L/1I91TKtFZ--



--===============2005072423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2005072423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2005072423==--
