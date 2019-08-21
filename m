From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/5] ASoC: SOF: Intel: hda: add helper to initialize SoundWire IP
Date: Wed, 21 Aug 2019 15:17:17 -0500
Message-ID: <20190821201720.17768-3-pierre-louis.bossart@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Fred Oh <fr>
List-Id: alsa-devel@alsa-project.org

The helper calls the SoundWire initializations and sets the resource
structure defined as an interface with the platform driver. The
resource deals with PCI base address, interrupts and the callback for
the stream configuration.

The interrupts are gated/ungated at the top-level with the
ADSPIPC2.SNDW field

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 63 +++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index c72e9a09eee1..a968890d0754 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -18,7 +18,9 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_register.h>
 
+#include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/intel-nhlt.h>
 #include <sound/sof.h>
 #include <sound/sof/xtensa.h>
@@ -35,6 +37,67 @@
 #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 #define IS_CNL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9dc8)
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
+
+static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+	if (enable)
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPIC2,
+					HDA_DSP_ADSPIC2_SNDW,
+					HDA_DSP_ADSPIC2_SNDW);
+	else
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPIC2,
+					HDA_DSP_ADSPIC2_SNDW,
+					0);
+}
+
+static int hda_sdw_init(struct snd_sof_dev *sdev)
+{
+	acpi_handle handle;
+	struct sdw_intel_res res;
+
+	handle = ACPI_HANDLE(sdev->dev);
+
+	memset(&res, 0, sizeof(res));
+
+	res.mmio_base = sdev->bar[HDA_DSP_BAR];
+	res.irq = sdev->ipc_irq;
+	res.parent = sdev->dev;
+
+	hda_sdw_int_enable(sdev, true);
+
+	sdev->sdw = sdw_intel_init(handle, &res);
+	if (!sdev->sdw) {
+		dev_err(sdev->dev, "SDW Init failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	hda_sdw_int_enable(sdev, false);
+
+	if (sdev->sdw)
+		sdw_intel_exit(sdev->sdw);
+
+	return 0;
+}
+#else
+static int hda_sdw_init(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+#endif
+
 /*
  * Debug
  */
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 5591841a1b6f..c8f93317aeb4 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -211,6 +211,7 @@
 
 #define HDA_DSP_ADSPIC_IPC			1
 #define HDA_DSP_ADSPIS_IPC			1
+#define HDA_DSP_ADSPIC2_SNDW			BIT(5)
 
 /* Intel HD Audio General DSP Registers */
 #define HDA_DSP_GEN_BASE		0x0
-- 
2.20.1
