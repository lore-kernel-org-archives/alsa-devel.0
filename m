From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880
Date: Wed,  5 Dec 2018 14:48:53 +0800
Message-ID: <20181205064856.19380-1-jian-hong@endlessm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Chris Chiu <chiu@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Chiu <chiu@endlessm.com>

Acer Aspire U27-880(AIO) with ALC286 codec can not detect headset mic
and internal mic not working either. It needs the similar quirk like
Sony laptops to fix headphone jack sensing and enables use of the
internal microphone.

Unfortunately jack sensing for the headset mic is still not working.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c0b289ba397f..f21d52eb2ed3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5516,6 +5516,7 @@ enum {
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
+	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6393,6 +6394,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_auto_mute_via_amp,
 	},
+	[ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7071,6 +7081,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x19, 0x04a11040},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0286, 0x1025, "Acer", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0288, 0x1028, "Dell", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
-- 
2.11.0
