From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 01/15] ALSA: hda/ca0132 - Define new verbs and control params
Date: Tue, 18 Sep 2018 14:33:29 -0400
Message-ID: <1537295625-8082-2-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch defines some new verbs found from reverse engineering of the
onboard 8051 CPU, and a control param found there as well. This clears
up usage of these verbs in other parts of the driver, and removes their
usage where they're now known to be unnecessary.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0166a3d..cd93c86 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -685,6 +685,9 @@ enum hda_cmd_vendor_io {
 	VENDOR_CHIPIO_DATA_LOW               = 0x300,
 	VENDOR_CHIPIO_DATA_HIGH              = 0x400,
 
+	VENDOR_CHIPIO_8051_WRITE_DIRECT      = 0x500,
+	VENDOR_CHIPIO_8051_READ_DIRECT       = 0xD00,
+
 	VENDOR_CHIPIO_GET_PARAMETER          = 0xF00,
 	VENDOR_CHIPIO_STATUS                 = 0xF01,
 	VENDOR_CHIPIO_HIC_POST_READ          = 0x702,
@@ -692,6 +695,9 @@ enum hda_cmd_vendor_io {
 
 	VENDOR_CHIPIO_8051_DATA_WRITE        = 0x707,
 	VENDOR_CHIPIO_8051_DATA_READ         = 0xF07,
+	VENDOR_CHIPIO_8051_PMEM_READ         = 0xF08,
+	VENDOR_CHIPIO_8051_IRAM_WRITE        = 0x709,
+	VENDOR_CHIPIO_8051_IRAM_READ         = 0xF09,
 
 	VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE   = 0x70A,
 	VENDOR_CHIPIO_CT_EXTENSIONS_GET      = 0xF0A,
@@ -798,6 +804,12 @@ enum control_param_id {
 	 * impedance is selected*/
 	CONTROL_PARAM_PORTD_160OHM_GAIN        = 10,
 
+	/*
+	 * This control param name was found in the 8051 memory, and makes
+	 * sense given the fact the AE-5 uses it and has the ASI flag set.
+	 */
+	CONTROL_PARAM_ASI                      = 23,
+
 	/* Stream Control */
 
 	/* Select stream with the given ID */
@@ -7140,11 +7152,6 @@ static void sbz_pre_dsp_setup(struct hda_codec *codec)
 	writel(0x00820680, spec->mem_base + 0x01C);
 	writel(0x00820680, spec->mem_base + 0x01C);
 
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
-
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
 	snd_hda_codec_write(codec, 0x11, 0,
@@ -7153,12 +7160,6 @@ static void sbz_pre_dsp_setup(struct hda_codec *codec)
 
 static void r3d_pre_dsp_setup(struct hda_codec *codec)
 {
-
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
-
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-- 
2.7.4
