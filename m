From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add docking station support for
	another HP machine
Date: Tue, 10 Feb 2015 09:09:41 +0100
Message-ID: <1423555781-4505-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AFC82606BA
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 09:09:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1412800@bugs.launchpad.net, tienfu.chen@canonical.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: TienFu Chen <tienfu.chen@canonical.com>

BugLink: https://bugs.launchpad.net/bugs/1412800
Signed-off-by: TienFu Chen <tienfu.chen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0403061..ddb9308 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4950,6 +4950,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x226e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2271, "HP", ALC286_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x2272, "HP", ALC280_FIXUP_HP_DOCK_PINS),
+	SND_PCI_QUIRK(0x103c, 0x2273, "HP", ALC280_FIXUP_HP_DOCK_PINS),
 	SND_PCI_QUIRK(0x103c, 0x229e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-- 
1.9.1
