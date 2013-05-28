From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable mic-mute LED on more HP
	laptops
Date: Tue, 28 May 2013 14:57:12 +0200
Message-ID: <1369745832-4155-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 52EF32610B9
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 14:56:33 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C15A8A535C
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 14:56:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The newer HP laptops have SSID 103c:20xx and 103c:21xx, and these
usually have the mic-mute LED on Fn-F8.  Let's enable it, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 1d9d642..9b6cb27 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2233,6 +2233,10 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 			  "HP Folio", STAC_92HD83XXX_HP_MIC_LED),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x1900,
 			  "HP", STAC_92HD83XXX_HP_MIC_LED),
+	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x2000,
+			  "HP", STAC_92HD83XXX_HP_MIC_LED),
+	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x2100,
+			  "HP", STAC_92HD83XXX_HP_MIC_LED),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3388,
 			  "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3389,
-- 
1.8.2.3
