From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Asoc: samsung: clean makefile about inexistant files
Date: Mon, 29 Jan 2018 12:26:16 +0000
Message-ID: <1517228776-1617-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, krzk@kernel.org, lgirdwood@gmail.com, perex@perex.cz, s.nawrocki@samsung.com, sbkim73@samsung.com, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Clean makefile rules about inexistant files.
Thoses files were removed in commit a076d418235f ("ASoC: samsung: Drop AC97 drivers")

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 sound/soc/samsung/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 030949e1e434..c3b76035f69c 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -21,8 +21,6 @@ obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-idma.o
 # S3C24XX Machine Support
 snd-soc-jive-wm8750-objs := jive_wm8750.o
 snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
-snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
-snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
 snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
 snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
@@ -32,7 +30,6 @@ snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
 snd-soc-smdk-wm8580-objs := smdk_wm8580.o
 snd-soc-smdk-wm8994-objs := smdk_wm8994.o
 snd-soc-snow-objs := snow.o
-snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
 snd-soc-smdk-wm8994pcm-objs := smdk_wm8994pcm.o
-- 
2.13.6
