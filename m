From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 6/7] ASoC: tegra: Harmony machine support
Date: Fri,  7 Jan 2011 22:36:16 -0700
Message-ID: <1294464977-25814-7-git-send-email-swarren@nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4542A103848
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:41 +0100 (CET)
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |  179 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/tegra/harmony.c

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
new file mode 100644
index 0000000..bf0dbaf
--- /dev/null
+++ b/sound/soc/tegra/harmony.c
@@ -0,0 +1,179 @@
+/*
+ * harmony.c - Harmony machine ASoC driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * Based on code copyright/by:
+ *
+ * (c) 2009, 2010 Nvidia Graphics Pvt. Ltd.
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <asm/mach-types.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "tegra_das.h"
+#include "tegra_i2s.h"
+#include "tegra_pcm.h"
+#include "tegra_asoc_utils.h"
+
+#define PREFIX "ASoC Harmony: "
+
+static struct platform_device *harmony_snd_device;
+
+static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int srate, mclk, mclk_change;
+	int err;
+
+	srate = params_rate(params);
+	switch (srate) {
+	case 64000:
+	case 88200:
+	case 96000:
+		mclk = 128 * srate;
+		break;
+	default:
+		mclk = 256 * srate;
+		break;
+	}
+	/* FIXME: Codec only requires >= 3MHz if OSR==0 */
+	while (mclk < 6000000)
+		mclk *= 2;
+
+	err = tegra_asoc_utils_set_rate(srate, mclk, &mclk_change);
+	if (err < 0) {
+		pr_err(PREFIX "Can't configure clocks\n");
+		return err;
+	}
+
+	err = snd_soc_dai_set_fmt(codec_dai,
+					SND_SOC_DAIFMT_I2S |
+					SND_SOC_DAIFMT_NB_NF |
+					SND_SOC_DAIFMT_CBS_CFS);
+	if (err < 0) {
+		pr_err(PREFIX "codec_dai fmt not set\n");
+		return err;
+	}
+
+	err = snd_soc_dai_set_fmt(cpu_dai,
+					SND_SOC_DAIFMT_I2S |
+					SND_SOC_DAIFMT_NB_NF |
+					SND_SOC_DAIFMT_CBS_CFS);
+	if (err < 0) {
+		pr_err(PREFIX "cpu_dai fmt not set\n");
+		return err;
+	}
+
+	if (mclk_change) {
+	    err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk, SND_SOC_CLOCK_IN);
+	    if (err < 0) {
+		    pr_err(PREFIX "codec_dai clock not set\n");
+		    return err;
+	    }
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops harmony_asoc_ops = {
+	.hw_params = harmony_asoc_hw_params,
+};
+
+static struct snd_soc_dai_link harmony_wm8903_dai = {
+	.name = "WM8903",
+	.stream_name = "WM8903 PCM",
+	.codec_name = "wm8903-codec.0-001a",
+	.platform_name = "tegra-pcm-audio",
+	.cpu_dai_name = "tegra-i2s.0",
+	.codec_dai_name = "wm8903-hifi",
+	.ops = &harmony_asoc_ops,
+};
+
+static struct snd_soc_card snd_soc_harmony = {
+	.name = "tegra-harmony",
+	.dai_link = &harmony_wm8903_dai,
+	.num_links = 1,
+};
+
+static int __init harmony_soc_modinit(void)
+{
+	int ret;
+
+	if (!machine_is_harmony()) {
+		pr_err(PREFIX "Not running on Tegra Harmony!\n");
+		return -ENODEV;
+	}
+
+	ret = tegra_asoc_utils_init();
+	if (ret) {
+		return ret;
+	}
+
+	/*
+	 * Create and register platform device
+	 */
+	harmony_snd_device = platform_device_alloc("soc-audio", -1);
+	if (harmony_snd_device == NULL) {
+		pr_err(PREFIX "platform_device_alloc failed\n");
+		ret = -ENOMEM;
+		goto err_clock_utils;
+	}
+
+	platform_set_drvdata(harmony_snd_device, &snd_soc_harmony);
+
+	ret = platform_device_add(harmony_snd_device);
+	if (ret) {
+		pr_err(PREFIX "platform_device_add failed (%d)\n",
+			ret);
+		goto err_device_put;
+	}
+
+	return 0;
+
+err_device_put:
+	platform_device_put(harmony_snd_device);
+err_clock_utils:
+	tegra_asoc_utils_fini();
+	return ret;
+}
+module_init(harmony_soc_modinit);
+
+static void __exit harmony_soc_modexit(void)
+{
+	platform_device_unregister(harmony_snd_device);
+
+	tegra_asoc_utils_fini();
+}
+module_exit(harmony_soc_modexit);
+
+MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
+MODULE_DESCRIPTION("Harmony machine ASoC driver");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
