From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: wm2200: Provide initial coefficient
	loading
Date: Fri,  5 Oct 2012 19:55:35 +0100
Message-ID: <1349463336-10871-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A15642650CF
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

Allow a coefficient set provided using the Wolfson callibration tools to
be provided along with the firmware files. Currently only coefficient
files which configure absolute register addresses are supported.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |  194 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wmfw.h   |   43 ++++++++++
 2 files changed, 237 insertions(+)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index e3f549b..06d4e61 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1150,6 +1150,192 @@ out:
 	return ret;
 }
 
+static int wm2200_setup_algs(struct snd_soc_codec *codec, int base)
+{
+	struct regmap *regmap = codec->control_data;
+	struct wmfw_adsp1_id_hdr id;
+	struct wmfw_adsp1_alg_hdr *alg;
+	size_t algs;
+	int zm, dm, pm, ret, i;
+	__be32 val;
+
+	switch (base) {
+	case WM2200_DSP1_CONTROL_1:
+		dm = WM2200_DSP1_DM_BASE;
+		pm = WM2200_DSP1_PM_BASE;
+		zm = WM2200_DSP1_ZM_BASE;
+		break;
+	case WM2200_DSP2_CONTROL_1:
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
+	ret = regmap_raw_read(regmap, dm, &id, sizeof(id));
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to read algorithm info: %d\n",
+			ret);
+		return ret;
+	}
+
+	algs = be32_to_cpu(id.algs);
+	dev_info(codec->dev, "Firmware: %x v%d.%d.%d, %d algorithms\n",
+		 be32_to_cpu(id.fw.id),
+		 (be32_to_cpu(id.fw.ver) & 0xff000) >> 16,
+		 (be32_to_cpu(id.fw.ver) & 0xff00) >> 8,
+		 be32_to_cpu(id.fw.ver) & 0xff,
+		 algs);
+
+	/* Read the terminator first to validate the length */
+	ret = regmap_raw_read(regmap, dm +
+			      (sizeof(id) + (algs * sizeof(*alg))) / 2,
+			      &val, sizeof(val));
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to read algorithm list end: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (be32_to_cpu(val) != 0xbedead)
+		dev_warn(codec->dev, "Algorithm list end %x 0x%x != 0xbeadead\n",
+			 (sizeof(id) + (algs * sizeof(*alg))) / 2,
+			 be32_to_cpu(val));
+
+	alg = kzalloc(sizeof(*alg) * algs, GFP_KERNEL);
+	if (!alg)
+		return -ENOMEM;
+
+	ret = regmap_raw_read(regmap, dm + (sizeof(id) / 2),
+			      alg, algs * sizeof(*alg));
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to read algorithm list: %d\n",
+			ret);
+		goto out;
+	}
+
+	for (i = 0; i < algs; i++) {
+		dev_info(codec->dev, "%d: ID %x v%d.%d.%d\n",
+			 i, be32_to_cpu(alg[i].alg.id),
+			 (be32_to_cpu(alg[i].alg.ver) & 0xff000) >> 16,
+			 (be32_to_cpu(alg[i].alg.ver) & 0xff00) >> 8,
+			 be32_to_cpu(alg[i].alg.ver) & 0xff);
+	}
+
+out:
+	kfree(alg);
+	return ret;
+}
+
+static int wm2200_load_coeff(struct snd_soc_codec *codec, int base)
+{
+	struct regmap *regmap = codec->control_data;
+	struct wmfw_coeff_hdr *hdr;
+	struct wmfw_coeff_item *blk;
+	const struct firmware *firmware;
+	const char *file, *region_name;
+	int ret, dm, pm, zm, pos, blocks, type, offset, reg;
+
+	switch (base) {
+	case WM2200_DSP1_CONTROL_1:
+		file = "wm2200-dsp1.bin";
+		dm = WM2200_DSP1_DM_BASE;
+		pm = WM2200_DSP1_PM_BASE;
+		zm = WM2200_DSP1_ZM_BASE;
+		break;
+	case WM2200_DSP2_CONTROL_1:
+		file = "wm2200-dsp2.bin";
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
+	if (sizeof(*hdr) >= firmware->size) {
+		dev_err(codec->dev, "%s: file too short, %d bytes\n",
+			file, firmware->size);
+		return -EINVAL;
+	}
+
+	hdr = (void*)&firmware->data[0];
+	if (memcmp(hdr->magic, "WMDR", 4) != 0) {
+		dev_err(codec->dev, "%s: invalid magic\n", file);
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "%s: v%d.%d.%d\n", file,
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
+		dev_dbg(codec->dev, "%s.%d: %x v%d.%d.%d\n",
+			file, blocks, le32_to_cpu(blk->id),
+			(le32_to_cpu(blk->ver) >> 16) & 0xff,
+			(le32_to_cpu(blk->ver) >>  8) & 0xff,
+			le32_to_cpu(blk->ver) & 0xff);
+		dev_dbg(codec->dev, "%s.%d: %d bytes at 0x%x in %x\n",
+			file, blocks, le32_to_cpu(blk->len), offset, type);
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
+			dev_err(codec->dev, "Unknown region type %x\n", type);
+			break;
+		}
+
+		if (reg) {
+			ret = regmap_raw_write(regmap, reg, blk->data,
+					       le32_to_cpu(blk->len));
+			if (ret != 0) {
+				dev_err(codec->dev,
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
+		dev_warn(codec->dev, "%s.%d: %d bytes at end of file\n",
+			 file, blocks, pos - firmware->size);
+
+	return 0;
+}
+
 static int wm2200_dsp_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event)
@@ -1164,6 +1350,14 @@ static int wm2200_dsp_ev(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			return ret;
 
+		ret = wm2200_setup_algs(codec, base);
+		if (ret != 0)
+			return ret;
+
+		ret = wm2200_load_coeff(codec, base);
+		if (ret != 0)
+			return ret;
+
 		/* Start the core running */
 		snd_soc_update_bits(codec, w->reg,
 				    WM2200_DSP1_CORE_ENA | WM2200_DSP1_START,
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index ef37316..5791f8e 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -43,6 +43,49 @@ struct wmfw_region {
 	u8 data[];
 } __packed;
 
+struct wmfw_id_hdr {
+	__be32 core_id;
+	__be32 core_rev;
+	__be32 id;
+	__be32 ver;
+} __packed;
+
+struct wmfw_adsp1_id_hdr {
+	struct wmfw_id_hdr fw;
+	__be32 zm;
+	__be32 dm;
+	__be32 algs;
+} __packed;
+
+struct wmfw_alg_hdr {
+	__be32 id;
+	__be32 ver;
+} __packed;
+
+struct wmfw_adsp1_alg_hdr {
+	struct wmfw_alg_hdr alg;
+	__be32 zm;
+	__be32 dm;
+} __packed;
+
+struct wmfw_coeff_hdr {
+	u8 magic[4];
+	__le32 len;
+	__le32 ver;
+	u8 data[];
+} __packed;
+
+struct wmfw_coeff_item {
+	union {
+		__be32 type;
+		__le32 offset;
+	};
+	__le32 id;
+	__le32 ver;
+	__le32 sr;
+	__le32 len;
+	u8 data[];
+} __packed;
 #define WMFW_ADSP1 1
 
 #define WMFW_ABSOLUTE  0xf0
-- 
1.7.10.4
