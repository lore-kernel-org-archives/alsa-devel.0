From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] hda-intel: Add position_fix quirk for ASUS
	M2V-MX SE.
Date: Mon, 08 Feb 2010 20:42:46 +0100
Message-ID: <1265658166.3834.35.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6518779468722978368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 1878C24150
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 20:42:48 +0100 (CET)
Received: from f053038078.adsl.alicedsl.de ([78.53.38.78]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NeZVP-0004Xu-NO
	for alsa-devel@alsa-project.org; Mon, 08 Feb 2010 19:42:47 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6518779468722978368==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sQBT7lnHOMBOl2IhzSP+"


--=-sQBT7lnHOMBOl2IhzSP+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With PulseAudio and an application accessing an input device like `gnome-vo=
lume-manager` both have high CPU load as reported in [1].

Loading `snd-hda-intel` with `position_fix=3D1` fixes this issue. Therefore=
 add a quirk for ASUS M2V-MX SE.

The only downside is, when now exiting for example MPlayer when it is playi=
ng an audio file a high pitched sound is outputted by the speaker.

$ lspci -vvnn | grep -A10 Audio
20:01.0 Audio device [0403]: VIA Technologies, Inc. VT1708/A [Azalia HDAC] =
(VIA High Definition Audio Controller) [1106:3288] (rev 10)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8290]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fbffc000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: <access denied>
	Kernel driver in use: HDA Intel

[1] http://sourceforge.net/mailarchive/forum.php?thread_name=3D1265550675.4=
642.24.camel%40mattotaupa&forum_name=3Dalsa-user

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
 sound/pci/hda/hda_intel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 051cf51..22dcdc2 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2264,6 +2264,7 @@ static struct snd_pci_quirk position_fix_list[] __dev=
initdata =3D {
 	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1028, 0x01de, "Dell Precision 390", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x103c, 0x306d, "HP dv3", POS_FIX_LPIB),
+	SND_PCI_QUIRK(0x1106, 0x3288, "ASUS M2V-MX SE", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1462, 0x1002, "MSI Wind U115", POS_FIX_LPIB),
 	{}
--=20
1.6.6.1

--=-sQBT7lnHOMBOl2IhzSP+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktwaTYACgkQPX1aK2wOHVhcEgCfcoTns20HRAiv0r3kCYaMrsQr
ksUAn3Ej8oJtPl2HcwTvQTtCZNy92ztT
=WhL/
-----END PGP SIGNATURE-----

--=-sQBT7lnHOMBOl2IhzSP+--


--===============6518779468722978368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6518779468722978368==--
