From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: wm_adsp: Parse HOST_BUFFER controls
Date: Thu, 19 Jul 2018 11:50:39 +0100
Message-ID: <20180719105039.28312-5-ckeepax@opensource.cirrus.com>
References: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A7B0826789C
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 12:50:43 +0200 (CEST)
In-Reply-To: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Currently the compressed streams in DSP firmwares are
identified essentially by looking at a fixed location inside
the firmware. This is fragile and also limits things to a
single compressed stream.

Here a new form of firmware parameter is added, the HOST_BUFFER
which identifies a compressed stream from meta-data in the
firmware file. This is more robust and allows for the possiblity
of using multiple streams per core in the future. Currently the
implementation is still limited to a single stream and will
use the first HOST_BUFFER parameter encountered. If there aren't
any HOST_BUFFER parameters it will fall back to the legacy way
of finding the host buffer.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wmfw.h    |  1 +
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 287ca8d6a9ce..3bc1bb5504a1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1607,6 +1607,15 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 			if (ret)
 				return -EINVAL;
 			break;
+		case WMFW_CTL_TYPE_HOST_BUFFER:
+			ret = wm_adsp_check_coeff_flags(dsp, &coeff_blk,
+						WMFW_CTL_FLAG_SYS |
+						WMFW_CTL_FLAG_VOLATILE |
+						WMFW_CTL_FLAG_READABLE,
+						0);
+			if (ret)
+				return -EINVAL;
+			break;
 		default:
 			adsp_err(dsp, "Unknown control type: %d\n",
 				 coeff_blk.ctl_type);
@@ -3202,7 +3211,7 @@ static inline int wm_adsp_buffer_write(struct wm_adsp_compr_buf *buf,
 				       buf->host_buf_ptr + field_offset, data);
 }
 
-static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
+static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 {
 	struct wm_adsp_alg_region *alg_region;
 	struct wm_adsp *dsp = buf->dsp;
@@ -3241,6 +3250,61 @@ static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
+static struct wm_coeff_ctl *
+wm_adsp_find_host_buffer_ctrl(struct wm_adsp_compr_buf *buf)
+{
+	struct wm_adsp *dsp = buf->dsp;
+	struct wm_coeff_ctl *ctl;
+
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (ctl->type != WMFW_CTL_TYPE_HOST_BUFFER)
+			continue;
+
+		if (!ctl->enabled)
+			continue;
+
+		return ctl;
+	}
+
+	return NULL;
+}
+
+static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
+{
+	struct wm_adsp *dsp = buf->dsp;
+	struct wm_coeff_ctl *ctl;
+	unsigned int reg;
+	u32 val;
+	int i, ret;
+
+	ctl = wm_adsp_find_host_buffer_ctrl(buf);
+	if (!ctl)
+		return wm_adsp_legacy_host_buf_addr(buf);
+
+	ret = wm_coeff_base_reg(ctl, &reg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 5; ++i) {
+		ret = regmap_raw_read(dsp->regmap, reg, &val, sizeof(val));
+		if (ret < 0)
+			return ret;
+
+		if (val)
+			break;
+
+		usleep_range(1000, 2000);
+	}
+
+	if (!val)
+		return -EIO;
+
+	buf->host_buf_ptr = be32_to_cpu(val);
+	adsp_dbg(dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+
+	return 0;
+}
+
 static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 {
 	const struct wm_adsp_fw_caps *caps = wm_adsp_fw[buf->dsp->fw].caps;
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index ec78b9da020f..0c3f50acb8b1 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -29,6 +29,7 @@
 /* Non-ALSA coefficient types start at 0x1000 */
 #define WMFW_CTL_TYPE_ACKED       0x1000 /* acked control */
 #define WMFW_CTL_TYPE_HOSTEVENT   0x1001 /* event control */
+#define WMFW_CTL_TYPE_HOST_BUFFER 0x1002 /* host buffer pointer */
 
 struct wmfw_header {
 	char magic[4];
-- 
2.11.0
