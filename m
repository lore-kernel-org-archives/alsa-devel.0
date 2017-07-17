From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Remove non-existing CONFIG_CPU_S3C2413" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:34 +0100
Message-ID: <E1dX8Xa-0005AM-9O@debutante>
References: <1500270261-23235-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500270261-23235-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Remove non-existing CONFIG_CPU_S3C2413

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

>From 2d397c518eead8b6c3cd817c29bc2d4fb1c41830 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 17 Jul 2017 07:44:21 +0200
Subject: [PATCH] ASoC: samsung: Remove non-existing CONFIG_CPU_S3C2413

There is no CONFIG_CPU_S3C2413 so get rid of it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 8f42deaa184b..ca522a95160b 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -27,7 +27,7 @@
 
 #undef S3C_IIS_V2_SUPPORTED
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
+#if defined(CONFIG_CPU_S3C2412) \
 	|| defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_CPU_S5PV210)
 #define S3C_IIS_V2_SUPPORTED
 #endif
-- 
2.13.2
