From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 2/3] ALSA: hda/realtek: Enable headset mic of ASUS P5440FF with ALC256
Date: Fri, 22 Mar 2019 11:37:20 +0800
Message-ID: <20190322033719.10793-2-jian-hong@endlessm.com>
References: <20190322033719.10793-1-jian-hong@endlessm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322033719.10793-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Chiu <chiu@endlessm.com>

The ASUS laptop P5440FF with ALC256 can't detect the headset microphone
until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2523e495924e..b8efb20916ba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7343,6 +7343,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x1a, 0x90a70130},
 		{0x1b, 0x90170110},
-- 
2.20.1
