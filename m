From: Travis Place <wishie@wishie.net>
Subject: Fwd: Re: Incorrect model selection for HDA Intel based
	card.
Date: Tue, 20 May 2008 02:07:48 +1000
Message-ID: <200805200207.48247.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UXaMIe4pBYIvQr/"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-101.dial.usertools.net
	[202.137.100.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 2026E24609
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 18:08:08 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 7098C31C83
	for <alsa-devel@alsa-project.org>; Mon, 19 May 2008 16:29:18 +1000 (EST)
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

--Boundary-00=_UXaMIe4pBYIvQr/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Below (as well as attached) is my patch, for the 0x814e variant of the ASUS 
P5GD1 w/SPDIF.


diff -r e2b60934d1c8 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_realtek.c	Tue May 20 01:50:04 2008 +1000
@@ -2981,7 +2981,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	/* SND_PCI_QUIRK(0x1043, 0x1964, "ASUS", ALC880_ASUS_DIG), */
 	SND_PCI_QUIRK(0x1043, 0x1973, "ASUS", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x19b3, "ASUS", ALC880_ASUS_DIG),
-	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS),
+	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS P5GD1 w/SPDIF", ALC880_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8181, "ASUS P4GPL", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST),
 	SND_PCI_QUIRK(0x1043, 0x81b4, "ASUS", ALC880_6ST),

Changelog:

Corrected the model assignment for the ASUS P5GD1 w/SPDIF after reports of 
surround sound not being possible.

Signed-off-by: Travis Place <wishie at wishie dot net>

--Boundary-00=_UXaMIe4pBYIvQr/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="P5GD1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="P5GD1.patch"

diff -r e2b60934d1c8 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_realtek.c	Tue May 20 02:00:37 2008 +1000
@@ -2981,7 +2981,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	/* SND_PCI_QUIRK(0x1043, 0x1964, "ASUS", ALC880_ASUS_DIG), */
 	SND_PCI_QUIRK(0x1043, 0x1973, "ASUS", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x19b3, "ASUS", ALC880_ASUS_DIG),
-	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS),
+	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS P5GD1 w/SPDIF", ALC880_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8181, "ASUS P4GPL", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST),
 	SND_PCI_QUIRK(0x1043, 0x81b4, "ASUS", ALC880_6ST),

--Boundary-00=_UXaMIe4pBYIvQr/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_UXaMIe4pBYIvQr/--
