From: Roman I Khimov <khimov@3os.ru>
Subject: [PATCH] VIA DXS whitelist for MiTAC notebook (ALSA)
Date: Fri, 04 Mar 2005 02:25:48 +0300
Message-ID: <1109892347.13458.113.camel@rik-note.loc>
Reply-To: khimov@3os.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TUUVI+3wJTAh9JkzMLRz"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--=-TUUVI+3wJTAh9JkzMLRz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Adds MiTAC S2054S DXS whitelist entry in VIA sound driver (ALSA).

Signed-off-by: Roman I Khimov <khimov@3os.ru>

--- linux-2.6.11/sound/pci/via82xx.c.old	2005-03-04 01:14:27.774913928 +030=
0
+++ linux-2.6.11/sound/pci/via82xx.c	2005-03-04 01:16:00.290849368 +0300
@@ -2106,6 +2106,7 @@ static int __devinit check_dxs_list(stru
 		{ .vendor =3D 0x1043, .device =3D 0x80b0, .action =3D VIA_DXS_NO_VRA }, =
/* ASUS A7V600 & K8V*/=20
 		{ .vendor =3D 0x1071, .device =3D 0x8375, .action =3D VIA_DXS_NO_VRA }, =
/* Vobis/Yakumo/Mitac notebook */
 		{ .vendor =3D 0x10cf, .device =3D 0x118e, .action =3D VIA_DXS_ENABLE }, =
/* FSC laptop */
+		{ .vendor =3D 0x1106, .device =3D 0x3059, .action =3D VIA_DXS_NO_VRA }, =
/* MiTAC S2054S notebook */
 		{ .vendor =3D 0x1106, .device =3D 0x4161, .action =3D VIA_DXS_NO_VRA }, =
/* ASRock K7VT2 */
 		{ .vendor =3D 0x1106, .device =3D 0x4552, .action =3D VIA_DXS_NO_VRA }, =
/* QDI Kudoz 7X/600-6AL */
 		{ .vendor =3D 0x1106, .device =3D 0xaa01, .action =3D VIA_DXS_NO_VRA }, =
/* EPIA MII */

--=20
  Roman.
http://www.3os.ru/   http://www.osrc.info/
gpg --recv-keys 0xE5E055C3

--=-TUUVI+3wJTAh9JkzMLRz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: =?koi8-r?Q?=FC=D4=C1?= =?koi8-r?Q?_=DE=C1=D3=D4=D8?=
	=?koi8-r?Q?_=D3=CF=CF=C2=DD=C5=CE=C9=D1?=
	=?koi8-r?Q?_=D0=CF=C4=D0=C9=D3=C1=CE=C1?=
	=?koi8-r?Q?_=C3=C9=C6=D2=CF=D7=CF=CA?=
	=?koi8-r?Q?_=D0=CF=C4=D0=C9=D3=D8=C0?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCJ5z6XJ70z+XgVcMRAhBvAJ49snzciIr0gIp/DuwSOrT8LJAf/ACdFGQ+
6aD7Nz21NVrwX7ys9oqW3D8=
=2g3r
-----END PGP SIGNATURE-----

--=-TUUVI+3wJTAh9JkzMLRz--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
