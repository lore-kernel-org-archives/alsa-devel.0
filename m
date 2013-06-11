From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2 (v2)] ALSA: hda - Headset mic support for
	three more machines
Date: Tue, 11 Jun 2013 11:06:48 +0200
Message-ID: <1370941609-5056-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E876A261A59
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 11:06:50 +0200 (CEST)
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
Cc: 1189363@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

They need these quirks to have headset mic support.

BugLink: https://bugs.launchpad.net/bugs/1189363
Tested-by: Shawn Wang <shawn.wang@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

Note that this patch replaces the patch sent yesterday. I added one more ID in this version.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 02e22b4..af9e71b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3483,6 +3483,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x05ca, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05cb, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05de, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05e0, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05e9, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05ea, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05eb, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -3494,6 +3495,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x05f5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05f6, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05f8, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0606, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0608, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0609, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
-- 
1.7.9.5
