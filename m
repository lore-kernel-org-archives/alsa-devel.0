From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: wm_adsp: Improve logging messages
Date: Fri, 22 Feb 2019 10:04:21 +0000
Message-ID: <20190222100421.894-5-ckeepax@opensource.cirrus.com>
References: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FECDF80C43
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

As the compressed stream implementation has acquired support for
multiple DAI links and compressed streams it has become harder to
interpret messages in the kernel log. Add additional macros to include
the compressed DAI name in the log messages, allowing different streams
to be easily disambiguated.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 97 +++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5edaed3320407..d9d74c099d001 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -46,6 +46,13 @@
 #define adsp_dbg(_dsp, fmt, ...) \
 	dev_dbg(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 
+#define compr_err(_obj, fmt, ...) \
+	adsp_err(_obj->dsp, "%s: " fmt, _obj->name ? _obj->name : "legacy", \
+		 ##__VA_ARGS__)
+#define compr_dbg(_obj, fmt, ...) \
+	adsp_dbg(_obj->dsp, "%s: " fmt, _obj->name ? _obj->name : "legacy", \
+		 ##__VA_ARGS__)
+
 #define ADSP1_CONTROL_1                   0x00
 #define ADSP1_CONTROL_2                   0x02
 #define ADSP1_CONTROL_3                   0x03
@@ -3033,20 +3040,23 @@ int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 	mutex_lock(&dsp->pwr_lock);
 
 	if (wm_adsp_fw[dsp->fw].num_caps == 0) {
-		adsp_err(dsp, "Firmware does not support compressed API\n");
+		adsp_err(dsp, "%s: Firmware does not support compressed API\n",
+			 rtd->codec_dai->name);
 		ret = -ENXIO;
 		goto out;
 	}
 
 	if (wm_adsp_fw[dsp->fw].compr_direction != stream->direction) {
-		adsp_err(dsp, "Firmware does not support stream direction\n");
+		adsp_err(dsp, "%s: Firmware does not support stream direction\n",
+			 rtd->codec_dai->name);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	list_for_each_entry(tmp, &dsp->compr_list, list) {
 		if (!strcmp(tmp->name, rtd->codec_dai->name)) {
-			adsp_err(dsp, "Only a single stream supported per dai\n");
+			adsp_err(dsp, "%s: Only a single stream supported per dai\n",
+				 rtd->codec_dai->name);
 			ret = -EBUSY;
 			goto out;
 		}
@@ -3106,9 +3116,9 @@ static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
 	    params->buffer.fragments < WM_ADSP_MIN_FRAGMENTS ||
 	    params->buffer.fragments > WM_ADSP_MAX_FRAGMENTS ||
 	    params->buffer.fragment_size % WM_ADSP_DATA_WORD_SIZE) {
-		adsp_err(dsp, "Invalid buffer fragsize=%d fragments=%d\n",
-			 params->buffer.fragment_size,
-			 params->buffer.fragments);
+		compr_err(compr, "Invalid buffer fragsize=%d fragments=%d\n",
+			  params->buffer.fragment_size,
+			  params->buffer.fragments);
 
 		return -EINVAL;
 	}
@@ -3136,9 +3146,9 @@ static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
 				return 0;
 	}
 
-	adsp_err(dsp, "Invalid params id=%u ch=%u,%u rate=%u fmt=%u\n",
-		 params->codec.id, params->codec.ch_in, params->codec.ch_out,
-		 params->codec.sample_rate, params->codec.format);
+	compr_err(compr, "Invalid params id=%u ch=%u,%u rate=%u fmt=%u\n",
+		  params->codec.id, params->codec.ch_in, params->codec.ch_out,
+		  params->codec.sample_rate, params->codec.format);
 	return -EINVAL;
 }
 
@@ -3160,8 +3170,8 @@ int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 
 	compr->size = params->buffer;
 
-	adsp_dbg(compr->dsp, "fragment_size=%d fragments=%d\n",
-		 compr->size.fragment_size, compr->size.fragments);
+	compr_dbg(compr, "fragment_size=%d fragments=%d\n",
+		  compr->size.fragment_size, compr->size.fragments);
 
 	size = wm_adsp_compr_frag_words(compr) * sizeof(*compr->raw_buf);
 	compr->raw_buf = kmalloc(size, GFP_DMA | GFP_KERNEL);
@@ -3303,10 +3313,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 
 		region->cumulative_size = offset;
 
-		adsp_dbg(buf->dsp,
-			 "region=%d type=%d base=%08x off=%08x size=%08x\n",
-			 i, region->mem_type, region->base_addr,
-			 region->offset, region->cumulative_size);
+		compr_dbg(buf,
+			  "region=%d type=%d base=%08x off=%08x size=%08x\n",
+			  i, region->mem_type, region->base_addr,
+			  region->offset, region->cumulative_size);
 	}
 
 	return 0;
@@ -3380,7 +3390,7 @@ static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 	if (ret < 0)
 		return ret;
 
-	adsp_dbg(dsp, "legacy host_buf_ptr=%x\n", buf->host_buf_ptr);
+	compr_dbg(buf, "legacy host_buf_ptr=%x\n", buf->host_buf_ptr);
 
 	return 0;
 }
@@ -3428,7 +3438,7 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 	 * control is one word, assume version 0.
 	 */
 	if (ctl->len == 4) {
-		adsp_dbg(ctl->dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+		compr_dbg(buf, "host_buf_ptr=%x\n", buf->host_buf_ptr);
 		return 0;
 	}
 
@@ -3458,8 +3468,8 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 	buf->name = kasprintf(GFP_KERNEL, "%s-dsp-%s", ctl->dsp->part,
 			      (char *)&coeff_v1.name);
 
-	adsp_dbg(ctl->dsp, "host_buf_ptr=%x coeff version %u\n",
-		 buf->host_buf_ptr, val);
+	compr_dbg(buf, "host_buf_ptr=%x coeff version %u\n",
+		  buf->host_buf_ptr, val);
 
 	return val;
 }
@@ -3525,11 +3535,11 @@ static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
 	if (ret < 0) {
-		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
+		compr_err(buf, "Failed to check buffer error: %d\n", ret);
 		return ret;
 	}
 	if (buf->error != 0) {
-		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
+		compr_err(buf, "Buffer error occurred: %d\n", buf->error);
 		return -EIO;
 	}
 
@@ -3542,7 +3552,7 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 	struct wm_adsp *dsp = compr->dsp;
 	int ret = 0;
 
-	adsp_dbg(dsp, "Trigger: %d\n", cmd);
+	compr_dbg(compr, "Trigger: %d\n", cmd);
 
 	mutex_lock(&dsp->pwr_lock);
 
@@ -3551,8 +3561,8 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 		if (!wm_adsp_compr_attached(compr)) {
 			ret = wm_adsp_compr_attach(compr);
 			if (ret < 0) {
-				adsp_err(dsp, "Failed to link buffer and stream: %d\n",
-					 ret);
+				compr_err(compr, "Failed to link buffer and stream: %d\n",
+					  ret);
 				break;
 			}
 		}
@@ -3568,8 +3578,8 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 					   HOST_BUFFER_FIELD(high_water_mark),
 					   wm_adsp_compr_frag_words(compr));
 		if (ret < 0) {
-			adsp_err(dsp, "Failed to set high water mark: %d\n",
-				 ret);
+			compr_err(compr, "Failed to set high water mark: %d\n",
+				  ret);
 			break;
 		}
 		break;
@@ -3610,7 +3620,7 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 		read_index = sign_extend32(next_read_index, 23);
 
 		if (read_index < 0) {
-			adsp_dbg(buf->dsp, "Avail check on unstarted stream\n");
+			compr_dbg(buf, "Avail check on unstarted stream\n");
 			return 0;
 		}
 
@@ -3628,8 +3638,8 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 	if (avail < 0)
 		avail += wm_adsp_buffer_size(buf);
 
-	adsp_dbg(buf->dsp, "readindex=0x%x, writeindex=0x%x, avail=%d\n",
-		 buf->read_index, write_index, avail * WM_ADSP_DATA_WORD_SIZE);
+	compr_dbg(buf, "readindex=0x%x, writeindex=0x%x, avail=%d\n",
+		  buf->read_index, write_index, avail * WM_ADSP_DATA_WORD_SIZE);
 
 	buf->avail = avail;
 
@@ -3648,6 +3658,7 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		ret = -ENODEV;
 		goto out;
 	}
+
 	adsp_dbg(dsp, "Handling buffer IRQ\n");
 
 	list_for_each_entry(buf, &dsp->buffer_list, list) {
@@ -3660,13 +3671,13 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
 					  &buf->irq_count);
 		if (ret < 0) {
-			adsp_err(dsp, "Failed to get irq_count: %d\n", ret);
+			compr_err(buf, "Failed to get irq_count: %d\n", ret);
 			goto out;
 		}
 
 		ret = wm_adsp_buffer_update_avail(buf);
 		if (ret < 0) {
-			adsp_err(dsp, "Error reading avail: %d\n", ret);
+			compr_err(buf, "Error reading avail: %d\n", ret);
 			goto out;
 		}
 
@@ -3690,8 +3701,7 @@ static int wm_adsp_buffer_reenable_irq(struct wm_adsp_compr_buf *buf)
 	if (buf->irq_count & 0x01)
 		return 0;
 
-	adsp_dbg(buf->dsp, "Enable IRQ(0x%x) for next fragment\n",
-		 buf->irq_count);
+	compr_dbg(buf, "Enable IRQ(0x%x) for next fragment\n", buf->irq_count);
 
 	buf->irq_count |= 0x01;
 
@@ -3707,7 +3717,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 	struct wm_adsp_compr_buf *buf;
 	int ret = 0;
 
-	adsp_dbg(dsp, "Pointer request\n");
+	compr_dbg(compr, "Pointer request\n");
 
 	mutex_lock(&dsp->pwr_lock);
 
@@ -3722,7 +3732,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 	if (buf->avail < wm_adsp_compr_frag_words(compr)) {
 		ret = wm_adsp_buffer_update_avail(buf);
 		if (ret < 0) {
-			adsp_err(dsp, "Error reading avail: %d\n", ret);
+			compr_err(compr, "Error reading avail: %d\n", ret);
 			goto out;
 		}
 
@@ -3741,9 +3751,8 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 			ret = wm_adsp_buffer_reenable_irq(buf);
 			if (ret < 0) {
-				adsp_err(dsp,
-					 "Failed to re-enable buffer IRQ: %d\n",
-					 ret);
+				compr_err(compr, "Failed to re-enable buffer IRQ: %d\n",
+					  ret);
 				goto out;
 			}
 		}
@@ -3818,11 +3827,10 @@ static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 			      char __user *buf, size_t count)
 {
-	struct wm_adsp *dsp = compr->dsp;
 	int ntotal = 0;
 	int nwords, nbytes;
 
-	adsp_dbg(dsp, "Requested read of %zu bytes\n", count);
+	compr_dbg(compr, "Requested read of %zu bytes\n", count);
 
 	if (!compr->buf || compr->buf->error) {
 		snd_compr_stop_error(compr->stream, SNDRV_PCM_STATE_XRUN);
@@ -3834,17 +3842,18 @@ static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 	do {
 		nwords = wm_adsp_buffer_capture_block(compr, count);
 		if (nwords < 0) {
-			adsp_err(dsp, "Failed to capture block: %d\n", nwords);
+			compr_err(compr, "Failed to capture block: %d\n",
+				  nwords);
 			return nwords;
 		}
 
 		nbytes = nwords * WM_ADSP_DATA_WORD_SIZE;
 
-		adsp_dbg(dsp, "Read %d bytes\n", nbytes);
+		compr_dbg(compr, "Read %d bytes\n", nbytes);
 
 		if (copy_to_user(buf + ntotal, compr->raw_buf, nbytes)) {
-			adsp_err(dsp, "Failed to copy data to user: %d, %d\n",
-				 ntotal, nbytes);
+			compr_err(compr, "Failed to copy data to user: %d, %d\n",
+				  ntotal, nbytes);
 			return -EFAULT;
 		}
 
-- 
2.11.0
