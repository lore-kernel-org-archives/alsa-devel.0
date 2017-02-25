From: Calin Cruceru <calin@rosedu.org>
Subject: [PATCH] ASoC: samsung: Remove extra blank lines
Date: Sat, 25 Feb 2017 12:11:11 +0200
Message-ID: <20170225101111.12707-1-calin@rosedu.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Calin Cruceru <calin@rosedu.org>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Calin Cruceru <calin@rosedu.org>
---
 sound/soc/samsung/bells.c      | 1 -
 sound/soc/samsung/i2s-regs.h   | 2 --
 sound/soc/samsung/i2s.c        | 1 -
 sound/soc/samsung/s3c-i2s-v2.c | 1 -
 4 files changed, 5 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 3dd246fa0059..34deba461ae1 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -446,7 +446,6 @@ static struct snd_soc_card bells_cards[] = {
 	},
 };
 
-
 static int bells_probe(struct platform_device *pdev)
 {
 	int ret;
diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index 9170c311d66e..fe6914005494 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -160,5 +160,3 @@
 #define I2SSIZE_SHIFT		(16)
 
 #endif /* __SND_SOC_SAMSUNG_I2S_REGS_H */
-
-
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 52a47ed292a4..af3ba4d4ccc5 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1242,7 +1242,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		i2s_dai_data = (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
 
-
 	pri_dai = i2s_alloc_dai(pdev, false);
 	if (!pri_dai) {
 		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 644f186fd35c..8f42deaa184b 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -72,7 +72,6 @@ static inline void dbg_showcon(const char *fn, u32 con)
 }
 #endif
 
-
 /* Turn on or off the transmission path. */
 static void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 {
-- 
2.11.0
