From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Makefile cleanup" to the asoc
	tree
Date: Fri, 11 Nov 2016 15:52:03 +0000
Message-ID: <E1c5E7X-0002f2-6x@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B316A267415
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 16:52:17 +0100 (CET)
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
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Makefile cleanup

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

>From 5acbd343980b034b6ea9b01824cc28d0b01cf4d8 Mon Sep 17 00:00:00 2001
From: Valentin Rothberg <valentinrothberg@gmail.com>
Date: Thu, 10 Nov 2016 08:11:55 +0100
Subject: [PATCH] ASoC: samsung: Makefile cleanup

Commit a076d418235f ("ASoC: samsung: Drop AC97 drivers") removed some
unused code and the associated Kconfig options, but left those options
referenced in the Makefile.  Remove the leftover references in the
Makefile.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index f3f4a32cd376..27956621c849 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -45,8 +45,6 @@ snd-soc-arndale-rt5631-objs := arndale_rt5631.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
@@ -56,7 +54,6 @@ obj-$(CONFIG_SND_SOC_SAMSUNG_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM8580) += snd-soc-smdk-wm8580.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994) += snd-soc-smdk-wm8994.o
 obj-$(CONFIG_SND_SOC_SNOW) += snd-soc-snow.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
-- 
2.10.2
