From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add the top speaker pin config for
	HP Spectre x360
Date: Tue, 27 Sep 2016 16:48:57 +0200
Message-ID: <20160927144857.5371-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 17F09265338
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 16:48:58 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 63CA9AC93
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 14:48:58 +0000 (UTC)
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

HP Spectre x360 with CX20724 codec has two speaker outputs while the
BIOS sets up only the bottom one (NID 0x17) and disables the top one
(NID 0x1d).

This patch adds a fixup simply defining the proper pincfg for NID 0x1d
so that the top speaker works as is.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=169071
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 56fefbd85782..ed62748a6d55 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -261,6 +261,7 @@ enum {
 	CXT_FIXUP_HP_530,
 	CXT_FIXUP_CAP_MIX_AMP_5047,
 	CXT_FIXUP_MUTE_LED_EAPD,
+	CXT_FIXUP_HP_SPECTRE,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -765,6 +766,14 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_mute_led_eapd,
 	},
+	[CXT_FIXUP_HP_SPECTRE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* enable NID 0x1d for the speaker on top */
+			{ 0x1d, 0x91170111 },
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -814,6 +823,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1025, 0x0543, "Acer Aspire One 522", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
+	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
-- 
2.10.0
