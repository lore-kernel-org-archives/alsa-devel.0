From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add missing newline at end of file" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:15 +0100 (BST)
Message-ID: <20190617152415.2AD7D440046@finisterre.sirena.org.uk>
References: <20190617144048.5450-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617144048.5450-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add missing newline at end of file

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 501e94b52aeda5841a60ceead5984ff575aeefa0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Jun 2019 16:40:48 +0200
Subject: [PATCH] ASoC: Add missing newline at end of file

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/Makefile | 2 +-
 sound/soc/tegra/Makefile           | 2 +-
 sound/usb/bcd2000/Makefile         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index 9ab90433a8d7..acbe01e9e928 100644
--- a/sound/soc/mediatek/common/Makefile
+++ b/sound/soc/mediatek/common/Makefile
@@ -3,4 +3,4 @@
 snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
 obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
 
-obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
\ No newline at end of file
+obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 2329b72c93e3..c84f183919f2 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -37,4 +37,4 @@ obj-$(CONFIG_SND_SOC_TEGRA_WM9712) += snd-soc-tegra-wm9712.o
 obj-$(CONFIG_SND_SOC_TEGRA_TRIMSLICE) += snd-soc-tegra-trimslice.o
 obj-$(CONFIG_SND_SOC_TEGRA_ALC5632) += snd-soc-tegra-alc5632.o
 obj-$(CONFIG_SND_SOC_TEGRA_MAX98090) += snd-soc-tegra-max98090.o
-obj-$(CONFIG_SND_SOC_TEGRA_SGTL5000) += snd-soc-tegra-sgtl5000.o
\ No newline at end of file
+obj-$(CONFIG_SND_SOC_TEGRA_SGTL5000) += snd-soc-tegra-sgtl5000.o
diff --git a/sound/usb/bcd2000/Makefile b/sound/usb/bcd2000/Makefile
index f09ccc0af6ff..0a100310a671 100644
--- a/sound/usb/bcd2000/Makefile
+++ b/sound/usb/bcd2000/Makefile
@@ -1,3 +1,3 @@
 snd-bcd2000-y := bcd2000.o
 
-obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
+obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
-- 
2.20.1
