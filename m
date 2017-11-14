From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH] ALSA: hda/realtek - Enable jack detection for
	Intel CFL + ALC700
Date: Tue, 14 Nov 2017 08:30:08 +0530
Message-ID: <20171114030008.858-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B79DF266CFB
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 04:00:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: PeiSen Hou <pshou@realtek.com>, kailang@realtek.com, Guneshwor Singh <guneshwor.o.singh@intel.com>, CHLin <doomko@realtek.com>
List-Id: alsa-devel@alsa-project.org

From: PeiSen Hou <pshou@realtek.com>

ALC700 has jack detection disabled by default in Intel Coffeelake
Reference board. To enable it, this fixup is required.

Signed-off-by: PeiSen Hou <pshou@realtek.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/pci/hda/patch_realtek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ce71111b4e3..61ef08173b1c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5264,6 +5264,7 @@ enum {
 	ALC233_FIXUP_LENOVO_MULTI_CODECS,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
 	ALC700_FIXUP_INTEL_REFERENCE,
+	ALC700_FIXUP_INTEL_CFL,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6074,6 +6075,21 @@ static const struct hda_fixup alc269_fixups[] = {
 			{}
 		}
 	},
+	[ALC700_FIXUP_INTEL_CFL] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Enables internal speaker */
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x45},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x5289},
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x4a},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x201b},
+			{0x58, AC_VERB_SET_COEF_INDEX, 0x00},
+			{0x58, AC_VERB_SET_PROC_COEF, 0x3888},
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x6f},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x2c0b},
+			{}
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6277,6 +6293,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
+	SND_PCI_QUIRK(0x8086, 0x7270, "Intel Coffeelake", ALC700_FIXUP_INTEL_CFL),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
2.15.0
