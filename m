From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ASoC: Add missing newline at end of file
Date: Mon, 17 Jun 2019 16:40:48 +0200
Message-ID: <20190617144048.5450-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/mediatek/common/Makefile | 2 +-
 sound/soc/tegra/Makefile           | 2 +-
 sound/usb/bcd2000/Makefile         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index 9ab90433a8d7b297..acbe01e9e9286d7a 100644
--- a/sound/soc/mediatek/common/Makefile
+++ b/sound/soc/mediatek/common/Makefile
@@ -3,4 +3,4 @@
 snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
 obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
 
-obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
\ No newline at end of file
+obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 2329b72c93e37807..c84f183919f2f1ab 100644
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
index 99546074e5f47ddb..e2d916e24787f963 100644
--- a/sound/usb/bcd2000/Makefile
+++ b/sound/usb/bcd2000/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 snd-bcd2000-y := bcd2000.o
 
-obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
+obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
-- 
2.17.1
