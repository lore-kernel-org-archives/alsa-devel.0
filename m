From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm2200: Convert over to wm_adsp for
	ADSP1 support
Date: Fri, 26 Oct 2012 19:36:32 +0100
Message-ID: <1351276594-30453-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A04C7265B71
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 20:36:37 +0200 (CEST)
In-Reply-To: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |  432 ++++-----------------------------------------
 1 file changed, 32 insertions(+), 400 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 2148ee3..1730df8 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -34,6 +34,7 @@
 
 #include "wm2200.h"
 #include "wmfw.h"
+#include "wm_adsp.h"
 
 #define WM2200_DSP_CONTROL_1                   0x00
 #define WM2200_DSP_CONTROL_2                   0x02
@@ -83,6 +84,7 @@ struct wm2200_fll {
 
 /* codec private data */
 struct wm2200_priv {
+	struct wm_adsp dsp[2];
 	struct regmap *regmap;
 	struct device *dev;
 	struct snd_soc_codec *codec;
@@ -152,6 +154,18 @@ static const struct regmap_range_cfg wm2200_ranges[] = {
 	  .window_start = WM2200_DSP2_ZM_0, .window_len = 1024, },
 };
 
+static const struct wm_adsp_region wm2200_dsp1_regions[] = {
+	{ .type = WMFW_ADSP1_PM, .base = WM2200_DSP1_PM_BASE },
+	{ .type = WMFW_ADSP1_DM, .base = WM2200_DSP1_DM_BASE },
+	{ .type = WMFW_ADSP1_ZM, .base = WM2200_DSP1_ZM_BASE },
+};
+
+static const struct wm_adsp_region wm2200_dsp2_regions[] = {
+	{ .type = WMFW_ADSP1_PM, .base = WM2200_DSP2_PM_BASE },
+	{ .type = WMFW_ADSP1_DM, .base = WM2200_DSP2_DM_BASE },
+	{ .type = WMFW_ADSP1_ZM, .base = WM2200_DSP2_ZM_BASE },
+};
+
 static struct reg_default wm2200_reg_defaults[] = {
 	{ 0x000B, 0x0000 },   /* R11    - Tone Generator 1 */
 	{ 0x0102, 0x0000 },   /* R258   - Clocking 3 */
@@ -981,400 +995,6 @@ static int wm2200_reset(struct wm2200_priv *wm2200)
 	}
 }
 
-static int wm2200_dsp_load(struct snd_soc_codec *codec, int base)
-{
-	const struct firmware *firmware;
-	struct regmap *regmap = codec->control_data;
-	unsigned int pos = 0;
-	const struct wmfw_header *header;
-	const struct wmfw_adsp1_sizes *adsp1_sizes;
-	const struct wmfw_footer *footer;
-	const struct wmfw_region *region;
-	const char *file, *region_name;
-	char *text;
-	unsigned int dm, pm, zm, reg;
-	int regions = 0;
-	int ret, offset, type;
-
-	switch (base) {
-	case WM2200_DSP1_CONTROL_1:
-		file = "wm2200-dsp1.wmfw";
-		dm = WM2200_DSP1_DM_BASE;
-		pm = WM2200_DSP1_PM_BASE;
-		zm = WM2200_DSP1_ZM_BASE;
-		break;
-	case WM2200_DSP2_CONTROL_1:
-		file = "wm2200-dsp2.wmfw";
-		dm = WM2200_DSP2_DM_BASE;
-		pm = WM2200_DSP2_PM_BASE;
-		zm = WM2200_DSP2_ZM_BASE;
-		break;
-	default:
-		dev_err(codec->dev, "BASE %x\n", base);
-		BUG_ON(1);
-		return -EINVAL;
-	}
-
-	ret = request_firmware(&firmware, file, codec->dev);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request '%s'\n", file);
-		return ret;
-	}
-
-	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
-	if (pos >= firmware->size) {
-		dev_err(codec->dev, "%s: file too short, %zu bytes\n",
-			file, firmware->size);
-		return -EINVAL;
-	}
-
-	header = (void*)&firmware->data[0];
-
-	if (memcmp(&header->magic[0], "WMFW", 4) != 0) {
-		dev_err(codec->dev, "%s: invalid magic\n", file);
-		return -EINVAL;
-	}
-
-	if (header->ver != 0) {
-		dev_err(codec->dev, "%s: unknown file format %d\n",
-			file, header->ver);
-		return -EINVAL;
-	}
-
-	if (le32_to_cpu(header->len) != sizeof(*header) +
-	    sizeof(*adsp1_sizes) + sizeof(*footer)) {
-		dev_err(codec->dev, "%s: unexpected header length %d\n",
-			file, le32_to_cpu(header->len));
-		return -EINVAL;
-	}
-
-	if (header->core != WMFW_ADSP1) {
-		dev_err(codec->dev, "%s: invalid core %d\n",
-			file, header->core);
-		return -EINVAL;
-	}
-
-	adsp1_sizes = (void *)&(header[1]);
-	footer = (void *)&(adsp1_sizes[1]);
-
-	dev_dbg(codec->dev, "%s: %d DM, %d PM, %d ZM\n",
-		file, le32_to_cpu(adsp1_sizes->dm),
-		le32_to_cpu(adsp1_sizes->pm), le32_to_cpu(adsp1_sizes->zm));
-
-	dev_dbg(codec->dev, "%s: timestamp %llu\n", file,
-		le64_to_cpu(footer->timestamp));
-
-	while (pos < firmware->size &&
-	       pos - firmware->size > sizeof(*region)) {
-		region = (void *)&(firmware->data[pos]);
-		region_name = "Unknown";
-		reg = 0;
-		text = NULL;
-		offset = le32_to_cpu(region->offset) & 0xffffff;
-		type = be32_to_cpu(region->type) & 0xff;
-		
-		switch (type) {
-		case WMFW_NAME_TEXT:
-			region_name = "Firmware name";
-			text = kzalloc(le32_to_cpu(region->len) + 1,
-				       GFP_KERNEL);
-			break;
-		case WMFW_INFO_TEXT:
-			region_name = "Information";
-			text = kzalloc(le32_to_cpu(region->len) + 1,
-				       GFP_KERNEL);
-			break;
-		case WMFW_ABSOLUTE:
-			region_name = "Absolute";
-			reg = offset;
-			break;
-		case WMFW_ADSP1_PM:
-			region_name = "PM";
-			reg = pm + (offset * 3);
-			break;
-		case WMFW_ADSP1_DM:
-			region_name = "DM";
-			reg = dm + (offset * 2);
-			break;
-		case WMFW_ADSP1_ZM:
-			region_name = "ZM";
-			reg = zm + (offset * 2);
-			break;
-		default:
-			dev_warn(codec->dev,
-				 "%s.%d: Unknown region type %x at %d(%x)\n",
-				 file, regions, type, pos, pos);
-			break;
-		}
-
-		dev_dbg(codec->dev, "%s.%d: %d bytes at %d in %s\n", file,
-			regions, le32_to_cpu(region->len), offset,
-			region_name);
-
-		if (text) {
-			memcpy(text, region->data, le32_to_cpu(region->len));
-			dev_info(codec->dev, "%s: %s\n", file, text);
-			kfree(text);
-		}
-
-		if (reg) {
-			ret = regmap_raw_write(regmap, reg, region->data,
-					       le32_to_cpu(region->len));
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
-					file, regions,
-					le32_to_cpu(region->len), offset,
-					region_name, ret);
-				goto out;
-			}
-		}
-
-		pos += le32_to_cpu(region->len) + sizeof(*region);
-		regions++;
-	}
-
-	if (pos > firmware->size)
-		dev_warn(codec->dev, "%s.%d: %zu bytes at end of file\n",
-			 file, regions, pos - firmware->size);
-
-out:
-	release_firmware(firmware);
-	
-	return ret;
-}
-
-static int wm2200_setup_algs(struct snd_soc_codec *codec, int base)
-{
-	struct regmap *regmap = codec->control_data;
-	struct wmfw_adsp1_id_hdr id;
-	struct wmfw_adsp1_alg_hdr *alg;
-	size_t algs;
-	int zm, dm, pm, ret, i;
-	__be32 val;
-
-	switch (base) {
-	case WM2200_DSP1_CONTROL_1:
-		dm = WM2200_DSP1_DM_BASE;
-		pm = WM2200_DSP1_PM_BASE;
-		zm = WM2200_DSP1_ZM_BASE;
-		break;
-	case WM2200_DSP2_CONTROL_1:
-		dm = WM2200_DSP2_DM_BASE;
-		pm = WM2200_DSP2_PM_BASE;
-		zm = WM2200_DSP2_ZM_BASE;
-		break;
-	default:
-		dev_err(codec->dev, "BASE %x\n", base);
-		BUG_ON(1);
-		return -EINVAL;
-	}
-
-	ret = regmap_raw_read(regmap, dm, &id, sizeof(id));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to read algorithm info: %d\n",
-			ret);
-		return ret;
-	}
-
-	algs = be32_to_cpu(id.algs);
-	dev_info(codec->dev, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
-		 be32_to_cpu(id.fw.id),
-		 (be32_to_cpu(id.fw.ver) & 0xff000) >> 16,
-		 (be32_to_cpu(id.fw.ver) & 0xff00) >> 8,
-		 be32_to_cpu(id.fw.ver) & 0xff,
-		 algs);
-
-	/* Read the terminator first to validate the length */
-	ret = regmap_raw_read(regmap, dm +
-			      (sizeof(id) + (algs * sizeof(*alg))) / 2,
-			      &val, sizeof(val));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to read algorithm list end: %d\n",
-			ret);
-		return ret;
-	}
-
-	if (be32_to_cpu(val) != 0xbedead)
-		dev_warn(codec->dev, "Algorithm list end %zx 0x%x != 0xbeadead\n",
-			 (sizeof(id) + (algs * sizeof(*alg))) / 2,
-			 be32_to_cpu(val));
-
-	alg = kzalloc(sizeof(*alg) * algs, GFP_KERNEL);
-	if (!alg)
-		return -ENOMEM;
-
-	ret = regmap_raw_read(regmap, dm + (sizeof(id) / 2),
-			      alg, algs * sizeof(*alg));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to read algorithm list: %d\n",
-			ret);
-		goto out;
-	}
-
-	for (i = 0; i < algs; i++) {
-		dev_info(codec->dev, "%d: ID %x v%d.%d.%d\n",
-			 i, be32_to_cpu(alg[i].alg.id),
-			 (be32_to_cpu(alg[i].alg.ver) & 0xff000) >> 16,
-			 (be32_to_cpu(alg[i].alg.ver) & 0xff00) >> 8,
-			 be32_to_cpu(alg[i].alg.ver) & 0xff);
-	}
-
-out:
-	kfree(alg);
-	return ret;
-}
-
-static int wm2200_load_coeff(struct snd_soc_codec *codec, int base)
-{
-	struct regmap *regmap = codec->control_data;
-	struct wmfw_coeff_hdr *hdr;
-	struct wmfw_coeff_item *blk;
-	const struct firmware *firmware;
-	const char *file, *region_name;
-	int ret, dm, pm, zm, pos, blocks, type, offset, reg;
-
-	switch (base) {
-	case WM2200_DSP1_CONTROL_1:
-		file = "wm2200-dsp1.bin";
-		dm = WM2200_DSP1_DM_BASE;
-		pm = WM2200_DSP1_PM_BASE;
-		zm = WM2200_DSP1_ZM_BASE;
-		break;
-	case WM2200_DSP2_CONTROL_1:
-		file = "wm2200-dsp2.bin";
-		dm = WM2200_DSP2_DM_BASE;
-		pm = WM2200_DSP2_PM_BASE;
-		zm = WM2200_DSP2_ZM_BASE;
-		break;
-	default:
-		dev_err(codec->dev, "BASE %x\n", base);
-		BUG_ON(1);
-		return -EINVAL;
-	}
-
-	ret = request_firmware(&firmware, file, codec->dev);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request '%s'\n", file);
-		return ret;
-	}
-
-	if (sizeof(*hdr) >= firmware->size) {
-		dev_err(codec->dev, "%s: file too short, %zu bytes\n",
-			file, firmware->size);
-		return -EINVAL;
-	}
-
-	hdr = (void*)&firmware->data[0];
-	if (memcmp(hdr->magic, "WMDR", 4) != 0) {
-		dev_err(codec->dev, "%s: invalid magic\n", file);
-		return -EINVAL;
-	}
-
-	dev_dbg(codec->dev, "%s: v%d.%d.%d\n", file,
-		(le32_to_cpu(hdr->ver) >> 16) & 0xff,
-		(le32_to_cpu(hdr->ver) >>  8) & 0xff,
-		le32_to_cpu(hdr->ver) & 0xff);
-
-	pos = le32_to_cpu(hdr->len);
-
-	blocks = 0;
-	while (pos < firmware->size &&
-	       pos - firmware->size > sizeof(*blk)) {
-		blk = (void*)(&firmware->data[pos]);
-
-		type = be32_to_cpu(blk->type) & 0xff;
-		offset = le32_to_cpu(blk->offset) & 0xffffff;
-
-		dev_dbg(codec->dev, "%s.%d: %x v%d.%d.%d\n",
-			file, blocks, le32_to_cpu(blk->id),
-			(le32_to_cpu(blk->ver) >> 16) & 0xff,
-			(le32_to_cpu(blk->ver) >>  8) & 0xff,
-			le32_to_cpu(blk->ver) & 0xff);
-		dev_dbg(codec->dev, "%s.%d: %d bytes at 0x%x in %x\n",
-			file, blocks, le32_to_cpu(blk->len), offset, type);
-
-		reg = 0;
-		region_name = "Unknown";
-		switch (type) {
-		case WMFW_NAME_TEXT:
-		case WMFW_INFO_TEXT:
-			break;
-		case WMFW_ABSOLUTE:
-			region_name = "register";
-			reg = offset;
-			break;
-		default:
-			dev_err(codec->dev, "Unknown region type %x\n", type);
-			break;
-		}
-
-		if (reg) {
-			ret = regmap_raw_write(regmap, reg, blk->data,
-					       le32_to_cpu(blk->len));
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"%s.%d: Failed to write to %x in %s\n",
-					file, blocks, reg, region_name);
-			}
-		}
-
-		pos += le32_to_cpu(blk->len) + sizeof(*blk);
-		blocks++;
-	}
-
-	if (pos > firmware->size)
-		dev_warn(codec->dev, "%s.%d: %zu bytes at end of file\n",
-			 file, blocks, pos - firmware->size);
-
-	return 0;
-}
-
-static int wm2200_dsp_ev(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol,
-			 int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	int base = w->reg - WM2200_DSP_CONTROL_30;
-	int ret;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		ret = wm2200_dsp_load(codec, base);
-		if (ret != 0)
-			return ret;
-
-		ret = wm2200_setup_algs(codec, base);
-		if (ret != 0)
-			return ret;
-
-		ret = wm2200_load_coeff(codec, base);
-		if (ret != 0)
-			return ret;
-
-		/* Start the core running */
-		snd_soc_update_bits(codec, w->reg,
-				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START,
-				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START);
-		break;
-
-	case SND_SOC_DAPM_PRE_PMD:
-		/* Halt the core */
-		snd_soc_update_bits(codec, w->reg,
-				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START,
-				    0);
-
-		snd_soc_update_bits(codec, base + WM2200_DSP_CONTROL_19,
-				    WM2200_DSP1_WDMA_BUFFER_LENGTH_MASK, 0);
-		break;
-
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static DECLARE_TLV_DB_SCALE(in_tlv, -6300, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
 static DECLARE_TLV_DB_SCALE(out_tlv, -6400, 100, 0);
@@ -1722,12 +1342,8 @@ SND_SOC_DAPM_PGA("LHPF1", WM2200_HPLPF1_1, WM2200_LHPF1_ENA_SHIFT, 0,
 SND_SOC_DAPM_PGA("LHPF2", WM2200_HPLPF2_1, WM2200_LHPF2_ENA_SHIFT, 0,
 		 NULL, 0),
 
-SND_SOC_DAPM_PGA_E("DSP1", WM2200_DSP1_CONTROL_30, WM2200_DSP1_SYS_ENA_SHIFT,
-		   0, NULL, 0, wm2200_dsp_ev,
-		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-SND_SOC_DAPM_PGA_E("DSP2", WM2200_DSP2_CONTROL_30, WM2200_DSP2_SYS_ENA_SHIFT,
-		   0, NULL, 0, wm2200_dsp_ev,
-		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+WM_ADSP1("DSP1", 0),
+WM_ADSP1("DSP2", 1),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", "Capture", 0,
 		    WM2200_AUDIO_IF_1_22, WM2200_AIF1TX1_ENA_SHIFT, 0),
@@ -2592,6 +2208,22 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 		goto err;
 	}
 
+	for (i = 0; i < 2; i++) {
+		wm2200->dsp[i].type = WMFW_ADSP1;
+		wm2200->dsp[i].part = "wm2200";
+		wm2200->dsp[i].num = i + 1;
+		wm2200->dsp[i].dev = &i2c->dev;
+		wm2200->dsp[i].regmap = wm2200->regmap;
+	}
+
+	wm2200->dsp[0].base = WM2200_DSP1_CONTROL_1;
+	wm2200->dsp[0].mem = wm2200_dsp1_regions;
+	wm2200->dsp[0].num_mems = ARRAY_SIZE(wm2200_dsp1_regions);
+
+	wm2200->dsp[1].base = WM2200_DSP2_CONTROL_1;
+	wm2200->dsp[1].mem = wm2200_dsp2_regions;
+	wm2200->dsp[1].num_mems = ARRAY_SIZE(wm2200_dsp2_regions);
+
 	if (pdata)
 		wm2200->pdata = *pdata;
 
-- 
1.7.10.4
