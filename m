From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 08/15] ALSA: hda/ca0132 - Change firmware name and usage
Date: Tue, 18 Sep 2018 14:33:36 -0400
Message-ID: <1537295625-8082-9-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Recon3D, AE-5, Z and ZxR all share the same firmware file. Rename
this from the specific "ctefx-sbz.bin" to "ctefx-desktop.bin" and set
the AE-5 and Recon3D to use it as well.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 163d2ac..ea67b9c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -81,12 +81,12 @@
 #define SCP_GET    1
 
 #define EFX_FILE   "ctefx.bin"
-#define SBZ_EFX_FILE   "ctefx-sbz.bin"
+#define DESKTOP_EFX_FILE   "ctefx-desktop.bin"
 #define R3DI_EFX_FILE  "ctefx-r3di.bin"
 
 #ifdef CONFIG_SND_HDA_CODEC_CA0132_DSP
 MODULE_FIRMWARE(EFX_FILE);
-MODULE_FIRMWARE(SBZ_EFX_FILE);
+MODULE_FIRMWARE(DESKTOP_EFX_FILE);
 MODULE_FIRMWARE(R3DI_EFX_FILE);
 #endif
 
@@ -6770,12 +6770,14 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	 */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
-		if (request_firmware(&fw_entry, SBZ_EFX_FILE,
+	case QUIRK_R3D:
+	case QUIRK_AE5:
+		if (request_firmware(&fw_entry, DESKTOP_EFX_FILE,
 					codec->card->dev) != 0) {
-			codec_dbg(codec, "SBZ alt firmware not detected. ");
+			codec_dbg(codec, "Desktop firmware not found. ");
 			spec->alt_firmware_present = false;
 		} else {
-			codec_dbg(codec, "Sound Blaster Z firmware selected.");
+			codec_dbg(codec, "Desktop firmware selected.");
 			spec->alt_firmware_present = true;
 		}
 		break;
-- 
2.7.4
