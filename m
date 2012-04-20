From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add external mic quirk for Asus
	Zenbook UX31E
Date: Fri, 20 Apr 2012 10:01:46 +0200
Message-ID: <1334908906-3170-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B071103EC0
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 10:02:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, 950490@bugs.launchpad.net, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

According to the reporter, external mic starts to work if the
laptop-dmic model is used. According to BIOS pin config, all
pins are consistent with the alc269vb_laptop_dmic fixup, except
for the external mic, which is not present.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/950490
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e65e354..818f90b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6109,6 +6109,7 @@ static const struct alc_fixup alc269_fixups[] = {
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_MIC2_MUTE_LED),
+	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
-- 
1.7.9.5
