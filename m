From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [alsa-devel] [PATCH v5 2/6] ASoC: Intel: Skylake: Add extended I2S config blob support in Clock driver
Date: Mon, 11 Dec 2017 13:16:26 +0530
Message-ID: <1512978390-8848-3-git-send-email-sriramx.periyasamy@intel.com>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, Sriram Periyasamy <sriramx.periyasamy@intel.com>
List-Id: alsa-devel@alsa-project.org

Extended I2S config blob supports multiple mclk dividers in NHLT blob.
This patch detects whether the I2S blob is legacy or extended based on the
signature value and chooses the mclk source and divider accordingly.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-i2s.h  | 31 ++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-nhlt.c | 41 +++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-i2s.h b/sound/soc/intel/skylake/skl-i2s.h
index dcf819bc688f..ad0a1bbca13c 100644
--- a/sound/soc/intel/skylake/skl-i2s.h
+++ b/sound/soc/intel/skylake/skl-i2s.h
@@ -27,6 +27,12 @@
 #define SKL_SHIFT(x)			(ffs(x) - 1)
 #define SKL_MCLK_DIV_RATIO_MASK		GENMASK(11, 0)
 
+#define is_legacy_blob(x) (x.signature != 0xEE)
+#define ext_to_legacy_blob(i2s_config_blob_ext) \
+	((struct skl_i2s_config_blob_legacy *) i2s_config_blob_ext)
+
+#define get_clk_src(mclk, mask) \
+		((mclk.mdivctrl & mask) >> SKL_SHIFT(mask))
 struct skl_i2s_config {
 	u32 ssc0;
 	u32 ssc1;
@@ -45,6 +51,24 @@ struct skl_i2s_config_mclk {
 	u32 mdivr;
 };
 
+struct skl_i2s_config_mclk_ext {
+	u32 mdivctrl;
+	u32 mdivr_count;
+	u32 mdivr[0];
+} __packed;
+
+struct skl_i2s_config_blob_signature {
+	u32 minor_ver : 8;
+	u32 major_ver : 8;
+	u32 resvdz : 8;
+	u32 signature : 8;
+} __packed;
+
+struct skl_i2s_config_blob_header {
+	struct skl_i2s_config_blob_signature sig;
+	u32 size;
+};
+
 /**
  * struct skl_i2s_config_blob_legacy - Structure defines I2S Gateway
  * configuration legacy blob
@@ -61,4 +85,11 @@ struct skl_i2s_config_blob_legacy {
 	struct skl_i2s_config_mclk mclk;
 };
 
+struct skl_i2s_config_blob_ext {
+	u32 gtw_attr;
+	struct skl_i2s_config_blob_header hdr;
+	u32 tdm_ts_group[SKL_I2S_MAX_TIME_SLOTS];
+	struct skl_i2s_config i2s_cfg;
+	struct skl_i2s_config_mclk_ext mclk;
+} __packed;
 #endif /* __SOUND_SOC_SKL_I2S_H */
diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index ca5dc2be7b68..770a9c7afca1 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -26,6 +26,7 @@ static guid_t osc_guid =
 	GUID_INIT(0xA69F886E, 0x6CEB, 0x4594,
 		  0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53);
 
+
 struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 {
 	acpi_handle handle;
@@ -272,6 +273,7 @@ void skl_nhlt_remove_sysfs(struct skl *skl)
 static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 				struct nhlt_fmt *fmt, u8 id)
 {
+	struct skl_i2s_config_blob_ext *i2s_config_ext;
 	struct skl_i2s_config_blob_legacy *i2s_config;
 	struct skl_clk_parent_src *parent;
 	struct skl_ssp_clk *sclk, *sclkfs;
@@ -332,12 +334,18 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 
 		/* Fill rate and parent for sclk/sclkfs */
 		if (!present) {
-			/* MCLK Divider Source Select */
-			i2s_config = (struct skl_i2s_config_blob_legacy *)
+			i2s_config_ext = (struct skl_i2s_config_blob_ext *)
 						fmt->fmt_config[0].config.caps;
-			clk_src = ((i2s_config->mclk.mdivctrl)
-					& SKL_MNDSS_DIV_CLK_SRC_MASK) >>
-					SKL_SHIFT(SKL_MNDSS_DIV_CLK_SRC_MASK);
+
+			/* MCLK Divider Source Select */
+			if (is_legacy_blob(i2s_config_ext->hdr.sig)) {
+				i2s_config = ext_to_legacy_blob(i2s_config_ext);
+				clk_src = get_clk_src(i2s_config->mclk,
+						SKL_MNDSS_DIV_CLK_SRC_MASK);
+			} else {
+				clk_src = get_clk_src(i2s_config_ext->mclk,
+						SKL_MNDSS_DIV_CLK_SRC_MASK);
+			}
 
 			parent = skl_get_parent_clk(clk_src);
 
@@ -363,6 +371,7 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 static void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
 				struct nhlt_fmt *fmt, u8 id)
 {
+	struct skl_i2s_config_blob_ext *i2s_config_ext;
 	struct skl_i2s_config_blob_legacy *i2s_config;
 	struct nhlt_specific_cfg *fmt_cfg;
 	struct skl_clk_parent_src *parent;
@@ -370,13 +379,21 @@ static void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
 	u8 clk_src;
 
 	fmt_cfg = &fmt->fmt_config[0].config;
-	i2s_config = (struct skl_i2s_config_blob_legacy *)fmt_cfg->caps;
-
-	/* MCLK Divider Source Select */
-	clk_src = ((i2s_config->mclk.mdivctrl) & SKL_MCLK_DIV_CLK_SRC_MASK) >>
-					SKL_SHIFT(SKL_MCLK_DIV_CLK_SRC_MASK);
-
-	clkdiv = i2s_config->mclk.mdivr & SKL_MCLK_DIV_RATIO_MASK;
+	i2s_config_ext = (struct skl_i2s_config_blob_ext *)fmt_cfg->caps;
+
+	/* MCLK Divider Source Select and divider */
+	if (is_legacy_blob(i2s_config_ext->hdr.sig)) {
+		i2s_config = ext_to_legacy_blob(i2s_config_ext);
+		clk_src = get_clk_src(i2s_config->mclk,
+				SKL_MCLK_DIV_CLK_SRC_MASK);
+		clkdiv = i2s_config->mclk.mdivr &
+				SKL_MCLK_DIV_RATIO_MASK;
+	} else {
+		clk_src = get_clk_src(i2s_config_ext->mclk,
+				SKL_MCLK_DIV_CLK_SRC_MASK);
+		clkdiv = i2s_config_ext->mclk.mdivr[0] &
+				SKL_MCLK_DIV_RATIO_MASK;
+	}
 
 	/* bypass divider */
 	div_ratio = 1;
-- 
2.7.4

