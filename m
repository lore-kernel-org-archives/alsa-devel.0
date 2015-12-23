From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v4 2/2] ASoC: wm_adsp: Pull data through
	compressed read
Date: Wed, 23 Dec 2015 10:58:23 +0000
Message-ID: <1450868303-11130-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1450868303-11130-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC2E265882
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 11:58:26 +0100 (CET)
In-Reply-To: <1450868303-11130-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Data is read in blocks of up to one fragment is size from the circular
buffer on the DSP and is re-packed to remove the padding byte that
exists in the DSP memory map.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

No changes since v3.

Thanks,
Charles

 sound/soc/codecs/wm5110.c  |   1 +
 sound/soc/codecs/wm_adsp.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |   2 +
 3 files changed, 141 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index dde94c4..61fa7cc 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2300,6 +2300,7 @@ static struct snd_compr_ops wm5110_compr_ops = {
 	.get_caps = wm_adsp_compr_get_caps,
 	.trigger = wm_adsp_compr_trigger,
 	.pointer = wm_adsp_compr_pointer,
+	.copy = wm_adsp_compr_copy,
 };
 
 static struct snd_soc_platform_driver wm5110_compr_platform = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index edf96b5..1edd56b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -293,6 +293,7 @@ struct wm_adsp_compr {
 	struct snd_compr_stream *stream;
 	struct snd_compressed_buffer size;
 
+	u32 *raw_buf;
 	unsigned int copied_total;
 };
 
@@ -2385,6 +2386,7 @@ int wm_adsp_compr_free(struct snd_compr_stream *stream)
 
 	dsp->compr = NULL;
 
+	kfree(compr->raw_buf);
 	kfree(compr);
 
 	mutex_unlock(&dsp->pwr_lock);
@@ -2452,6 +2454,7 @@ int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 			     struct snd_compr_params *params)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	unsigned int size;
 	int ret;
 
 	ret = wm_adsp_compr_check_params(stream, params);
@@ -2463,6 +2466,11 @@ int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 	adsp_dbg(compr->dsp, "fragment_size=%d fragments=%d\n",
 		 compr->size.fragment_size, compr->size.fragments);
 
+	size = wm_adsp_compr_frag_words(compr) * sizeof(*compr->raw_buf);
+	compr->raw_buf = kmalloc(size, GFP_DMA | GFP_KERNEL);
+	if (!compr->raw_buf)
+		return -ENOMEM;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_set_params);
@@ -2796,6 +2804,7 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf = dsp->buffer;
+	struct wm_adsp_compr *compr = dsp->compr;
 	int ret = 0;
 
 	mutex_lock(&dsp->pwr_lock);
@@ -2832,6 +2841,9 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		goto out;
 	}
 
+	if (compr->stream)
+		snd_compr_fragment_elapsed(compr->stream);
+
 out:
 	mutex_unlock(&dsp->pwr_lock);
 
@@ -2911,4 +2923,130 @@ out:
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_pointer);
 
+static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
+{
+	struct wm_adsp_compr_buf *buf = compr->buf;
+	u8 *pack_in = (u8 *)compr->raw_buf;
+	u8 *pack_out = (u8 *)compr->raw_buf;
+	unsigned int adsp_addr;
+	int mem_type, nwords, max_read;
+	int i, j, ret;
+
+	/* Calculate read parameters */
+	for (i = 0; i < wm_adsp_fw[buf->dsp->fw].caps->num_regions; ++i)
+		if (buf->read_index < buf->regions[i].cumulative_size)
+			break;
+
+	if (i == wm_adsp_fw[buf->dsp->fw].caps->num_regions)
+		return -EINVAL;
+
+	mem_type = buf->regions[i].mem_type;
+	adsp_addr = buf->regions[i].base_addr +
+		    (buf->read_index - buf->regions[i].offset);
+
+	max_read = wm_adsp_compr_frag_words(compr);
+	nwords = buf->regions[i].cumulative_size - buf->read_index;
+
+	if (nwords > target)
+		nwords = target;
+	if (nwords > buf->avail)
+		nwords = buf->avail;
+	if (nwords > max_read)
+		nwords = max_read;
+	if (!nwords)
+		return 0;
+
+	/* Read data from DSP */
+	ret = wm_adsp_read_data_block(buf->dsp, mem_type, adsp_addr,
+				      nwords, compr->raw_buf);
+	if (ret < 0)
+		return ret;
+
+	/* Remove the padding bytes from the data read from the DSP */
+	for (i = 0; i < nwords; i++) {
+		for (j = 0; j < WM_ADSP_DATA_WORD_SIZE; j++)
+			*pack_out++ = *pack_in++;
+
+		pack_in += sizeof(*(compr->raw_buf)) - WM_ADSP_DATA_WORD_SIZE;
+	}
+
+	/* update read index to account for words read */
+	buf->read_index += nwords;
+	if (buf->read_index == wm_adsp_buffer_size(buf))
+		buf->read_index = 0;
+
+	ret = wm_adsp_buffer_write(buf, HOST_BUFFER_FIELD(next_read_index),
+				   buf->read_index);
+	if (ret < 0)
+		return ret;
+
+	/* update avail to account for words read */
+	buf->avail -= nwords;
+
+	return nwords;
+}
+
+static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
+			      char __user *buf, size_t count)
+{
+	struct wm_adsp *dsp = compr->dsp;
+	int ntotal = 0;
+	int nwords, nbytes;
+
+	adsp_dbg(dsp, "Requested read of %zu bytes\n", count);
+
+	if (!compr->buf)
+		return -ENXIO;
+
+	if (compr->buf->error)
+		return -EIO;
+
+	count /= WM_ADSP_DATA_WORD_SIZE;
+
+	do {
+		nwords = wm_adsp_buffer_capture_block(compr, count);
+		if (nwords < 0) {
+			adsp_err(dsp, "Failed to capture block: %d\n", nwords);
+			return nwords;
+		}
+
+		nbytes = nwords * WM_ADSP_DATA_WORD_SIZE;
+
+		adsp_dbg(dsp, "Read %d bytes\n", nbytes);
+
+		if (copy_to_user(buf + ntotal, compr->raw_buf, nbytes)) {
+			adsp_err(dsp, "Failed to copy data to user: %d, %d\n",
+				 ntotal, nbytes);
+			return -EFAULT;
+		}
+
+		count -= nwords;
+		ntotal += nbytes;
+	} while (nwords > 0 && count > 0);
+
+	compr->copied_total += ntotal;
+
+	return ntotal;
+}
+
+int wm_adsp_compr_copy(struct snd_compr_stream *stream, char __user *buf,
+		       size_t count)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	struct wm_adsp *dsp = compr->dsp;
+	int ret;
+
+	mutex_lock(&dsp->pwr_lock);
+
+	if (stream->direction == SND_COMPRESS_CAPTURE)
+		ret = wm_adsp_compr_read(compr, buf, count);
+	else
+		ret = -ENOTSUPP;
+
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_copy);
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 522fa1a..1a928ec 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -115,5 +115,7 @@ extern int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd);
 extern int wm_adsp_compr_handle_irq(struct wm_adsp *dsp);
 extern int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 				 struct snd_compr_tstamp *tstamp);
+extern int wm_adsp_compr_copy(struct snd_compr_stream *stream,
+			      char __user *buf, size_t count);
 
 #endif
-- 
2.1.4
