From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: clean makefile about
	inexistant files" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:08 +0000
Message-ID: <E1elDDM-0002rG-5a@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33C1126735F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:09 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: clean makefile about inexistant files

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From beff23ff26db0c1df2eaabc0dfe877bcbf05f6db Mon Sep 17 00:00:00 2001
From: Corentin Labbe <clabbe@baylibre.com>
Date: Mon, 29 Jan 2018 12:26:16 +0000
Subject: [PATCH] ASoC: samsung: clean makefile about inexistant files

Clean makefile rules about inexistant files.
Thoses files were removed in commit a076d418235f ("ASoC: samsung: Drop AC97 drivers")

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.1
