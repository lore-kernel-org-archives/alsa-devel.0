From: Tony Vroon <tony@linx.net>
Subject: [PATCH] Compaq Presario CQ60 patching for Conexant
Date: Wed, 27 May 2009 21:00:41 +0100 (BST)
Message-ID: <20090527200041.858C510080@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D63D24356
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 22:00:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A docking mic control is shown by default. The Compaq Presario 
CQ60 laptop has no docking connector, so designate it as a 
CXT5051_HP model.
This makes the phantom mixer slider disappear.

Signed-off-by: Tony Vroon <tony@linx.net>

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 56ce19e..4fcbe21 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1848,6 +1848,7 @@ static const char *cxt5051_models[CXT5051_MODELS] = {
 
 static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30cf, "HP DV6736", CXT5051_HP_DV6736),
+	SND_PCI_QUIRK(0x103c, 0x360b, "Compaq Presario CQ60", CXT5051_HP),
 	SND_PCI_QUIRK(0x14f1, 0x0101, "Conexant Reference board",
 		      CXT5051_LAPTOP),
 	SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),
