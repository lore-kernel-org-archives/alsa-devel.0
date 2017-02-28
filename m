From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH 4/5] ALSA: hda/realtek - Fix headset mic and
	speaker on Asus X441SA/X441UV
Date: Tue, 28 Feb 2017 14:17:14 -0600
Message-ID: <20170228201715.7862-4-drake@endlessm.com>
References: <20170228201715.7862-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id D77A6266718
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 21:17:27 +0100 (CET)
Received: by mail-ua0-f172.google.com with SMTP id 40so26752407uau.2
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 12:17:27 -0800 (PST)
In-Reply-To: <20170228201715.7862-1-drake@endlessm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: linux@endlessm.com, alsa-devel@alsa-project.org, chiu@endlessm.com
List-Id: alsa-devel@alsa-project.org

From: Chris Chiu <chiu@endlessm.com>

ASUS X441SA and X441UV laptops with ALC3236 (ALC223) codec require
the known fixup (ALC269_FIXUP_HEADSET_MIC) and a different pin value on
pin 0x19 to make the headset mic work.

To make the speaker work, it requires an EAPD verb fixup.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 101b14f..1158d2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4874,6 +4874,8 @@ enum {
 	ALC221_FIXUP_HP_MIC_NO_PRESENCE,
 	ALC256_FIXUP_ASUS_HEADSET_MODE,
 	ALC256_FIXUP_ASUS_MIC,
+	ALC233_FIXUP_ASUS_MIC_NO_PRESENCE,
+	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5594,6 +5596,26 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC233_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
+	},
+	[ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Enables internal speaker */
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x40},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x8800},
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC233_FIXUP_ASUS_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5723,6 +5745,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x1290, "ASUS X441SA", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x12a0, "ASUS X441UV", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
-- 
2.9.3
