From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Fix subwoofer pin on ASUS N751 and N551
Date: Tue, 10 May 2016 11:52:20 +0200
Message-ID: <1462873940-3369-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FFCE265D66
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 11:52:23 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E5217AC8A
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:52:22 +0000 (UTC)
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

From: Yura Pakhuchiy <pakhuchiy@gmail.com>

Subwoofer does not work out of the box on ASUS N751/N551 laptops. This
patch fixes it. Patch tested on N751 laptop. N551 part is not tested,
but according to [1] and [2] this laptop requires similar changes, so I
included them in the patch.

1. https://github.com/honsiorovskyi/asus-n551-hda-fix
2. https://bugs.launchpad.net/ubuntu/+source/alsa-tools/+bug/1405691

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117781
Signed-off-by: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1b5cd19876fc..4918ffa5ba68 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6426,6 +6426,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -6672,6 +6673,15 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_BASS_1A
 	},
+	[ALC668_FIXUP_ASUS_Nx51] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x1a, 0x90170151}, /* bass speaker */
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_BASS_CHMAP,
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -6700,6 +6710,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x129d, "Asus N750", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
+	SND_PCI_QUIRK(0x1043, 0x177d, "ASUS N551", ALC668_FIXUP_ASUS_Nx51),
+	SND_PCI_QUIRK(0x1043, 0x17bd, "ASUS N751", ALC668_FIXUP_ASUS_Nx51),
 	SND_PCI_QUIRK(0x1043, 0x1b73, "ASUS N55SF", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x8469, "ASUS mobo", ALC662_FIXUP_NO_JACK_DETECT),
-- 
2.8.2
