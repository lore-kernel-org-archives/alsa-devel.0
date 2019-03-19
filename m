From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add support for new Halo core
	DSPs" to the asoc tree
Date: Tue, 19 Mar 2019 13:13:00 +0000 (GMT)
Message-ID: <20190319131300.E81E511288DF@debutante.sirena.org.uk>
References: <20190319115215.22960-11-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BECFF896B9
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:12 +0100 (CET)
In-Reply-To: <20190319115215.22960-11-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Wen Shi <wenshi@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, Piotr Stankiewicz <piotrs@opensource.cirrus.com>, lgirdwood@gmail.com, david.rhodes@cirrus.com, Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add support for new Halo core DSPs

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

>From 170b1e123f385e7d60e992bc7fb1cc2897520769 Mon Sep 17 00:00:00 2001
From: Wen Shi <wenshi@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:13 +0000
Subject: [PATCH] ASoC: wm_adsp: Add support for new Halo core DSPs

The Halo core is a new generation of audio DSP architecture from
Cirrus Logic. A new iteration of the WMFW file format (v3) is also
added, for this new architecture. Currently this format is not
supported on the old ADSP2 architecture however support may be
added for it in the future.

Signed-off-by: Wen Shi <wenshi@opensource.cirrus.com>
Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 354 ++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/wm_adsp.h |   8 +
 sound/soc/codecs/wmfw.h    |  30 ++++
 3 files changed, 363 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index eccc640d6184..bd31056db4f5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -227,8 +227,54 @@
  */
 #define WM_ADSP_FW_EVENT_SHUTDOWN            0x000001
 
+/*
+ * HALO core
+ */
+#define HALO_SCRATCH1                        0x005c0
+#define HALO_SCRATCH2                        0x005c8
+#define HALO_SCRATCH3                        0x005d0
+#define HALO_SCRATCH4                        0x005d8
+#define HALO_CCM_CORE_CONTROL                0x41000
+#define HALO_CORE_SOFT_RESET                 0x00010
+
+/*
+ * HALO MPU banks
+ */
+#define HALO_MPU_XMEM_ACCESS_0               0x43000
+#define HALO_MPU_YMEM_ACCESS_0               0x43004
+#define HALO_MPU_WINDOW_ACCESS_0             0x43008
+#define HALO_MPU_XREG_ACCESS_0               0x4300C
+#define HALO_MPU_YREG_ACCESS_0               0x43014
+#define HALO_MPU_XMEM_ACCESS_1               0x43018
+#define HALO_MPU_YMEM_ACCESS_1               0x4301C
+#define HALO_MPU_WINDOW_ACCESS_1             0x43020
+#define HALO_MPU_XREG_ACCESS_1               0x43024
+#define HALO_MPU_YREG_ACCESS_1               0x4302C
+#define HALO_MPU_XMEM_ACCESS_2               0x43030
+#define HALO_MPU_YMEM_ACCESS_2               0x43034
+#define HALO_MPU_WINDOW_ACCESS_2             0x43038
+#define HALO_MPU_XREG_ACCESS_2               0x4303C
+#define HALO_MPU_YREG_ACCESS_2               0x43044
+#define HALO_MPU_XMEM_ACCESS_3               0x43048
+#define HALO_MPU_YMEM_ACCESS_3               0x4304C
+#define HALO_MPU_WINDOW_ACCESS_3             0x43050
+#define HALO_MPU_XREG_ACCESS_3               0x43054
+#define HALO_MPU_YREG_ACCESS_3               0x4305C
+#define HALO_MPU_LOCK_CONFIG                 0x43140
+
+/*
+ * HALO_CCM_CORE_CONTROL
+ */
+#define HALO_CORE_EN                        0x00000001
+
+/*
+ * HALO_CORE_SOFT_RESET
+ */
+#define HALO_CORE_SOFT_RESET_MASK           0x00000001
+
 struct wm_adsp_ops wm_adsp1_ops;
 struct wm_adsp_ops wm_adsp2_ops[];
+struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
 	struct list_head list;
@@ -309,6 +355,12 @@ struct wm_adsp_system_config_xm_hdr {
 	__be32 build_job_number;
 };
 
+struct wm_halo_system_config_xm_hdr {
+	__be32 halo_heartbeat;
+	__be32 build_job_name[3];
+	__be32 build_job_number;
+};
+
 struct wm_adsp_alg_xm_struct {
 	__be32 magic;
 	__be32 smoothing;
@@ -535,12 +587,18 @@ static const char *wm_adsp_mem_region_name(unsigned int type)
 	switch (type) {
 	case WMFW_ADSP1_PM:
 		return "PM";
+	case WMFW_HALO_PM_PACKED:
+		return "PM_PACKED";
 	case WMFW_ADSP1_DM:
 		return "DM";
 	case WMFW_ADSP2_XM:
 		return "XM";
+	case WMFW_HALO_XM_PACKED:
+		return "XM_PACKED";
 	case WMFW_ADSP2_YM:
 		return "YM";
+	case WMFW_HALO_YM_PACKED:
+		return "YM_PACKED";
 	case WMFW_ADSP1_ZM:
 		return "ZM";
 	default:
@@ -772,17 +830,12 @@ static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 					  unsigned int offset)
 {
-	if (WARN_ON(!mem))
-		return offset;
 	switch (mem->type) {
 	case WMFW_ADSP1_PM:
 		return mem->base + (offset * 3);
 	case WMFW_ADSP1_DM:
-		return mem->base + (offset * 2);
 	case WMFW_ADSP2_XM:
-		return mem->base + (offset * 2);
 	case WMFW_ADSP2_YM:
-		return mem->base + (offset * 2);
 	case WMFW_ADSP1_ZM:
 		return mem->base + (offset * 2);
 	default:
@@ -791,6 +844,24 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 	}
 }
 
+static unsigned int wm_halo_region_to_reg(struct wm_adsp_region const *mem,
+					  unsigned int offset)
+{
+	switch (mem->type) {
+	case WMFW_ADSP2_XM:
+	case WMFW_ADSP2_YM:
+		return mem->base + (offset * 4);
+	case WMFW_HALO_XM_PACKED:
+	case WMFW_HALO_YM_PACKED:
+		return (mem->base + (offset * 3)) & ~0x3;
+	case WMFW_HALO_PM_PACKED:
+		return mem->base + (offset * 5);
+	default:
+		WARN(1, "Unknown memory region type");
+		return offset;
+	}
+}
+
 static void wm_adsp_read_fw_status(struct wm_adsp *dsp,
 				   int noffs, unsigned int *offs)
 {
@@ -829,6 +900,18 @@ static void wm_adsp2v2_show_fw_status(struct wm_adsp *dsp)
 		 offs[1] & 0xFFFF, offs[1] >> 16);
 }
 
+static void wm_halo_show_fw_status(struct wm_adsp *dsp)
+{
+	unsigned int offs[] = {
+		HALO_SCRATCH1, HALO_SCRATCH2, HALO_SCRATCH3, HALO_SCRATCH4,
+	};
+
+	wm_adsp_read_fw_status(dsp, ARRAY_SIZE(offs), offs);
+
+	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
+		 offs[0], offs[1], offs[2], offs[3]);
+}
+
 static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
 {
 	return container_of(ext, struct wm_coeff_ctl, bytes_ext);
@@ -847,7 +930,7 @@ static int wm_coeff_base_reg(struct wm_coeff_ctl *ctl, unsigned int *reg)
 		return -EINVAL;
 	}
 
-	*reg = wm_adsp_region_to_reg(mem, ctl->alg_region.base + ctl->offset);
+	*reg = dsp->ops->region_to_reg(mem, ctl->alg_region.base + ctl->offset);
 
 	return 0;
 }
@@ -1335,28 +1418,33 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	case 1:
 		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s %x",
 			 dsp->name, region_name, alg_region->alg);
+		subname = NULL; /* don't append subname */
 		break;
-	default:
+	case 2:
 		ret = snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
 				"%s%c %.12s %x", dsp->name, *region_name,
 				wm_adsp_fw_text[dsp->fw], alg_region->alg);
+		break;
+	default:
+		ret = snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s %.12s %x", dsp->name,
+				wm_adsp_fw_text[dsp->fw], alg_region->alg);
+		break;
+	}
 
-		/* Truncate the subname from the start if it is too long */
-		if (subname) {
-			int avail = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret - 2;
-			int skip = 0;
+	if (subname) {
+		int avail = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret - 2;
+		int skip = 0;
 
-			if (dsp->component->name_prefix)
-				avail -= strlen(dsp->component->name_prefix) + 1;
+		if (dsp->component->name_prefix)
+			avail -= strlen(dsp->component->name_prefix) + 1;
 
-			if (subname_len > avail)
-				skip = subname_len - avail;
+		/* Truncate the subname from the start if it is too long */
+		if (subname_len > avail)
+			skip = subname_len - avail;
 
-			snprintf(name + ret,
-				 SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret, " %.*s",
-				 subname_len - skip, subname + skip);
-		}
-		break;
+		snprintf(name + ret, SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret,
+			 " %.*s", subname_len - skip, subname + skip);
 	}
 
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
@@ -1689,6 +1777,16 @@ static bool wm_adsp_validate_version(struct wm_adsp *dsp, unsigned int version)
 	}
 }
 
+static bool wm_halo_validate_version(struct wm_adsp *dsp, unsigned int version)
+{
+	switch (version) {
+	case 3:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
 	LIST_HEAD(buf_list);
@@ -1774,7 +1872,6 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		text = NULL;
 		offset = le32_to_cpu(region->offset) & 0xffffff;
 		type = be32_to_cpu(region->type) & 0xff;
-		mem = wm_adsp_find_region(dsp, type);
 
 		switch (type) {
 		case WMFW_NAME_TEXT:
@@ -1802,8 +1899,17 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		case WMFW_ADSP2_XM:
 		case WMFW_ADSP2_YM:
 		case WMFW_ADSP1_ZM:
+		case WMFW_HALO_PM_PACKED:
+		case WMFW_HALO_XM_PACKED:
+		case WMFW_HALO_YM_PACKED:
+			mem = wm_adsp_find_region(dsp, type);
+			if (!mem) {
+				adsp_err(dsp, "No region of type: %x\n", type);
+				goto out_fw;
+			}
+
 			region_name = wm_adsp_mem_region_name(type);
-			reg = wm_adsp_region_to_reg(mem, offset);
+			reg = dsp->ops->region_to_reg(mem, offset);
 			break;
 		default:
 			adsp_warn(dsp,
@@ -1916,7 +2022,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	}
 
 	/* Read the terminator first to validate the length */
-	reg = wm_adsp_region_to_reg(mem, pos + len);
+	reg = dsp->ops->region_to_reg(mem, pos + len);
 
 	ret = regmap_raw_read(dsp->regmap, reg, &val, sizeof(val));
 	if (ret != 0) {
@@ -1936,7 +2042,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	if (!alg)
 		return ERR_PTR(-ENOMEM);
 
-	reg = wm_adsp_region_to_reg(mem, pos);
+	reg = dsp->ops->region_to_reg(mem, pos);
 
 	ret = regmap_raw_read(dsp->regmap, reg, alg, len);
 	if (ret != 0) {
@@ -2008,6 +2114,35 @@ static void wmfw_parse_id_header(struct wm_adsp *dsp,
 		  nalgs);
 }
 
+static void wmfw_v3_parse_id_header(struct wm_adsp *dsp,
+				    struct wmfw_v3_id_hdr *fw, int nalgs)
+{
+	dsp->fw_id = be32_to_cpu(fw->id);
+	dsp->fw_id_version = be32_to_cpu(fw->ver);
+	dsp->fw_vendor_id = be32_to_cpu(fw->vendor_id);
+
+	adsp_info(dsp, "Firmware: %x vendor: 0x%x v%d.%d.%d, %zu algorithms\n",
+		  dsp->fw_id, dsp->fw_vendor_id,
+		  (dsp->fw_id_version & 0xff0000) >> 16,
+		  (dsp->fw_id_version & 0xff00) >> 8, dsp->fw_id_version & 0xff,
+		  nalgs);
+}
+
+static int wm_adsp_create_regions(struct wm_adsp *dsp, __be32 id, int nregions,
+				int *type, __be32 *base)
+{
+	struct wm_adsp_alg_region *alg_region;
+	int i;
+
+	for (i = 0; i < nregions; i++) {
+		alg_region = wm_adsp_create_region(dsp, type[i], id, base[i]);
+		if (IS_ERR(alg_region))
+			return PTR_ERR(alg_region);
+	}
+
+	return 0;
+}
+
 static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 {
 	struct wmfw_adsp1_id_hdr adsp1_id;
@@ -2238,6 +2373,78 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 	return ret;
 }
 
+static int wm_halo_create_regions(struct wm_adsp *dsp, __be32 id,
+				  __be32 xm_base, __be32 ym_base)
+{
+	int types[] = {
+		WMFW_ADSP2_XM, WMFW_HALO_XM_PACKED,
+		WMFW_ADSP2_YM, WMFW_HALO_YM_PACKED
+	};
+	__be32 bases[] = { xm_base, xm_base, ym_base, ym_base };
+
+	return wm_adsp_create_regions(dsp, id, ARRAY_SIZE(types), types, bases);
+}
+
+static int wm_halo_setup_algs(struct wm_adsp *dsp)
+{
+	struct wmfw_halo_id_hdr halo_id;
+	struct wmfw_halo_alg_hdr *halo_alg;
+	const struct wm_adsp_region *mem;
+	unsigned int pos, len;
+	size_t n_algs;
+	int i, ret;
+
+	mem = wm_adsp_find_region(dsp, WMFW_ADSP2_XM);
+	if (WARN_ON(!mem))
+		return -EINVAL;
+
+	ret = regmap_raw_read(dsp->regmap, mem->base, &halo_id,
+			      sizeof(halo_id));
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to read algorithm info: %d\n",
+			 ret);
+		return ret;
+	}
+
+	n_algs = be32_to_cpu(halo_id.n_algs);
+
+	wmfw_v3_parse_id_header(dsp, &halo_id.fw, n_algs);
+
+	ret = wm_halo_create_regions(dsp, halo_id.fw.id,
+				     halo_id.ym_base, halo_id.ym_base);
+	if (ret)
+		return ret;
+
+	/* Calculate offset and length in DSP words */
+	pos = sizeof(halo_id) / sizeof(u32);
+	len = (sizeof(*halo_alg) * n_algs) / sizeof(u32);
+
+	halo_alg = wm_adsp_read_algs(dsp, n_algs, mem, pos, len);
+	if (IS_ERR(halo_alg))
+		return PTR_ERR(halo_alg);
+
+	for (i = 0; i < n_algs; i++) {
+		adsp_info(dsp,
+			  "%d: ID %x v%d.%d.%d XM@%x YM@%x\n",
+			  i, be32_to_cpu(halo_alg[i].alg.id),
+			  (be32_to_cpu(halo_alg[i].alg.ver) & 0xff0000) >> 16,
+			  (be32_to_cpu(halo_alg[i].alg.ver) & 0xff00) >> 8,
+			  be32_to_cpu(halo_alg[i].alg.ver) & 0xff,
+			  be32_to_cpu(halo_alg[i].xm_base),
+			  be32_to_cpu(halo_alg[i].ym_base));
+
+		ret = wm_halo_create_regions(dsp, halo_alg[i].alg.id,
+					     halo_alg[i].xm_base,
+					     halo_alg[i].ym_base);
+		if (ret)
+			goto out;
+	}
+
+out:
+	kfree(halo_alg);
+	return ret;
+}
+
 static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 {
 	LIST_HEAD(buf_list);
@@ -2332,7 +2539,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 					adsp_err(dsp, "No ZM\n");
 					break;
 				}
-				reg = wm_adsp_region_to_reg(mem, 0);
+				reg = dsp->ops->region_to_reg(mem, 0);
 
 			} else {
 				region_name = "register";
@@ -2344,6 +2551,9 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		case WMFW_ADSP1_ZM:
 		case WMFW_ADSP2_XM:
 		case WMFW_ADSP2_YM:
+		case WMFW_HALO_XM_PACKED:
+		case WMFW_HALO_YM_PACKED:
+		case WMFW_HALO_PM_PACKED:
 			adsp_dbg(dsp, "%s.%d: %d bytes in %x for %x\n",
 				 file, blocks, le32_to_cpu(blk->len),
 				 type, le32_to_cpu(blk->id));
@@ -2358,7 +2568,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 						le32_to_cpu(blk->id));
 			if (alg_region) {
 				reg = alg_region->base;
-				reg = wm_adsp_region_to_reg(mem, reg);
+				reg = dsp->ops->region_to_reg(mem, reg);
 				reg += offset;
 			} else {
 				adsp_err(dsp, "No %x for algorithm %x\n",
@@ -2748,6 +2958,37 @@ static void wm_adsp_boot_work(struct work_struct *work)
 	mutex_unlock(&dsp->pwr_lock);
 }
 
+static int wm_halo_configure_mpu(struct wm_adsp *dsp, unsigned int lock_regions)
+{
+	struct reg_sequence config[] = {
+		{ dsp->base + HALO_MPU_LOCK_CONFIG,     0x5555 },
+		{ dsp->base + HALO_MPU_LOCK_CONFIG,     0xAAAA },
+		{ dsp->base + HALO_MPU_XMEM_ACCESS_0,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_YMEM_ACCESS_0,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_WINDOW_ACCESS_0, lock_regions },
+		{ dsp->base + HALO_MPU_XREG_ACCESS_0,   lock_regions },
+		{ dsp->base + HALO_MPU_YREG_ACCESS_0,   lock_regions },
+		{ dsp->base + HALO_MPU_XMEM_ACCESS_1,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_YMEM_ACCESS_1,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_WINDOW_ACCESS_1, lock_regions },
+		{ dsp->base + HALO_MPU_XREG_ACCESS_1,   lock_regions },
+		{ dsp->base + HALO_MPU_YREG_ACCESS_1,   lock_regions },
+		{ dsp->base + HALO_MPU_XMEM_ACCESS_2,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_YMEM_ACCESS_2,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_WINDOW_ACCESS_2, lock_regions },
+		{ dsp->base + HALO_MPU_XREG_ACCESS_2,   lock_regions },
+		{ dsp->base + HALO_MPU_YREG_ACCESS_2,   lock_regions },
+		{ dsp->base + HALO_MPU_XMEM_ACCESS_3,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_YMEM_ACCESS_3,   0xFFFFFFFF },
+		{ dsp->base + HALO_MPU_WINDOW_ACCESS_3, lock_regions },
+		{ dsp->base + HALO_MPU_XREG_ACCESS_3,   lock_regions },
+		{ dsp->base + HALO_MPU_YREG_ACCESS_3,   lock_regions },
+		{ dsp->base + HALO_MPU_LOCK_CONFIG,     0 },
+	};
+
+	return regmap_multi_reg_write(dsp->regmap, config, ARRAY_SIZE(config));
+}
+
 int wm_adsp2_set_dspclk(struct snd_soc_dapm_widget *w, unsigned int freq)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
@@ -2970,6 +3211,23 @@ int wm_adsp_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(wm_adsp_event);
 
+static int wm_halo_start_core(struct wm_adsp *dsp)
+{
+	return regmap_update_bits(dsp->regmap,
+				  dsp->base + HALO_CCM_CORE_CONTROL,
+				  HALO_CORE_EN, HALO_CORE_EN);
+}
+
+static void wm_halo_stop_core(struct wm_adsp *dsp)
+{
+	regmap_update_bits(dsp->regmap, dsp->base + HALO_CCM_CORE_CONTROL,
+			   HALO_CORE_EN, 0);
+
+	/* reset halo core with CORE_SOFT_REEST */
+	regmap_update_bits(dsp->regmap, dsp->base + HALO_CORE_SOFT_RESET,
+			   HALO_CORE_SOFT_RESET_MASK, 1);
+}
+
 int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *component)
 {
 	char preload[32];
@@ -3031,6 +3289,22 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
 
+int wm_halo_init(struct wm_adsp *dsp)
+{
+	int ret;
+
+	ret = wm_adsp_common_init(dsp);
+	if (ret)
+		return ret;
+
+	dsp->ops = &wm_halo_ops;
+
+	INIT_WORK(&dsp->boot_work, wm_adsp_boot_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_halo_init);
+
 void wm_adsp2_remove(struct wm_adsp *dsp)
 {
 	struct wm_coeff_ctl *ctl;
@@ -3275,7 +3549,7 @@ static int wm_adsp_read_data_block(struct wm_adsp *dsp, int mem_type,
 	if (!mem)
 		return -EINVAL;
 
-	reg = wm_adsp_region_to_reg(mem, mem_addr);
+	reg = dsp->ops->region_to_reg(mem, mem_addr);
 
 	ret = regmap_raw_read(dsp->regmap, reg, data,
 			      sizeof(*data) * num_words);
@@ -3303,7 +3577,7 @@ static int wm_adsp_write_data_word(struct wm_adsp *dsp, int mem_type,
 	if (!mem)
 		return -EINVAL;
 
-	reg = wm_adsp_region_to_reg(mem, mem_addr);
+	reg = dsp->ops->region_to_reg(mem, mem_addr);
 
 	data = cpu_to_be32(data & 0x00ffffffu);
 
@@ -3414,7 +3688,7 @@ static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	alg_region = wm_adsp_find_alg_region(dsp, WMFW_ADSP2_XM, dsp->fw_id);
-	xmalg = sizeof(struct wm_adsp_system_config_xm_hdr) / sizeof(__be32);
+	xmalg = dsp->ops->sys_config_size / sizeof(__be32);
 
 	addr = alg_region->base + xmalg + ALG_XM_FIELD(magic);
 	ret = wm_adsp_read_data_word(dsp, WMFW_ADSP2_XM, addr, &magic);
@@ -4024,13 +4298,16 @@ EXPORT_SYMBOL_GPL(wm_adsp2_bus_error);
 struct wm_adsp_ops wm_adsp1_ops = {
 	.validate_version = wm_adsp_validate_version,
 	.parse_sizes = wm_adsp1_parse_sizes,
+	.region_to_reg = wm_adsp_region_to_reg,
 };
 
 struct wm_adsp_ops wm_adsp2_ops[] = {
 	{
+		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = wm_adsp2_parse_sizes,
 		.validate_version = wm_adsp_validate_version,
 		.setup_algs = wm_adsp2_setup_algs,
+		.region_to_reg = wm_adsp_region_to_reg,
 
 		.show_fw_status = wm_adsp2_show_fw_status,
 
@@ -4045,9 +4322,11 @@ struct wm_adsp_ops wm_adsp2_ops[] = {
 
 	},
 	{
+		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = wm_adsp2_parse_sizes,
 		.validate_version = wm_adsp_validate_version,
 		.setup_algs = wm_adsp2_setup_algs,
+		.region_to_reg = wm_adsp_region_to_reg,
 
 		.show_fw_status = wm_adsp2v2_show_fw_status,
 
@@ -4062,9 +4341,11 @@ struct wm_adsp_ops wm_adsp2_ops[] = {
 		.stop_core = wm_adsp2_stop_core,
 	},
 	{
+		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = wm_adsp2_parse_sizes,
 		.validate_version = wm_adsp_validate_version,
 		.setup_algs = wm_adsp2_setup_algs,
+		.region_to_reg = wm_adsp_region_to_reg,
 
 		.show_fw_status = wm_adsp2v2_show_fw_status,
 		.stop_watchdog = wm_adsp_stop_watchdog,
@@ -4081,4 +4362,19 @@ struct wm_adsp_ops wm_adsp2_ops[] = {
 	},
 };
 
+struct wm_adsp_ops wm_halo_ops = {
+	.sys_config_size = sizeof(struct wm_halo_system_config_xm_hdr),
+	.parse_sizes = wm_adsp2_parse_sizes,
+	.validate_version = wm_halo_validate_version,
+	.setup_algs = wm_halo_setup_algs,
+	.region_to_reg = wm_halo_region_to_reg,
+
+	.show_fw_status = wm_halo_show_fw_status,
+
+	.lock_memory = wm_halo_configure_mpu,
+
+	.start_core = wm_halo_start_core,
+	.stop_core = wm_halo_stop_core,
+};
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index c75a671c19a1..e7f1fde2b54b 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -70,6 +70,7 @@ struct wm_adsp {
 	struct wm_adsp_ops *ops;
 
 	unsigned int base;
+	unsigned int base_sysinfo;
 	unsigned int sysclk_reg;
 	unsigned int sysclk_mask;
 	unsigned int sysclk_shift;
@@ -78,6 +79,7 @@ struct wm_adsp {
 
 	unsigned int fw_id;
 	unsigned int fw_id_version;
+	unsigned int fw_vendor_id;
 
 	const struct wm_adsp_region *mem;
 	int num_mems;
@@ -110,12 +112,16 @@ struct wm_adsp {
 };
 
 struct wm_adsp_ops {
+	unsigned int sys_config_size;
+
 	bool (*validate_version)(struct wm_adsp *dsp, unsigned int version);
 	unsigned int (*parse_sizes)(struct wm_adsp *dsp,
 				    const char * const file,
 				    unsigned int pos,
 				    const struct firmware *firmware);
 	int (*setup_algs)(struct wm_adsp *dsp);
+	unsigned int (*region_to_reg)(struct wm_adsp_region const *mem,
+				      unsigned int offset);
 
 	void (*show_fw_status)(struct wm_adsp *dsp);
 	void (*stop_watchdog)(struct wm_adsp *dsp);
@@ -160,6 +166,8 @@ int wm_adsp2_init(struct wm_adsp *dsp);
 void wm_adsp2_remove(struct wm_adsp *dsp);
 int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *component);
 int wm_adsp2_component_remove(struct wm_adsp *dsp, struct snd_soc_component *component);
+int wm_halo_init(struct wm_adsp *dsp);
+
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 0c3f50acb8b1..14b2d1a2fc59 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -73,6 +73,14 @@ struct wmfw_id_hdr {
 	__be32 ver;
 } __packed;
 
+struct wmfw_v3_id_hdr {
+	__be32 core_id;
+	__be32 block_rev;
+	__be32 vendor_id;
+	__be32 id;
+	__be32 ver;
+} __packed;
+
 struct wmfw_adsp1_id_hdr {
 	struct wmfw_id_hdr fw;
 	__be32 zm;
@@ -88,6 +96,15 @@ struct wmfw_adsp2_id_hdr {
 	__be32 n_algs;
 } __packed;
 
+struct wmfw_halo_id_hdr {
+	struct wmfw_v3_id_hdr fw;
+	__be32 xm_base;
+	__be32 xm_size;
+	__be32 ym_base;
+	__be32 ym_size;
+	__be32 n_algs;
+} __packed;
+
 struct wmfw_alg_hdr {
 	__be32 id;
 	__be32 ver;
@@ -106,6 +123,14 @@ struct wmfw_adsp2_alg_hdr {
 	__be32 ym;
 } __packed;
 
+struct wmfw_halo_alg_hdr {
+	struct wmfw_alg_hdr alg;
+	__be32 xm_base;
+	__be32 xm_size;
+	__be32 ym_base;
+	__be32 ym_size;
+} __packed;
+
 struct wmfw_adsp_alg_data {
 	__le32 id;
 	u8 name[WMFW_MAX_ALG_NAME];
@@ -154,6 +179,7 @@ struct wmfw_coeff_item {
 
 #define WMFW_ADSP1 1
 #define WMFW_ADSP2 2
+#define WMFW_HALO 4
 
 #define WMFW_ABSOLUTE         0xf0
 #define WMFW_ALGORITHM_DATA   0xf2
@@ -169,4 +195,8 @@ struct wmfw_coeff_item {
 #define WMFW_ADSP2_XM 5
 #define WMFW_ADSP2_YM 6
 
+#define WMFW_HALO_PM_PACKED 0x10
+#define WMFW_HALO_XM_PACKED 0x11
+#define WMFW_HALO_YM_PACKED 0x12
+
 #endif
-- 
2.20.1
