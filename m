From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - remove quirk for Dell Vostro
	1015
Date: Tue,  7 Aug 2012 14:03:29 +0200
Message-ID: <1344341010-6762-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F3050265EC7
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 13:33:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: "3.2+" <stable@kernel.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This computer is confirmed working with model=auto on kernel 3.2.
Also, parsing fails with hda-emu with the current model.

Cc: stable@kernel.org (3.2+)
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 -
 1 file changed, 1 deletion(-)

Alsa info: see hda-emu/codecs/canonical/cx20585-dell-vostro-1015-ccert-201010-6649

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 1436118..6f538eb 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2972,7 +2972,6 @@ static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell Vostro 320", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x0401, "Dell Vostro 1014", CXT5066_DELL_VOSTRO),
-	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x050f, "Dell Inspiron", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x0510, "Dell Vostro", CXT5066_IDEAPAD),
-- 
1.7.9.5
