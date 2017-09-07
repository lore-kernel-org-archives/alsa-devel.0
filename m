From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/6] ASoC: Intel: Skylake: Parse nhlt to populate clock information
Date: Thu,  7 Sep 2017 19:59:21 +0530
Message-ID: <1504794565-19168-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>

NHLT is parsed to fill the SSP clock information. If an endpoint is present
for a SSP, then the corresponding SSP clocks are created.

MCLK is consistent across endpoints and configuration for an SSP. So NHLT
is queried for the first endpoint for an SSP and MCLK information for that
SSP is populated.

For SCLK/SCLKFS, the best fit is queried from the NHLT configurations which
matches the clock rate requested. Best fit is decided based on below:

1. If rate matches with multiple configurations, then the first
configuration is selected.

2. If for a selected fs and bits_per_sample, there are multiple endpoint
configuration match, then the configuration with max number of channels is
selected. So, the user has to set the rate which fits max number of
channels

Max of 18 clocks created, 3 for each SSP and there are 6 SSPs. There are
also 3 parent clocks XTAL, Cardinal and PLL. This patch populates the all
the clock information.

Cardinal/PLL are fixed for all platforms. For XTAL, APL/GLK uses 19.2MHz,
whereas for SKL/APL it is 24MHz.

Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-i2s.h     |  56 +++++++++++++
 sound/soc/intel/skylake/skl-nhlt.c    | 148 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.h |  86 ++++++++++++++++++++
 sound/soc/intel/skylake/skl.c         |  71 ++++++++++++++++
 sound/soc/intel/skylake/skl.h         |   3 +
 5 files changed, 364 insertions(+)
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h

diff --git a/sound/soc/intel/skylake/skl-i2s.h b/sound/soc/intel/skylake/skl-i2s.h
new file mode 100644
index 000000000000..378d17adde9d
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-i2s.h
@@ -0,0 +1,56 @@
+/*
+ *  skl-i2s.h - i2s blob mapping
+ *
+ *  Copyright (C) 2017 Intel Corp
+ *  Author: Subhransu S. Prusty < subhransu.s.prusty@intel.com>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef __SOUND_SOC_SKL_I2S_H
+#define __SOUND_SOC_SKL_I2S_H
+
+#define SKL_I2S_MAX_TIME_SLOTS		8
+#define SKL_MCLK_DIV_CLK_SRC_MASK	GENMASK(17, 16)
+#define SKL_MCLK_DIV_CLK_SRC_SHIFT	16
+
+#define SKL_MNDSS_DIV_CLK_SRC_MASK	GENMASK(21, 20)
+#define SKL_MNDSS_DIV_CLK_SRC_SHIFT	20
+#define SKL_MCLK_DIV_RATIO_MASK		GENMASK(11, 0)
+
+struct skl_i2s_config {
+	u32 ssc0;
+	u32 ssc1;
+	u32 sscto;
+	u32 sspsp;
+	u32 sstsa;
+	u32 ssrsa;
+	u32 ssc2;
+	u32 sspsp2;
+	u32 ssc3;
+	u32 ssioc;
+} __packed;
+
+struct skl_i2s_config_mclk {
+	u32 mdivctrl;
+	u32 mdivr;
+} __packed;
+
+struct skl_i2s_config_blob_legacy {
+	u32 gtw_attr;
+	u32 tdm_ts_group[SKL_I2S_MAX_TIME_SLOTS];
+	struct skl_i2s_config i2s_cfg;
+	struct skl_i2s_config_mclk mclk;
+};
+
+#endif /* __SOUND_SOC_SKL_I2S_H */
diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index e7d766d56c8e..a6bf7cd01ddf 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -19,6 +19,7 @@
  */
 #include <linux/pci.h>
 #include "skl.h"
+#include "skl-i2s.h"
 
 /* Unique identification for getting NHLT blobs */
 static guid_t osc_guid =
@@ -262,3 +263,150 @@ void skl_nhlt_remove_sysfs(struct skl *skl)
 
 	sysfs_remove_file(&dev->kobj, &dev_attr_platform_id.attr);
 }
+
+/*
+ * Queries NHLT for all the fmt configuration for a particular endpoint and
+ * stores all possible rates supported in a rate table for the corresponding
+ * sclk/sclkfs.
+ */
+void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
+				struct nhlt_fmt *fmt, u8 id)
+{
+	struct nhlt_fmt_cfg *fmt_cfg;
+	struct skl_i2s_config_blob_legacy *i2s_config;
+	struct wav_fmt_ext *wav_fmt;
+	struct skl_clk_parent_src *parent;
+	struct skl_ssp_clk *sclk, *sclkfs;
+	unsigned long rate = 0;
+	u16 channels, bps;
+	u32 fs;
+	u8 clk_src;
+	int rate_index = 0;
+	int i, j;
+	bool present = false;
+
+	sclk = &ssp_clks[SKL_SCLK_OFS];
+	sclkfs = &ssp_clks[SKL_SCLKFS_OFS];
+
+	if (fmt->fmt_count == 0)
+		return;
+
+	for (i = 0; i < fmt->fmt_count; i++) {
+		fmt_cfg = &fmt->fmt_config[i];
+		wav_fmt = &fmt_cfg->fmt_ext;
+
+		channels = wav_fmt->fmt.channels;
+		bps = wav_fmt->fmt.bits_per_sample;
+		fs = wav_fmt->fmt.samples_per_sec;
+
+		/*
+		 * In case of TDM configuration on the same ssp, there can
+		 * be more than one blob in which channel masks are
+		 * different for each usecase for a specific rate and bps.
+		 * But the sclk rate will be based on the total number of
+		 * channels used for that endpoint.
+		 *
+		 * So there is a blob which represent the superset of all
+		 * the channels used for that endpoint. Select the rate that
+		 * matches with the blob which has the number of channels is
+		 * equall to all channel for that endpoint.
+		 */
+		for (j = i; j < fmt->fmt_count; j++) {
+			fmt_cfg = &fmt->fmt_config[j];
+			wav_fmt = &fmt_cfg->fmt_ext;
+			if ((fs == wav_fmt->fmt.samples_per_sec) &&
+					(bps == wav_fmt->fmt.bits_per_sample) &&
+					(channels < wav_fmt->fmt.channels)) {
+
+				channels = wav_fmt->fmt.channels;
+			}
+		}
+
+		rate = channels * bps * fs;
+
+		/* check if the rate is already present */
+		for (j = 0; (sclk[id].rate_cfg[j].rate != 0) &&
+				(j < SKL_MAX_CLK_RATES); j++) {
+			if (sclk[id].rate_cfg[j].rate == rate) {
+				present = true;
+				break;
+			}
+		}
+
+		/* Fill rate and parent for sclk/sclkfs */
+		if (!present) {
+			sclk[id].rate_cfg[rate_index].rate = rate;
+			sclk[id].rate_cfg[rate_index].config = fmt_cfg;
+			sclkfs[id].rate_cfg[rate_index].rate = rate;
+			sclkfs[id].rate_cfg[rate_index].config = fmt_cfg;
+
+			/* MCLK Divider Source Select */
+			i2s_config = (struct skl_i2s_config_blob_legacy *)
+						fmt->fmt_config[0].config.caps;
+			clk_src = ((i2s_config->mclk.mdivctrl)
+					& SKL_MNDSS_DIV_CLK_SRC_MASK) >>
+					SKL_MNDSS_DIV_CLK_SRC_SHIFT;
+
+			parent = skl_get_parent_clk(clk_src);
+			sclk[id].parent_name = parent->name;
+			sclkfs[id].parent_name = parent->name;
+
+			rate_index++;
+		}
+	}
+}
+
+void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
+				struct nhlt_fmt *fmt, u8 id)
+{
+	struct nhlt_specific_cfg *fmt_cfg;
+	struct skl_i2s_config_blob_legacy *i2s_config;
+	struct skl_clk_parent_src *parent;
+	u32 clkdiv, div_ratio;
+	u8 clk_src;
+
+	fmt_cfg = &fmt->fmt_config[0].config;
+	i2s_config = (struct skl_i2s_config_blob_legacy *)fmt_cfg->caps;
+
+	/* MCLK Divider Source Select */
+	clk_src = ((i2s_config->mclk.mdivctrl) & SKL_MCLK_DIV_CLK_SRC_MASK) >>
+						SKL_MCLK_DIV_CLK_SRC_SHIFT;
+
+
+	clkdiv = i2s_config->mclk.mdivr & SKL_MCLK_DIV_RATIO_MASK;
+
+	if (clkdiv == 0xfff) /* bypass divider */
+		div_ratio = 1;
+	else
+		/* Divider is 2 + clkdiv */
+		div_ratio = clkdiv + 2;
+
+	/* Calculate MCLK rate from source using div value */
+	parent = skl_get_parent_clk(clk_src);
+	mclk[id].rate_cfg[0].rate = parent->rate/div_ratio;
+	mclk[id].rate_cfg[0].config = &fmt->fmt_config[0];
+	mclk[id].parent_name = parent->name;
+}
+
+void skl_get_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks)
+{
+	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
+	struct nhlt_endpoint *epnt;
+	struct nhlt_fmt *fmt;
+	int i;
+	u8 id;
+
+	epnt = (struct nhlt_endpoint *)nhlt->desc;
+	for (i = 0; i < nhlt->endpoint_count; i++) {
+		if (epnt->linktype == NHLT_LINK_SSP) {
+			id = epnt->virtual_bus_id;
+
+			fmt = (struct nhlt_fmt *)(epnt->config.caps
+					+ epnt->config.size);
+
+			skl_get_ssp_clks(skl, ssp_clks, fmt, id);
+			skl_get_mclk(skl, ssp_clks, fmt, id);
+		}
+		epnt = (struct nhlt_endpoint *)((u8 *)epnt + epnt->length);
+	}
+}
diff --git a/sound/soc/intel/skylake/skl-ssp-clk.h b/sound/soc/intel/skylake/skl-ssp-clk.h
new file mode 100644
index 000000000000..9d98f458f08a
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-ssp-clk.h
@@ -0,0 +1,86 @@
+/*
+ *  skl-ssp-clk.h - Skylake ssp clock information and ipc structure
+ *
+ *  Copyright (C) 2017 Intel Corp
+ *  Author: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef SOUND_SOC_SKL_SSP_CLK_H
+#define SOUND_SOC_SKL_SSP_CLK_H
+
+#define SKL_MAX_SSP		6
+#define SKL_MAX_CLK_SRC		3 /* xtal/cardinal/pll, parent of ssp clocks and mclk */
+#define SKL_MAX_SSP_CLK_TYPES	3 /* mclk, sclk, sclkfs */
+
+#define SKL_MAX_CLK_CNT		(SKL_MAX_SSP * SKL_MAX_SSP_CLK_TYPES)
+
+/* Max number of configurations supported for each clock */
+#define SKL_MAX_CLK_RATES	10
+
+#define SKL_SCLK_OFS		SKL_MAX_SSP
+#define SKL_SCLKFS_OFS		(SKL_SCLK_OFS + SKL_MAX_SSP)
+
+enum skl_clk_type {
+	SKL_MCLK,
+	SKL_SCLK,
+	SKL_SCLK_FS,
+};
+
+enum skl_clk_src_type {
+	SKL_XTAL,
+	SKL_CARDINAL,
+	SKL_PLL,
+};
+
+struct skl_clk_parent_src {
+	u8 clk_id;
+	const char *name;
+	unsigned long rate;
+	const char *parent_name;
+};
+
+struct skl_clk_rate_cfg_table {
+	unsigned long rate;
+	void *config;
+};
+
+/*
+ * rate for mclk will be in rates[0]. For sclk and sclkfs, rates[] store
+ * all possible clocks ssp can generate for that platform.
+ */
+struct skl_ssp_clk {
+	const char *name;
+	const char *parent_name;
+	struct skl_clk_rate_cfg_table rate_cfg[SKL_MAX_CLK_RATES];
+};
+
+struct skl_clk_ops {
+	int (*prepare)(void *pvt_data, u32 id, unsigned long rate);
+	int (*unprepare)(void *pvt_data, u32 id, unsigned long rate);
+	int (*set_rate)(u32 id, unsigned long rate);
+	unsigned long (*recalc_rate)(u32 id, unsigned long parent_rate);
+};
+
+struct skl_clk_pdata {
+	struct skl_clk_parent_src *parent_clks;
+	int num_clks;
+	struct skl_ssp_clk *ssp_clks;
+	struct skl_clk_ops *ops;
+	void *pvt_data;
+};
+
+#endif /* SOUND_SOC_SKL_SSP_CLK_H */
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f94b484abb99..440caf1ced43 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -435,6 +435,23 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	return 0;
 }
 
+/*
+ * For each ssp there are 3 clocks (mclk/sclk/sclkfs).
+ * e.g. for ssp0, clocks will be named as
+ *      "ssp0_mclk", "ssp0_sclk", "ssp0_sclkfs"
+ * So for skl+, there are 6 ssps, so 18 clocks will be created.
+ */
+static struct skl_ssp_clk skl_ssp_clks[] = {
+	{.name = "ssp0_mclk"}, {.name = "ssp1_mclk"}, {.name = "ssp2_mclk"},
+	{.name = "ssp3_mclk"}, {.name = "ssp4_mclk"}, {.name = "ssp5_mclk"},
+	{.name = "ssp0_sclk"}, {.name = "ssp1_sclk"}, {.name = "ssp2_sclk"},
+	{.name = "ssp3_sclk"}, {.name = "ssp4_sclk"}, {.name = "ssp5_sclk"},
+	{.name = "ssp0_sclkfs"}, {.name = "ssp1_sclkfs"},
+						{.name = "ssp2_sclkfs"},
+	{.name = "ssp3_sclkfs"}, {.name = "ssp4_sclkfs"},
+						{.name = "ssp5_sclkfs"},
+};
+
 static int skl_machine_device_register(struct skl *skl, void *driver_data)
 {
 	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
@@ -506,6 +523,60 @@ static void skl_dmic_device_unregister(struct skl *skl)
 		platform_device_unregister(skl->dmic_dev);
 }
 
+static struct skl_clk_parent_src skl_clk_src[] = {
+	{ .clk_id = SKL_XTAL, .name = "xtal" },
+	{ .clk_id = SKL_CARDINAL, .name = "cardinal", .rate = 24576000 },
+	{ .clk_id = SKL_PLL, .name = "pll", .rate = 96000000 },
+};
+
+struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(skl_clk_src); i++) {
+		if (skl_clk_src[i].clk_id == clk_id)
+			return &skl_clk_src[i];
+	}
+
+	return NULL;
+}
+
+void init_skl_xtal_rate(int pci_id)
+{
+	switch (pci_id) {
+	case 0x9d70:
+	case 0x9d71:
+		skl_clk_src[0].rate = 24000000;
+		return;
+
+	default:
+		skl_clk_src[0].rate = 19200000;
+		return;
+	}
+}
+
+static int skl_clock_device_register(struct skl *skl)
+{
+	struct skl_clk_pdata *clk_pdata;
+
+
+	clk_pdata = devm_kzalloc(&skl->pci->dev, sizeof(*clk_pdata),
+							GFP_KERNEL);
+	if (!clk_pdata)
+		return -ENOMEM;
+
+	init_skl_xtal_rate(skl->pci->device);
+
+	clk_pdata->parent_clks = skl_clk_src;
+	clk_pdata->ssp_clks = skl_ssp_clks;
+	clk_pdata->num_clks = ARRAY_SIZE(skl_ssp_clks);
+
+	/* Query NHLT to fill the rates and parent */
+	skl_get_clks(skl, clk_pdata->ssp_clks);
+
+	return 0;
+}
+
 /*
  * Probe the given codec address
  */
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 8d9d6899f761..ff75de370c45 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -25,6 +25,7 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/soc.h>
 #include "skl-nhlt.h"
+#include "skl-ssp-clk.h"
 
 #define SKL_SUSPEND_DELAY 2000
 
@@ -123,6 +124,8 @@ struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 void skl_update_d0i3c(struct device *dev, bool enable);
 int skl_nhlt_create_sysfs(struct skl *skl);
 void skl_nhlt_remove_sysfs(struct skl *skl);
+void skl_get_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks);
+struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id);
 
 struct skl_module_cfg;
 
-- 
1.9.1

