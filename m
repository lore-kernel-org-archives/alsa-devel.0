From: Richard Sailer <rs@tuxedocomputers.com>
Subject: [PATCH] Headset,
	microphone and internal speaker support for Tuxedo XC 1509
Date: Tue,  2 Apr 2019 15:52:04 +0200
Message-ID: <20190402135204.11563-1-rs@tuxedocomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01DB6F89610
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 15:52:29 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

This adds a SND_PCI_QUIRK(...) line for the Tuxedo XC 1509.

The Tuxedo XC 1509 and the System76 oryp5 are the same barebone
notebooks manufactured by Clevo. To name the fixups both use after the
actual underlying hardware, this patch also changes System76_orpy5
to clevo_pb51ed in 2 enum symbols and one function name,
matching the other pci_quirk entries which are also named after the device ODM.

Signed-off-by: Richard Sailer <rs@tuxedocomputers.com>
---
 sound/pci/hda/patch_realtek.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 715ab2342151..9df868ea96ee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1864,8 +1864,8 @@ enum {
 	ALC887_FIXUP_BASS_CHMAP,
 	ALC1220_FIXUP_GB_DUAL_CODECS,
 	ALC1220_FIXUP_CLEVO_P950,
-	ALC1220_FIXUP_SYSTEM76_ORYP5,
-	ALC1220_FIXUP_SYSTEM76_ORYP5_PINS,
+	ALC1220_FIXUP_CLEVO_PB51ED,
+	ALC1220_FIXUP_CLEVO_PB51ED_PINS,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2070,7 +2070,7 @@ static void alc1220_fixup_clevo_p950(struct hda_codec *codec,
 static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action);
 
-static void alc1220_fixup_system76_oryp5(struct hda_codec *codec,
+static void alc1220_fixup_clevo_pb51ed(struct hda_codec *codec,
 				     const struct hda_fixup *fix,
 				     int action)
 {
@@ -2322,18 +2322,18 @@ static const struct hda_fixup alc882_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_clevo_p950,
 	},
-	[ALC1220_FIXUP_SYSTEM76_ORYP5] = {
+	[ALC1220_FIXUP_CLEVO_PB51ED] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc1220_fixup_system76_oryp5,
+		.v.func = alc1220_fixup_clevo_pb51ed,
 	},
-	[ALC1220_FIXUP_SYSTEM76_ORYP5_PINS] = {
+	[ALC1220_FIXUP_CLEVO_PB51ED_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
 			{}
 		},
 		.chained = true,
-		.chain_id = ALC1220_FIXUP_SYSTEM76_ORYP5,
+		.chain_id = ALC1220_FIXUP_CLEVO_PB51ED,
 	},
 };
 
@@ -2411,8 +2411,9 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x9501, "Clevo P950HR", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e1, "Clevo P95xER", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e2, "Clevo P950ER", ALC1220_FIXUP_CLEVO_P950),
-	SND_PCI_QUIRK(0x1558, 0x96e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
-	SND_PCI_QUIRK(0x1558, 0x97e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
+	SND_PCI_QUIRK(0x1558, 0x96e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x97e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x65d1, "Tuxedo Book XC1509", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", ALC882_FIXUP_LENOVO_Y530),
-- 
2.17.1
