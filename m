From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] snd-fm801: Add PCI ID for Gallant Odyssey Sound 4
Date: Sun, 10 Apr 2005 20:14:59 +0400
Message-ID: <20050410161459.GB2101@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Gallant Odyssey Sound 4 card is based on the ForteMedia FM801
chip, but has a different PCI ID.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- alsa-driver-1.0.9rc2/alsa-kernel/pci/fm801.c.fm801-more-ids	2005-04-10 =
20:04:03 +0400
+++ alsa-driver-1.0.9rc2/alsa-kernel/pci/fm801.c	2005-04-10 20:04:44 +0400
@@ -195,6 +195,7 @@ struct _snd_fm801 {
=20
 static struct pci_device_id snd_fm801_ids[] =3D {
 	{ 0x1319, 0x0801, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8=
, 0xffff00, 0, },   /* FM801 */
+	{ 0x5213, 0x0510, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8=
, 0xffff00, 0, },   /* Gallant Odyssey Sound 4 */
 	{ 0, }
 };
=20

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCWVEDW82GfkQfsqIRAgl3AJ9xNNSl+IaSwS19TRV6Fs3tORDuDgCfZcGl
0fZYN/ULqizRmz3shIZBZ9E=
=SBSh
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
