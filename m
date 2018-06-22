From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Add a quirk for FSC
	ESPRIMO U9210
Date: Fri, 22 Jun 2018 12:23:45 +0200
Message-ID: <20180622102345.22726-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 312E12670D7
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 12:23:46 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A2BABAE75
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 10:23:46 +0000 (UTC)
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

Fujitsu Seimens ESPRIMO Mobile U9210 requires the same fixup as H270
for the correct pin configs.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200107
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 487ceb9fd038..70bf4c30548a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2545,6 +2545,7 @@ static const struct snd_pci_quirk alc262_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1397, "Fujitsu Lifebook S7110", ALC262_FIXUP_FSC_S7110),
 	SND_PCI_QUIRK(0x10cf, 0x142d, "Fujitsu Lifebook E8410", ALC262_FIXUP_BENQ),
 	SND_PCI_QUIRK(0x10f1, 0x2915, "Tyan Thunder n6650W", ALC262_FIXUP_TYAN),
+	SND_PCI_QUIRK(0x1734, 0x1141, "FSC ESPRIMO U9210", ALC262_FIXUP_FSC_H270),
 	SND_PCI_QUIRK(0x1734, 0x1147, "FSC Celsius H270", ALC262_FIXUP_FSC_H270),
 	SND_PCI_QUIRK(0x17aa, 0x384e, "Lenovo 3000", ALC262_FIXUP_LENOVO_3000),
 	SND_PCI_QUIRK(0x17ff, 0x0560, "Benq ED8", ALC262_FIXUP_BENQ),
-- 
2.17.1
