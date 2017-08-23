From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add stereo mic quirk for Lenovo
	G50-70 (17aa:3978)
Date: Wed, 23 Aug 2017 09:32:55 +0200
Message-ID: <20170823073255.8599-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECBB72670B5
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 09:32:57 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4863EAD08
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 07:32:57 +0000 (UTC)
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

Lenovo G50-70 (17aa:3978) with Conexant codec chip requires the
similar workaround for the inverted stereo dmic like other Lenovo
models.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1020657
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 8c1289963c80..a81aacf684b2 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -947,6 +947,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo G50-70", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
-- 
2.14.0
