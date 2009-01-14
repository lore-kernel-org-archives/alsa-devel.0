From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: fixed invalid value for SND_PCI_QUIRK
Date: Wed, 14 Jan 2009 13:37:43 -0500
Message-ID: <496E30F7.8090205@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 976D9103843
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 19:37:55 +0100 (CET)
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

Changed invalid STAC_92HD71BXX_REF value for reference board SND_PCI_QUIRK to
correct STAC_92HD83XXX_REF.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 35b83dc..a4e2d8f 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -1682,7 +1682,7 @@ static const char *stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
 static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
-		      "DFI LanParty", STAC_92HD71BXX_REF),
+		      "DFI LanParty", STAC_92HD83XXX_REF),
 	{} /* terminator */
 };
