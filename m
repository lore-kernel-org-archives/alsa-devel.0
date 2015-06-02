From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Add a fixup for another
	Acer Aspire 9420
Date: Tue,  2 Jun 2015 20:00:27 +0200
Message-ID: <1433268027-4975-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0365D2605A2
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 20:00:29 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 69B9DAB5F
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 18:00:28 +0000 (UTC)
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

Acer Aspire 9420 with ALC883 (1025:0107) needs the fixup for EAPD to
make the sound working like other Aspire models.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=94111
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 80be33ce1a9e..0320cb523d9e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2168,6 +2168,7 @@ static const struct hda_fixup alc882_fixups[] = {
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x006c, "Acer Aspire 9810", ALC883_FIXUP_ACER_EAPD),
 	SND_PCI_QUIRK(0x1025, 0x0090, "Acer Aspire", ALC883_FIXUP_ACER_EAPD),
+	SND_PCI_QUIRK(0x1025, 0x0107, "Acer Aspire", ALC883_FIXUP_ACER_EAPD),
 	SND_PCI_QUIRK(0x1025, 0x010a, "Acer Ferrari 5000", ALC883_FIXUP_ACER_EAPD),
 	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_FIXUP_ACER_EAPD),
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_FIXUP_ACER_EAPD),
-- 
2.4.2
