From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH v2 3/4] ARM: tegra: Platform data fixes for
	ASoC driver updates
Date: Wed, 19 Jan 2011 13:50:04 -0700
Message-ID: <1295470205-26501-4-git-send-email-swarren@nvidia.com>
References: <1295470205-26501-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C0598103896
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 21:50:19 +0100 (CET)
In-Reply-To: <1295470205-26501-1-git-send-email-swarren@nvidia.com>
In-Reply-To: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The WM8903 driver now needs platform data in order to correctly expose its
GPIOs through gpiolib.

The top-level ASoC driver now needs a platform device in order to provide
infra-structure to pass in platform data.

The top-level ASoC driver now needs platform data in order to be informed
which GPIO IDs to use.

This is all needed to allow the top-level ASoC driver to configure the
WM8903's GPIO3 as an output GPIO, and enable it as appropriate. This is the
enable signal for the external speaker amplifier chips.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony.c |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/gpio-names.h    |    2 ++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 2696a20..c5a4ae0 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -2,6 +2,7 @@
  * arch/arm/mach-tegra/board-harmony.c
  *
  * Copyright (C) 2010 Google, Inc.
+ * Copyright (C) 2011 NVIDIA, Inc.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -24,12 +25,15 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 
+#include <sound/wm8903.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
 
 #include <mach/gpio.h>
+#include <mach/harmony_audio.h>
 #include <mach/i2c.h>
 #include <mach/iomap.h>
 #include <mach/irqs.h>
@@ -53,6 +57,8 @@
 #define ATAG_NVIDIA_PRESERVED_MEM_N	2
 #define ATAG_NVIDIA_FORCE_32		0x7fffffff
 
+#define GPIO_WM8903(_x_) (TEGRA_MAX_GPIO + 1 + (_x_))
+
 struct tag_tegra {
 	__u32 bootarg_key;
 	__u32 bootarg_len;
@@ -112,9 +118,33 @@ static struct tegra_i2c_platform_data harmony_i2c1_platform_data = {
 	.bus_clk_rate	= { 400000, 0 },
 };
 
+static struct wm8903_platform_data harmony_wm8903_pdata = {
+	.gpio_base = GPIO_WM8903(0),
+	.gpio_cfg = {
+		WM8903_GPIO_NO_CONFIG,
+		WM8903_GPIO_NO_CONFIG,
+		0,
+		WM8903_GPIO_NO_CONFIG,
+		WM8903_GPIO_NO_CONFIG,
+	},
+};
+
 static struct i2c_board_info __initdata harmony_i2c_bus1_board_info[] = {
 	{
 		I2C_BOARD_INFO("wm8903", 0x1a),
+		.platform_data = &harmony_wm8903_pdata,
+	},
+};
+
+static struct harmony_audio_platform_data harmony_audio_pdata = {
+	.gpio_spkr_en = GPIO_WM8903(2),
+};
+
+static struct platform_device harmony_audio_device = {
+	.name   = "tegra-snd-harmony",
+	.id     = 0,
+	.dev    = {
+		.platform_data  = &harmony_audio_pdata,
 	},
 };
 
@@ -127,6 +157,7 @@ static struct platform_device *harmony_devices[] __initdata = {
 	&tegra_i2s_device1,
 	&tegra_das_device,
 	&tegra_pcm_device,
+	&harmony_audio_device,
 };
 
 static void __init tegra_harmony_fixup(struct machine_desc *desc,
diff --git a/arch/arm/mach-tegra/gpio-names.h b/arch/arm/mach-tegra/gpio-names.h
index f28220a..e8b5cf3 100644
--- a/arch/arm/mach-tegra/gpio-names.h
+++ b/arch/arm/mach-tegra/gpio-names.h
@@ -244,4 +244,6 @@
 #define TEGRA_GPIO_PBB6		222
 #define TEGRA_GPIO_PBB7		223
 
+#define TEGRA_MAX_GPIO		TEGRA_GPIO_PBB7
+
 #endif
-- 
1.7.1
