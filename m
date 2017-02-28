From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH 5/5] ALSA: hda/realtek - Fix speaker support
	for Asus AiO ZN270IE
Date: Tue, 28 Feb 2017 14:17:15 -0600
Message-ID: <20170228201715.7862-5-drake@endlessm.com>
References: <20170228201715.7862-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CAC266D1F
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 21:17:31 +0100 (CET)
Received: by mail-ua0-f174.google.com with SMTP id 40so26753196uau.2
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 12:17:31 -0800 (PST)
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

Asus AiO ZN270IE with ALC256 has no audio ouput for internal speaker
and headphone. It requires GPIO 2 as an amp. This commit enables the
GPIO and pulls it high.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1158d2a..b35dcd4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4874,6 +4874,7 @@ enum {
 	ALC221_FIXUP_HP_MIC_NO_PRESENCE,
 	ALC256_FIXUP_ASUS_HEADSET_MODE,
 	ALC256_FIXUP_ASUS_MIC,
+	ALC256_FIXUP_ASUS_AIO_GPIO2,
 	ALC233_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
 };
@@ -5596,6 +5597,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC256_FIXUP_ASUS_AIO_GPIO2] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set up GPIO2 for the speaker amp */
+			{ 0x01, AC_VERB_SET_GPIO_MASK, 0x04 },
+			{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04 },
+			{ 0x01, AC_VERB_SET_GPIO_DATA, 0x04 },
+			{}
+		},
+	},
 	[ALC233_FIXUP_ASUS_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5748,6 +5759,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1290, "ASUS X441SA", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x12a0, "ASUS X441UV", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
-- 
2.9.3
