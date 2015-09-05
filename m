From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Use ALC880_FIXUP_FUJITSU for
	FSC Amilo M1437
Date: Sat,  5 Sep 2015 18:18:51 +0200
Message-ID: <1441469931-25417-2-git-send-email-tiwai@suse.de>
References: <1441469931-25417-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E53732604FC
 for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2015 18:18:53 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 74556ABCF
 for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2015 16:18:53 +0000 (UTC)
In-Reply-To: <1441469931-25417-1-git-send-email-tiwai@suse.de>
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

It turned out that the machine has a bass speaker, so take a correct
fixup entry.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=102501
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9b43cb95c047..f71ee28bf0f3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1364,7 +1364,7 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
 	SND_PCI_QUIRK(0x1631, 0xe011, "PB 13201056", ALC880_FIXUP_6ST_AUTOMUTE),
-	SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_FIXUP_F1734),
+	SND_PCI_QUIRK(0x1734, 0x107c, "FSC Amilo M1437", ALC880_FIXUP_FUJITSU),
 	SND_PCI_QUIRK(0x1734, 0x1094, "FSC Amilo M1451G", ALC880_FIXUP_FUJITSU),
 	SND_PCI_QUIRK(0x1734, 0x10ac, "FSC AMILO Xi 1526", ALC880_FIXUP_F1734),
 	SND_PCI_QUIRK(0x1734, 0x10b0, "FSC Amilo Pi1556", ALC880_FIXUP_FUJITSU),
-- 
2.5.1
