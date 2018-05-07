From: Jeremy Soller <jeremy@system76.com>
Subject: [PATCH] Clevo P950ER ALC1220 Fixup
Date: Mon, 07 May 2018 09:28:45 -0600
Message-ID: <1525706925.3365083.1363584480.0D4473BE@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 0444026762A
 for <alsa-devel@alsa-project.org>; Mon,  7 May 2018 17:28:47 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0D5D42191E
 for <alsa-devel@alsa-project.org>; Mon,  7 May 2018 11:28:46 -0400 (EDT)
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

This adds support for the P950ER, which has the same required fixup as the P950HR, but has a different PCI ID.

Signed-off-by: Jeremy Soller <jeremy@system76.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2dd34dd77447..01a6643fc7d4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2363,6 +2363,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
        SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),
        SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", ALC882_FIXUP_ABIT_AW9D_MAX),
        SND_PCI_QUIRK(0x1558, 0x9501, "Clevo P950HR", ALC1220_FIXUP_CLEVO_P950),
+       SND_PCI_QUIRK(0x1558, 0x95e2, "Clevo P950ER", ALC1220_FIXUP_CLEVO_P950),
        SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
        SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
        SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", ALC882_FIXUP_LENOVO_Y530),
