From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: adsp: Add ADSP base support
Date: Fri, 26 Oct 2012 19:36:31 +0100
Message-ID: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56D1026518B
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 20:36:37 +0200 (CEST)
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

Many current Wolfson devices feature DSPs based around an architecture
known as ADSP.  Since there is a lot of commonality in the system
integration of these devices a common library will be used to provide
support for them.

This version provides equivalent support for ADSP1 to that currently
included in the WM2200 driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig   |    5 +
 sound/soc/codecs/Makefile  |    1 +
 sound/soc/codecs/wm_adsp.c |  571 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |   54 +++++
 sound/soc/codecs/wmfw.h    |   29 +++
 5 files changed, 660 insertions(+)
 create mode 100644 sound/soc/codecs/wm_adsp.c
 create mode 100644 sound/soc/codecs/wm_adsp.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6f4f284..91cbbe0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -147,6 +147,11 @@ config SND_SOC_WM_HUBS
 	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
 	default m if SND_SOC_WM8993=m || SND_SOC_WM8994=m
 
+config SND_SOC_WM_ADSP
+	tristate
+	default y if SND_SOC_WM2200=y
+	default m if SND_SOC_WM2200=m
+
 config SND_SOC_AB8500_CODEC
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index c55d2d7..ffbed85 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -63,6 +63,7 @@ snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wl1273-objs := wl1273.o
+snd-soc-wm-adsp := wm_adsp.o
 snd-soc-wm0010-objs := wm0010.o
 snd-soc-wm1250-ev1-objs := wm1250-ev1.o
 snd-soc-wm2000-objs := wm2000.o
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
new file mode 100644
index 0000000..c72d3fa
--- /dev/null
+++ b/sound/soc/codecs/wm_adsp.c
@@ -0,0 +1,571 @@
+/*
+ * wm_adsp.c  --  Wolfson ADSP support
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include <linux/mfd/arizona/registers.h>
+
+#include "wm_adsp.h"
+
+#define adsp_crit(_dsp, fmt, ...) \
+	dev_crit(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+#define adsp_err(_dsp, fmt, ...) \
+	dev_err(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+#define adsp_warn(_dsp, fmt, ...) \
+	dev_warn(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+#define adsp_info(_dsp, fmt, ...) \
+	dev_info(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+#define adsp_dbg(_dsp, fmt, ...) \
+	dev_dbg(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+
+#define ADSP1_CONTROL_1                   0x00
+#define ADSP1_CONTROL_2                   0x02
+#define ADSP1_CONTROL_3                   0x03
+#define ADSP1_CONTROL_4                   0x04
+#define ADSP1_CONTROL_5                   0x06
+#define ADSP1_CONTROL_6                   0x07
+#define ADSP1_CONTROL_7                   0x08
+#define ADSP1_CONTROL_8                   0x09
+#define ADSP1_CONTROL_9                   0x0A
+#define ADSP1_CONTROL_10                  0x0B
+#define ADSP1_CONTROL_11                  0x0C
+#define ADSP1_CONTROL_12                  0x0D
+#define ADSP1_CONTROL_13                  0x0F
+#define ADSP1_CONTROL_14                  0x10
+#define ADSP1_CONTROL_15                  0x11
+#define ADSP1_CONTROL_16                  0x12
+#define ADSP1_CONTROL_17                  0x13
+#define ADSP1_CONTROL_18                  0x14
+#define ADSP1_CONTROL_19                  0x16
+#define ADSP1_CONTROL_20                  0x17
+#define ADSP1_CONTROL_21                  0x18
+#define ADSP1_CONTROL_22                  0x1A
+#define ADSP1_CONTROL_23                  0x1B
+#define ADSP1_CONTROL_24                  0x1C
+#define ADSP1_CONTROL_25                  0x1E
+#define ADSP1_CONTROL_26                  0x20
+#define ADSP1_CONTROL_27                  0x21
+#define ADSP1_CONTROL_28                  0x22
+#define ADSP1_CONTROL_29                  0x23
+#define ADSP1_CONTROL_30                  0x24
+#define ADSP1_CONTROL_31                  0x26
+
+/*
+ * ADSP1 Control 19
+ */
+#define ADSP1_WDMA_BUFFER_LENGTH_MASK     0x00FF  /* DSP1_WDMA_BUFFER_LENGTH - [7:0] */
+#define ADSP1_WDMA_BUFFER_LENGTH_SHIFT         0  /* DSP1_WDMA_BUFFER_LENGTH - [7:0] */
+#define ADSP1_WDMA_BUFFER_LENGTH_WIDTH         8  /* DSP1_WDMA_BUFFER_LENGTH - [7:0] */
+
+
+/*
+ * ADSP1 Control 30
+ */
+#define ADSP1_DBG_CLK_ENA                 0x0008  /* DSP1_DBG_CLK_ENA */
+#define ADSP1_DBG_CLK_ENA_MASK            0x0008  /* DSP1_DBG_CLK_ENA */
+#define ADSP1_DBG_CLK_ENA_SHIFT                3  /* DSP1_DBG_CLK_ENA */
+#define ADSP1_DBG_CLK_ENA_WIDTH                1  /* DSP1_DBG_CLK_ENA */
+#define ADSP1_SYS_ENA                     0x0004  /* DSP1_SYS_ENA */
+#define ADSP1_SYS_ENA_MASK                0x0004  /* DSP1_SYS_ENA */
+#define ADSP1_SYS_ENA_SHIFT                    2  /* DSP1_SYS_ENA */
+#define ADSP1_SYS_ENA_WIDTH                    1  /* DSP1_SYS_ENA */
+#define ADSP1_CORE_ENA                    0x0002  /* DSP1_CORE_ENA */
+#define ADSP1_CORE_ENA_MASK               0x0002  /* DSP1_CORE_ENA */
+#define ADSP1_CORE_ENA_SHIFT                   1  /* DSP1_CORE_ENA */
+#define ADSP1_CORE_ENA_WIDTH                   1  /* DSP1_CORE_ENA */
+#define ADSP1_START                       0x0001  /* DSP1_START */
+#define ADSP1_START_MASK                  0x0001  /* DSP1_START */
+#define ADSP1_START_SHIFT                      0  /* DSP1_START */
+#define ADSP1_START_WIDTH                      1  /* DSP1_START */
+
+#define ADSP2_CONTROL 0
+#define ADSP2_STATUS1 4
+
+/*
+ * ADSP2 Control
+ */
+
+#define ADSP2_MEM_ENA                     0x0010  /* DSP1_MEM_ENA */
+#define ADSP2_MEM_ENA_MASK                0x0010  /* DSP1_MEM_ENA */
+#define ADSP2_MEM_ENA_SHIFT                    4  /* DSP1_MEM_ENA */
+#define ADSP2_MEM_ENA_WIDTH                    1  /* DSP1_MEM_ENA */
+#define ADSP2_SYS_ENA                     0x0004  /* DSP1_SYS_ENA */
+#define ADSP2_SYS_ENA_MASK                0x0004  /* DSP1_SYS_ENA */
+#define ADSP2_SYS_ENA_SHIFT                    2  /* DSP1_SYS_ENA */
+#define ADSP2_SYS_ENA_WIDTH                    1  /* DSP1_SYS_ENA */
+#define ADSP2_CORE_ENA                    0x0002  /* DSP1_CORE_ENA */
+#define ADSP2_CORE_ENA_MASK               0x0002  /* DSP1_CORE_ENA */
+#define ADSP2_CORE_ENA_SHIFT                   1  /* DSP1_CORE_ENA */
+#define ADSP2_CORE_ENA_WIDTH                   1  /* DSP1_CORE_ENA */
+#define ADSP2_START                       0x0001  /* DSP1_START */
+#define ADSP2_START_MASK                  0x0001  /* DSP1_START */
+#define ADSP2_START_SHIFT                      0  /* DSP1_START */
+#define ADSP2_START_WIDTH                      1  /* DSP1_START */
+
+/*
+ * ADSP2 Status 1
+ */
+#define ADSP2_RAM_RDY                     0x0001
+#define ADSP2_RAM_RDY_MASK                0x0001
+#define ADSP2_RAM_RDY_SHIFT                    0
+#define ADSP2_RAM_RDY_WIDTH                    1
+
+
+static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
+							int type)
+{
+	int i;
+
+	for (i = 0; i < dsp->num_mems; i++)
+		if (dsp->mem[i].type == type)
+			return &dsp->mem[i];
+
+	return NULL;
+}
+
+static int wm_adsp_load(struct wm_adsp *dsp)
+{
+	const struct firmware *firmware;
+	struct regmap *regmap = dsp->regmap;
+	unsigned int pos = 0;
+	const struct wmfw_header *header;
+	const struct wmfw_adsp1_sizes *adsp1_sizes;
+	const struct wmfw_adsp2_sizes *adsp2_sizes;
+	const struct wmfw_footer *footer;
+	const struct wmfw_region *region;
+	const struct wm_adsp_region *mem;
+	const char *region_name;
+	char *file, *text;
+	unsigned int reg;
+	int regions = 0;
+	int ret, offset, type, sizes;
+
+	file = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (file == NULL)
+		return -ENOMEM;
+
+	snprintf(file, PAGE_SIZE, "%s-dsp%d.wmfw", dsp->part, dsp->num);
+	file[PAGE_SIZE - 1] = '\0';
+
+	ret = request_firmware(&firmware, file, dsp->dev);
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to request '%s'\n", file);
+		goto out;
+	}
+	ret = -EINVAL;
+
+	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
+	if (pos >= firmware->size) {
+		adsp_err(dsp, "%s: file too short, %zu bytes\n",
+			 file, firmware->size);
+		goto out_fw;
+	}
+
+	header = (void*)&firmware->data[0];
+
+	if (memcmp(&header->magic[0], "WMFW", 4) != 0) {
+		adsp_err(dsp, "%s: invalid magic\n", file);
+		goto out_fw;
+	}
+
+	if (header->ver != 0) {
+		adsp_err(dsp, "%s: unknown file format %d\n",
+			 file, header->ver);
+		goto out_fw;
+	}
+
+	if (header->core != dsp->type) {
+		adsp_err(dsp, "%s: invalid core %d != %d\n",
+			 file, header->core, dsp->type);
+		goto out_fw;
+	}
+
+	switch (dsp->type) {
+	case WMFW_ADSP1:
+		pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
+		adsp1_sizes = (void *)&(header[1]);
+		footer = (void *)&(adsp1_sizes[1]);
+		sizes = sizeof(*adsp1_sizes);
+
+		adsp_dbg(dsp, "%s: %d DM, %d PM, %d ZM\n",
+			 file, le32_to_cpu(adsp1_sizes->dm),
+			 le32_to_cpu(adsp1_sizes->pm),
+			 le32_to_cpu(adsp1_sizes->zm));
+		break;
+
+	case WMFW_ADSP2:
+		pos = sizeof(*header) + sizeof(*adsp2_sizes) + sizeof(*footer);
+		adsp2_sizes = (void *)&(header[1]);
+		footer = (void *)&(adsp2_sizes[1]);
+		sizes = sizeof(*adsp2_sizes);
+
+		adsp_dbg(dsp, "%s: %d XM, %d YM %d PM, %d ZM\n",
+			 file, le32_to_cpu(adsp2_sizes->xm),
+			 le32_to_cpu(adsp2_sizes->ym),
+			 le32_to_cpu(adsp2_sizes->pm),
+			 le32_to_cpu(adsp2_sizes->zm));
+		break;
+
+	default:
+		BUG_ON(NULL == "Unknown DSP type");
+		goto out_fw;
+	}
+
+	if (le32_to_cpu(header->len) != sizeof(*header) +
+	    sizes + sizeof(*footer)) {
+		adsp_err(dsp, "%s: unexpected header length %d\n",
+			 file, le32_to_cpu(header->len));
+		goto out_fw;
+	}
+
+	adsp_dbg(dsp, "%s: timestamp %llu\n", file,
+		 le64_to_cpu(footer->timestamp));
+
+	while (pos < firmware->size &&
+	       pos - firmware->size > sizeof(*region)) {
+		region = (void *)&(firmware->data[pos]);
+		region_name = "Unknown";
+		reg = 0;
+		text = NULL;
+		offset = le32_to_cpu(region->offset) & 0xffffff;
+		type = be32_to_cpu(region->type) & 0xff;
+		mem = wm_adsp_find_region(dsp, type);
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
+			BUG_ON(!mem);
+			region_name = "PM";
+			reg = mem->base + (offset * 3);
+			break;
+		case WMFW_ADSP1_DM:
+			BUG_ON(!mem);
+			region_name = "DM";
+			reg = mem->base + (offset * 2);
+			break;
+		case WMFW_ADSP2_XM:
+			BUG_ON(!mem);
+			region_name = "XM";
+			reg = mem->base + (offset * 2);
+			break;
+		case WMFW_ADSP2_YM:
+			BUG_ON(!mem);
+			region_name = "YM";
+			reg = mem->base + (offset * 2);
+			break;
+		case WMFW_ADSP1_ZM:
+			BUG_ON(!mem);
+			region_name = "ZM";
+			reg = mem->base + (offset * 2);
+			break;
+		default:
+			adsp_warn(dsp,
+				  "%s.%d: Unknown region type %x at %d(%x)\n",
+				  file, regions, type, pos, pos);
+			break;
+		}
+
+		adsp_dbg(dsp, "%s.%d: %d bytes at %d in %s\n", file,
+			 regions, le32_to_cpu(region->len), offset,
+			 region_name);
+
+		if (text) {
+			memcpy(text, region->data, le32_to_cpu(region->len));
+			adsp_info(dsp, "%s: %s\n", file, text);
+			kfree(text);
+		}
+
+		if (reg) {
+			ret = regmap_raw_write(regmap, reg, region->data,
+					       le32_to_cpu(region->len));
+			if (ret != 0) {
+				adsp_err(dsp,
+					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
+					file, regions,
+					le32_to_cpu(region->len), offset,
+					region_name, ret);
+				goto out_fw;
+			}
+		}
+
+		pos += le32_to_cpu(region->len) + sizeof(*region);
+		regions++;
+	}
+	
+	if (pos > firmware->size)
+		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
+			  file, regions, pos - firmware->size);
+
+out_fw:
+	release_firmware(firmware);
+out:
+	kfree(file);
+
+	return ret;
+}
+
+static int wm_adsp_load_coeff(struct wm_adsp *dsp)
+{
+	struct regmap *regmap = dsp->regmap;
+	struct wmfw_coeff_hdr *hdr;
+	struct wmfw_coeff_item *blk;
+	const struct firmware *firmware;
+	const char *region_name;
+	int ret, pos, blocks, type, offset, reg;
+	char *file;
+
+	file = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (file == NULL)
+		return -ENOMEM;
+
+	snprintf(file, PAGE_SIZE, "%s-dsp%d.bin", dsp->part, dsp->num);
+	file[PAGE_SIZE - 1] = '\0';
+
+	ret = request_firmware(&firmware, file, dsp->dev);
+	if (ret != 0) {
+		adsp_warn(dsp, "Failed to request '%s'\n", file);
+		ret = 0;
+		goto out;
+	}
+	ret = -EINVAL;
+
+	if (sizeof(*hdr) >= firmware->size) {
+		adsp_err(dsp, "%s: file too short, %zu bytes\n",
+			file, firmware->size);
+		goto out_fw;
+	}
+
+	hdr = (void*)&firmware->data[0];
+	if (memcmp(hdr->magic, "WMDR", 4) != 0) {
+		adsp_err(dsp, "%s: invalid magic\n", file);
+		return -EINVAL;
+	}
+
+	adsp_dbg(dsp, "%s: v%d.%d.%d\n", file,
+		(le32_to_cpu(hdr->ver) >> 16) & 0xff,
+		(le32_to_cpu(hdr->ver) >>  8) & 0xff,
+		le32_to_cpu(hdr->ver) & 0xff);
+
+	pos = le32_to_cpu(hdr->len);
+
+	blocks = 0;
+	while (pos < firmware->size &&
+	       pos - firmware->size > sizeof(*blk)) {
+		blk = (void*)(&firmware->data[pos]);
+
+		type = be32_to_cpu(blk->type) & 0xff;
+		offset = le32_to_cpu(blk->offset) & 0xffffff;
+
+		adsp_dbg(dsp, "%s.%d: %x v%d.%d.%d\n",
+			 file, blocks, le32_to_cpu(blk->id),
+			 (le32_to_cpu(blk->ver) >> 16) & 0xff,
+			 (le32_to_cpu(blk->ver) >>  8) & 0xff,
+			 le32_to_cpu(blk->ver) & 0xff);
+		adsp_dbg(dsp, "%s.%d: %d bytes at 0x%x in %x\n",
+			 file, blocks, le32_to_cpu(blk->len), offset, type);
+
+		reg = 0;
+		region_name = "Unknown";
+		switch (type) {
+		case WMFW_NAME_TEXT:
+		case WMFW_INFO_TEXT:
+			break;
+		case WMFW_ABSOLUTE:
+			region_name = "register";
+			reg = offset;
+			break;
+		default:
+			adsp_err(dsp, "Unknown region type %x\n", type);
+			break;
+		}
+
+		if (reg) {
+			ret = regmap_raw_write(regmap, reg, blk->data,
+					       le32_to_cpu(blk->len));
+			if (ret != 0) {
+				adsp_err(dsp,
+					"%s.%d: Failed to write to %x in %s\n",
+					file, blocks, reg, region_name);
+			}
+		}
+
+		pos += le32_to_cpu(blk->len) + sizeof(*blk);
+		blocks++;
+	}
+
+	if (pos > firmware->size)
+		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
+			  file, blocks, pos - firmware->size);
+
+out_fw:
+	release_firmware(firmware);
+out:
+	kfree(file);
+	return 0;
+}
+
+int wm_adsp1_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol,
+		   int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
+	struct wm_adsp *dsp = &dsps[w->shift];
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
+				   ADSP1_SYS_ENA, ADSP1_SYS_ENA);
+
+		ret = wm_adsp_load(dsp);
+		if (ret != 0)
+			goto err;
+
+		ret = wm_adsp_load_coeff(dsp);
+		if (ret != 0)
+			goto err;
+
+		/* Start the core running */
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
+				   ADSP1_CORE_ENA | ADSP1_START,
+				   ADSP1_CORE_ENA | ADSP1_START);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		/* Halt the core */
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
+				   ADSP1_CORE_ENA | ADSP1_START, 0);
+
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_19,
+				   ADSP1_WDMA_BUFFER_LENGTH_MASK, 0);
+
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
+				   ADSP1_SYS_ENA, 0);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+
+err:
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
+			   ADSP1_SYS_ENA, 0);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp1_event);
+
+static int wm_adsp2_ena(struct wm_adsp *dsp)
+{
+	unsigned int val;
+	int ret, count;
+
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+	if (ret != 0)
+		return ret;
+
+	/* Wait for the RAM to start, should be near instantaneous */
+	count = 0;
+	do {
+		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1,
+				  &val);
+		if (ret != 0)
+			return ret;
+	} while (!(val & ADSP2_RAM_RDY) && ++count < 10);
+
+	if (!(val & ADSP2_RAM_RDY)) {
+		adsp_err(dsp, "Failed to start DSP RAM\n");
+		return -EBUSY;
+	}
+
+	adsp_dbg(dsp, "RAM ready after %d polls\n", count);
+	adsp_info(dsp, "RAM ready after %d polls\n", count);
+
+	return 0;
+}
+
+int wm_adsp2_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
+	struct wm_adsp *dsp = &dsps[w->shift];
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		ret = wm_adsp2_ena(dsp);
+		if (ret != 0)
+			return ret;
+
+		ret = wm_adsp_load(dsp);
+		if (ret != 0)
+			goto err;
+
+		ret = wm_adsp_load_coeff(dsp);
+		if (ret != 0)
+			goto err;
+
+		ret = regmap_update_bits(dsp->regmap,
+					 dsp->base + ADSP2_CONTROL,
+					 ADSP2_SYS_ENA | ADSP2_START, 0);
+		if (ret != 0)
+			goto err;
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				   ADSP2_SYS_ENA | ADSP2_START, 0);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+err:
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_SYS_ENA | ADSP2_START, 0);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_event);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
new file mode 100644
index 0000000..b303b1f
--- /dev/null
+++ b/sound/soc/codecs/wm_adsp.h
@@ -0,0 +1,54 @@
+/*
+ * wm_adsp.h  --  Wolfson ADSP support
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
+#ifndef __WM_ADSP_H
+#define __WM_ADSP_H
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "wmfw.h"
+
+struct wm_adsp_region {
+	int type;
+	unsigned int base;
+};
+
+struct wm_adsp {
+	const char *part;
+	int num;
+	int type;
+	struct device *dev;
+	struct regmap *regmap;
+
+	int base;
+
+	const struct wm_adsp_region *mem;
+	int num_mems;
+};
+
+#define WM_ADSP1(wname, num) \
+	{ .id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, \
+	.shift = num, .event = wm_adsp1_event, \
+	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
+
+#define WM_ADSP2(wname, num) \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, \
+	.shift = num, .event = wm_adsp2_event, \
+	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
+
+int wm_adsp1_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event);
+int wm_adsp2_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event);
+
+#endif
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 5791f8e..5632ded 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -34,6 +34,13 @@ struct wmfw_adsp1_sizes {
 	__le32 zm;
 } __packed;
 
+struct wmfw_adsp2_sizes {
+	__le32 xm;
+	__le32 ym;
+	__le32 pm;
+	__le32 zm;
+} __packed;
+
 struct wmfw_region {
 	union {
 		__be32 type;
@@ -57,6 +64,14 @@ struct wmfw_adsp1_id_hdr {
 	__be32 algs;
 } __packed;
 
+struct wmfw_adsp2_id_hdr {
+	struct wmfw_id_hdr fw;
+	__be32 zm;
+	__be32 xm;
+	__be32 ym;
+	__be32 algs;
+} __packed;
+
 struct wmfw_alg_hdr {
 	__be32 id;
 	__be32 ver;
@@ -68,6 +83,13 @@ struct wmfw_adsp1_alg_hdr {
 	__be32 dm;
 } __packed;
 
+struct wmfw_adsp2_alg_hdr {
+	struct wmfw_alg_hdr alg;
+	__be32 zm;
+	__be32 xm;
+	__be32 ym;
+} __packed;
+
 struct wmfw_coeff_hdr {
 	u8 magic[4];
 	__le32 len;
@@ -86,7 +108,9 @@ struct wmfw_coeff_item {
 	__le32 len;
 	u8 data[];
 } __packed;
+
 #define WMFW_ADSP1 1
+#define WMFW_ADSP2 2
 
 #define WMFW_ABSOLUTE  0xf0
 #define WMFW_NAME_TEXT 0xfe
@@ -96,4 +120,9 @@ struct wmfw_coeff_item {
 #define WMFW_ADSP1_DM 3
 #define WMFW_ADSP1_ZM 4
 
+#define WMFW_ADSP2_PM 2
+#define WMFW_ADSP2_ZM 4
+#define WMFW_ADSP2_XM 5
+#define WMFW_ADSP2_YM 6
+
 #endif
-- 
1.7.10.4
