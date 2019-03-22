From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/ca0132 - Simplify alt firmware
	loading code
Date: Fri, 22 Mar 2019 16:30:12 +0100
Message-ID: <20190322153012.30898-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94E6BF8076F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 16:30:15 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

ca0132 codec driver loads the firmware selectively depending on the
model in addition to the fallback of the default firmware.  The code
works good, but a minor problem is that the current code seems
confusing for Clang where it spews a warning about uninitialized
variable.

This patch simplifies the code flow for such a false-positive
warning.  After this refactoring, the ca0132_spec.alt_firmware_present
field is no longer used, hence it's eliminated as well.

Reported-and-tested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 29882bda7632..e1ebc6d5f382 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1005,7 +1005,6 @@ struct ca0132_spec {
 	unsigned int scp_resp_header;
 	unsigned int scp_resp_data[4];
 	unsigned int scp_resp_count;
-	bool alt_firmware_present;
 	bool startup_check_entered;
 	bool dsp_reload;
 
@@ -7518,7 +7517,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	bool dsp_loaded = false;
 	struct ca0132_spec *spec = codec->spec;
 	const struct dsp_image_seg *dsp_os_image;
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = NULL;
 	/*
 	 * Alternate firmwares for different variants. The Recon3Di apparently
 	 * can use the default firmware, but I'll leave the option in case
@@ -7529,33 +7528,26 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	case QUIRK_R3D:
 	case QUIRK_AE5:
 		if (request_firmware(&fw_entry, DESKTOP_EFX_FILE,
-					codec->card->dev) != 0) {
+					codec->card->dev) != 0)
 			codec_dbg(codec, "Desktop firmware not found.");
-			spec->alt_firmware_present = false;
-		} else {
+		else
 			codec_dbg(codec, "Desktop firmware selected.");
-			spec->alt_firmware_present = true;
-		}
 		break;
 	case QUIRK_R3DI:
 		if (request_firmware(&fw_entry, R3DI_EFX_FILE,
-					codec->card->dev) != 0) {
+					codec->card->dev) != 0)
 			codec_dbg(codec, "Recon3Di alt firmware not detected.");
-			spec->alt_firmware_present = false;
-		} else {
+		else
 			codec_dbg(codec, "Recon3Di firmware selected.");
-			spec->alt_firmware_present = true;
-		}
 		break;
 	default:
-		spec->alt_firmware_present = false;
 		break;
 	}
 	/*
 	 * Use default ctefx.bin if no alt firmware is detected, or if none
 	 * exists for your particular codec.
 	 */
-	if (!spec->alt_firmware_present) {
+	if (!fw_entry) {
 		codec_dbg(codec, "Default firmware selected.");
 		if (request_firmware(&fw_entry, EFX_FILE,
 					codec->card->dev) != 0)
-- 
2.16.4
