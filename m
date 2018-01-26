From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add extended I2S config
	blob support in Clock driver" to the asoc tree
Date: Fri, 26 Jan 2018 12:54:04 +0000
Message-ID: <E1ef3W8-0002Fi-Cx@debutante>
References: <1512978390-8848-3-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 91CE9267666
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 13:54:20 +0100 (CET)
In-Reply-To: <1512978390-8848-3-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add extended I2S config blob support in Clock driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9afbc5ec76526d412de1c5c368524aae36eb608d Mon Sep 17 00:00:00 2001
From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Date: Thu, 4 Jan 2018 16:55:15 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add extended I2S config blob support in
 Clock driver

Extended I2S config blob supports multiple mclk dividers in NHLT blob.
This patch detects whether the I2S blob is legacy or extended based on the
signature value and chooses the mclk source and divider accordingly.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 3b1d2b828c1b..b9b140275be0 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -28,6 +28,7 @@ static guid_t osc_guid =
 	GUID_INIT(0xA69F886E, 0x6CEB, 0x4594,
 		  0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53);
 
+
 struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 {
 	acpi_handle handle;
@@ -287,6 +288,7 @@ void skl_nhlt_remove_sysfs(struct skl *skl)
 static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 				struct nhlt_fmt *fmt, u8 id)
 {
+	struct skl_i2s_config_blob_ext *i2s_config_ext;
 	struct skl_i2s_config_blob_legacy *i2s_config;
 	struct skl_clk_parent_src *parent;
 	struct skl_ssp_clk *sclk, *sclkfs;
@@ -347,12 +349,18 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 
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
 
@@ -378,6 +386,7 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 static void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
 				struct nhlt_fmt *fmt, u8 id)
 {
+	struct skl_i2s_config_blob_ext *i2s_config_ext;
 	struct skl_i2s_config_blob_legacy *i2s_config;
 	struct nhlt_specific_cfg *fmt_cfg;
 	struct skl_clk_parent_src *parent;
@@ -385,13 +394,21 @@ static void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
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
2.15.1
