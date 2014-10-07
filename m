From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - Add Inverted Internal mic for
	Samsung Ativ book 9 (NP900X3G)
Date: Tue,  7 Oct 2014 10:18:41 +0200
Message-ID: <1412669922-10056-2-git-send-email-david.henningsson@canonical.com>
References: <1412669922-10056-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B292260320
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 10:18:43 +0200 (CEST)
In-Reply-To: <1412669922-10056-1-git-send-email-david.henningsson@canonical.com>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In this case, it looks like the right channel records noise rather
than the inverted signal, but the simplest way is to just call it
"Inverted Internal Mic", which will cause it to be muted by default.

Alsa-info at http://www.alsa-project.org/db/?f=064f0b536a1b068efd30d58c2641b5ec2348f059

BugLink: https://bugs.launchpad.net/bugs/1316518
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a109fdb..82ea50e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4925,6 +4925,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9099, "Sony VAIO S13", ALC275_FIXUP_SONY_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
+	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_BXBT2807_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),
-- 
1.9.1
