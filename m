From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix Dock Headphone on Thinkpad X250 seen as a Line Out
Date: Wed, 24 Jun 2015 10:46:33 +0200
Message-ID: <1435135593-6176-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thinkpad X250, when attached to a dock, has two headphone outs but
no line out. Make sure we don't try to turn this into one headphone
and one line out (since that disables the headphone amp on the dock).

Alsa-info at http://www.alsa-project.org/db/?f=36f8764e1d782397928feec715d0ef90dfddd4c1

Cc: stable@vger.kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 431a20b..8e02cdf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4511,6 +4511,7 @@ enum {
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC292_FIXUP_TPT440_DOCK,
+	ALC292_FIXUP_TPT440_DOCK2,
 	ALC283_FIXUP_BXBT2807_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
@@ -4960,6 +4961,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
 	[ALC292_FIXUP_TPT440_DOCK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
+		.chained = true,
+		.chain_id = ALC292_FIXUP_TPT440_DOCK2
+	},
+	[ALC292_FIXUP_TPT440_DOCK2] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x16, 0x21211010 }, /* dock headphone */
-- 
1.9.1
