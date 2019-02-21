From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with ALC294
Date: Thu, 21 Feb 2019 17:00:18 +0800
Message-ID: <20190221090018.1428-1-jian-hong@endlessm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>, Ming Shuo Chiu <chiu@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The ASUS UX362FA with ALC294 cannot detect the headset MIC and outputs
through the internal speaker and the headphone.  This issue can be fixed
by the quirk in the commit 4e0511067 ALSA: hda/realtek: Enable audio
jacks of ASUS UX533FD with ALC294.

Besides, ASUS UX362FA and UX533FD have the same audio initial pin config
values.  So, this patch replaces SND_PCI_QUIRK of UX533FD with a new
SND_HDA_PIN_QUIRK which benefits both UX362FA and UX533FD.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Ming Shuo Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1ffa36e987b4..6421864a8a0f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6771,7 +6771,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
-	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
@@ -7388,6 +7387,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
-- 
2.20.1
