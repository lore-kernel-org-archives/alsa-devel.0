From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Refactor compress stream
	initialisation" to the asoc tree
Date: Tue, 26 Feb 2019 12:06:26 +0000 (GMT)
Message-ID: <20190226120626.F20A811284E3@debutante.sirena.org.uk>
References: <20190222100421.894-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2599BF80734
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 13:06:28 +0100 (CET)
In-Reply-To: <20190222100421.894-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Refactor compress stream initialisation

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

>From a792af69b08fd7f89b156c8cba1dfc2088522582 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 22 Feb 2019 10:04:19 +0000
Subject: [PATCH] ASoC: wm_adsp: Refactor compress stream initialisation

Make the code slightly clearer and prepare things for the addition of
multiple compressed streams on a single DSP core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 139 ++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 65 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 852ab3f70689..4fdcef3f0ecc 100644
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
2.20.1
