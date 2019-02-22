From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: wm_adsp: Refactor compress stream
	initialisation
Date: Fri, 22 Feb 2019 10:04:19 +0000
Message-ID: <20190222100421.894-3-ckeepax@opensource.cirrus.com>
References: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 680E7F80C30
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 11:04:33 +0100 (CET)
In-Reply-To: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Make the code slightly clearer and prepare things for the addition of
multiple compressed streams on a single DSP core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 139 ++++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 65 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d556ea7204167..d5b0d969dddf7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3253,6 +3253,11 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	u32 offset = 0;
 	int i, ret;
 
+	buf->regions = kcalloc(caps->num_regions, sizeof(*buf->regions),
+			       GFP_KERNEL);
+	if (!buf->regions)
+		return -ENOMEM;
+
 	for (i = 0; i < caps->num_regions; ++i) {
 		region = &buf->regions[i];
 
@@ -3287,13 +3292,34 @@ static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
 	buf->avail = 0;
 }
 
-static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
+static struct wm_adsp_compr_buf *wm_adsp_buffer_alloc(struct wm_adsp *dsp)
+{
+	struct wm_adsp_compr_buf *buf;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->dsp = dsp;
+
+	wm_adsp_buffer_clear(buf);
+
+	dsp->buffer = buf;
+
+	return buf;
+}
+
+static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 {
 	struct wm_adsp_alg_region *alg_region;
-	struct wm_adsp *dsp = buf->dsp;
+	struct wm_adsp_compr_buf *buf;
 	u32 xmalg, addr, magic;
 	int i, ret;
 
+	buf = wm_adsp_buffer_alloc(dsp);
+	if (!buf)
+		return -ENOMEM;
+
 	alg_region = wm_adsp_find_alg_region(dsp, WMFW_ADSP2_XM, dsp->fw_id);
 	xmalg = sizeof(struct wm_adsp_system_config_xm_hdr) / sizeof(__be32);
 
@@ -3303,7 +3329,7 @@ static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 		return ret;
 
 	if (magic != WM_ADSP_ALG_XM_STRUCT_MAGIC)
-		return -EINVAL;
+		return -ENODEV;
 
 	addr = alg_region->base + xmalg + ALG_XM_FIELD(host_buf_ptr);
 	for (i = 0; i < 5; ++i) {
@@ -3323,49 +3349,27 @@ static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 
 	buf->host_buf_mem_type = WMFW_ADSP2_XM;
 
-	adsp_dbg(dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
-
-	return 0;
-}
-
-static struct wm_coeff_ctl *
-wm_adsp_find_host_buffer_ctrl(struct wm_adsp_compr_buf *buf)
-{
-	struct wm_adsp *dsp = buf->dsp;
-	struct wm_coeff_ctl *ctl;
-
-	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (ctl->type != WMFW_CTL_TYPE_HOST_BUFFER)
-			continue;
-
-		if (!ctl->enabled)
-			continue;
+	ret = wm_adsp_buffer_populate(buf);
+	if (ret < 0)
+		return ret;
 
-		buf->host_buf_mem_type = ctl->alg_region.type;
-		return ctl;
-	}
+	adsp_dbg(dsp, "legacy host_buf_ptr=%x\n", buf->host_buf_ptr);
 
-	return NULL;
+	return 0;
 }
 
-static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
+static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 {
-	struct wm_adsp *dsp = buf->dsp;
-	struct wm_coeff_ctl *ctl;
-	unsigned int reg;
-	u32 val;
-	int i, ret;
-
-	ctl = wm_adsp_find_host_buffer_ctrl(buf);
-	if (!ctl)
-		return wm_adsp_legacy_host_buf_addr(buf);
+	struct wm_adsp_compr_buf *buf;
+	unsigned int val, reg;
+	int ret, i;
 
 	ret = wm_coeff_base_reg(ctl, &reg);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < 5; ++i) {
-		ret = regmap_raw_read(dsp->regmap, reg, &val, sizeof(val));
+		ret = regmap_raw_read(ctl->dsp->regmap, reg, &val, sizeof(val));
 		if (ret < 0)
 			return ret;
 
@@ -3375,56 +3379,61 @@ static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
 		usleep_range(1000, 2000);
 	}
 
-	if (!val)
+	if (!val) {
+		adsp_err(ctl->dsp, "Failed to acquire host buffer\n");
 		return -EIO;
+	}
+
+	buf = wm_adsp_buffer_alloc(ctl->dsp);
+	if (!buf)
+		return -ENOMEM;
 
+	buf->host_buf_mem_type = ctl->alg_region.type;
 	buf->host_buf_ptr = be32_to_cpu(val);
-	adsp_dbg(dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+
+	ret = wm_adsp_buffer_populate(buf);
+	if (ret < 0)
+		return ret;
+
+	adsp_dbg(ctl->dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
 
 	return 0;
 }
 
-
 static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 {
-	struct wm_adsp_compr_buf *buf;
+	struct wm_coeff_ctl *ctl;
 	int ret;
 
-	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	buf->dsp = dsp;
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (ctl->type != WMFW_CTL_TYPE_HOST_BUFFER)
+			continue;
 
-	wm_adsp_buffer_clear(buf);
+		if (!ctl->enabled)
+			continue;
 
-	ret = wm_adsp_buffer_locate(buf);
-	if (ret < 0) {
-		adsp_err(dsp, "Failed to acquire host buffer: %d\n", ret);
-		goto err_buffer;
-	}
+		ret = wm_adsp_buffer_parse_coeff(ctl);
+		if (ret < 0) {
+			adsp_err(dsp, "Failed to parse coeff: %d\n", ret);
+			goto error;
+		}
 
-	buf->regions = kcalloc(wm_adsp_fw[dsp->fw].caps->num_regions,
-			       sizeof(*buf->regions), GFP_KERNEL);
-	if (!buf->regions) {
-		ret = -ENOMEM;
-		goto err_buffer;
+		return 0;
 	}
 
-	ret = wm_adsp_buffer_populate(buf);
-	if (ret < 0) {
-		adsp_err(dsp, "Failed to populate host buffer: %d\n", ret);
-		goto err_regions;
+	if (!dsp->buffer) {
+		/* Fall back to legacy support */
+		ret = wm_adsp_buffer_parse_legacy(dsp);
+		if (ret) {
+			adsp_err(dsp, "Failed to parse legacy: %d\n", ret);
+			goto error;
+		}
 	}
 
-	dsp->buffer = buf;
-
 	return 0;
 
-err_regions:
-	kfree(buf->regions);
-err_buffer:
-	kfree(buf);
+error:
+	wm_adsp_buffer_free(dsp);
 	return ret;
 }
 
-- 
2.11.0
