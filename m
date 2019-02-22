From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 4/5] ASoC: wm_adsp: Add support for multiple
	compressed buffers
Date: Fri, 22 Feb 2019 10:04:20 +0000
Message-ID: <20190222100421.894-4-ckeepax@opensource.cirrus.com>
References: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7565CF807A4
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 11:04:34 +0100 (CET)
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

From: Stuart Henderson <stuarth@opensource.cirrus.com>

Currently, only a single compressed stream is supported per firmware.
Add support for multiple compressed streams on a single firmware, this
allows additional features like completely independent trigger words or
separate debug capture streams to be implemented.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 166 ++++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/wm_adsp.h |   4 +-
 2 files changed, 119 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d5b0d969dddf7..5edaed3320407 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -310,6 +310,12 @@ struct wm_adsp_alg_xm_struct {
 	__be64 smoothed_power;
 };
 
+struct wm_adsp_host_buf_coeff_v1 {
+	__be32 host_buf_ptr;		/* Host buffer pointer */
+	__be32 versions;		/* Version numbers */
+	__be32 name[4];			/* The buffer name */
+};
+
 struct wm_adsp_buffer {
 	__be32 buf1_base;		/* Base addr of first buffer area */
 	__be32 buf1_size;		/* Size of buf1 area in DSP words */
@@ -334,6 +340,7 @@ struct wm_adsp_buffer {
 struct wm_adsp_compr;
 
 struct wm_adsp_compr_buf {
+	struct list_head list;
 	struct wm_adsp *dsp;
 	struct wm_adsp_compr *compr;
 
@@ -345,9 +352,12 @@ struct wm_adsp_compr_buf {
 	int read_index;
 	int avail;
 	int host_buf_mem_type;
+
+	char *name;
 };
 
 struct wm_adsp_compr {
+	struct list_head list;
 	struct wm_adsp *dsp;
 	struct wm_adsp_compr_buf *buf;
 
@@ -358,6 +368,8 @@ struct wm_adsp_compr {
 	unsigned int copied_total;
 
 	unsigned int sample_rate;
+
+	const char *name;
 };
 
 #define WM_ADSP_DATA_WORD_SIZE         3
@@ -375,6 +387,11 @@ struct wm_adsp_compr {
 #define ALG_XM_FIELD(field) \
 	(offsetof(struct wm_adsp_alg_xm_struct, field) / sizeof(__be32))
 
+#define HOST_BUF_COEFF_SUPPORTED_COMPAT_VER	1
+
+#define HOST_BUF_COEFF_COMPAT_VER_MASK		0xFF00
+#define HOST_BUF_COEFF_COMPAT_VER_SHIFT		8
+
 static int wm_adsp_buffer_init(struct wm_adsp *dsp);
 static int wm_adsp_buffer_free(struct wm_adsp *dsp);
 
@@ -708,7 +725,7 @@ int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&dsp[e->shift_l].pwr_lock);
 
-	if (dsp[e->shift_l].booted || dsp[e->shift_l].compr)
+	if (dsp[e->shift_l].booted || !list_empty(&dsp[e->shift_l].compr_list))
 		ret = -EBUSY;
 	else
 		dsp[e->shift_l].fw = ucontrol->value.enumerated.item[0];
@@ -2430,6 +2447,8 @@ static int wm_adsp_common_init(struct wm_adsp *dsp)
 
 	INIT_LIST_HEAD(&dsp->alg_regions);
 	INIT_LIST_HEAD(&dsp->ctl_list);
+	INIT_LIST_HEAD(&dsp->compr_list);
+	INIT_LIST_HEAD(&dsp->buffer_list);
 
 	mutex_init(&dsp->pwr_lock);
 
@@ -2972,14 +2991,19 @@ static inline int wm_adsp_compr_attached(struct wm_adsp_compr *compr)
 
 static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
 {
-	/*
-	 * Note this will be more complex once each DSP can support multiple
-	 * streams
-	 */
-	if (!compr->dsp->buffer)
+	struct wm_adsp_compr_buf *buf = NULL, *tmp;
+
+	list_for_each_entry(tmp, &compr->dsp->buffer_list, list) {
+		if (!tmp->name || !strcmp(compr->name, tmp->name)) {
+			buf = tmp;
+			break;
+		}
+	}
+
+	if (!buf)
 		return -EINVAL;
 
-	compr->buf = compr->dsp->buffer;
+	compr->buf = buf;
 	compr->buf->compr = compr;
 
 	return 0;
@@ -3002,7 +3026,8 @@ static void wm_adsp_compr_detach(struct wm_adsp_compr *compr)
 
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 {
-	struct wm_adsp_compr *compr;
+	struct wm_adsp_compr *compr, *tmp;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
 	int ret = 0;
 
 	mutex_lock(&dsp->pwr_lock);
@@ -3019,11 +3044,12 @@ int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 		goto out;
 	}
 
-	if (dsp->compr) {
-		/* It is expect this limitation will be removed in future */
-		adsp_err(dsp, "Only a single stream supported per DSP\n");
-		ret = -EBUSY;
-		goto out;
+	list_for_each_entry(tmp, &dsp->compr_list, list) {
+		if (!strcmp(tmp->name, rtd->codec_dai->name)) {
+			adsp_err(dsp, "Only a single stream supported per dai\n");
+			ret = -EBUSY;
+			goto out;
+		}
 	}
 
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
@@ -3034,8 +3060,9 @@ int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 
 	compr->dsp = dsp;
 	compr->stream = stream;
+	compr->name = rtd->codec_dai->name;
 
-	dsp->compr = compr;
+	list_add_tail(&compr->list, &dsp->compr_list);
 
 	stream->runtime->private_data = compr;
 
@@ -3054,7 +3081,7 @@ int wm_adsp_compr_free(struct snd_compr_stream *stream)
 	mutex_lock(&dsp->pwr_lock);
 
 	wm_adsp_compr_detach(compr);
-	dsp->compr = NULL;
+	list_del(&compr->list);
 
 	kfree(compr->raw_buf);
 	kfree(compr);
@@ -3304,7 +3331,7 @@ static struct wm_adsp_compr_buf *wm_adsp_buffer_alloc(struct wm_adsp *dsp)
 
 	wm_adsp_buffer_clear(buf);
 
-	dsp->buffer = buf;
+	list_add_tail(&buf->list, &dsp->buffer_list);
 
 	return buf;
 }
@@ -3360,6 +3387,7 @@ static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 
 static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 {
+	struct wm_adsp_host_buf_coeff_v1 coeff_v1;
 	struct wm_adsp_compr_buf *buf;
 	unsigned int val, reg;
 	int ret, i;
@@ -3395,9 +3423,45 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 	if (ret < 0)
 		return ret;
 
-	adsp_dbg(ctl->dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+	/*
+	 * v0 host_buffer coefficients didn't have versioning, so if the
+	 * control is one word, assume version 0.
+	 */
+	if (ctl->len == 4) {
+		adsp_dbg(ctl->dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+		return 0;
+	}
+
+	ret = regmap_raw_read(ctl->dsp->regmap, reg, &coeff_v1,
+			      sizeof(coeff_v1));
+	if (ret < 0)
+		return ret;
+
+	coeff_v1.versions = be32_to_cpu(coeff_v1.versions);
+	val = coeff_v1.versions & HOST_BUF_COEFF_COMPAT_VER_MASK;
+	val >>= HOST_BUF_COEFF_COMPAT_VER_SHIFT;
 
-	return 0;
+	if (val > HOST_BUF_COEFF_SUPPORTED_COMPAT_VER) {
+		adsp_err(ctl->dsp,
+			 "Host buffer coeff ver %u > supported version %u\n",
+			 val, HOST_BUF_COEFF_SUPPORTED_COMPAT_VER);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(coeff_v1.name); i++)
+		coeff_v1.name[i] = be32_to_cpu(coeff_v1.name[i]);
+
+	wm_adsp_remove_padding((u32 *)&coeff_v1.name,
+			       ARRAY_SIZE(coeff_v1.name),
+			       WM_ADSP_DATA_WORD_SIZE);
+
+	buf->name = kasprintf(GFP_KERNEL, "%s-dsp-%s", ctl->dsp->part,
+			      (char *)&coeff_v1.name);
+
+	adsp_dbg(ctl->dsp, "host_buf_ptr=%x coeff version %u\n",
+		 buf->host_buf_ptr, val);
+
+	return val;
 }
 
 static int wm_adsp_buffer_init(struct wm_adsp *dsp)
@@ -3416,12 +3480,13 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 		if (ret < 0) {
 			adsp_err(dsp, "Failed to parse coeff: %d\n", ret);
 			goto error;
+		} else if (ret == 0) {
+			/* Only one buffer supported for version 0 */
+			return 0;
 		}
-
-		return 0;
 	}
 
-	if (!dsp->buffer) {
+	if (list_empty(&dsp->buffer_list)) {
 		/* Fall back to legacy support */
 		ret = wm_adsp_buffer_parse_legacy(dsp);
 		if (ret) {
@@ -3439,13 +3504,16 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 
 static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 {
-	if (dsp->buffer) {
-		wm_adsp_compr_detach(dsp->buffer->compr);
+	struct wm_adsp_compr_buf *buf, *tmp;
 
-		kfree(dsp->buffer->regions);
-		kfree(dsp->buffer);
+	list_for_each_entry_safe(buf, tmp, &dsp->buffer_list, list) {
+		if (buf->compr)
+			wm_adsp_compr_detach(buf->compr);
 
-		dsp->buffer = NULL;
+		kfree(buf->name);
+		kfree(buf->regions);
+		list_del(&buf->list);
+		kfree(buf);
 	}
 
 	return 0;
@@ -3576,39 +3644,39 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 
 	mutex_lock(&dsp->pwr_lock);
 
-	buf = dsp->buffer;
-	compr = dsp->compr;
-
-	if (!buf) {
+	if (list_empty(&dsp->buffer_list)) {
 		ret = -ENODEV;
 		goto out;
 	}
-
 	adsp_dbg(dsp, "Handling buffer IRQ\n");
 
-	ret = wm_adsp_buffer_get_error(buf);
-	if (ret < 0)
-		goto out_notify; /* Wake poll to report error */
+	list_for_each_entry(buf, &dsp->buffer_list, list) {
+		compr = buf->compr;
 
-	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
-				  &buf->irq_count);
-	if (ret < 0) {
-		adsp_err(dsp, "Failed to get irq_count: %d\n", ret);
-		goto out;
-	}
+		ret = wm_adsp_buffer_get_error(buf);
+		if (ret < 0)
+			goto out_notify; /* Wake poll to report error */
 
-	ret = wm_adsp_buffer_update_avail(buf);
-	if (ret < 0) {
-		adsp_err(dsp, "Error reading avail: %d\n", ret);
-		goto out;
-	}
+		ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
+					  &buf->irq_count);
+		if (ret < 0) {
+			adsp_err(dsp, "Failed to get irq_count: %d\n", ret);
+			goto out;
+		}
 
-	if (wm_adsp_fw[dsp->fw].voice_trigger && buf->irq_count == 2)
-		ret = WM_ADSP_COMPR_VOICE_TRIGGER;
+		ret = wm_adsp_buffer_update_avail(buf);
+		if (ret < 0) {
+			adsp_err(dsp, "Error reading avail: %d\n", ret);
+			goto out;
+		}
+
+		if (wm_adsp_fw[dsp->fw].voice_trigger && buf->irq_count == 2)
+			ret = WM_ADSP_COMPR_VOICE_TRIGGER;
 
 out_notify:
-	if (compr && compr->stream)
-		snd_compr_fragment_elapsed(compr->stream);
+		if (compr && compr->stream)
+			snd_compr_fragment_elapsed(compr->stream);
+	}
 
 out:
 	mutex_unlock(&dsp->pwr_lock);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 4b8778b0b06cd..59e07ad163296 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -90,8 +90,8 @@ struct wm_adsp {
 
 	struct work_struct boot_work;
 
-	struct wm_adsp_compr *compr;
-	struct wm_adsp_compr_buf *buffer;
+	struct list_head compr_list;
+	struct list_head buffer_list;
 
 	struct mutex pwr_lock;
 
-- 
2.11.0
