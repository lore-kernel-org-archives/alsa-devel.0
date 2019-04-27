From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: Add support for HDAudio
	codecs" to the asoc tree
Date: Sat, 27 Apr 2019 18:52:42 +0100 (BST)
Message-ID: <20190427175242.57FD1441D56@finisterre.ee.mobilebroadband>
References: <20190412160904.30418-14-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160904.30418-14-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: Add support for HDAudio codecs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 5507b8103e2653b4f5fc2e4c339d7eacde00da2d Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Apr 2019 11:08:56 -0500
Subject: [PATCH] ASoC: SOF: Intel: Add support for HDAudio codecs

Add probe, init and cleanup routines for HDaudio.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 171 ++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-codec.c

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
new file mode 100644
index 000000000000..b8b37f082309
--- /dev/null
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Keyon Jie <yang.jie@linux.intel.com>
+//
+
+#include <linux/module.h>
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_codec.h>
+#include <sound/hda_i915.h>
+#include <sound/sof.h>
+#include "../ops.h"
+#include "hda.h"
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+#include "../../codecs/hdac_hda.h"
+#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+#define IDISP_VID_INTEL	0x80860000
+
+/* load the legacy HDA codec driver */
+#ifdef MODULE
+static void hda_codec_load_module(struct hda_codec *codec)
+{
+	char alias[MODULE_NAME_LEN];
+	const char *module = alias;
+
+	snd_hdac_codec_modalias(&codec->core, alias, sizeof(alias));
+	dev_dbg(&codec->core.dev, "loading codec module: %s\n", module);
+	request_module(module);
+}
+#else
+static void hda_codec_load_module(struct hda_codec *codec) {}
+#endif
+
+#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
+
+/* probe individual codec */
+static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
+{
+	struct hda_bus *hbus = sof_to_hbus(sdev);
+	struct hdac_device *hdev;
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+	struct hdac_hda_priv *hda_priv;
+#endif
+	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
+		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
+	u32 resp = -1;
+	int ret;
+
+	mutex_lock(&hbus->core.cmd_mutex);
+	snd_hdac_bus_send_cmd(&hbus->core, hda_cmd);
+	snd_hdac_bus_get_response(&hbus->core, address, &resp);
+	mutex_unlock(&hbus->core.cmd_mutex);
+	if (resp == -1)
+		return -EIO;
+	dev_dbg(sdev->dev, "HDA codec #%d probed OK: response: %x\n",
+		address, resp);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+	/* snd_hdac_ext_bus_device_exit will use kfree to free hdev */
+	hda_priv = kzalloc(sizeof(*hda_priv), GFP_KERNEL);
+	if (!hda_priv)
+		return -ENOMEM;
+
+	hda_priv->codec.bus = hbus;
+	hdev = &hda_priv->codec.core;
+
+	ret = snd_hdac_ext_bus_device_init(&hbus->core, address, hdev);
+	if (ret < 0)
+		return ret;
+
+	/* use legacy bus only for HDA codecs, idisp uses ext bus */
+	if ((resp & 0xFFFF0000) != IDISP_VID_INTEL) {
+		hdev->type = HDA_DEV_LEGACY;
+		hda_codec_load_module(&hda_priv->codec);
+	}
+
+	return 0;
+#else
+	/* snd_hdac_ext_bus_device_exit will use kfree to free hdev */
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	ret = snd_hdac_ext_bus_device_init(&hbus->core, address, hdev);
+
+	return ret;
+#endif
+}
+
+/* Codec initialization */
+int hda_codec_probe_bus(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	int i, ret;
+
+	/* probe codecs in avail slots */
+	for (i = 0; i < HDA_MAX_CODECS; i++) {
+
+		if (!(bus->codec_mask & (1 << i)))
+			continue;
+
+		ret = hda_codec_probe(sdev, i);
+		if (ret < 0) {
+			dev_err(bus->dev, "error: codec #%d probe error, ret: %d\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(hda_codec_probe_bus);
+
+#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)
+
+void hda_codec_i915_get(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+	dev_dbg(bus->dev, "Turning i915 HDAC power on\n");
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
+}
+EXPORT_SYMBOL(hda_codec_i915_get);
+
+void hda_codec_i915_put(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+	dev_dbg(bus->dev, "Turning i915 HDAC power off\n");
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
+}
+EXPORT_SYMBOL(hda_codec_i915_put);
+
+int hda_codec_i915_init(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	int ret;
+
+	/* i915 exposes a HDA codec for HDMI audio */
+	ret = snd_hdac_i915_init(bus);
+	if (ret < 0)
+		return ret;
+
+	hda_codec_i915_get(sdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(hda_codec_i915_init);
+
+int hda_codec_i915_exit(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	int ret;
+
+	hda_codec_i915_put(sdev);
+
+	ret = snd_hdac_i915_exit(bus);
+
+	return ret;
+}
+EXPORT_SYMBOL(hda_codec_i915_exit);
+
+#endif /* CONFIG_SND_SOC_HDAC_HDMI */
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1
