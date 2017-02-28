From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/5] ALSA: hda/realtek - Fix headset mic on
	several Asus laptops with ALC255
Date: Tue, 28 Feb 2017 14:17:12 -0600
Message-ID: <20170228201715.7862-2-drake@endlessm.com>
References: <20170228201715.7862-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9576E266718
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 21:17:24 +0100 (CET)
Received: by mail-ua0-f182.google.com with SMTP id f54so26592356uaa.1
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 12:17:24 -0800 (PST)
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

Add pin quirks to enable use of the headset mic on Asus Z550MA,
X540LA, X540LJ, X556UR, Z450LA, and X441NC.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2b1f74f9..1bbd4d8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4834,6 +4834,7 @@ enum {
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
+	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC255_FIXUP_HEADSET_MODE,
@@ -5297,6 +5298,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE
 	},
+	[ALC255_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_HEADSET_MODE
+	},
 	[ALC255_FIXUP_DELL1_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5689,6 +5699,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
@@ -5866,6 +5879,14 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a601c0},
 		{0x14, 0x90171120},
 		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1043, "ASUS", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x1b, 0x90a70130},
+		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1043, "ASUS", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x1a, 0x90a70130},
+		{0x1b, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
-- 
2.9.3
