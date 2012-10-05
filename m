From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: wm2200: Initial DSP support
Date: Fri,  5 Oct 2012 19:55:34 +0100
Message-ID: <1349463336-10871-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34B812650D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 20:55:43 +0200 (CEST)
In-Reply-To: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Support download and execution of firmwares to the DSPs on the WM2200.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |  240 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wmfw.h   |   56 +++++++++++
 2 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/wmfw.h

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index f24ef0a..e3f549b 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/firmware.h>
 #include <linux/gcd.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -32,6 +33,39 @@
 #include <sound/wm2200.h>
 
 #include "wm2200.h"
+#include "wmfw.h"
+
+#define WM2200_DSP_CONTROL_1                   0x00
+#define WM2200_DSP_CONTROL_2                   0x02
+#define WM2200_DSP_CONTROL_3                   0x03
+#define WM2200_DSP_CONTROL_4                   0x04
+#define WM2200_DSP_CONTROL_5                   0x06
+#define WM2200_DSP_CONTROL_6                   0x07
+#define WM2200_DSP_CONTROL_7                   0x08
+#define WM2200_DSP_CONTROL_8                   0x09
+#define WM2200_DSP_CONTROL_9                   0x0A
+#define WM2200_DSP_CONTROL_10                  0x0B
+#define WM2200_DSP_CONTROL_11                  0x0C
+#define WM2200_DSP_CONTROL_12                  0x0D
+#define WM2200_DSP_CONTROL_13                  0x0F
+#define WM2200_DSP_CONTROL_14                  0x10
+#define WM2200_DSP_CONTROL_15                  0x11
+#define WM2200_DSP_CONTROL_16                  0x12
+#define WM2200_DSP_CONTROL_17                  0x13
+#define WM2200_DSP_CONTROL_18                  0x14
+#define WM2200_DSP_CONTROL_19                  0x16
+#define WM2200_DSP_CONTROL_20                  0x17
+#define WM2200_DSP_CONTROL_21                  0x18
+#define WM2200_DSP_CONTROL_22                  0x1A
+#define WM2200_DSP_CONTROL_23                  0x1B
+#define WM2200_DSP_CONTROL_24                  0x1C
+#define WM2200_DSP_CONTROL_25                  0x1E
+#define WM2200_DSP_CONTROL_26                  0x20
+#define WM2200_DSP_CONTROL_27                  0x21
+#define WM2200_DSP_CONTROL_28                  0x22
+#define WM2200_DSP_CONTROL_29                  0x23
+#define WM2200_DSP_CONTROL_30                  0x24
+#define WM2200_DSP_CONTROL_31                  0x26
 
 /* The code assumes DCVDD is generated internally */
 #define WM2200_NUM_CORE_SUPPLIES 2
@@ -953,6 +987,206 @@ static int wm2200_reset(struct wm2200_priv *wm2200)
 	}
 }
 
+static int wm2200_dsp_load(struct snd_soc_codec *codec, int base)
+{
+	const struct firmware *firmware;
+	struct regmap *regmap = codec->control_data;
+	unsigned int pos = 0;
+	const struct wmfw_header *header;
+	const struct wmfw_adsp1_sizes *adsp1_sizes;
+	const struct wmfw_footer *footer;
+	const struct wmfw_region *region;
+	const char *file, *region_name;
+	char *text;
+	unsigned int dm, pm, zm, reg;
+	int regions = 0;
+	int ret, offset, type;
+
+	switch (base) {
+	case WM2200_DSP1_CONTROL_1:
+		file = "wm2200-dsp1.wmfw";
+		dm = WM2200_DSP1_DM_BASE;
+		pm = WM2200_DSP1_PM_BASE;
+		zm = WM2200_DSP1_ZM_BASE;
+		break;
+	case WM2200_DSP2_CONTROL_1:
+		file = "wm2200-dsp2.wmfw";
+		dm = WM2200_DSP2_DM_BASE;
+		pm = WM2200_DSP2_PM_BASE;
+		zm = WM2200_DSP2_ZM_BASE;
+		break;
+	default:
+		dev_err(codec->dev, "BASE %x\n", base);
+		BUG_ON(1);
+		return -EINVAL;
+	}
+
+	ret = request_firmware(&firmware, file, codec->dev);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request '%s'\n", file);
+		return ret;
+	}
+
+	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
+	if (pos >= firmware->size) {
+		dev_err(codec->dev, "%s: file too short, %d bytes\n",
+			file, firmware->size);
+		return -EINVAL;
+	}
+
+	header = (void*)&firmware->data[0];
+
+	if (memcmp(&header->magic[0], "WMFW", 4) != 0) {
+		dev_err(codec->dev, "%s: invalid magic\n", file);
+		return -EINVAL;
+	}
+
+	if (header->ver != 0) {
+		dev_err(codec->dev, "%s: unknown file format %d\n",
+			file, header->ver);
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(header->len) != sizeof(*header) +
+	    sizeof(*adsp1_sizes) + sizeof(*footer)) {
+		dev_err(codec->dev, "%s: unexpected header length %d\n",
+			file, le32_to_cpu(header->len));
+		return -EINVAL;
+	}
+
+	if (header->core != WMFW_ADSP1) {
+		dev_err(codec->dev, "%s: invalid core %d\n",
+			file, header->core);
+		return -EINVAL;
+	}
+
+	adsp1_sizes = (void *)&(header[1]);
+	footer = (void *)&(adsp1_sizes[1]);
+
+	dev_dbg(codec->dev, "%s: %d DM, %d PM, %d ZM\n",
+		file, le32_to_cpu(adsp1_sizes->dm),
+		le32_to_cpu(adsp1_sizes->pm), le32_to_cpu(adsp1_sizes->zm));
+
+	dev_dbg(codec->dev, "%s: timestamp %llu\n", file,
+		le64_to_cpu(footer->timestamp));
+
+	while (pos < firmware->size &&
+	       pos - firmware->size > sizeof(*region)) {
+		region = (void *)&(firmware->data[pos]);
+		region_name = "Unknown";
+		reg = 0;
+		text = NULL;
+		offset = le32_to_cpu(region->offset) & 0xffffff;
+		type = be32_to_cpu(region->type) & 0xff;
+		
+		switch (type) {
+		case WMFW_NAME_TEXT:
+			region_name = "Firmware name";
+			text = kzalloc(le32_to_cpu(region->len) + 1,
+				       GFP_KERNEL);
+			break;
+		case WMFW_INFO_TEXT:
+			region_name = "Information";
+			text = kzalloc(le32_to_cpu(region->len) + 1,
+				       GFP_KERNEL);
+			break;
+		case WMFW_ABSOLUTE:
+			region_name = "Absolute";
+			reg = offset;
+			break;
+		case WMFW_ADSP1_PM:
+			region_name = "PM";
+			reg = pm + (offset * 3);
+			break;
+		case WMFW_ADSP1_DM:
+			region_name = "DM";
+			reg = dm + (offset * 2);
+			break;
+		case WMFW_ADSP1_ZM:
+			region_name = "ZM";
+			reg = zm + (offset * 2);
+			break;
+		default:
+			dev_warn(codec->dev,
+				 "%s.%d: Unknown region type %x at %d(%x)\n",
+				 file, regions, type, pos, pos);
+			break;
+		}
+
+		dev_dbg(codec->dev, "%s.%d: %d bytes at %d in %s\n", file,
+			regions, le32_to_cpu(region->len), offset,
+			region_name);
+
+		if (text) {
+			memcpy(text, region->data, le32_to_cpu(region->len));
+			dev_info(codec->dev, "%s: %s\n", file, text);
+			kfree(text);
+		}
+
+		if (reg) {
+			ret = regmap_raw_write(regmap, reg, region->data,
+					       le32_to_cpu(region->len));
+			if (ret != 0) {
+				dev_err(codec->dev,
+					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
+					file, regions,
+					le32_to_cpu(region->len), offset,
+					region_name, ret);
+				goto out;
+			}
+		}
+
+		pos += le32_to_cpu(region->len) + sizeof(*region);
+		regions++;
+	}
+
+	if (pos > firmware->size)
+		dev_warn(codec->dev, "%s.%d: %d bytes at end of file\n",
+			 file, regions, pos - firmware->size);
+
+out:
+	release_firmware(firmware);
+	
+	return ret;
+}
+
+static int wm2200_dsp_ev(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol,
+			 int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	int base = w->reg - WM2200_DSP_CONTROL_30;
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		ret = wm2200_dsp_load(codec, base);
+		if (ret != 0)
+			return ret;
+
+		/* Start the core running */
+		snd_soc_update_bits(codec, w->reg,
+				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START,
+				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		/* Halt the core */
+		snd_soc_update_bits(codec, w->reg,
+				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START,
+				    0);
+
+		snd_soc_update_bits(codec, base + WM2200_DSP_CONTROL_19,
+				    WM2200_DSP1_WDMA_BUFFER_LENGTH_MASK, 0);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static DECLARE_TLV_DB_SCALE(in_tlv, -6300, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
 static DECLARE_TLV_DB_SCALE(out_tlv, -6400, 100, 0);
@@ -1301,9 +1535,11 @@ SND_SOC_DAPM_PGA("LHPF2", WM2200_HPLPF2_1, WM2200_LHPF2_ENA_SHIFT, 0,
 		 NULL, 0),
 
 SND_SOC_DAPM_PGA_E("DSP1", WM2200_DSP1_CONTROL_30, WM2200_DSP1_SYS_ENA_SHIFT,
-		   0, NULL, 0, NULL, 0),
+		   0, NULL, 0, wm2200_dsp_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA_E("DSP2", WM2200_DSP2_CONTROL_30, WM2200_DSP2_SYS_ENA_SHIFT,
-		   0, NULL, 0, NULL, 0),
+		   0, NULL, 0, wm2200_dsp_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", "Capture", 0,
 		    WM2200_AUDIO_IF_1_22, WM2200_AIF1TX1_ENA_SHIFT, 0),
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
new file mode 100644
index 0000000..ef37316
--- /dev/null
+++ b/sound/soc/codecs/wmfw.h
@@ -0,0 +1,56 @@
+/*
+ * wmfw.h - Wolfson firmware format information
+ *
+ * Copyright 2012 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __WMFW_H
+#define __WMFW_H
+
+#include <linux/types.h>
+
+struct wmfw_header {
+	char magic[4];
+	__le32 len;
+	__le16 rev;
+	u8 core;
+	u8 ver;
+} __packed;
+
+struct wmfw_footer {
+	__le64 timestamp;
+	__le32 checksum;
+} __packed;
+
+struct wmfw_adsp1_sizes {
+	__le32 dm;
+	__le32 pm;
+	__le32 zm;
+} __packed;
+
+struct wmfw_region {
+	union {
+		__be32 type;
+		__le32 offset;
+	};
+	__le32 len;
+	u8 data[];
+} __packed;
+
+#define WMFW_ADSP1 1
+
+#define WMFW_ABSOLUTE  0xf0
+#define WMFW_NAME_TEXT 0xfe
+#define WMFW_INFO_TEXT 0xff
+
+#define WMFW_ADSP1_PM 2
+#define WMFW_ADSP1_DM 3
+#define WMFW_ADSP1_ZM 4
+
+#endif
-- 
1.7.10.4
