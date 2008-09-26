From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: HP laptop quirk
Date: Fri, 26 Sep 2008 10:37:03 -0400
Message-ID: <48DCF38F.5080606@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 315B02438B
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:37:10 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added HP laptop SND_PCI_QUIRK for STAC_HP_M4.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..7db954a 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -1650,6 +1650,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x361a,
+				"unknown HP", STAC_HP_M4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
 				"unknown Dell", STAC_DELL_M4_1),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
