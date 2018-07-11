From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 2/2] ALSA: hda/ca0132: Update a pci quirk
	device name
Date: Wed, 11 Jul 2018 18:09:46 -0400
Message-ID: <20180711220946.20368-2-alastair.bridgewater@gmail.com>
References: <20180711220946.20368-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180711220946.20368-1-alastair.bridgewater@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

The PCI subsystem in question for this quirk rule has been
identified as a Gigabyte GA-Z170X-Gaming 7 motherboard.  Set the
device name appropriately.

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c803cca1c236..d09422aab2b4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1049,7 +1049,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
-	SND_PCI_QUIRK(0x1458, 0xA036, "Recon3Di", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	{}
 };
 
-- 
2.16.1
