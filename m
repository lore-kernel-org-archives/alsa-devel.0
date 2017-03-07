From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Remove extra blank lines" to
	the asoc tree
Date: Tue, 07 Mar 2017 15:21:33 +0100
Message-ID: <E1clFzZ-0006fd-6B@finisterre>
References: <20170225101111.12707-1-calin@rosedu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C197266FE1
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 15:22:34 +0100 (CET)
In-Reply-To: <20170225101111.12707-1-calin@rosedu.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Calin Cruceru <calin@rosedu.org>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, krzk@kernel.org, tiwai@suse.com, broonie@kernel.org, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Remove extra blank lines

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 114ab993e1845a4152bc01d1075b1fb38e741df9 Mon Sep 17 00:00:00 2001
From: Calin Cruceru <calin@rosedu.org>
Date: Sat, 25 Feb 2017 12:11:11 +0200
Subject: [PATCH] ASoC: samsung: Remove extra blank lines

This was reported by checkpatch.pl

Signed-off-by: Calin Cruceru <calin@rosedu.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
