From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Another fixup for ASUS laptop with
	ALC660 codec
Date: Mon,  2 Dec 2013 15:29:26 +0100
Message-ID: <1385994566-10831-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC72262626
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:29:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 97790A7CF5
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:29:26 +0100 (CET)
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

ASUS Z35HL laptop also needs the very same fix as the previous one
that was applied to ASUS W7J.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=66231
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a98f3296b891..9ca83001fc37 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4559,6 +4559,7 @@ static const struct hda_fixup alc861_fixups[] = {
 
 static const struct snd_pci_quirk alc861_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1253, "ASUS W7J", ALC660_FIXUP_ASUS_W7J),
+	SND_PCI_QUIRK(0x1043, 0x1263, "ASUS Z35HL", ALC660_FIXUP_ASUS_W7J),
 	SND_PCI_QUIRK(0x1043, 0x1393, "ASUS A6Rp", ALC861_FIXUP_ASUS_A6RP),
 	SND_PCI_QUIRK_VENDOR(0x1043, "ASUS laptop", ALC861_FIXUP_AMP_VREF_0F),
 	SND_PCI_QUIRK(0x1462, 0x7254, "HP DX2200", ALC861_FIXUP_NO_JACK_DETECT),
-- 
1.8.4.4
